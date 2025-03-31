import os
import subprocess as sp
from pathlib import Path

from cmd2 import Cmd, Cmd2ArgumentParser, with_argparser, with_category
from loguru import logger

from FABulous.FABulous_CLI.define import CMD_FABRIC_FLOW
from FABulous.FABulous_CLI.helper import check_if_application_exists

synthesis_parser = Cmd2ArgumentParser()
synthesis_parser.add_argument(
    "synthFile",
    help="Path to the target files.",
    nargs="*",
    completer=Cmd.path_complete,
)
synthesis_parser.add_argument("-q", "--quiet", action="store_true", help="Quiet mode")
scriptTypeGroup = synthesis_parser.add_mutually_exclusive_group(required=True)
scriptTypeGroup.add_argument("-tcl", type=Path, help="Run TCL script")
scriptTypeGroup.add_argument("-ys", type=Path, help="Run Yosys script")


@with_category(CMD_FABRIC_FLOW)
@with_argparser(synthesis_parser)
def do_synthesis_script(self, args):
    logger.info("Synthesis with a synthesis script")
    resolvePaths: list[Path] = [Path(i).absolute() for i in args.synthFile]

    for i in resolvePaths:
        if not i.exists():
            logger.error(f"{i} does not exits")
            return

    yosys = check_if_application_exists(os.getenv("FAB_YOSYS_PATH", "yosys"))
    runCmd = [
        f"{yosys}",
        "-q" if args.quiet else "",
        "-s" if args.ys else "",
        f"{Path(args.ys).absolute()}" if args.ys else "",
        "-c" if args.tcl else "",
        f"{Path(args.tcl).absolute()}" if args.tcl else "",
        f"{" ".join([str(i) for i in resolvePaths])}",
    ]
    runCmd = [i for i in runCmd if i != ""]

    try:
        sp.run(runCmd, check=True)
        logger.info("Synthesis completed")
    except sp.CalledProcessError:
        logger.error("Synthesis failed")
