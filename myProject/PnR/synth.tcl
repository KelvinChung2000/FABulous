set fabRoot $env(my_FAB_ROOT)

yosys read_verilog -sv $fabRoot/myProject/user_design/test.sv
yosys read_verilog -lib $fabRoot/myProject/.FABulous/libs.v
yosys read_rtlil -lib $fabRoot/myProject/.FABulous/cells.li
yosys read_verilog -lib $fabRoot/myProject/.FABulous/IO_buf.v
yosys prep -auto-top -flatten
yosys opt -full
yosys clean -purge

yosys techmap -map $fabRoot/myProject/.FABulous/wrap_map.v
yosys read_rtlil -lib $fabRoot/myProject/Tile/PE/metadata/cell_ALU_ALU_func_0.il
yosys connwrappers -unsigned \$__add_wrapper Y Y_WIDTH ;;
yosys design -push 
yosys read_rtlil $fabRoot/myProject/Tile/PE/metadata/cell_ALU_ALU_func_0.il
yosys techmap -map $fabRoot/myProject/.FABulous/wrap_map.v
yosys design -save __add_xmap
yosys design -pop
yosys extract -constports -ignore_parameters -map %__add_xmap -swap "\$__add_wrapper" A,B;;
yosys techmap -map $fabRoot/myProject/.FABulous/unwrap_map.v
yosys techmap -map $fabRoot/myProject/.FABulous/techmaps.v

yosys read_rtlil -lib $fabRoot/myProject/Tile/PE/metadata/cell_const_unit.il
yosys hilomap -wrap const_unit const_out ConfigBits

yosys extract -map $fabRoot/myProject/Tile/PE/metadata/cell_reg_unit_en_1_rst_0.il
yosys techmap -map $fabRoot/myProject/.FABulous/techmaps.v

yosys iopadmap -widthparam WIDTH -outpad IO from_fabric:out -inpad IO to_fabric:in
yosys iopadmap -bits -outpad OUTBUF I:PAD -inpad INBUF O:PAD

yosys opt;;;
yosys clean -purge
#syosys show -width

yosys write_json $fabRoot/myProject/user_design/synth_test.json
