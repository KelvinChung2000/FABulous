yosys ./synth.ys
nextpnr-himbaechel --chipdb ../.FABulous/eFPGA.bit --device "test" --json test.json --write test_routed.json --router router2 --debug-router