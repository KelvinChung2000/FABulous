"""FABulous sequential flow with recursive, typed step substitution.

:class:`FABulousSequentialFlow` is a thin subclass of
:class:`librelane.flows.sequential.SequentialFlow` that routes class-level
``Substitutions`` through the recursive engine in
:mod:`fabulous.fabric_generator.gds_generator.substitution`. Rules descend
into nested-step containers (``WhileStep``, LibreLane's ``CompositeStep``,
etc.) instead of being silently dropped, and the typed rule dataclasses —
:class:`Replace`, :class:`Remove`, :class:`InsertBefore`,
:class:`InsertAfter` — replace the ``+``/``-``/``None`` string overloads
for any new code while still accepting the legacy shape for existing
flows and YAML ``meta.substituting_steps`` metadata.

Everything else — ``run``, ``Substitute``, ``Make``'s sister ``make``,
gating-variable validation, id normalization, ``frm``/``to``/``skip``
/``reproducible`` handling — is inherited from upstream unchanged. When
LibreLane lands the same improvements, replacing this file with a single
import will be sufficient.
"""

from typing import Self

from librelane.flows.flow import Flow
from librelane.flows.sequential import SequentialFlow
from librelane.steps import Step

from fabulous.fabric_generator.gds_generator.substitution import (
    parse_rules,
    substitute_steps,
)


@Flow.factory.register()
class FABulousSequentialFlow(SequentialFlow):
    """Sequential flow with recursive, typed substitutions.

    Drop-in replacement for :class:`SequentialFlow`. Subclass it and set
    :attr:`Steps` (and optionally :attr:`Substitutions`,
    :attr:`gating_config_vars`) exactly as you would for the upstream class.

    An empty :attr:`Steps` list is declared at this level so upstream's
    ``__init_subclass__`` bookkeeping (which copies ``Steps`` before this
    class body is fully defined) has something to operate on. Concrete
    subclasses still have to set ``Steps`` to a non-empty list, and
    :class:`Flow` will refuse to instantiate an abstract flow that does
    not.

    :cvar Substitutions: Consumed at class-definition time and cleared on
        ``cls`` afterwards. Accepts either:

        * an ordered list of typed rules (:class:`Replace`, :class:`Remove`,
          :class:`InsertBefore`, :class:`InsertAfter`) — the recommended
          form; order is significant and duplicate patterns are allowed;
        * LibreLane's legacy dict / list-of-tuples shape with ``+``/``-``
          prefixed string keys — accepted so existing flows and YAML
          ``meta.substituting_steps`` metadata continue to work unchanged.

        Rules descend into nested-step containers, so substituting
        ``OpenROAD.GeneratePDN`` inside a flow that wraps a
        :class:`WhileStep` will rewrite the nested occurrence rather than
        silently dropping the rule.
    """

    Steps: list[type[Step]] = []

    def __init_subclass__(
        cls,
        scm_type: str | None = None,
        name: str | None = None,
        **kwargs: str | bool | None,
    ) -> None:
        """Intercept ``Substitutions`` and apply rules recursively at class creation."""
        # Capture Substitutions declared on *this* subclass only; reading
        # from cls.__dict__ prevents rules already consumed by a parent
        # class from being re-applied here.
        pending = cls.__dict__.get("Substitutions")
        # Disable upstream's flat substitution pass; we take over below so
        # rules reach nested-step containers.
        cls.Substitutions = None
        super().__init_subclass__(scm_type=scm_type, name=name, **kwargs)
        if pending is not None:
            rules = parse_rules(pending)
            if rules:
                cls.Steps = substitute_steps(cls.Steps, rules)

    @classmethod
    def Make(cls, step_ids: list[str]) -> type[Self]:
        """Build a new flow class from an ordered list of step ids.

        Uses ``cls`` as the base so derived flows keep their own
        ``__init_subclass__`` behavior. Upstream's :meth:`SequentialFlow.Make`
        hardcodes ``SequentialFlow`` as the base, which would bypass our
        recursive engine; this override fixes that for FABulous use.
        """
        step_list: list[type[Step]] = []
        for name in step_ids:
            step = Step.factory.get(name)
            if step is None:
                raise TypeError(f"No step found with id '{name}'")
            step_list.append(step)

        class CustomFABulousSequentialFlow(cls):  # type: ignore[valid-type, misc]
            name = "Custom FABulous Sequential Flow"
            Steps = step_list

        return CustomFABulousSequentialFlow
