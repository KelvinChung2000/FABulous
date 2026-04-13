"""Typed, recursive step substitution for FABulous flows.

FABulous does not mirror LibreLane's prefix-encoded substitution format.
Rules here are typed dataclasses — :class:`Replace`, :class:`Remove`,
:class:`InsertBefore`, :class:`InsertAfter` — so every operation is
self-describing. A list of rules is an ordered script: two rules may target
the same pattern and the order between them is explicit, unlike a dict where
duplicate keys silently collide.

The engine descends recursively into nested-step containers (any step class
with a non-empty class-level `Steps` list, which covers :class:`WhileStep`
and LibreLane's `CompositeStep`). Containers whose nested list is rewritten
are forked into a fresh anonymous subclass, leaving the original class
untouched so other flows that reference it are never disturbed.

A compatibility adapter :func:`parse_rules` accepts LibreLane's legacy
dict / list-of-tuples shape so rules loaded from YAML ``meta.substituting_steps``
metadata or existing ``Substitutions = {...}`` class attributes still reach
the engine unchanged. Below :func:`parse_rules` everything is typed.
"""

import fnmatch
import re
from collections.abc import Iterable
from dataclasses import dataclass

from librelane.flows.flow import FlowException
from librelane.steps.step import Step

Match = type[Step] | str
RuleStep = type[Step] | str
LegacyRuleValue = RuleStep | None
LegacyRulePair = tuple[str, LegacyRuleValue]


@dataclass(frozen=True)
class Replace:
    """Replace every step whose id matches ``match`` with ``with_step``.

    ``match`` may be a :class:`Step` subclass, a :mod:`fnmatch`-style pattern,
    or a regular expression string. Strings are compared case-insensitively
    against each step's ``id`` attribute. ``with_step`` may be a :class:`Step`
    subclass or a step id string resolved via :attr:`Step.factory`.
    """

    match: Match
    with_step: RuleStep

    def __str__(self) -> str:
        """Render the rule for diagnostics."""
        return f"Replace(match={self.match!r}, with_step={self.with_step!r})"


@dataclass(frozen=True)
class Remove:
    """Remove every step whose id matches ``match``."""

    match: Match

    def __str__(self) -> str:
        """Render the rule for diagnostics."""
        return f"Remove(match={self.match!r})"


@dataclass(frozen=True)
class InsertBefore:
    """Insert ``step`` immediately before every step whose id matches ``match``."""

    match: Match
    step: RuleStep

    def __str__(self) -> str:
        """Render the rule for diagnostics."""
        return f"InsertBefore(match={self.match!r}, step={self.step!r})"


@dataclass(frozen=True)
class InsertAfter:
    """Insert ``step`` immediately after every step whose id matches ``match``."""

    match: Match
    step: RuleStep

    def __str__(self) -> str:
        """Render the rule for diagnostics."""
        return f"InsertAfter(match={self.match!r}, step={self.step!r})"


Rule = Replace | Remove | InsertBefore | InsertAfter
RuleInput = (
    dict[str, LegacyRuleValue] | Iterable[LegacyRulePair] | Iterable[Rule] | None
)

_RULE_TYPES: tuple[type, ...] = (Replace, Remove, InsertBefore, InsertAfter)


def parse_rules(raw: RuleInput) -> list[Rule]:
    """Normalize user-facing substitution input into a typed rule list.

    ``raw`` may be any of:

    * an iterable of already-typed :class:`Rule` instances (returned as-is);
    * a ``dict`` mapping patterns to step classes / id strings / ``None``,
      where patterns may be prefixed with ``+`` (insert after) or ``-``
      (insert before) — LibreLane's historical shape;
    * a ``list`` of ``(pattern, replacement)`` tuples with the same
      conventions, preserved in order so duplicate patterns are allowed;
    * ``None`` (returned as an empty list).

    Pairing a ``+`` / ``-`` prefix with a ``None`` value is rejected, because
    "insert nothing" is nonsensical. All legacy inputs are mapped onto
    :class:`Replace` / :class:`Remove` / :class:`InsertBefore` /
    :class:`InsertAfter`, at which point every downstream consumer only ever
    sees typed rules.
    """
    if raw is None:
        return []

    if isinstance(raw, dict):
        pairs: Iterable[LegacyRulePair] = raw.items()
    elif isinstance(raw, list | tuple):
        items = list(raw)
        if items and all(isinstance(i, _RULE_TYPES) for i in items):
            return list(items)
        if not items:
            return []
        pairs = items  # list of (pattern, replacement) tuples
    else:
        # Treat any other iterable as a stream of typed rules.
        try:
            items = list(raw)
        except TypeError:
            items = None
        if items is not None and all(isinstance(i, _RULE_TYPES) for i in items):
            return items
        raise FlowException(
            f"Cannot interpret substitutions of type {type(raw).__name__}: "
            "expected a list of Rule objects, a dict, or a list of tuples."
        )

    rules: list[Rule] = []
    for key, value in pairs:
        if not isinstance(key, str):
            raise FlowException(
                f"Substitution pattern must be a string, got {type(key).__name__}."
            )
        if key.startswith("+"):
            if value is None:
                raise FlowException(
                    f"Cannot insert None after '{key[1:]}'; use Remove instead."
                )
            rules.append(InsertAfter(match=key[1:], step=value))
        elif key.startswith("-"):
            if value is None:
                raise FlowException(
                    f"Cannot insert None before '{key[1:]}'; use Remove instead."
                )
            rules.append(InsertBefore(match=key[1:], step=value))
        elif value is None:
            rules.append(Remove(match=key))
        else:
            rules.append(Replace(match=key, with_step=value))
    return rules


