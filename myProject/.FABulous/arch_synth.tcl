set project_root $env(FAB_PROJECT_DIR)

yosys hierarchy -auto-top

yosys read_verilog -lib $project_root/.FABulous/libs.v
yosys read_rtlil -lib $project_root/.FABulous/cells.il
yosys read_verilog -lib $project_root/.FABulous/IO_buf.v
yosys proc
yosys flatten -noscopeinfo
yosys opt_expr
yosys opt_clean
yosys check
yosys opt -nodffe -nosdff
yosys fsm -nomap
yosys opt
yosys wreduce
yosys peepopt
yosys opt_clean
yosys share
yosys opt_expr
yosys opt_clean
yosys memory_dff -no-rw-check
yosys memory_collect

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
yosys techmap -map ../../myProject/Tile/PE/metadata/wrap_map_compare.v
yosys connwrappers -unsigned \$__eq_wrapper Y Y_WIDTH
yosys connwrappers -unsigned \$__le_wrapper Y Y_WIDTH
yosys connwrappers -unsigned \$__lt_wrapper Y Y_WIDTH

# extract cells
extract "../../myProject/Tile/PE/metadata/cell_compare_conf_2.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_compare.v"
extract "../../myProject/Tile/PE/metadata/cell_compare_conf_1.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_compare.v"
extract "../../myProject/Tile/PE/metadata/cell_compare_conf_0.il" \
        "../../myProject/Tile/PE/metadata/wrap_map_compare.v"
# unwrapping
yosys techmap -map ../../myProject/Tile/PE/metadata/unwrap_map_compare.v

# wrapping base design
yosys techmap -map ../../myProject/Tile/PE/metadata/wrap_map_reg_unit.v

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

yosys constmap -cell const_unit const_out ConfigBits

# io mapping
yosys iopadmap -widthparam WIDTH -outpad IO from_fabric:out -inpad IO to_fabric:in
yosys iopadmap -bits -outpad OUTBUF I:PAD -inpad INBUF O:PAD

# final optimization
yosys opt;;;
yosys clean -purge

yosys show -width -format dot -prefix $project_root/.FABulous/design
yosys write_json $project_root/user_design/synth_test.json
yosys stat