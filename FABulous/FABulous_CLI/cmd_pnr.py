import os
import subprocess as sp
import sys
from pathlib import Path

from cmd2 import Cmd, Cmd2ArgumentParser, with_argparser, with_category
from loguru import logger

from FABulous.FABulous_CLI.define import CMD_FABRIC_FLOW
from FABulous.FABulous_CLI.helper import check_if_application_exists

pnrParser = Cmd2ArgumentParser()
pnrParser.add_argument(
    "file", type=Path, help="Path to the target file", completer=Cmd.path_complete
)
pnrParser.add_argument("--gui", action="store_true", help="Open the GUI for Nextpnr")
pnrParser.add_argument(
    "--chipdb",
    type=Path,
    help="Path to the chip database file. This will overwrite the default file version",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--pre-pack",
    type=Path,
    help="Path to the pre-pack Python script",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--pre-place",
    type=Path,
    help="Path to the pre-place Python script",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--pre-route",
    type=Path,
    help="Python file to run before routing",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--post-route",
    type=Path,
    help="Python file to run after routing",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--on-failure",
    type=Path,
    help="Python file to run in event of crash for design introspection",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--json", type=Path, help="JSON design file to ingest", completer=Cmd.path_complete
)
pnrParser.add_argument(
    "--write", type=Path, help="JSON design file to write", completer=Cmd.path_complete
)
pnrParser.add_argument("--top", type=str, help="Name of top module")
pnrParser.add_argument(
    "--seed", type=int, help="Seed value for random number generator"
)
pnrParser.add_argument(
    "-r",
    "--randomize-seed",
    action="store_true",
    help="Randomize seed value for random number generator",
)
pnrParser.add_argument(
    "--placer",
    type=str,
    choices=["sa", "heap"],
    default="heap",
    help="Placer algorithm to use; available: sa, heap; default: heap",
)
pnrParser.add_argument(
    "--router",
    type=str,
    choices=["router1", "router2"],
    default="router1",
    help="Router algorithm to use; available: router1, router2; default: router1",
)
pnrParser.add_argument(
    "--slack-redist-iter",
    type=int,
    help="Number of iterations between slack redistribution",
)
pnrParser.add_argument(
    "--cstrweight",
    type=float,
    help="Placer weighting for relative constraint satisfaction",
)
pnrParser.add_argument("--starttemp", type=float, help="Placer SA start temperature")
pnrParser.add_argument(
    "--pack-only",
    action="store_true",
    help="Pack design only without placement or routing",
)
pnrParser.add_argument(
    "--no-route", action="store_true", help="Process design without routing"
)
pnrParser.add_argument(
    "--no-place", action="store_true", help="Process design without placement"
)
pnrParser.add_argument(
    "--no-pack", action="store_true", help="Process design without packing"
)
pnrParser.add_argument(
    "--ignore-loops",
    action="store_true",
    help="Ignore combinational loops in timing analysis",
)
pnrParser.add_argument(
    "--ignore-rel-clk",
    action="store_true",
    help="Ignore clock-to-clock relations in timing checks",
)
pnrParser.add_argument(
    "--test", action="store_true", help="Check architecture database integrity"
)
pnrParser.add_argument(
    "--freq", type=int, help="Set target frequency for design in MHz"
)
pnrParser.add_argument(
    "--timing-allow-fail", action="store_true", help="Allow timing to fail in design"
)
pnrParser.add_argument(
    "--no-tmdriv", action="store_true", help="Disable timing-driven placement"
)
pnrParser.add_argument(
    "--sdc",
    type=Path,
    help="Generic timing constraints SDC file to load",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--sdf",
    type=Path,
    help="SDF delay back-annotation file to write",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--sdf-cvc",
    action="store_true",
    help="Enable tweaks for SDF file compatibility with the CVC simulator",
)
pnrParser.add_argument(
    "--no-print-critical-path-source",
    action="store_true",
    help="Disable printing of the line numbers associated with each net in the critical path",
)
pnrParser.add_argument(
    "--placer-heap-alpha",
    type=float,
    default=0.1,
    help="Placer heap alpha value (float, default: 0.1)",
)
pnrParser.add_argument(
    "--placer-heap-beta",
    type=float,
    default=0.9,
    help="Placer heap beta value (float, default: 0.9)",
)
pnrParser.add_argument(
    "--placer-heap-critexp",
    type=int,
    default=2,
    help="Placer heap criticality exponent (int, default: 2)",
)
pnrParser.add_argument(
    "--placer-heap-timingweight",
    type=int,
    default=10,
    help="Placer heap timing weight (int, default: 10)",
)
pnrParser.add_argument(
    "--placer-heap-cell-placement-timeout",
    type=int,
    default=8,
    help="Allow placer to attempt up to max(10000, total cells^2 / N) iterations to place a cell (int N, default: 8, 0 for no timeout)",
)
pnrParser.add_argument(
    "--static-dump-density",
    action="store_true",
    help="Write density csv files during placer-static flow",
)
pnrParser.add_argument(
    "--parallel-refine",
    action="store_true",
    help="Use new experimental parallelised engine for placement refinement",
)
pnrParser.add_argument(
    "--router2-heatmap",
    type=Path,
    help="Prefix for router2 resource congestion heatmaps",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--tmg-ripup",
    action="store_true",
    help="Enable experimental timing-driven ripup in router",
)
pnrParser.add_argument(
    "--router2-alt-weights", action="store_true", help="Use alternate router2 weights"
)
pnrParser.add_argument(
    "--report",
    type=Path,
    help="Write timing and utilization report in JSON format to file",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--detailed-timing-report",
    action="store_true",
    help="Append detailed net timing data to the JSON report",
)
pnrParser.add_argument(
    "--placed-svg",
    type=Path,
    help="Write render of placement to SVG file",
    completer=Cmd.path_complete,
)
pnrParser.add_argument(
    "--routed-svg",
    type=Path,
    help="Write render of routing to SVG file",
    completer=Cmd.path_complete,
)


