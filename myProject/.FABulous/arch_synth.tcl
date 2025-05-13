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

yosys fsm -encoding binary -expand
yosys opt
yosys techmap -map $project_root/.FABulous/logic_to_std.v

yosys peepopt
yosys opt_clean
yosys share
yosys opt_expr
yosys opt_clean
yosys techmap -map $project_root/.FABulous/reduce_or_to_or.v
yosys techmap -map $project_root/.FABulous/eq_to_and.v
yosys techmap -map $project_root/.FABulous/ne_to_xor.v


# memory opt
yosys opt_mem_priority
yosys opt_mem_feedback
yosys memory_bmux2rom
yosys memory_dff
yosys opt_clean
yosys memory_share
yosys opt_mem_widen
yosys opt_clean
yosys memory_collect

yosys opt -full
yosys memory_libmap -lib $project_root/.FABulous/memory_map.txt
yosys techmap -map $project_root/.FABulous/techmaps.v

# const unit mapping
yosys constmap -cell \$__const O VALUE
yosys techmap -map $project_root/.FABulous/const_map.v
yosys opt -full

proc extract {cell wrapperPath} {
    # wrapping for mapping
    yosys design -push
    yosys read_json $cell
    yosys techmap -map $wrapperPath
    yosys design -save xmap
    yosys design -pop

    # extracting cell
    yosys extract -constports -ignore_parameters -map %xmap
    yosys design -delete xmap
}



# wrapping base design
yosys techmap -map myProject/Tile/PE/metadata/wrap_map_reg_unit_WIDTH_1.v
yosys connwrappers -unsigned \$__sdff_wrapper Q WIDTH 
yosys connwrappers -unsigned \$__dffe_wrapper Q WIDTH 
yosys connwrappers -unsigned \$__sdffe_wrapper Q WIDTH 
yosys connwrappers -unsigned \$__dff_wrapper Q WIDTH 

# extract cells
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_1_tide_rst_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit_WIDTH_1.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_0_tide_rst_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit_WIDTH_1.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_0_tide_rst_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit_WIDTH_1.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_1_tide_rst_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit_WIDTH_1.v"
# unwrapping
yosys techmap -map myProject/Tile/PE/metadata/unwrap_map_reg_unit_WIDTH_1.v
yosys opt -full
yosys clean -purge

# wrapping base design
yosys techmap -map myProject/Tile/PE/metadata/wrap_map_ALU.v
yosys connwrappers -unsigned \$__xor_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__mul_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__add_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__sub_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__mux_wrapper Y WIDTH 

# extract cells
extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_4.json" \
        "myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_5.json" \
        "myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_ALU.v"
extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_6.json" \
        "myProject/Tile/PE/metadata/wrap_map_ALU.v"
# unwrapping
yosys techmap -map myProject/Tile/PE/metadata/unwrap_map_ALU.v
yosys opt -full
yosys clean -purge

# wrapping base design
yosys techmap -map myProject/Tile/PE/metadata/wrap_map_logic_op.v
yosys connwrappers -unsigned \$__and_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__or_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__not_wrapper Y Y_WIDTH 
yosys connwrappers -unsigned \$__xor_wrapper Y Y_WIDTH 

# extract cells
extract "myProject/Tile/PE/metadata/cell_logic_op_conf_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_logic_op.v"
extract "myProject/Tile/PE/metadata/cell_logic_op_conf_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_logic_op.v"
extract "myProject/Tile/PE/metadata/cell_logic_op_conf_3.json" \
        "myProject/Tile/PE/metadata/wrap_map_logic_op.v"
extract "myProject/Tile/PE/metadata/cell_logic_op_conf_2.json" \
        "myProject/Tile/PE/metadata/wrap_map_logic_op.v"
# unwrapping
yosys techmap -map myProject/Tile/PE/metadata/unwrap_map_logic_op.v
yosys opt -full
yosys clean -purge

# wrapping base design
yosys techmap -map myProject/Tile/PE/metadata/wrap_map_reg_unit.v
yosys connwrappers -unsigned \$__sdff_wrapper Q WIDTH 
yosys connwrappers -unsigned \$__sdffe_wrapper Q WIDTH 
yosys connwrappers -unsigned \$__dffe_wrapper Q WIDTH 
yosys connwrappers -unsigned \$__dff_wrapper Q WIDTH 

# extract cells
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_1_tide_rst_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_0_tide_rst_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_0_tide_rst_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_0_tide_rst_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_1_tide_rst_1.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_WIDTH_1_tide_en_1_tide_rst_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_1_tide_rst_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_0_tide_rst_0.json" \
        "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
# unwrapping
yosys techmap -map myProject/Tile/PE/metadata/unwrap_map_reg_unit.v
yosys opt -full
yosys clean -purge


# FSM mapping


# cell techmapping
yosys techmap -map $project_root/.FABulous/techmaps.v



# io mapping
yosys iopadmap -widthparam WIDTH -outpad \$__external_out I:O -inpad \$__external_in O:I
yosys techmap -map $project_root/.FABulous/IO_techmap.v


# final optimization
yosys opt -full
yosys clean -purge
yosys fsm_info
yosys show -enum -long -width -format dot -prefix $project_root/.FABulous/design
yosys write_json $project_root/user_design/synth_test.json
yosys stat