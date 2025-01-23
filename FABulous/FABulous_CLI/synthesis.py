import os
import subprocess as sp
from pathlib import Path

from cmd2 import Cmd, Cmd2ArgumentParser, with_argparser, with_category
from loguru import logger

from FABulous.FABulous_CLI.helper import check_if_application_exists

CMD_FABRIC_FLOW = "Fabric Flow"
HELP = """
Runs Yosys using Nextpnr JSON backend to synthesise the Verilog design
specified by <files> and generates a Nextpnr-compatible JSON file for
further place and route process. By default the name of the JSON file generated 
will be <first_file_provided_stem>.json.

Also logs usage errors or synthesis failures.

The following commands are executed by when executing the synthesis command:
    read_verilog <"projectDir"/user_design/top_wrapper.v>
    read_verilog <file>                 (for each file in files)
    read_verilog  -lib +/fabulous/prims.v
    read_verilog -lib <extra_plib.v>    (for each -extra-plib)

    begin:
        hierarchy -check
        proc

    flatten:    (unless -noflatten)
        flatten
        tribuf -logic
        deminout

    coarse:
        tribuf -logic
        deminout
        opt_expr
        opt_clean
        check
        opt -nodffe -nosdff
        fsm          (unless -nofsm)
        opt
        wreduce
        peepopt
        opt_clean
        techmap -map +/cmp2lut.v -map +/cmp2lcu.v     (if -lut)
        alumacc      (unless -noalumacc)
        share        (unless -noshare)
        opt
        memory -nomap
        opt_clean

    map_ram:    (unless -noregfile)
        memory_libmap -lib +/fabulous/ram_regfile.txt
        techmap -map +/fabulous/regfile_map.v

    map_ffram:
        opt -fast -mux_undef -undriven -fine
        memory_map
        opt -undriven -fine

    map_gates:
        opt -full
        techmap -map +/techmap.v -map +/fabulous/arith_map.v -D ARITH_<carry>
        opt -fast

    map_iopad:    (if -iopad)
        opt -full
        iopadmap -bits -outpad $__FABULOUS_OBUF I:PAD -inpad $__FABULOUS_IBUF O:PAD -toutpad IO_1_bidirectional_frame_config_pass ~T:I:PAD -tinoutpad IO_1_bidirectional_frame_config_pass ~T:O:I:PAD A:top    (skip if '-noiopad')
        techmap -map +/fabulous/io_map.v

    map_ffs:
        dfflegalize -cell $_DFF_P_ 0 -cell $_DLATCH_?_ x    without -complex-dff
        techmap -map +/fabulous/latches_map.v
        techmap -map +/fabulous/ff_map.v
        techmap -map <extra_map.v>...    (for each -extra-map)
        clean

    map_luts:
        abc -lut 4 -dress
        clean

    map_cells:
        techmap -D LUT_K=4 -map +/fabulous/cells_map.v
        clean

    check:
        hierarchy -check
        stat

    blif:
        opt_clean -purge
        write_blif -attr -cname -conn -param <file-name>

    json:
        write_json <file-name>
"""


