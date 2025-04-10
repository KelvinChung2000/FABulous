set project_root $env(FAB_PROJECT_DIR)

yosys hierarchy -auto-top

yosys read_verilog -lib $project_root/.FABulous/libs.v
yosys read_rtlil -lib $project_root/.FABulous/cells.il
yosys read_verilog -lib $project_root/.FABulous/IO_buf.v
yosys flatten -noscopeinfo
yosys proc
# yosys opt_expr
# yosys opt_clean
# yosys check
# yosys opt -nodffe -nosdff
# yosys fsm -nomap -expand -encfile $project_root/.FABulous/fsm_state_info.txt
# yosys opt
# yosys wreduce
# yosys peepopt
# yosys opt_clean
# yosys share
# yosys opt_expr
# yosys opt_clean
yosys memory_collect
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


# # wrapping base design
# yosys techmap -map myProject/Tile/PE/metadata/wrap_map_ALU.v
# yosys connwrappers -unsigned \$__or_wrapper Y Y_WIDTH 
# yosys connwrappers -unsigned \$__xor_wrapper Y Y_WIDTH 
# yosys connwrappers -unsigned \$__mul_wrapper Y Y_WIDTH 
# yosys connwrappers -unsigned \$__add_wrapper Y Y_WIDTH 
# yosys connwrappers -unsigned \$__sub_wrapper Y Y_WIDTH 
# yosys connwrappers -unsigned \$__mux_wrapper Y WIDTH 

# # extract cells
# extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_3.json" \
#         "myProject/Tile/PE/metadata/wrap_map_ALU.v"
# extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_4.json" \
#         "myProject/Tile/PE/metadata/wrap_map_ALU.v"
# extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_5.json" \
#         "myProject/Tile/PE/metadata/wrap_map_ALU.v"
# extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_0.json" \
#         "myProject/Tile/PE/metadata/wrap_map_ALU.v"
# extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_1.json" \
#         "myProject/Tile/PE/metadata/wrap_map_ALU.v"
# extract "myProject/Tile/PE/metadata/cell_ALU_ALU_func_6.json" \
#         "myProject/Tile/PE/metadata/wrap_map_ALU.v"
# # unwrapping
# yosys techmap -map myProject/Tile/PE/metadata/unwrap_map_ALU.v

# # wrapping base design
# yosys techmap -map myProject/Tile/PE/metadata/wrap_map_compare.v
# yosys connwrappers -unsigned \$__lt_wrapper Y Y_WIDTH 
# yosys connwrappers -unsigned \$__le_wrapper Y Y_WIDTH 
# yosys connwrappers -unsigned \$__eq_wrapper Y Y_WIDTH 

# # extract cells
# extract "myProject/Tile/PE/metadata/cell_compare_conf_0.json" \
#         "myProject/Tile/PE/metadata/wrap_map_compare.v"
# extract "myProject/Tile/PE/metadata/cell_compare_conf_1.json" \
#         "myProject/Tile/PE/metadata/wrap_map_compare.v"
# extract "myProject/Tile/PE/metadata/cell_compare_conf_2.json" \
#         "myProject/Tile/PE/metadata/wrap_map_compare.v"
# # unwrapping
# yosys techmap -map myProject/Tile/PE/metadata/unwrap_map_compare.v

# # wrapping base design
# yosys techmap -map myProject/Tile/PE/metadata/wrap_map_reg_unit.v
# yosys connwrappers -unsigned \$__sdffe_wrapper Q WIDTH 
# yosys connwrappers -unsigned \$__sdff_wrapper Q WIDTH 
# yosys connwrappers -unsigned \$__dff_wrapper Q WIDTH 
# yosys connwrappers -unsigned \$__dffe_wrapper Q WIDTH 

# # extract cells
# extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_0_tide_rst_1.json" \
#         "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
# extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_1_tide_rst_1.json" \
#         "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
# extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_1_tide_rst_0.json" \
#         "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
# extract "myProject/Tile/PE/metadata/cell_reg_unit_tide_en_0_tide_rst_0.json" \
#         "myProject/Tile/PE/metadata/wrap_map_reg_unit.v"
# # unwrapping
# yosys techmap -map myProject/Tile/PE/metadata/unwrap_map_reg_unit.v

# # wrapping base design
# yosys techmap -map myProject/Tile/N_IO/../include/metadata/wrap_map_IO.v

# # extract cells
# # unwrapping
# yosys techmap -map myProject/Tile/N_IO/../include/metadata/unwrap_map_IO.v

# wrapping base design
yosys techmap -map myProject/Tile/E_Mem_bot/metadata/wrap_map_Mem.v
yosys connwrappers -unsigned \$__mux_wrapper Y WIDTH 
yosys connwrappers -unsigned \$__mem_v2_wrapper RD_DATA WIDTH 

# extract cells
extract "myProject/Tile/E_Mem_bot/metadata/cell_Mem_read_allow_1_write_allow_1.json" \
        "myProject/Tile/E_Mem_bot/metadata/wrap_map_Mem.v"
extract "myProject/Tile/E_Mem_bot/metadata/cell_Mem_read_allow_1_write_allow_0.json" \
        "myProject/Tile/E_Mem_bot/metadata/wrap_map_Mem.v"
# unwrapping
# yosys techmap -map myProject/Tile/E_Mem_bot/metadata/unwrap_map_Mem.v


# cell techmapping
# yosys techmap -map $project_root/.FABulous/techmaps.v

# # const unit mapping

# yosys constmap -cell const_unit const_out ConfigBits

# # io mapping
# yosys iopadmap -widthparam WIDTH -outpad IO from_fabric:out -inpad IO to_fabric:in
# yosys iopadmap -bits -outpad OUTBUF I:PAD -inpad INBUF O:PAD

# # final optimization
# yosys fsm -expand
# yosys opt -full 
# yosys clean -purge

# yosys show -enum -long -width -format dot -prefix $project_root/.FABulous/design
# yosys write_json $project_root/user_design/synth_test.json
# yosys fsm_info
yosys stat