@with_category(CMD_FABRIC_FLOW)
@with_argparser(pnrParser)
def do_place_and_route(self, args):
    """Runs place and route with Nextpnr for a given JSON file generated by Yosys, which
    requires a Nextpnr model and JSON file first, generated by 'synthesis'.

    Also logs place and route error, file not found error and type error.
    """
    logger.info(f"Running Placement and Routing with Nextpnr for design {args.file}")
    path = Path(args.file)
    parent = path.parent
    json_file = path.name
    top_module_name = path.stem

    fasm_file = top_module_name + ".fasm"
    log_file = top_module_name + "_npnr_log.txt"

    if parent == "":
        parent = "."

    if not os.path.exists(
        f"{self.projectDir}/.FABulous/pips.txt"
    ) or not os.path.exists(f"{self.projectDir}/.FABulous/bel.txt"):
        logger.error(
            "Pips and Bel files are not found, please run model_gen_npnr first"
        )
        return

    if not Path(f"{self.projectDir}/{parent}").exists():
        logger.error(f"Directory {self.projectDir}/{parent} does not exist.")
        return

    # TODO rewriting the fab_arch script so no need to copy file for work around
    npnr = check_if_application_exists(
        os.getenv("FAB_NEXTPNR_PATH", "nextpnr-himbaechel")
    )
    if f"{json_file}" in os.listdir(f"{self.projectDir}/{parent}"):
        runCmd = [
            f"FAB_ROOT={self.projectDir}",
            f"{npnr}",
            # key arguments
            f"--chipdb {args.chipdb}",
            f"--json {args.file}",
            f"--top {args.top}" if args.top else "",
            f"--seed {args.seed}" if args.seed else "",
            "--randomize-seed" if args.randomizeSeed else "",
            f"--placer {args.placer}",
            f"--router {args.router}",
            f"--report {args.report}" if args.report else "",
            "--gui" if args.gui else "",
            # flow control
            f"--pre-pack {args.prePack}" if args.prePack else "",
            f"--pre-place {args.prePlace}" if args.prePlace else "",
            f"--pre-route {args.preRoute}" if args.preRoute else "",
            f"--post-route {args.postRoute}" if args.postRoute else "",
            # fine tuning and stats
            (
                f"--slack-redist-iter {args.slackRedistIter}"
                if args.slackRedistIter
                else ""
            ),
            f"--cstrweight {args.cstrweight}" if args.cstrweight else "",
            f"--starttemp {args.starttemp}" if args.starttemp else "",
            "--pack-only" if args.packOnly else "",
            "--no-route" if args.noRoute else "",
            "--no-place" if args.noPlace else "",
            "--no-pack" if args.noPack else "",
            "--ignore-loops" if args.ignoreLoops else "",
            "--ignore-rel-clk" if args.ignoreRelClk else "",
            "--test" if args.test else "",
            f"--freq {args.freq}" if args.freq else "",
            "--timing-allow-fail" if args.timingAllowFail else "",
            "--no-tmdriv" if args.noTmdriv else "",
            f"--sdc {args.sdc}" if args.sdc else "",
            f"--sdf {args.sdf}" if args.sdf else "",
            "--sdf-cvc" if args.sdfCvc else "",
            "--no-print-critical-path-source" if args.noPrintCriticalPathSource else "",
            f"--placer-heap-alpha {args.placerHeapAlpha}",
            f"--placer-heap-beta {args.placerHeapBeta}",
            f"--placer-heap-critexp {args.placerHeapCritexp}",
            f"--placer-heap-timingweight {args.placerHeapTimingweight}",
            f"--placer-heap-cell-placement-timeout {args.placerHeapCellPlacementTimeout}",
            "--static-dump-density" if args.staticDumpDensity else "",
            "--parallel-refine" if args.parallelRefine else "",
            f"--router2-heatmap {args.router2Heatmap}" if args.router2Heatmap else "",
            "--tmg-ripup" if args.tmgRipup else "",
            "--router2-alt-weights" if args.router2AltWeights else "",
            "--detailed-timing-report" if args.detailedTimingReport else "",
            f"--placed-svg {args.placedSvg}" if args.placedSvg else "",
            f"--routed-svg {args.routedSvg}" if args.routedSvg else "",
        ]
        try:
            sp.run(
                " ".join(runCmd),
                stdout=sys.stdout,
                stderr=sp.STDOUT,
                check=True,
                shell=True,
            )
        except sp.CalledProcessError:
            logger.error("Placement and Routing failed.")
            return

    else:
        logger.error(
            f'Cannot find file "{json_file}" in path "./{parent}/", which is generated by running Yosys with Nextpnr backend (e.g. synthesis).'
        )
        raise FileNotFoundError
