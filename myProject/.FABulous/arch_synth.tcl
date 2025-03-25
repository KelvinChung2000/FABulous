set project_root $env(FAB_PROJECT_DIR)

yosys read_verilog -sv $project_root/user_design/test.sv

yosys read_verilog -lib $project_root/.FABulous/libs.v
yosys read_rtlil -lib $project_root/.FABulous/cells.li
yosys read_verilog -lib $project_root/.FABulous/IO_buf.v
yosys prep -auto-top -flatten
yosys opt -full
yosys clean -purge


proc extract {cell wrapperPath} {
    # wrapping for mapping
    yosys design -push
    yosys read_rtlil $cell
    yosys techmap -map $wrapperPath
    yosys design -save xmap
    yosys design -pop
    
    # extracting cell
    yosys extract -constports -ignore_parameters -map %xmap
    yosys design -delete xmap
}


# wrapping base design
yosys techmap -map ../../myProject/Tile/PE/metadata/wrap_map_ALU.v
yosys connwrappers -unsigned \$__add_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__and_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__mul_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__or_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__sub_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__xor_wrapper Y Y_WIDTH 

# extract cells
extract "../../myProject/Tile/PE/metadata/cell_ALU_ALU_func_0.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "../../myProject/Tile/PE/metadata/cell_ALU_ALU_func_3.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "../../myProject/Tile/PE/metadata/cell_ALU_ALU_func_4.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "../../myProject/Tile/PE/metadata/cell_ALU_ALU_func_2.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "../../myProject/Tile/PE/metadata/cell_ALU_ALU_func_5.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "../../myProject/Tile/PE/metadata/cell_ALU_ALU_func_6.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "../../myProject/Tile/PE/metadata/cell_ALU_ALU_func_1.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_ALU.v"
# unwrapping
yosys techmap -map ../../myProject/Tile/PE/metadata/unwrap_map_ALU.v

# wrapping base design
yosys techmap -map ../../myProject/Tile/PE/metadata/wrap_map_reg_unit.v
yosys connwrappers -unsigned \$__and_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__or_wrapper Y Y_WIDTH 

# extract cells
extract "../../myProject/Tile/PE/metadata/cell_reg_unit_tide_en_0_tide_rst_1.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "../../myProject/Tile/PE/metadata/cell_reg_unit_tide_en_1_tide_rst_1.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "../../myProject/Tile/PE/metadata/cell_reg_unit_tide_en_1_tide_rst_0.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "../../myProject/Tile/PE/metadata/cell_reg_unit_tide_en_0_tide_rst_0.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
# unwrapping
yosys techmap -map ../../myProject/Tile/PE/metadata/unwrap_map_reg_unit.v

# wrapping base design
yosys techmap -map ../../myProject/Tile/N_IO/../include/metadata/wrap_map_IO.v

# extract cells
# unwrapping
yosys techmap -map ../../myProject/Tile/N_IO/../include/metadata/unwrap_map_IO.v


# cell techmapping
yosys techmap -map $project_root/.FABulous/techmaps.v

# const unit mapping
yosys read_rtlil -lib $project_root/Tile/PE/metadata/cell_const_unit.il
yosys hilomap -wrap const_unit const_out ConfigBits

# io mapping
yosys iopadmap -widthparam WIDTH -outpad IO from_fabric:out -inpad IO to_fabric:in
yosys iopadmap -bits -outpad OUTBUF I:PAD -inpad INBUF O:PAD

# final optimization
yosys opt;;;
yosys clean -purge

yosys write_json $project_root/user_design/synth_test.json