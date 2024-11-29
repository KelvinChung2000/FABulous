yosys ./synth.ys
nextpnr-himbaechel --chipdb ../.FABulous/eFPGA.bit --device "FABulous" \
 --json test.json --write test_routed.json -r \
 -o minII=2 \
 -o placeTrial=100