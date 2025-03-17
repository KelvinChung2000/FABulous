# /home/kelvin/FABulous_fork/.venv/bin/python /home/kelvin/FABulous_fork/FABulous/fabric_cad/chip_database_generation.py
# cd /home/kelvin/FABulous_fork/myProject/PnR
# yosys -q ./test.v ./synth.ys -o test.json
# nextpnr-himbaechel --chipdb ../.FABulous/hycube.bit --device "FABulous" \
#  --json test.json --write test_routed.json -r \
#  -o minII=2 \
#  -o placeTrial=100 \
#  --placer-heap-export-init-placement test_init_placement.csv
# cd -

FABulous --debug ../../myProject -p "load_fabric; gen_FABulous_CAD_tool_files; synthesis_script -q -tcl synth.tcl"
# xdot /home/kelvin/FABulous_fork/myProject/.FABulous/routing_graph.dot &
nextpnr-himbaechel --chipdb ../.FABulous/hycube.bit --device "FABulous" \
                   --json $my_FAB_ROOT/myProject/user_design/synth_test.json \
                   --write $my_FAB_ROOT/myProject/user_design/router_test.json \
                   -o constrain-pair=$my_FAB_ROOT/myProject/.FABulous/hycube_constrain_pair.inc \
                   -o fasm=$my_FAB_ROOT/myProject/user_design/router_test.fasm
/home/kelvin/FABulous_fork/.venv/bin/python /home/kelvin/FABulous_fork/FABulous/fabric_cad/graph_draw.py