"""Unit tests for the recursive step substitution engine."""

from __future__ import annotations

from typing import TYPE_CHECKING

import pytest
from librelane.flows.flow import FlowException
from librelane.steps.step import Step

from fabulous.fabric_generator.gds_generator.steps.while_step import WhileStep
from fabulous.fabric_generator.gds_generator.substitution import (
    InsertAfter,
    InsertBefore,
    Remove,
    Replace,
    parse_rules,
    substitute_steps,
)

if TYPE_CHECKING:
    from librelane.state.state import State
    from pytest_mock import MockerFixture


def _make_step(step_id: str) -> type[Step]:
    """Build a minimal concrete Step subclass with the given id."""

    class _TestStep(Step):  # type: ignore[misc]
        id = step_id
        name = step_id
        inputs: list = []
        outputs: list = []

        def run(
            self, _state_in: State, **_kwargs: str
        ) -> tuple[dict[str, str], dict[str, str]]:
            return ({}, {})

    _TestStep.__name__ = step_id.replace(".", "_")
    _TestStep.__qualname__ = _TestStep.__name__
    return _TestStep


def _make_container(container_id: str, nested: list[type[Step]]) -> type[WhileStep]:
    """Build a WhileStep subclass that wraps the given nested steps."""

    class _Container(WhileStep):
        id = container_id
        name = container_id
        inputs: list = []
        outputs: list = []
        Steps = list(nested)

    _Container.__name__ = container_id.replace(".", "_")
    _Container.__qualname__ = _Container.__name__
    return _Container


@pytest.fixture
def step_a() -> type[Step]:
    return _make_step("Test.A")


@pytest.fixture
def step_b() -> type[Step]:
    return _make_step("Test.B")


@pytest.fixture
def step_c() -> type[Step]:
    return _make_step("Test.C")


class TestParseRules:
    """``parse_rules`` normalizes every accepted input shape into typed rules."""

    def test_none_yields_empty_list(self) -> None:
        assert parse_rules(None) == []

    def test_empty_dict(self) -> None:
        assert parse_rules({}) == []

    def test_empty_list(self) -> None:
        assert parse_rules([]) == []

    def test_typed_rules_passthrough(self, step_a: type[Step]) -> None:
        rules = [Remove(match="X"), Replace(match="Y", with_step=step_a)]
        result = parse_rules(rules)
        assert result == rules

    def test_typed_rules_tuple_passthrough(self, step_a: type[Step]) -> None:
        rules = (Remove(match="X"), Replace(match="Y", with_step=step_a))
        result = parse_rules(rules)
        assert result == list(rules)

    def test_legacy_dict_replace(self, step_a: type[Step]) -> None:
        result = parse_rules({"Test.X": step_a})
        assert result == [Replace(match="Test.X", with_step=step_a)]

    def test_legacy_dict_remove(self) -> None:
        result = parse_rules({"Test.X": None})
        assert result == [Remove(match="Test.X")]

    def test_legacy_dict_insert_after(self, step_a: type[Step]) -> None:
        result = parse_rules({"+Test.X": step_a})
        assert result == [InsertAfter(match="Test.X", step=step_a)]

    def test_legacy_dict_insert_before(self, step_a: type[Step]) -> None:
        result = parse_rules({"-Test.X": step_a})
        assert result == [InsertBefore(match="Test.X", step=step_a)]

    def test_legacy_list_of_tuples_preserves_duplicates(
        self, step_a: type[Step], step_b: type[Step]
    ) -> None:
        result = parse_rules(
            [("Test.X", step_a), ("Test.X", step_b)],
        )
        assert result == [
            Replace(match="Test.X", with_step=step_a),
            Replace(match="Test.X", with_step=step_b),
        ]

    def test_legacy_insert_none_raises(self) -> None:
        with pytest.raises(FlowException, match="Cannot insert None after"):
            parse_rules({"+Test.X": None})
        with pytest.raises(FlowException, match="Cannot insert None before"):
            parse_rules({"-Test.X": None})

    def test_non_string_pattern_raises(self, step_a: type[Step]) -> None:
        with pytest.raises(FlowException, match="must be a string"):
            parse_rules([(123, step_a)])

    def test_unknown_type_raises(self) -> None:
        with pytest.raises(FlowException, match="Cannot interpret substitutions"):
            parse_rules(1)  # type: ignore[arg-type]


class TestEngineRejectsUntypedRules:
    """``substitute_steps`` is strict: only typed rules reach the core loop."""

    def test_raises_on_legacy_dict(self, step_a: type[Step]) -> None:
        with pytest.raises(FlowException, match="expected Rule instances"):
            substitute_steps([step_a], [("Test.A", None)])  # type: ignore[list-item]


