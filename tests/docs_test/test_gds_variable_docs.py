"""Regression tests for the GDS variable doc generator."""

import generate_gds_variable_docs as gds


def test_extracts_nonempty_gds_variables() -> None:
    result = gds.extract_gds_variables()
    # The capital-F import bug made this {} on the live site.
    assert result, "expected GDS variables, got nothing (import casing bug?)"
    assert len(result) >= 10, f"expected many categories, got {len(result)}"
    total_vars = sum(len(v) for v in result.values())
    assert total_vars > 100, f"expected >100 vars across categories, got {total_vars}"


def test_known_variable_present() -> None:
    result = gds.extract_gds_variables()
    all_names = {var["name"] for vars_ in result.values() for var in vars_}
    assert "PNR_CORNERS" in all_names


def test_types_are_table_safe() -> None:
    result = gds.extract_gds_variables()
    for vars_ in result.values():
        for var in vars_:
            assert "|" not in var["type"], f"pipe in type breaks table: {var}"
            assert "\n" not in var["type"]


def test_type_cells_have_no_rest_role_markup() -> None:
    # librelane's type repr embeds `{class}`Name <path>`` cross references that
    # resolve to nothing in a generated table; they must be stripped to plain text.
    result = gds.extract_gds_variables()
    for vars_ in result.values():
        for var in vars_:
            assert "{" not in var["type"], f"role markup left in type: {var}"
