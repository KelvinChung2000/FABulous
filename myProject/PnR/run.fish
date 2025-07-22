#!/bin/fish
# /home/kelvin/FABulous_fork/.venv/bin/python /home/kelvin/FABulous_fork/FABulous/fabric_cad/chip_database_generation.py
# cd /home/kelvin/FABulous_fork/myProject/PnR
# yosys -q ./test.v ./synth.ys -o test.json
# nextpnr-himbaechel --chipdb ../.FABulous/hycube.bit --device "FABulous" \
#  --json test.json --write test_routed.json -r \
#  -o minII=2 \
#  -o placeTrial=100 \
#  --placer-heap-export-init-placement test_init_placement.csv
# cd -

function check_status
    set -l last_status $status
    if test $last_status -ne 0
        echo "Error: Command failed with status $last_status"
        exit 1
    end
end

set source_futil /home/kelvin/FABulous_fork/myProject/PnR/mac-pipelined/mac-pipelined.futil 
# set source_hdl /home/kelvin/FABulous_fork/myProject/PnR/mac-pipelined/mac-pipelined.sv
# set source_hdl /home/kelvin/FABulous_fork/benchmarks/userbench/loop_array/loop_array.sv
set source_hdl /home/kelvin/FABulous_fork/benchmarks/userbench/loop_array_inner/loop_array_inner.sv
# set source_hdl /home/kelvin/FABulous_fork/myProject/PnR/test.v
# set source_hdl /home/kelvin/FABulous_fork/myProject/user_design/synth_test_mod.v
set source_hdl /home/kelvin/FABulous_fork/myProject/PnR/compilation_result/04_verilog/spmv_crs_inner_loop_0.sv
set -x OUT_JSON_PATH /home/kelvin/FABulous_fork/myProject/user_design/synth_test.json
set ir /home/kelvin/FABulous_fork/myProject/PnR/mac-pipelined/ir.log
set my_FAB_ROOT /home/kelvin/FABulous_fork

# cd /home/kelvin/calyx
# cargo build
# cd -

set clayx_flag "-p fsm-opt -x simplify-with-control:without-register -x static-inline:offload-pause=false -p lower --nested -d papercut -d cell-share"

# calyx --dump-ir $clayx_flag $source_futil -o $source_hdl > $ir
# check_status
cd ../..
# FABulous --debug myProject -p "load_fabric; gen_FABulous_CAD_tool_files"
uv run FABulous --debug myProject -p \
        "\
        load_fabric; \
        gen_bitStream_spec; \
        gen_cells_and_techmaps; \
        gen_chipdb -routing_graph $my_FAB_ROOT/myProject/.FABulous/routing_graph.dot -filter 3,5 3,4; \
        "
        # synthesis_script $source_hdl -tcl $my_FAB_ROOT/myProject/.FABulous/arch_synth.tcl; \
# /home/kelvin/FABulous_fork/.venv/bin/python /home/kelvin/FABulous_fork/FABulous/fabric_cad/graph_draw2.py
check_status
cd -
# # # FABulous --debug ../../myProject -p "load_fabric; gen_FABulous_CAD_tool_files;"
# # # xdot /home/kelvin/FABulous_fork/myProject/.FABulous/routing_graph.dot &
# gdb -args \
nextpnr-himbaechel --chipdb "$my_FAB_ROOT/myProject/.FABulous/hycube.bit" --device "FABulous" \
                   --json "$OUT_JSON_PATH" \
                   --write "$my_FAB_ROOT/myProject/user_design/router_test.json" \
                   -o constrain-pair="$my_FAB_ROOT/myProject/.FABulous/hycube_constrain_pair.inc" \
                   -o fasm="$my_FAB_ROOT/myProject/user_design/router_test.fasm" \
                   -o fdc="$my_FAB_ROOT/myProject/user_design/test.fdc" \
                   --placer-heap-seed-placement-strategy graph_grid \
                   --placer-heap-beta 0.9 \
                   --placer-heap-arch-connectivity-factor 0.0 \
                   --placer-heap-congestion-aware-factor 0.0 \
                #    --no-route \
                   -o placeTrial=10 --router1-timeout 20000 -f --debug-placer
                #    --placer-heap-export-init-placement "$my_FAB_ROOT/myProject/user_design/test_init_placement.csv" \
# successful seed:5743725230106451036 
# python $my_FAB_ROOT/myProject/Test/test_fabric.py

# /home/kelvin/FABulous_fork/.venv/bin/python /home/kelvin/FABulous_fork/FABulous/fabric_cad/graph_draw2.py