class TestTopLevelReplace:
    def test_replace_by_class(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        result = substitute_steps(
            [step_a, step_b],
            [Replace(match="Test.A", with_step=step_c)],
        )
        assert [s.id for s in result] == ["Test.C", "Test.B"]

    def test_replace_match_by_step_class(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        result = substitute_steps(
            [step_a, step_b],
            [Replace(match=step_a, with_step=step_c)],
        )
        assert [s.id for s in result] == ["Test.C", "Test.B"]

    def test_replace_by_id_string(
        self, step_a: type[Step], step_b: type[Step], mocker: MockerFixture
    ) -> None:
        mocker.patch(
            "fabulous.fabric_generator.gds_generator.substitution.Step.factory.get",
            return_value=step_b,
        )
        result = substitute_steps(
            [step_a],
            [Replace(match="Test.A", with_step="Test.B")],
        )
        assert [s.id for s in result] == ["Test.B"]

    def test_replace_unknown_id_raises(
        self, step_a: type[Step], mocker: MockerFixture
    ) -> None:
        mocker.patch(
            "fabulous.fabric_generator.gds_generator.substitution.Step.factory.get",
            return_value=None,
        )
        with pytest.raises(FlowException, match="not registered with Step.factory"):
            substitute_steps(
                [step_a],
                [Replace(match="Test.A", with_step="Test.Missing")],
            )


class TestTopLevelRemove:
    def test_remove_wildcard_matches_multiple(self) -> None:
        sta1 = _make_step("OpenROAD.STAPrePNR")
        sta2 = _make_step("OpenROAD.STAMidPNR")
        keep = _make_step("OpenROAD.Floorplan")
        result = substitute_steps(
            [sta1, sta2, keep],
            [Remove(match="OpenROAD.STA*")],
        )
        assert [s.id for s in result] == ["OpenROAD.Floorplan"]

    def test_remove_regex_matches_multiple(self) -> None:
        sta = _make_step("OpenROAD.STAPrePNR")
        rcx = _make_step("OpenROAD.RCX")
        keep = _make_step("OpenROAD.Floorplan")
        result = substitute_steps(
            [sta, rcx, keep],
            [Remove(match=r"OpenROAD\.(STA.*|RCX)")],
        )
        assert [s.id for s in result] == ["OpenROAD.Floorplan"]

    def test_remove_no_match_raises(self, step_a: type[Step]) -> None:
        with pytest.raises(FlowException, match="matched no steps"):
            substitute_steps([step_a], [Remove(match="Test.Missing")])


class TestTopLevelInsert:
    def test_insert_after(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        result = substitute_steps(
            [step_a, step_b],
            [InsertAfter(match="Test.A", step=step_c)],
        )
        assert [s.id for s in result] == ["Test.A", "Test.C", "Test.B"]

    def test_insert_before(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        result = substitute_steps(
            [step_a, step_b],
            [InsertBefore(match="Test.B", step=step_c)],
        )
        assert [s.id for s in result] == ["Test.A", "Test.C", "Test.B"]


class TestRuleOrdering:
    """A list of typed rules is an ordered script: order matters."""

    def test_ordered_rules_compose(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        result = substitute_steps(
            [step_a, step_b],
            [
                Replace(match="Test.A", with_step=step_c),
                InsertAfter(match="Test.B", step=step_a),
            ],
        )
        assert [s.id for s in result] == ["Test.C", "Test.B", "Test.A"]

    def test_two_rules_same_pattern_apply_in_order(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        """Ordered lists allow two rules to target the same pattern; a dict cannot
        because later keys would overwrite earlier ones."""
        result = substitute_steps(
            [step_a],
            [
                Replace(match="Test.A", with_step=step_b),
                Replace(match="Test.B", with_step=step_c),
            ],
        )
        assert [s.id for s in result] == ["Test.C"]


class TestReturnedListIsFresh:
    def test_input_untouched(self, step_a: type[Step], step_b: type[Step]) -> None:
        inp = [step_a, step_b]
        out = substitute_steps(inp, [Replace(match="Test.A", with_step=step_b)])
        assert out is not inp
        assert [s.id for s in inp] == ["Test.A", "Test.B"]


class TestNestedReplace:
    def test_forks_container(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        orig_nested = list(container.Steps)

        result = substitute_steps(
            [container],
            [Replace(match="Test.A", with_step=step_c)],
        )

        assert len(result) == 1
        forked = result[0]
        assert forked is not container, "container must be forked, not mutated"
        assert issubclass(forked, container)
        assert [s.id for s in forked.Steps] == ["Test.C", "Test.B"]
        assert list(container.Steps) == orig_nested, "original container unchanged"


class TestNestedInsertAndRemove:
    def test_remove_nested_by_step_class(
        self, step_a: type[Step], step_b: type[Step]
    ) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        result = substitute_steps(
            [container],
            [Remove(match=step_a)],
        )
        forked = result[0]
        assert [s.id for s in forked.Steps] == ["Test.B"]

    def test_insert_after_nested(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        result = substitute_steps(
            [container],
            [InsertAfter(match="Test.A", step=step_c)],
        )
        forked = result[0]
        assert [s.id for s in forked.Steps] == ["Test.A", "Test.C", "Test.B"]

    def test_insert_before_nested(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        result = substitute_steps(
            [container],
            [InsertBefore(match="Test.B", step=step_c)],
        )
        forked = result[0]
        assert [s.id for s in forked.Steps] == ["Test.A", "Test.C", "Test.B"]

    def test_remove_nested(self, step_a: type[Step], step_b: type[Step]) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        result = substitute_steps(
            [container],
            [Remove(match="Test.A")],
        )
        forked = result[0]
        assert [s.id for s in forked.Steps] == ["Test.B"]

    def test_remove_wildcard_nested(self, step_b: type[Step]) -> None:
        aa = _make_step("Test.A1")
        ab = _make_step("Test.A2")
        container = _make_container("Test.Loop", [aa, ab, step_b])
        result = substitute_steps([container], [Remove(match="Test.A*")])
        forked = result[0]
        assert [s.id for s in forked.Steps] == ["Test.B"]


class TestNestedNoMatch:
    def test_no_match_anywhere_raises(
        self, step_a: type[Step], step_b: type[Step]
    ) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        with pytest.raises(FlowException, match="matched no steps"):
            substitute_steps([container], [Remove(match="Test.Missing")])


class TestMixedLevelMatching:
    def test_single_pattern_hits_top_and_nested(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        result = substitute_steps(
            [step_a, container],
            [Replace(match="Test.A", with_step=step_c)],
        )
        assert result[0].id == "Test.C"
        forked_container = result[1]
        assert forked_container is not container
        assert [s.id for s in forked_container.Steps] == ["Test.C", "Test.B"]


class TestIsolation:
    def test_two_calls_never_share_mutations(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        container = _make_container("Test.Loop", [step_a, step_b])
        orig_nested = list(container.Steps)

        left = substitute_steps(
            [container], [Replace(match="Test.A", with_step=step_c)]
        )
        right = substitute_steps(
            [container], [Replace(match="Test.B", with_step=step_c)]
        )

        assert left[0] is not right[0]
        assert [s.id for s in left[0].Steps] == ["Test.C", "Test.B"]
        assert [s.id for s in right[0].Steps] == ["Test.A", "Test.C"]
        assert list(container.Steps) == orig_nested


class TestForkedContainerAttributes:
    def test_recomputes_config_vars(
        self, step_a: type[Step], step_b: type[Step]
    ) -> None:
        from librelane.config.variable import Variable

        class StepWithVar(Step):  # type: ignore[misc]
            id = "Test.WithVar"
            name = "WithVar"
            inputs: list = []
            outputs: list = []
            config_vars = [Variable("TEST_VAR", int, "A test var", default=0)]

            def run(
                self, _state_in: State, **_kwargs: str
            ) -> tuple[dict[str, str], dict[str, str]]:
                return ({}, {})

        container = _make_container("Test.Loop", [step_a, step_b])
        assert "TEST_VAR" not in {v.name for v in container.config_vars}

        result = substitute_steps(
            [container],
            [Replace(match="Test.A", with_step=StepWithVar)],
        )
        forked = result[0]
        assert "TEST_VAR" in {v.name for v in forked.config_vars}


class TestIdNormalization:
    def test_duplicate_ids_get_suffixed_after_insert(
        self, step_a: type[Step], step_b: type[Step]
    ) -> None:
        result = substitute_steps(
            [step_a, step_b],
            [InsertAfter(match="Test.A", step=step_b)],
        )
        ids = [s.id for s in result]
        assert ids.count("Test.B") == 1
        assert "Test.B-1" in ids


class TestLegacyShapeEndToEnd:
    """Rules coming in as legacy dict still reach the engine via parse_rules."""

    def test_legacy_dict_works_when_normalized(
        self, step_a: type[Step], step_b: type[Step], step_c: type[Step]
    ) -> None:
        rules = parse_rules({"Test.A": step_c, "+Test.B": step_a})
        result = substitute_steps([step_a, step_b], rules)
        assert [s.id for s in result] == ["Test.C", "Test.B", "Test.A"]
