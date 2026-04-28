"""Tests for GlobalTileSizeOptimization NLP problem helpers.

The Pareto frontier helper is the most failure-prone part of the NLP setup: a
flipped iteration direction silently locks the body row to the worst-aspect
sample, producing 1:8 rectangles for square-ish tiles. These tests pin the
correct algorithm so that regression cannot reappear unnoticed.
"""

# ruff: noqa: SLF001

import pytest

from fabulous.fabric_generator.gds_generator.steps.global_tile_opitmisation import (
    NLPTileProblem,
)


class TestParetoFrontier:
    """Unit tests for NLPTileProblem._pareto_frontier."""

    def test_empty_input_returns_empty(self) -> None:
        assert NLPTileProblem._pareto_frontier([]) == []

    def test_single_sample_round_trips(self) -> None:
        assert NLPTileProblem._pareto_frontier([(100.0, 50.0)]) == [(100.0, 50.0)]

    def test_keeps_wide_short_alongside_narrow_tall(self) -> None:
        """Two samples with opposite trade-offs are both Pareto-optimal."""
        # (236.16, 470.4) and (127.68, 1034.88) are mutually non-dominated:
        # neither has both smaller w AND smaller h. This is the DSP supertile
        # case from the demo project that the buggy frontier discarded.
        samples = [(127.68, 1034.88), (236.16, 470.4)]
        frontier = NLPTileProblem._pareto_frontier(samples)

        assert (236.16, 470.4) in frontier
        assert (127.68, 1034.88) in frontier
        assert len(frontier) == 2

    def test_drops_dominated_samples(self) -> None:
        """A sample that is wider AND taller than another is dominated and dropped."""
        # (200, 200) dominates (300, 300) — keep the former, drop the latter.
        samples = [(300.0, 300.0), (200.0, 200.0), (250.0, 250.0)]
        frontier = NLPTileProblem._pareto_frontier(samples)
        assert frontier == [(200.0, 200.0)]

    def test_dedupes_equal_height_samples_keeping_smallest_w(self) -> None:
        """At the same h, only the smallest-w sample survives."""
        samples = [(150.0, 100.0), (100.0, 100.0), (200.0, 100.0)]
        frontier = NLPTileProblem._pareto_frontier(samples)
        assert frontier == [(100.0, 100.0)]

    def test_output_sorted_by_h_ascending(self) -> None:
        """Frontier is sorted by h ascending, w strictly decreasing along it."""
        # Real LUT4AB samples from the demo project's exploration:
        samples = [
            (582.72, 108.36),  # FIND_MIN_WIDTH probe
            (238.08, 271.74),  # BALANCE final
            (120.96, 1310.4),  # FIND_MIN_HEIGHT final
            (731.52, 108.36),  # dominated by (582.72, 108.36) at same h
        ]
        frontier = NLPTileProblem._pareto_frontier(samples)
        assert frontier == [
            (582.72, 108.36),
            (238.08, 271.74),
            (120.96, 1310.4),
        ]
        # Heights strictly increase, widths strictly decrease.
        for prev, curr in zip(frontier, frontier[1:], strict=False):
            assert curr[1] > prev[1]
            assert curr[0] < prev[0]

    @pytest.mark.parametrize(
        ("samples", "expected_first_w_h", "expected_last_w_h"),
        [
            pytest.param(
                # DSP supertile: balance (236, 470), find_min_height probes
                # at w=127.68 with various h. Frontier should include both
                # the wide+short balance sample AND the narrow+tall extremes.
                [
                    (236.16, 470.4),
                    (127.68, 828.24),
                    (127.68, 1034.88),
                    (127.68, 916.02),
                ],
                (236.16, 470.4),
                (127.68, 828.24),
                id="dsp-supertile-frontier",
            ),
            pytest.param(
                # W_IO real samples — has 3 frontier points.
                [
                    (108.48, 142.38),
                    (20.16, 1338.96),
                    (125.76, 108.36),
                    (249.6, 108.36),  # dominated by (125.76, 108.36)
                ],
                (125.76, 108.36),
                (20.16, 1338.96),
                id="w-io-frontier",
            ),
        ],
    )
    def test_real_demo_project_frontiers(
        self,
        samples: list[tuple[float, float]],
        expected_first_w_h: tuple[float, float],
        expected_last_w_h: tuple[float, float],
    ) -> None:
        """Lock in the frontier shape for representative tiles from the demo."""
        frontier = NLPTileProblem._pareto_frontier(samples)
        assert frontier[0] == expected_first_w_h
        assert frontier[-1] == expected_last_w_h
        # Every kept sample is non-dominated by every other kept sample.
        for i, (w_i, h_i) in enumerate(frontier):
            for j, (w_j, h_j) in enumerate(frontier):
                if i == j:
                    continue
                assert not (w_j <= w_i and h_j <= h_i and (w_j, h_j) != (w_i, h_i)), (
                    f"{frontier[j]} dominates {frontier[i]}"
                )
