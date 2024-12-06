import math
import subprocess as sp
import sys
from functools import partial
from glob import glob
from multiprocessing import Pool
from pathlib import Path

import networkx as nx
from loguru import logger

from myProject.PnR.dotToVerilog import dotToVerilog

logger.remove()
logger.add(
    sys.stdout,
    level="INFO",
    format="{time:HH:mm:ss} | {level} | {message}",
    enqueue=True,
    backtrace=True,
    diagnose=True,
)

BENCHMARKS = [
    "aes_aes",
    "bfs_bulk",
    "bfs_queue",
    "fft_strided",
    "fft_transpose",
    "gemm_ncubed",
    "gemm_blocked",
    "kmp_kmp",
    "md_knn",
    "md_grid",
    "nw_nw",
    "sort_merge",
    "sort_radix",
    "spmv_crs",
    "spmv_ellpack",
    "stencil_stencil2d",
    "stencil_stencil3d",
    "viterbi_viterbi",
]

arch = "SpecArch"
mapper = "ILPMapper"
maxThreads = 80
# row = 4
# col = 4


@logger.catch
def runMapping(benchmark, context=-1, row=4, col=4):
    path = f"{Path.home()}/MachSuite/benchmark/dfg/{benchmark}/"
    logger.info(f"Running mapping for {path}")
    basePath = [i for i in glob(f"{path}/Loop*")]
    for p in basePath:
        allDfg = [i for i in glob(f"{p}/*.dot")]
        allDfgGraphs = [
            (Path(dfg), nx.drawing.nx_agraph.read_dot(dfg)) for dfg in allDfg
        ]
        sortedDfgGraphs = sorted(
            allDfgGraphs, key=lambda x: x[1].number_of_nodes(), reverse=True
        )

        allUniqueMem = set()
        for _, g in sortedDfgGraphs:
            allUniqueMem.update(
                [j for _, j in g.nodes.data("memName", None) if j is not None]
            )

        initGraph, *restGraphs = sortedDfgGraphs
        logger.info(f"Running mapping for {str(initGraph[0])}")
        II = math.ceil(len(initGraph[1]) / (row * col))

        if context != -1:
            II = context

        logger.info(f"II: {II}")
        logger.info(f"Number of unique memory: {len(allUniqueMem)}")
        logger.info(f"Name of memory: {allUniqueMem}")
        # if len(allUniqueMem) > row:
        #     logger.warning(f"Number of unique memory is more than col count: {col}, skipping")
        #     continue

        logger.info("Dot to Verilog")
        try:
            dotToVerilog(initGraph[0], initGraph[0].with_suffix(".v"))
        except Exception as e:
            logger.error(e)
            continue

        logger.info("Start init mapping")

        logger.info("Synthesising")
        cmd = [
            "yosys",
            "-q",
            str(initGraph[0].with_suffix(".v")),
            "/home/kelvin/FABulous_fork/myProject/PnR/synth.ys",
            "-o",
            str(initGraph[0].with_suffix(".json")),
        ]
        logger.info(" ".join(cmd))
        result = sp.run(cmd, check=True)
        if result.returncode != 0:
            logger.error("Synthesis failed")
            continue

        cmd = [
            "nextpnr-himbaechel",
            "-q",
            "--chipdb",
            "/home/kelvin/FABulous_fork/myProject/.FABulous/eFPGA.bit",
            "--device",
            "FABulous",
            "--json",
            str(initGraph[0].with_suffix(".json")),
            "--write",
            str(initGraph[0].parent / (initGraph[0].stem + "_routed.json")),
            "-o",
            "minII=2",
            "-o",
            "placeTrial=200",
            "--placer-heap-export-init-placement",
            str(initGraph[0].with_suffix(".csv")),
        ]

        logger.info(" ".join(cmd))
        try:
            sp.run(cmd, timeout=60)
        except sp.TimeoutExpired:
            logger.error("Timeout")
            logger.error("Init Mapping Fail")
            continue

        if not Path.exists(initGraph[0].parent / (initGraph[0].stem + "_routed.json")):
            logger.error("Init Mapping Fail")
            continue

        # with open(resultPath, "r") as f:
        #     dotG = f.read()
        # with open(resultPath, "w") as f:
        #     f.write(re.sub(r'name=".*?", ', "", dotG))

        # resultGraph = nx.DiGraph(nx.drawing.nx_pydot.read_dot(resultPath))
        # regOp = [i for i in resultGraph.nodes if "RegOp.fu" in i]
        # memOp = [i for i in resultGraph.nodes if "gep_mem_unit.mem" in i]
        # logger.info(f"Number of RegOp: {len(regOp)}")
        # logger.info(f"Number of MemOp: {len(memOp)}")


if __name__ == "__main__":
    sp.run(
        "/home/kelvin/FABulous_fork/.venv/bin/python /home/kelvin/FABulous_fork/FABulous/fabric_cad/chip_database_generation.py".split()
    )
    with Pool(4) as p:
        f = partial(runMapping, context=4, row=4, col=4)
        result = p.map(f, BENCHMARKS)
        # f = partial(runMapping, context=8, row=8, col=8)
        # result = p.map(f, BENCHMARKS)