def substitute_steps(
    steps: list[type[Step]],
    rules: Iterable[Rule],
) -> list[type[Step]]:
    """Apply typed substitution rules recursively to a step list.

    The caller's ``steps`` argument is never mutated. Nested-step containers
    whose ``Steps`` list is touched by a rule are replaced with fresh
    anonymous subclasses, so the original class stays identical for any other
    flow that references it.

    Rules are applied in order; id normalization (matching LibreLane's
    ``-1``/``-2`` suffix convention for duplicate ids) runs after each rule.

    Parameters
    ----------
    steps : list[type[Step]]
        Initial flow steps that substitutions are applied to.
    rules : Iterable[Rule]
        Typed substitution rules to apply in sequence.

    Returns
    -------
    list[type[Step]]
        A new list containing the substituted top-level steps.

    Raises
    ------
    FlowException
        If any rule matches no step at any depth, or if a string replacement
        cannot be resolved via :attr:`Step.factory`.
    """
    working = list(steps)
    for rule in rules:
        if not isinstance(rule, _RULE_TYPES):
            raise FlowException(
                f"substitute_steps expected Rule instances, got {type(rule).__name__}. "
                "Pass legacy dict/list-of-tuples through parse_rules() first."
            )
        resolved: type[Step] | None = None
        if not isinstance(rule, Remove):
            payload: RuleStep = (
                rule.with_step if isinstance(rule, Replace) else rule.step
            )
            if isinstance(payload, str):
                resolved = Step.factory.get(payload)
                if resolved is None:
                    raise FlowException(
                        f"Step id '{payload}' referenced by {rule} is "
                        "not registered with Step.factory."
                    )
            else:
                resolved = payload
        matched = _apply_rule_recursive(working, rule, resolved)
        if not matched:
            raise FlowException(
                f"{rule} matched no steps in the flow (including nested containers)."
            )
        normalize_step_ids(working)
    return working


def _apply_rule_recursive(
    steps: list[type[Step]],
    rule: Rule,
    resolved: type[Step] | None,
) -> bool:
    """Apply ``rule`` to ``steps`` in place.

    Returns True if anything matched.
    """
    matched = False

    top_indices: list[int] = []
    for i, step_cls in enumerate(steps):
        if isinstance(rule.match, type) and issubclass(rule.match, Step):
            if (
                step_cls is rule.match
                or step_cls.get_implementation_id()
                == rule.match.get_implementation_id()
            ):
                top_indices.append(i)
            continue
        if not isinstance(rule.match, str):
            raise FlowException(
                f"Substitution match must be a Step class or string, got "
                f"{type(rule.match).__name__}."
            )
        if step_cls.id is NotImplemented:
            continue
        if fnmatch.fnmatch(step_cls.id.lower(), rule.match.lower()):
            top_indices.append(i)
            continue
        try:
            if re.fullmatch(rule.match, step_cls.id, re.IGNORECASE) is not None:
                top_indices.append(i)
        except re.error:
            pass

    if top_indices:
        matched = True
        match rule:
            case Remove():
                for i in reversed(top_indices):
                    del steps[i]
            case Replace():
                assert resolved is not None, "Non-Remove rules always resolve to a Step"
                for i in top_indices:
                    steps[i] = resolved
            case InsertAfter():
                assert resolved is not None, "Non-Remove rules always resolve to a Step"
                for i in reversed(top_indices):
                    steps.insert(i + 1, resolved)
            case InsertBefore():
                assert resolved is not None, "Non-Remove rules always resolve to a Step"
                for i in reversed(top_indices):
                    steps.insert(i, resolved)

    # Descend into nested containers. Iterate over a snapshot because we may
    # replace entries as we go.
    for step_cls in list(steps):
        nested = getattr(step_cls, "Steps", None)
        if not isinstance(nested, list) or not nested:
            continue
        if not all(isinstance(s, type) for s in nested):
            continue
        nested_copy = list(nested)
        if _apply_rule_recursive(nested_copy, rule, resolved):
            matched = True
            # Rebuild the touched container so other flows using the original
            # class do not observe nested substitutions.
            forked = type(
                step_cls.__name__ + "'",
                (step_cls,),
                {"Steps": nested_copy},
            )
            for j, existing in enumerate(steps):
                if existing is step_cls:
                    steps[j] = forked

    return matched


def normalize_step_ids(steps: list[type[Step]]) -> None:
    """Ensure step ids in ``steps`` are unique by appending ``-N`` suffixes.

    Mirrors LibreLane's convention (first occurrence keeps its id, subsequent
    duplicates get ``-1``, ``-2``, ... suffixes) so FABulous flows remain
    indistinguishable from upstream on the wire.
    """
    ids_used: set[str] = set()
    for i, step in enumerate(steps):
        imp_id = step.get_implementation_id()
        if imp_id is NotImplemented:
            continue
        new_id = imp_id
        counter = 0
        while new_id in ids_used:
            counter += 1
            new_id = f"{imp_id}-{counter}"
        if new_id != step.id:
            steps[i] = step.with_id(new_id)
        ids_used.add(new_id)
