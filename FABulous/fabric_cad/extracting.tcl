
yosys read_verilog -sv ./myProject/Tile/PE/ALU.v
yosys hierarchy -auto-top
yosys proc
yosys design -save base
#connect -set
yosys opt;;;
set stat [yosys tee -q -s result.json stat -json]
set cell_count [dict get $stat design num_cells ]

set inPorts [split [yosys tee -q -s result.string select -list i:* a:'[CONTROL]' %i] "\n"]
puts $inPorts