synthesis_parser = Cmd2ArgumentParser(description=HELP)
synthesis_parser.add_argument(
    "files", type=Path, help="Path to the target files", completer=Cmd.path_complete, nargs="+"
)
synthesis_parser.add_argument(
    "-top", type=str, help="use the specified module as top module (default='top_wrapper')", default="top_wrapper"
)
synthesis_parser.add_argument("-auto-top", help="automatically determine the top of the design hierarchy")
synthesis_parser.add_argument(
    "-blif",
    type=Path,
    help="write the design to the specified BLIF file. writing of an output file is omitted "
    "if this parameter is not specified.",
    completer=Cmd.path_complete,
)
synthesis_parser.add_argument(
    "-edif",
    type=Path,
    help="write the design to the specified EDIF file. writing of an output file is omitted "
    "if this parameter is not specified.",
    completer=Cmd.path_complete,
)
synthesis_parser.add_argument(
    "-json",
    type=Path,
    help="write the design to the specified JSON file. "
    "if this parameter is not specified it will default to <first_file_stem>.json",
    completer=Cmd.path_complete,
)
synthesis_parser.add_argument(
    "-lut", type=str, default="4", help="perform synthesis for a k-LUT architecture (default 4)."
)
synthesis_parser.add_argument(
    "-plib",
    type=str,
    help="use the specified Verilog file as a primitive library.",
    completer=Cmd.path_complete,
)
synthesis_parser.add_argument(
    "-extra-plib",
    type=Path,
    help="use the specified Verilog file for extra primitives (can be specified multiple times).",
    action="append",
    completer=Cmd.path_complete,
)
synthesis_parser.add_argument(
    "-extra-map",
    type=Path,
    help="use the specified Verilog file for extra techmap rules (can be specified multiple times).",
    action="append",
    completer=Cmd.path_complete,
)
synthesis_parser.add_argument(
    "-encfile", type=Path, help="passed to 'fsm_recode' via 'fsm'", completer=Cmd.path_complete
)
synthesis_parser.add_argument("-nofsm", help="do not run FSM optimization")
synthesis_parser.add_argument(
    "-noalumacc",
    help="do not run 'alumacc' pass. i.e. keep arithmetic operators in their direct form ($add, $sub, etc.).",
)
synthesis_parser.add_argument(
    "-carry",
    type=str,
    required=False,
    choices=["none", "ha"],
    default="none",
    help="carry mapping style (none, half-adders, ...) default=none",
)
synthesis_parser.add_argument("-noregfile", help="do not map register files")
synthesis_parser.add_argument(
    "-iopad",
    help="enable automatic insertion of IO buffers (otherwise a wrapper with "
    "manually inserted and constrained IO should be used.)",
)
synthesis_parser.add_argument(
    "-complex-dff",
    help="enable support for FFs with enable and synchronous SR (must also be supported by the target fabric.)",
)
synthesis_parser.add_argument("-noflatten", help="do not flatten design after elaboration")
synthesis_parser.add_argument(
    "-nordff", required=False, help="passed to 'memory'. prohibits merging of FFs into memory read ports"
)
synthesis_parser.add_argument("-noshare", help="do not run SAT-based resource sharing")
synthesis_parser.add_argument(
    "-run",
    help="only run the commands between the labels (see below). an empty from label is synonymous to 'begin',"
    " and empty to label is synonymous to the end of the command list.",
)
synthesis_parser.add_argument(
    "-no-rw-check",
    help="marks all recognized read ports as 'return don't-care value on read/write collision'"
    "(same result as setting the no_rw_check attribute on all memories).",
)


@with_category(CMD_FABRIC_FLOW)
@with_argparser(synthesis_parser)
def do_synthesis(self, args):
    logger.info(f"Running synthesis that targeting Nextpnr with design {[str(i) for i in args.files]}")

    p: Path
    paths: list[Path] = []
    for p in args.files:
        if p.is_absolute():
            paths.append(p)
        else:
            resolvePath: Path = self.projectDir / p
            if resolvePath.exists():
                paths.append(resolvePath)
            else:
                logger.error(f"{resolvePath} does not exits")
                return

    json_file = paths[0].with_suffix(".json")
    yosys = check_if_application_exists(os.getenv("FAB_YOSYS_PATH", "yosys"))

    cmd = [
        "synth_fabulous",
        f"-top {args.top}",
        f"-blif {args.blif}" if args.blif else "",
        f"-edif {args.edif}" if args.edif else "",
        f"-json {args.json}" if args.json else f"-json {json_file}",
        f"-lut {args.lut}" if args.lut else "",
        f"-plib {args.plib}" if args.plib else "",
        " ".join([f"-extra-plib {i}" for i in args.extra_plib]) if args.extra_plib else "",
        " ".join([f"-extra-map {i}" for i in args.extra_map]) if args.extra_map else "",
        f"-encfile {args.encfile}" if args.encfile else "",
        "-nofsm" if args.nofsm else "",
        "-noalumacc" if args.noalumacc else "",
        f"-carry {args.carry}" if args.carry else "",
        "-noregfile" if args.noregfile else "",
        "-iopad" if args.iopad else "",
        "-complex-dff" if args.complex_dff else "",
        "-noflatten" if args.noflatten else "",
        "-noshare" if args.noshare else "",
        f"-run {args.run}" if args.run else "",
        "-no-rw-check" if args.no_rw_check else "",
    ]

    cmd = " ".join([i for i in cmd if i != ""])

    runCmd = [f"{yosys}", "-p", f'{cmd}', f"{self.projectDir}/user_design/top_wrapper.v", *[str(i) for i in paths]]
    logger.debug(f"{runCmd}")
    try:
        sp.run(runCmd, check=True)
        logger.info("Synthesis completed")
    except sp.CalledProcessError:
        logger.error("Synthesis failed")
