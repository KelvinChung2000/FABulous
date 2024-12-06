/home/kelvin/FABulous_fork/.venv/bin/python /home/kelvin/FABulous_fork/FABulous/fabric_cad/chip_database_generation.py
cd /home/kelvin/FABulous_fork/myProject/PnR
yosys -q ./test.v ./synth.ys -o test.json
nextpnr-himbaechel --chipdb ../.FABulous/eFPGA.bit --device "FABulous" \
 --json test.json --write test_routed.json -r \
 -o minII=2 \
 -o placeTrial=100 \
 --placer-heap-export-init-placement test_init_placement.csv
cd -