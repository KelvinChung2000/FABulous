module attributes {calyx.entrypoint = "main"} {
  calyx.component @main(%in0: i32, %in1: i32, %in2: i32, %in3: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %mem_1.addr0, %mem_1.clk, %mem_1.reset, %mem_1.content_en, %mem_1.write_en, %mem_1.write_data, %mem_1.read_data, %mem_1.done = calyx.seq_mem @mem_1 <[2048] x 32> [11] {external = true} : i11, i1, i1, i1, i1, i32, i32, i1
    %mem_0.addr0, %mem_0.clk, %mem_0.reset, %mem_0.content_en, %mem_0.write_en, %mem_0.write_data, %mem_0.read_data, %mem_0.done = calyx.seq_mem @mem_0 <[2048] x 32> [11] {external = true} : i11, i1, i1, i1, i1, i32, i32, i1
    %sort_radix_inner_loop_1_instance.in0, %sort_radix_inner_loop_1_instance.in2, %sort_radix_inner_loop_1_instance.in3, %sort_radix_inner_loop_1_instance.in4, %sort_radix_inner_loop_1_instance.clk, %sort_radix_inner_loop_1_instance.reset, %sort_radix_inner_loop_1_instance.go, %sort_radix_inner_loop_1_instance.done = calyx.instance @sort_radix_inner_loop_1_instance of @sort_radix_inner_loop_1 : i32, i32, i32, i32, i1, i1, i1, i1
    calyx.wires {
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.invoke @sort_radix_inner_loop_1_instance[arg_mem_0 = mem_0, arg_mem_1 = mem_1](%sort_radix_inner_loop_1_instance.in0 = %in0, %sort_radix_inner_loop_1_instance.in2 = %in1, %sort_radix_inner_loop_1_instance.in3 = %in2, %sort_radix_inner_loop_1_instance.in4 = %in3) -> (i32, i32, i32, i32)
        }
      }
    }
  } {toplevel}
  calyx.component @sort_radix(%clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %c4_i32 = hw.constant 4 : i32
    %c512_i32 = hw.constant 512 : i32
    %c0_i32 = hw.constant 0 : i32
    %c32_i32 = hw.constant 32 : i32
    %c2_i32 = hw.constant 2 : i32
    %c2048_i32 = hw.constant 2048 : i32
    %c1_i32 = hw.constant 1 : i32
    %c16_i32 = hw.constant 16 : i32
    %c128_i32 = hw.constant 128 : i32
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i7
    %std_add_14.left, %std_add_14.right, %std_add_14.out = calyx.std_add @std_add_14 : i32, i32, i32
    %std_slt_14.left, %std_slt_14.right, %std_slt_14.out = calyx.std_slt @std_slt_14 : i32, i32, i1
    %std_add_13.left, %std_add_13.right, %std_add_13.out = calyx.std_add @std_add_13 : i32, i32, i32
    %std_slt_13.left, %std_slt_13.right, %std_slt_13.out = calyx.std_slt @std_slt_13 : i32, i32, i1
    %std_add_12.left, %std_add_12.right, %std_add_12.out = calyx.std_add @std_add_12 : i32, i32, i32
    %std_slt_12.left, %std_slt_12.right, %std_slt_12.out = calyx.std_slt @std_slt_12 : i32, i32, i1
    %std_add_11.left, %std_add_11.right, %std_add_11.out = calyx.std_add @std_add_11 : i32, i32, i32
    %std_slt_11.left, %std_slt_11.right, %std_slt_11.out = calyx.std_slt @std_slt_11 : i32, i32, i1
    %std_pad_0.in, %std_pad_0.out = calyx.std_pad @std_pad_0 : i1, i32
    %std_add_10.left, %std_add_10.right, %std_add_10.out = calyx.std_add @std_add_10 : i32, i32, i32
    %std_slt_10.left, %std_slt_10.right, %std_slt_10.out = calyx.std_slt @std_slt_10 : i32, i32, i1
    %std_add_9.left, %std_add_9.right, %std_add_9.out = calyx.std_add @std_add_9 : i32, i32, i32
    %std_slt_9.left, %std_slt_9.right, %std_slt_9.out = calyx.std_slt @std_slt_9 : i32, i32, i1
    %std_add_8.left, %std_add_8.right, %std_add_8.out = calyx.std_add @std_add_8 : i32, i32, i32
    %std_slt_8.left, %std_slt_8.right, %std_slt_8.out = calyx.std_slt @std_slt_8 : i32, i32, i1
    %std_add_7.left, %std_add_7.right, %std_add_7.out = calyx.std_add @std_add_7 : i32, i32, i32
    %std_slt_7.left, %std_slt_7.right, %std_slt_7.out = calyx.std_slt @std_slt_7 : i32, i32, i1
    %std_add_6.left, %std_add_6.right, %std_add_6.out = calyx.std_add @std_add_6 : i32, i32, i32
    %std_slt_6.left, %std_slt_6.right, %std_slt_6.out = calyx.std_slt @std_slt_6 : i32, i32, i1
    %std_add_5.left, %std_add_5.right, %std_add_5.out = calyx.std_add @std_add_5 : i32, i32, i32
    %std_slt_5.left, %std_slt_5.right, %std_slt_5.out = calyx.std_slt @std_slt_5 : i32, i32, i1
    %std_add_4.left, %std_add_4.right, %std_add_4.out = calyx.std_add @std_add_4 : i32, i32, i32
    %std_slt_4.left, %std_slt_4.right, %std_slt_4.out = calyx.std_slt @std_slt_4 : i32, i32, i1
    %std_add_3.left, %std_add_3.right, %std_add_3.out = calyx.std_add @std_add_3 : i32, i32, i32
    %std_slt_3.left, %std_slt_3.right, %std_slt_3.out = calyx.std_slt @std_slt_3 : i32, i32, i1
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %std_slt_2.left, %std_slt_2.right, %std_slt_2.out = calyx.std_slt @std_slt_2 : i32, i32, i1
    %cmpi_0_reg.in, %cmpi_0_reg.write_en, %cmpi_0_reg.clk, %cmpi_0_reg.reset, %cmpi_0_reg.out, %cmpi_0_reg.done = calyx.register @cmpi_0_reg : i1, i1, i1, i1, i1, i1
    %std_eq_0.left, %std_eq_0.right, %std_eq_0.out = calyx.std_eq @std_eq_0 : i32, i32, i1
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_slt_1.left, %std_slt_1.right, %std_slt_1.out = calyx.std_slt @std_slt_1 : i32, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_14_arg1_reg.in, %while_14_arg1_reg.write_en, %while_14_arg1_reg.clk, %while_14_arg1_reg.reset, %while_14_arg1_reg.out, %while_14_arg1_reg.done = calyx.register @while_14_arg1_reg : i32, i1, i1, i1, i32, i1
    %while_14_arg0_reg.in, %while_14_arg0_reg.write_en, %while_14_arg0_reg.clk, %while_14_arg0_reg.reset, %while_14_arg0_reg.out, %while_14_arg0_reg.done = calyx.register @while_14_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_13_arg0_reg.in, %while_13_arg0_reg.write_en, %while_13_arg0_reg.clk, %while_13_arg0_reg.reset, %while_13_arg0_reg.out, %while_13_arg0_reg.done = calyx.register @while_13_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_12_arg0_reg.in, %while_12_arg0_reg.write_en, %while_12_arg0_reg.clk, %while_12_arg0_reg.reset, %while_12_arg0_reg.out, %while_12_arg0_reg.done = calyx.register @while_12_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_11_arg0_reg.in, %while_11_arg0_reg.write_en, %while_11_arg0_reg.clk, %while_11_arg0_reg.reset, %while_11_arg0_reg.out, %while_11_arg0_reg.done = calyx.register @while_11_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_10_arg0_reg.in, %while_10_arg0_reg.write_en, %while_10_arg0_reg.clk, %while_10_arg0_reg.reset, %while_10_arg0_reg.out, %while_10_arg0_reg.done = calyx.register @while_10_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_9_arg0_reg.in, %while_9_arg0_reg.write_en, %while_9_arg0_reg.clk, %while_9_arg0_reg.reset, %while_9_arg0_reg.out, %while_9_arg0_reg.done = calyx.register @while_9_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_8_arg0_reg.in, %while_8_arg0_reg.write_en, %while_8_arg0_reg.clk, %while_8_arg0_reg.reset, %while_8_arg0_reg.out, %while_8_arg0_reg.done = calyx.register @while_8_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_7_arg0_reg.in, %while_7_arg0_reg.write_en, %while_7_arg0_reg.clk, %while_7_arg0_reg.reset, %while_7_arg0_reg.out, %while_7_arg0_reg.done = calyx.register @while_7_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_6_arg0_reg.in, %while_6_arg0_reg.write_en, %while_6_arg0_reg.clk, %while_6_arg0_reg.reset, %while_6_arg0_reg.out, %while_6_arg0_reg.done = calyx.register @while_6_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_5_arg0_reg.in, %while_5_arg0_reg.write_en, %while_5_arg0_reg.clk, %while_5_arg0_reg.reset, %while_5_arg0_reg.out, %while_5_arg0_reg.done = calyx.register @while_5_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_4_arg0_reg.in, %while_4_arg0_reg.write_en, %while_4_arg0_reg.clk, %while_4_arg0_reg.reset, %while_4_arg0_reg.out, %while_4_arg0_reg.done = calyx.register @while_4_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_3_arg0_reg.in, %while_3_arg0_reg.write_en, %while_3_arg0_reg.clk, %while_3_arg0_reg.reset, %while_3_arg0_reg.out, %while_3_arg0_reg.done = calyx.register @while_3_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_2_arg0_reg.in, %while_2_arg0_reg.write_en, %while_2_arg0_reg.clk, %while_2_arg0_reg.reset, %while_2_arg0_reg.out, %while_2_arg0_reg.done = calyx.register @while_2_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_1_arg0_reg.in, %while_1_arg0_reg.write_en, %while_1_arg0_reg.clk, %while_1_arg0_reg.reset, %while_1_arg0_reg.out, %while_1_arg0_reg.done = calyx.register @while_1_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %sort_radix_inner_loop_7_instance.in0, %sort_radix_inner_loop_7_instance.in2, %sort_radix_inner_loop_7_instance.in3, %sort_radix_inner_loop_7_instance.in4, %sort_radix_inner_loop_7_instance.clk, %sort_radix_inner_loop_7_instance.reset, %sort_radix_inner_loop_7_instance.go, %sort_radix_inner_loop_7_instance.done = calyx.instance @sort_radix_inner_loop_7_instance of @sort_radix_inner_loop_7 : i32, i32, i32, i32, i1, i1, i1, i1
    %sort_radix_inner_loop_6_instance.in0, %sort_radix_inner_loop_6_instance.in2, %sort_radix_inner_loop_6_instance.in3, %sort_radix_inner_loop_6_instance.in4, %sort_radix_inner_loop_6_instance.clk, %sort_radix_inner_loop_6_instance.reset, %sort_radix_inner_loop_6_instance.go, %sort_radix_inner_loop_6_instance.done = calyx.instance @sort_radix_inner_loop_6_instance of @sort_radix_inner_loop_6 : i32, i32, i32, i32, i1, i1, i1, i1
    %sort_radix_inner_loop_5_instance.in0, %sort_radix_inner_loop_5_instance.in2, %sort_radix_inner_loop_5_instance.clk, %sort_radix_inner_loop_5_instance.reset, %sort_radix_inner_loop_5_instance.go, %sort_radix_inner_loop_5_instance.done = calyx.instance @sort_radix_inner_loop_5_instance of @sort_radix_inner_loop_5 : i32, i32, i1, i1, i1, i1
    %sort_radix_inner_loop_4_instance.in0, %sort_radix_inner_loop_4_instance.clk, %sort_radix_inner_loop_4_instance.reset, %sort_radix_inner_loop_4_instance.go, %sort_radix_inner_loop_4_instance.done = calyx.instance @sort_radix_inner_loop_4_instance of @sort_radix_inner_loop_4 : i32, i1, i1, i1, i1
    %sort_radix_inner_loop_3_instance.in0, %sort_radix_inner_loop_3_instance.in2, %sort_radix_inner_loop_3_instance.clk, %sort_radix_inner_loop_3_instance.reset, %sort_radix_inner_loop_3_instance.go, %sort_radix_inner_loop_3_instance.done = calyx.instance @sort_radix_inner_loop_3_instance of @sort_radix_inner_loop_3 : i32, i32, i1, i1, i1, i1
    %sort_radix_inner_loop_2_instance.in0, %sort_radix_inner_loop_2_instance.in2, %sort_radix_inner_loop_2_instance.in3, %sort_radix_inner_loop_2_instance.in4, %sort_radix_inner_loop_2_instance.clk, %sort_radix_inner_loop_2_instance.reset, %sort_radix_inner_loop_2_instance.go, %sort_radix_inner_loop_2_instance.done = calyx.instance @sort_radix_inner_loop_2_instance of @sort_radix_inner_loop_2 : i32, i32, i32, i32, i1, i1, i1, i1
    %sort_radix_inner_loop_1_instance.in0, %sort_radix_inner_loop_1_instance.in2, %sort_radix_inner_loop_1_instance.in3, %sort_radix_inner_loop_1_instance.in4, %sort_radix_inner_loop_1_instance.clk, %sort_radix_inner_loop_1_instance.reset, %sort_radix_inner_loop_1_instance.go, %sort_radix_inner_loop_1_instance.done = calyx.instance @sort_radix_inner_loop_1_instance of @sort_radix_inner_loop_1 : i32, i32, i32, i32, i1, i1, i1, i1
    %sort_radix_inner_loop_0_instance.in0, %sort_radix_inner_loop_0_instance.clk, %sort_radix_inner_loop_0_instance.reset, %sort_radix_inner_loop_0_instance.go, %sort_radix_inner_loop_0_instance.done = calyx.instance @sort_radix_inner_loop_0_instance of @sort_radix_inner_loop_0 : i32, i1, i1, i1, i1
    %arg_mem_3.addr0, %arg_mem_3.clk, %arg_mem_3.reset, %arg_mem_3.content_en, %arg_mem_3.write_en, %arg_mem_3.write_data, %arg_mem_3.read_data, %arg_mem_3.done = calyx.seq_mem @arg_mem_3 <[128] x 32> [7] : i7, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_2.addr0, %arg_mem_2.clk, %arg_mem_2.reset, %arg_mem_2.content_en, %arg_mem_2.write_en, %arg_mem_2.write_data, %arg_mem_2.read_data, %arg_mem_2.done = calyx.seq_mem @arg_mem_2 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @assign_while_0_init_0 {
        calyx.assign %while_0_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_init_0 {
        calyx.assign %while_1_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.group_done %while_1_arg0_reg.done : i1
      }
      calyx.group @assign_while_2_init_0 {
        calyx.assign %while_2_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_2_arg0_reg.write_en = %true : i1
        calyx.group_done %while_2_arg0_reg.done : i1
      }
      calyx.group @assign_while_3_init_0 {
        calyx.assign %while_3_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_3_arg0_reg.write_en = %true : i1
        calyx.group_done %while_3_arg0_reg.done : i1
      }
      calyx.group @assign_while_4_init_0 {
        calyx.assign %while_4_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_4_arg0_reg.write_en = %true : i1
        calyx.group_done %while_4_arg0_reg.done : i1
      }
      calyx.group @assign_while_5_init_0 {
        calyx.assign %while_5_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_5_arg0_reg.write_en = %true : i1
        calyx.group_done %while_5_arg0_reg.done : i1
      }
      calyx.group @assign_while_6_init_0 {
        calyx.assign %while_6_arg0_reg.in = %c1_i32 : i32
        calyx.assign %while_6_arg0_reg.write_en = %true : i1
        calyx.group_done %while_6_arg0_reg.done : i1
      }
      calyx.group @assign_while_7_init_0 {
        calyx.assign %while_7_arg0_reg.in = %c1_i32 : i32
        calyx.assign %while_7_arg0_reg.write_en = %true : i1
        calyx.group_done %while_7_arg0_reg.done : i1
      }
      calyx.group @assign_while_8_init_0 {
        calyx.assign %while_8_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_8_arg0_reg.write_en = %true : i1
        calyx.group_done %while_8_arg0_reg.done : i1
      }
      calyx.group @assign_while_9_init_0 {
        calyx.assign %while_9_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_9_arg0_reg.write_en = %true : i1
        calyx.group_done %while_9_arg0_reg.done : i1
      }
      calyx.group @assign_while_10_init_0 {
        calyx.assign %while_10_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_10_arg0_reg.write_en = %true : i1
        calyx.group_done %while_10_arg0_reg.done : i1
      }
      calyx.group @assign_while_11_init_0 {
        calyx.assign %while_11_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_11_arg0_reg.write_en = %true : i1
        calyx.group_done %while_11_arg0_reg.done : i1
      }
      calyx.group @assign_while_12_init_0 {
        calyx.assign %while_12_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_12_arg0_reg.write_en = %true : i1
        calyx.group_done %while_12_arg0_reg.done : i1
      }
      calyx.group @assign_while_13_init_0 {
        calyx.assign %while_13_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_13_arg0_reg.write_en = %true : i1
        calyx.group_done %while_13_arg0_reg.done : i1
      }
      calyx.group @assign_while_14_init_0 {
        calyx.assign %while_14_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_14_arg0_reg.write_en = %true : i1
        calyx.group_done %while_14_arg0_reg.done : i1
      }
      calyx.group @assign_while_14_init_1 {
        calyx.assign %while_14_arg1_reg.in = %c0_i32 : i32
        calyx.assign %while_14_arg1_reg.write_en = %true : i1
        calyx.group_done %while_14_arg1_reg.done : i1
      }
      calyx.comb_group @bb0_0 {
        calyx.assign %std_slt_0.left = %while_14_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c32_i32 : i32
      }
      calyx.comb_group @bb0_2 {
        calyx.assign %std_slt_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_1.right = %c2048_i32 : i32
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_1.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_1.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %cmpi_0_reg.in = %std_eq_0.out : i1
        calyx.assign %cmpi_0_reg.write_en = %true : i1
        calyx.assign %std_eq_0.left = %while_14_arg1_reg.out : i32
        calyx.assign %std_eq_0.right = %c0_i32 : i32
        calyx.group_done %cmpi_0_reg.done : i1
      }
      calyx.comb_group @bb0_5 {
        calyx.assign %std_slt_2.left = %while_2_arg0_reg.out : i32
        calyx.assign %std_slt_2.right = %c512_i32 : i32
      }
      calyx.comb_group @bb0_7 {
        calyx.assign %std_slt_3.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_slt_3.right = %c4_i32 : i32
      }
      calyx.group @assign_while_1_latch {
        calyx.assign %while_1_arg0_reg.in = %std_add_3.out : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_3.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_add_3.right = %c1_i32 : i32
        calyx.group_done %while_1_arg0_reg.done : i1
      }
      calyx.group @assign_while_2_latch {
        calyx.assign %while_2_arg0_reg.in = %std_add_2.out : i32
        calyx.assign %while_2_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_2.left = %while_2_arg0_reg.out : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.group_done %while_2_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_9 {
        calyx.assign %std_slt_4.left = %while_4_arg0_reg.out : i32
        calyx.assign %std_slt_4.right = %c512_i32 : i32
      }
      calyx.comb_group @bb0_11 {
        calyx.assign %std_slt_5.left = %while_3_arg0_reg.out : i32
        calyx.assign %std_slt_5.right = %c4_i32 : i32
      }
      calyx.group @assign_while_3_latch {
        calyx.assign %while_3_arg0_reg.in = %std_add_5.out : i32
        calyx.assign %while_3_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_5.left = %while_3_arg0_reg.out : i32
        calyx.assign %std_add_5.right = %c1_i32 : i32
        calyx.group_done %while_3_arg0_reg.done : i1
      }
      calyx.group @assign_while_4_latch {
        calyx.assign %while_4_arg0_reg.in = %std_add_4.out : i32
        calyx.assign %while_4_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_4.left = %while_4_arg0_reg.out : i32
        calyx.assign %std_add_4.right = %c1_i32 : i32
        calyx.group_done %while_4_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_13 {
        calyx.assign %std_slt_6.left = %while_6_arg0_reg.out : i32
        calyx.assign %std_slt_6.right = %c16_i32 : i32
      }
      calyx.comb_group @bb0_15 {
        calyx.assign %std_slt_7.left = %while_5_arg0_reg.out : i32
        calyx.assign %std_slt_7.right = %c128_i32 : i32
      }
      calyx.group @assign_while_5_latch {
        calyx.assign %while_5_arg0_reg.in = %std_add_7.out : i32
        calyx.assign %while_5_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_7.left = %while_5_arg0_reg.out : i32
        calyx.assign %std_add_7.right = %c1_i32 : i32
        calyx.group_done %while_5_arg0_reg.done : i1
      }
      calyx.group @assign_while_6_latch {
        calyx.assign %while_6_arg0_reg.in = %std_add_6.out : i32
        calyx.assign %while_6_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_6.left = %while_6_arg0_reg.out : i32
        calyx.assign %std_add_6.right = %c1_i32 : i32
        calyx.group_done %while_6_arg0_reg.done : i1
      }
      calyx.group @bb0_17 {
        calyx.assign %std_slice_0.in = %c0_i32 : i32
        calyx.assign %arg_mem_3.addr0 = %std_slice_0.out : i7
        calyx.assign %arg_mem_3.write_data = %c0_i32 : i32
        calyx.assign %arg_mem_3.write_en = %true : i1
        calyx.assign %arg_mem_3.content_en = %true : i1
        calyx.group_done %arg_mem_3.done : i1
      }
      calyx.comb_group @bb0_18 {
        calyx.assign %std_slt_8.left = %while_7_arg0_reg.out : i32
        calyx.assign %std_slt_8.right = %c128_i32 : i32
      }
      calyx.group @assign_while_7_latch {
        calyx.assign %while_7_arg0_reg.in = %std_add_8.out : i32
        calyx.assign %while_7_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_8.left = %while_7_arg0_reg.out : i32
        calyx.assign %std_add_8.right = %c1_i32 : i32
        calyx.group_done %while_7_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_20 {
        calyx.assign %std_slt_9.left = %while_9_arg0_reg.out : i32
        calyx.assign %std_slt_9.right = %c16_i32 : i32
      }
      calyx.comb_group @bb0_22 {
        calyx.assign %std_slt_10.left = %while_8_arg0_reg.out : i32
        calyx.assign %std_slt_10.right = %c128_i32 : i32
      }
      calyx.group @assign_while_8_latch {
        calyx.assign %while_8_arg0_reg.in = %std_add_10.out : i32
        calyx.assign %while_8_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_10.left = %while_8_arg0_reg.out : i32
        calyx.assign %std_add_10.right = %c1_i32 : i32
        calyx.group_done %while_8_arg0_reg.done : i1
      }
      calyx.group @assign_while_9_latch {
        calyx.assign %while_9_arg0_reg.in = %std_add_9.out : i32
        calyx.assign %while_9_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_9.left = %while_9_arg0_reg.out : i32
        calyx.assign %std_add_9.right = %c1_i32 : i32
        calyx.group_done %while_9_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_25 {
        calyx.assign %std_slt_11.left = %while_11_arg0_reg.out : i32
        calyx.assign %std_slt_11.right = %c512_i32 : i32
      }
      calyx.comb_group @bb0_27 {
        calyx.assign %std_slt_12.left = %while_10_arg0_reg.out : i32
        calyx.assign %std_slt_12.right = %c4_i32 : i32
      }
      calyx.group @assign_while_10_latch {
        calyx.assign %while_10_arg0_reg.in = %std_add_12.out : i32
        calyx.assign %while_10_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_12.left = %while_10_arg0_reg.out : i32
        calyx.assign %std_add_12.right = %c1_i32 : i32
        calyx.group_done %while_10_arg0_reg.done : i1
      }
      calyx.group @assign_while_11_latch {
        calyx.assign %while_11_arg0_reg.in = %std_add_11.out : i32
        calyx.assign %while_11_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_11.left = %while_11_arg0_reg.out : i32
        calyx.assign %std_add_11.right = %c1_i32 : i32
        calyx.group_done %while_11_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_29 {
        calyx.assign %std_slt_13.left = %while_13_arg0_reg.out : i32
        calyx.assign %std_slt_13.right = %c512_i32 : i32
      }
      calyx.comb_group @bb0_31 {
        calyx.assign %std_slt_14.left = %while_12_arg0_reg.out : i32
        calyx.assign %std_slt_14.right = %c4_i32 : i32
      }
      calyx.group @assign_while_12_latch {
        calyx.assign %while_12_arg0_reg.in = %std_add_14.out : i32
        calyx.assign %while_12_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_14.left = %while_12_arg0_reg.out : i32
        calyx.assign %std_add_14.right = %c1_i32 : i32
        calyx.group_done %while_12_arg0_reg.done : i1
      }
      calyx.group @assign_while_13_latch {
        calyx.assign %while_13_arg0_reg.in = %std_add_13.out : i32
        calyx.assign %while_13_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_13.left = %while_13_arg0_reg.out : i32
        calyx.assign %std_add_13.right = %c1_i32 : i32
        calyx.group_done %while_13_arg0_reg.done : i1
      }
      calyx.group @assign_while_14_latch {
        calyx.assign %while_14_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_14_arg0_reg.write_en = %true : i1
        calyx.assign %while_14_arg1_reg.in = %std_pad_0.out : i32
        calyx.assign %while_14_arg1_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_14_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c2_i32 : i32
        calyx.assign %std_pad_0.in = %cmpi_0_reg.out : i1
        %0 = comb.and %while_14_arg1_reg.done, %while_14_arg0_reg.done : i1
        calyx.group_done %0 ? %true : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.par {
          calyx.enable @assign_while_14_init_0
          calyx.enable @assign_while_14_init_1
        }
        calyx.while %std_slt_0.out with @bb0_0 {
          calyx.seq {
            calyx.seq {
              calyx.par {
                calyx.enable @assign_while_0_init_0
              }
              calyx.while %std_slt_1.out with @bb0_2 {
                calyx.seq {
                  calyx.seq {
                    calyx.invoke @sort_radix_inner_loop_0_instance[arg_mem_0 = arg_mem_2](%sort_radix_inner_loop_0_instance.in0 = %while_0_arg0_reg.out) -> (i32)
                  }
                  calyx.enable @assign_while_0_latch
                }
              }
              calyx.enable @bb0_4
              calyx.if %cmpi_0_reg.out {
                calyx.seq {
                  calyx.par {
                    calyx.enable @assign_while_2_init_0
                  }
                  calyx.while %std_slt_2.out with @bb0_5 {
                    calyx.seq {
                      calyx.par {
                        calyx.enable @assign_while_1_init_0
                      }
                      calyx.while %std_slt_3.out with @bb0_7 {
                        calyx.seq {
                          calyx.seq {
                            calyx.invoke @sort_radix_inner_loop_1_instance[arg_mem_0 = arg_mem_0, arg_mem_1 = arg_mem_2](%sort_radix_inner_loop_1_instance.in0 = %while_1_arg0_reg.out, %sort_radix_inner_loop_1_instance.in2 = %while_2_arg0_reg.out, %sort_radix_inner_loop_1_instance.in3 = %while_14_arg0_reg.out, %sort_radix_inner_loop_1_instance.in4 = %while_2_arg0_reg.out) -> (i32, i32, i32, i32)
                          }
                          calyx.enable @assign_while_1_latch
                        }
                      }
                      calyx.enable @assign_while_2_latch
                    }
                  }
                }
              } else {
                calyx.seq {
                  calyx.par {
                    calyx.enable @assign_while_4_init_0
                  }
                  calyx.while %std_slt_4.out with @bb0_9 {
                    calyx.seq {
                      calyx.par {
                        calyx.enable @assign_while_3_init_0
                      }
                      calyx.while %std_slt_5.out with @bb0_11 {
                        calyx.seq {
                          calyx.seq {
                            calyx.invoke @sort_radix_inner_loop_2_instance[arg_mem_0 = arg_mem_1, arg_mem_1 = arg_mem_2](%sort_radix_inner_loop_2_instance.in0 = %while_3_arg0_reg.out, %sort_radix_inner_loop_2_instance.in2 = %while_4_arg0_reg.out, %sort_radix_inner_loop_2_instance.in3 = %while_14_arg0_reg.out, %sort_radix_inner_loop_2_instance.in4 = %while_4_arg0_reg.out) -> (i32, i32, i32, i32)
                          }
                          calyx.enable @assign_while_3_latch
                        }
                      }
                      calyx.enable @assign_while_4_latch
                    }
                  }
                }
              }
              calyx.par {
                calyx.enable @assign_while_6_init_0
              }
              calyx.while %std_slt_6.out with @bb0_13 {
                calyx.seq {
                  calyx.par {
                    calyx.enable @assign_while_5_init_0
                  }
                  calyx.while %std_slt_7.out with @bb0_15 {
                    calyx.seq {
                      calyx.seq {
                        calyx.invoke @sort_radix_inner_loop_3_instance[arg_mem_0 = arg_mem_2](%sort_radix_inner_loop_3_instance.in0 = %while_5_arg0_reg.out, %sort_radix_inner_loop_3_instance.in2 = %while_6_arg0_reg.out) -> (i32, i32)
                      }
                      calyx.enable @assign_while_5_latch
                    }
                  }
                  calyx.enable @assign_while_6_latch
                }
              }
              calyx.enable @bb0_17
              calyx.par {
                calyx.enable @assign_while_7_init_0
              }
              calyx.while %std_slt_8.out with @bb0_18 {
                calyx.seq {
                  calyx.seq {
                    calyx.invoke @sort_radix_inner_loop_4_instance[arg_mem_0 = arg_mem_3, arg_mem_1 = arg_mem_2](%sort_radix_inner_loop_4_instance.in0 = %while_7_arg0_reg.out) -> (i32)
                  }
                  calyx.enable @assign_while_7_latch
                }
              }
              calyx.par {
                calyx.enable @assign_while_9_init_0
              }
              calyx.while %std_slt_9.out with @bb0_20 {
                calyx.seq {
                  calyx.par {
                    calyx.enable @assign_while_8_init_0
                  }
                  calyx.while %std_slt_10.out with @bb0_22 {
                    calyx.seq {
                      calyx.seq {
                        calyx.invoke @sort_radix_inner_loop_5_instance[arg_mem_0 = arg_mem_2, arg_mem_1 = arg_mem_3](%sort_radix_inner_loop_5_instance.in0 = %while_8_arg0_reg.out, %sort_radix_inner_loop_5_instance.in2 = %while_9_arg0_reg.out) -> (i32, i32)
                      }
                      calyx.enable @assign_while_8_latch
                    }
                  }
                  calyx.enable @assign_while_9_latch
                }
              }
              calyx.if %cmpi_0_reg.out {
                calyx.seq {
                  calyx.par {
                    calyx.enable @assign_while_11_init_0
                  }
                  calyx.while %std_slt_11.out with @bb0_25 {
                    calyx.seq {
                      calyx.par {
                        calyx.enable @assign_while_10_init_0
                      }
                      calyx.while %std_slt_12.out with @bb0_27 {
                        calyx.seq {
                          calyx.seq {
                            calyx.invoke @sort_radix_inner_loop_6_instance[arg_mem_0 = arg_mem_0, arg_mem_1 = arg_mem_2, arg_mem_2 = arg_mem_1](%sort_radix_inner_loop_6_instance.in0 = %while_10_arg0_reg.out, %sort_radix_inner_loop_6_instance.in2 = %while_11_arg0_reg.out, %sort_radix_inner_loop_6_instance.in3 = %while_14_arg0_reg.out, %sort_radix_inner_loop_6_instance.in4 = %while_11_arg0_reg.out) -> (i32, i32, i32, i32)
                          }
                          calyx.enable @assign_while_10_latch
                        }
                      }
                      calyx.enable @assign_while_11_latch
                    }
                  }
                }
              } else {
                calyx.seq {
                  calyx.par {
                    calyx.enable @assign_while_13_init_0
                  }
                  calyx.while %std_slt_13.out with @bb0_29 {
                    calyx.seq {
                      calyx.par {
                        calyx.enable @assign_while_12_init_0
                      }
                      calyx.while %std_slt_14.out with @bb0_31 {
                        calyx.seq {
                          calyx.seq {
                            calyx.invoke @sort_radix_inner_loop_7_instance[arg_mem_0 = arg_mem_1, arg_mem_1 = arg_mem_2, arg_mem_2 = arg_mem_0](%sort_radix_inner_loop_7_instance.in0 = %while_12_arg0_reg.out, %sort_radix_inner_loop_7_instance.in2 = %while_13_arg0_reg.out, %sort_radix_inner_loop_7_instance.in3 = %while_14_arg0_reg.out, %sort_radix_inner_loop_7_instance.in4 = %while_13_arg0_reg.out) -> (i32, i32, i32, i32)
                          }
                          calyx.enable @assign_while_12_latch
                        }
                      }
                      calyx.enable @assign_while_13_latch
                    }
                  }
                }
              }
            }
            calyx.enable @assign_while_14_latch
          }
        }
      }
    }
  }
  calyx.component @init(%clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %c1_i32 = hw.constant 1 : i32
    %c2048_i32 = hw.constant 2048 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %init_inner_loop_0_instance.in0, %init_inner_loop_0_instance.clk, %init_inner_loop_0_instance.reset, %init_inner_loop_0_instance.go, %init_inner_loop_0_instance.done = calyx.instance @init_inner_loop_0_instance of @init_inner_loop_0 : i32, i1, i1, i1, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @assign_while_0_init_0 {
        calyx.assign %while_0_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_0 {
        calyx.assign %std_slt_0.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c2048_i32 : i32
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.par {
          calyx.enable @assign_while_0_init_0
        }
        calyx.while %std_slt_0.out with @bb0_0 {
          calyx.seq {
            calyx.seq {
              calyx.invoke @init_inner_loop_0_instance[arg_mem_0 = arg_mem_0](%init_inner_loop_0_instance.in0 = %while_0_arg0_reg.out) -> (i32)
            }
            calyx.enable @assign_while_0_latch
          }
        }
      }
    }
  }
  calyx.component @hist(%in2: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %c4_i32 = hw.constant 4 : i32
    %c1_i32 = hw.constant 1 : i32
    %c512_i32 = hw.constant 512 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_slt_1.left, %std_slt_1.right, %std_slt_1.out = calyx.std_slt @std_slt_1 : i32, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_1_arg0_reg.in, %while_1_arg0_reg.write_en, %while_1_arg0_reg.clk, %while_1_arg0_reg.reset, %while_1_arg0_reg.out, %while_1_arg0_reg.done = calyx.register @while_1_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %hist_inner_loop_0_instance.in0, %hist_inner_loop_0_instance.in2, %hist_inner_loop_0_instance.in3, %hist_inner_loop_0_instance.in4, %hist_inner_loop_0_instance.clk, %hist_inner_loop_0_instance.reset, %hist_inner_loop_0_instance.go, %hist_inner_loop_0_instance.done = calyx.instance @hist_inner_loop_0_instance of @hist_inner_loop_0 : i32, i32, i32, i32, i1, i1, i1, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @assign_while_0_init_0 {
        calyx.assign %while_0_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_init_0 {
        calyx.assign %while_1_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.group_done %while_1_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_0 {
        calyx.assign %std_slt_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c512_i32 : i32
      }
      calyx.comb_group @bb0_2 {
        calyx.assign %std_slt_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_1.right = %c4_i32 : i32
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_1.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_1.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_latch {
        calyx.assign %while_1_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %while_1_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.par {
          calyx.enable @assign_while_1_init_0
        }
        calyx.while %std_slt_0.out with @bb0_0 {
          calyx.seq {
            calyx.par {
              calyx.enable @assign_while_0_init_0
            }
            calyx.while %std_slt_1.out with @bb0_2 {
              calyx.seq {
                calyx.seq {
                  calyx.invoke @hist_inner_loop_0_instance[arg_mem_0 = arg_mem_1, arg_mem_1 = arg_mem_0](%hist_inner_loop_0_instance.in0 = %while_0_arg0_reg.out, %hist_inner_loop_0_instance.in2 = %while_1_arg0_reg.out, %hist_inner_loop_0_instance.in3 = %in2, %hist_inner_loop_0_instance.in4 = %while_1_arg0_reg.out) -> (i32, i32, i32, i32)
                }
                calyx.enable @assign_while_0_latch
              }
            }
            calyx.enable @assign_while_1_latch
          }
        }
      }
    }
  }
  calyx.component @local_scan(%clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %c16_i32 = hw.constant 16 : i32
    %c1_i32 = hw.constant 1 : i32
    %c128_i32 = hw.constant 128 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_slt_1.left, %std_slt_1.right, %std_slt_1.out = calyx.std_slt @std_slt_1 : i32, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_1_arg0_reg.in, %while_1_arg0_reg.write_en, %while_1_arg0_reg.clk, %while_1_arg0_reg.reset, %while_1_arg0_reg.out, %while_1_arg0_reg.done = calyx.register @while_1_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %local_scan_inner_loop_0_instance.in0, %local_scan_inner_loop_0_instance.in2, %local_scan_inner_loop_0_instance.clk, %local_scan_inner_loop_0_instance.reset, %local_scan_inner_loop_0_instance.go, %local_scan_inner_loop_0_instance.done = calyx.instance @local_scan_inner_loop_0_instance of @local_scan_inner_loop_0 : i32, i32, i1, i1, i1, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @assign_while_0_init_0 {
        calyx.assign %while_0_arg0_reg.in = %c1_i32 : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_init_0 {
        calyx.assign %while_1_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.group_done %while_1_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_0 {
        calyx.assign %std_slt_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c128_i32 : i32
      }
      calyx.comb_group @bb0_2 {
        calyx.assign %std_slt_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_1.right = %c16_i32 : i32
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_1.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_1.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_latch {
        calyx.assign %while_1_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %while_1_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.par {
          calyx.enable @assign_while_1_init_0
        }
        calyx.while %std_slt_0.out with @bb0_0 {
          calyx.seq {
            calyx.par {
              calyx.enable @assign_while_0_init_0
            }
            calyx.while %std_slt_1.out with @bb0_2 {
              calyx.seq {
                calyx.seq {
                  calyx.invoke @local_scan_inner_loop_0_instance[arg_mem_0 = arg_mem_0](%local_scan_inner_loop_0_instance.in0 = %while_0_arg0_reg.out, %local_scan_inner_loop_0_instance.in2 = %while_1_arg0_reg.out) -> (i32, i32)
                }
                calyx.enable @assign_while_0_latch
              }
            }
            calyx.enable @assign_while_1_latch
          }
        }
      }
    }
  }
  calyx.component @sum_scan(%clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %c128_i32 = hw.constant 128 : i32
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i7
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %sum_scan_inner_loop_0_instance.in0, %sum_scan_inner_loop_0_instance.clk, %sum_scan_inner_loop_0_instance.reset, %sum_scan_inner_loop_0_instance.go, %sum_scan_inner_loop_0_instance.done = calyx.instance @sum_scan_inner_loop_0_instance of @sum_scan_inner_loop_0 : i32, i1, i1, i1, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[128] x 32> [7] : i7, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @assign_while_0_init_0 {
        calyx.assign %while_0_arg0_reg.in = %c1_i32 : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @bb0_0 {
        calyx.assign %std_slice_0.in = %c0_i32 : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i7
        calyx.assign %arg_mem_0.write_data = %c0_i32 : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.comb_group @bb0_1 {
        calyx.assign %std_slt_0.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c128_i32 : i32
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.par {
            calyx.enable @assign_while_0_init_0
          }
          calyx.while %std_slt_0.out with @bb0_1 {
            calyx.seq {
              calyx.seq {
                calyx.invoke @sum_scan_inner_loop_0_instance[arg_mem_0 = arg_mem_0, arg_mem_1 = arg_mem_1](%sum_scan_inner_loop_0_instance.in0 = %while_0_arg0_reg.out) -> (i32)
              }
              calyx.enable @assign_while_0_latch
            }
          }
        }
      }
    }
  }
  calyx.component @last_step_scan(%clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c0_i32 = hw.constant 0 : i32
    %c128_i32 = hw.constant 128 : i32
    %c1_i32 = hw.constant 1 : i32
    %c16_i32 = hw.constant 16 : i32
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i7
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_slt_1.left, %std_slt_1.right, %std_slt_1.out = calyx.std_slt @std_slt_1 : i32, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_1_arg0_reg.in, %while_1_arg0_reg.write_en, %while_1_arg0_reg.clk, %while_1_arg0_reg.reset, %while_1_arg0_reg.out, %while_1_arg0_reg.done = calyx.register @while_1_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %last_step_scan_inner_loop_0_instance.in0, %last_step_scan_inner_loop_0_instance.in2, %last_step_scan_inner_loop_0_instance.in3, %last_step_scan_inner_loop_0_instance.clk, %last_step_scan_inner_loop_0_instance.reset, %last_step_scan_inner_loop_0_instance.go, %last_step_scan_inner_loop_0_instance.done = calyx.instance @last_step_scan_inner_loop_0_instance of @last_step_scan_inner_loop_0 : i32, i32, i32, i1, i1, i1, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[128] x 32> [7] : i7, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @assign_while_0_init_0 {
        calyx.assign %while_0_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_init_0 {
        calyx.assign %while_1_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.group_done %while_1_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_0 {
        calyx.assign %std_slt_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c128_i32 : i32
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_0.in = %while_1_arg0_reg.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_0.out : i7
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.group_done %arg_mem_1.done : i1
      }
      calyx.comb_group @bb0_3 {
        calyx.assign %std_slt_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_1.right = %c16_i32 : i32
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_1.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_1.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_latch {
        calyx.assign %while_1_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %while_1_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.par {
          calyx.enable @assign_while_1_init_0
        }
        calyx.while %std_slt_0.out with @bb0_0 {
          calyx.seq {
            calyx.seq {
              calyx.enable @bb0_2
              calyx.par {
                calyx.enable @assign_while_0_init_0
              }
              calyx.while %std_slt_1.out with @bb0_3 {
                calyx.seq {
                  calyx.seq {
                    calyx.invoke @last_step_scan_inner_loop_0_instance[arg_mem_0 = arg_mem_0](%last_step_scan_inner_loop_0_instance.in0 = %while_0_arg0_reg.out, %last_step_scan_inner_loop_0_instance.in2 = %while_1_arg0_reg.out, %last_step_scan_inner_loop_0_instance.in3 = %arg_mem_1.read_data) -> (i32, i32, i32)
                  }
                  calyx.enable @assign_while_0_latch
                }
              }
            }
            calyx.enable @assign_while_1_latch
          }
        }
      }
    }
  }
  calyx.component @update(%in3: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %c4_i32 = hw.constant 4 : i32
    %c1_i32 = hw.constant 1 : i32
    %c512_i32 = hw.constant 512 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_slt_1.left, %std_slt_1.right, %std_slt_1.out = calyx.std_slt @std_slt_1 : i32, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_1_arg0_reg.in, %while_1_arg0_reg.write_en, %while_1_arg0_reg.clk, %while_1_arg0_reg.reset, %while_1_arg0_reg.out, %while_1_arg0_reg.done = calyx.register @while_1_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %update_inner_loop_0_instance.in0, %update_inner_loop_0_instance.in2, %update_inner_loop_0_instance.in3, %update_inner_loop_0_instance.in4, %update_inner_loop_0_instance.clk, %update_inner_loop_0_instance.reset, %update_inner_loop_0_instance.go, %update_inner_loop_0_instance.done = calyx.instance @update_inner_loop_0_instance of @update_inner_loop_0 : i32, i32, i32, i32, i1, i1, i1, i1
    %arg_mem_2.addr0, %arg_mem_2.clk, %arg_mem_2.reset, %arg_mem_2.content_en, %arg_mem_2.write_en, %arg_mem_2.write_data, %arg_mem_2.read_data, %arg_mem_2.done = calyx.seq_mem @arg_mem_2 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @assign_while_0_init_0 {
        calyx.assign %while_0_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_init_0 {
        calyx.assign %while_1_arg0_reg.in = %c0_i32 : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.group_done %while_1_arg0_reg.done : i1
      }
      calyx.comb_group @bb0_0 {
        calyx.assign %std_slt_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c512_i32 : i32
      }
      calyx.comb_group @bb0_2 {
        calyx.assign %std_slt_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_1.right = %c4_i32 : i32
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_1.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_1.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_1.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_latch {
        calyx.assign %while_1_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %while_1_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.par {
          calyx.enable @assign_while_1_init_0
        }
        calyx.while %std_slt_0.out with @bb0_0 {
          calyx.seq {
            calyx.par {
              calyx.enable @assign_while_0_init_0
            }
            calyx.while %std_slt_1.out with @bb0_2 {
              calyx.seq {
                calyx.seq {
                  calyx.invoke @update_inner_loop_0_instance[arg_mem_0 = arg_mem_2, arg_mem_1 = arg_mem_1, arg_mem_2 = arg_mem_0](%update_inner_loop_0_instance.in0 = %while_0_arg0_reg.out, %update_inner_loop_0_instance.in2 = %while_1_arg0_reg.out, %update_inner_loop_0_instance.in3 = %in3, %update_inner_loop_0_instance.in4 = %while_1_arg0_reg.out) -> (i32, i32, i32, i32)
                }
                calyx.enable @assign_while_0_latch
              }
            }
            calyx.enable @assign_while_1_latch
          }
        }
      }
    }
  }
  calyx.component @sort_radix_inner_loop_0(%in0: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_slice_0.in = %in0 : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_0.write_data = %c0_i32 : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.enable @bb0_0
      }
    }
  }
  calyx.component @sort_radix_inner_loop_1(%in0: i32, %in2: i32, %in3: i32, %in4: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c3_i32 = hw.constant 3 : i32
    %c512_i32 = hw.constant 512 : i32
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_3.left, %std_add_3.right, %std_add_3.out = calyx.std_add @std_add_3 : i32, i32, i32
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_1_reg.in, %muli_1_reg.write_en, %muli_1_reg.clk, %muli_1_reg.reset, %muli_1_reg.out, %muli_1_reg.done = calyx.register @muli_1_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_1.clk, %std_mult_pipe_1.reset, %std_mult_pipe_1.go, %std_mult_pipe_1.left, %std_mult_pipe_1.right, %std_mult_pipe_1.out, %std_mult_pipe_1.done = calyx.std_mult_pipe @std_mult_pipe_1 : i1, i1, i1, i32, i32, i32, i1
    %std_and_0.left, %std_and_0.right, %std_and_0.out = calyx.std_and @std_and_0 : i32, i32, i32
    %std_srsh_0.left, %std_srsh_0.right, %std_srsh_0.out = calyx.std_srsh @std_srsh_0 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c4_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_2.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_mult_pipe_1.left = %std_and_0.out : i32
        calyx.assign %std_mult_pipe_1.right = %c512_i32 : i32
        calyx.assign %muli_1_reg.in = %std_mult_pipe_1.out : i32
        calyx.assign %muli_1_reg.write_en = %std_mult_pipe_1.done : i1
        %0 = comb.xor %std_mult_pipe_1.done, %true : i1
        calyx.assign %std_mult_pipe_1.go = %0 ? %true : i1
        calyx.assign %std_and_0.left = %std_srsh_0.out : i32
        calyx.assign %std_srsh_0.left = %arg_mem_0.read_data : i32
        calyx.assign %std_srsh_0.right = %in3 : i32
        calyx.assign %std_and_0.right = %c3_i32 : i32
        calyx.group_done %muli_1_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_slice_1.in = %std_add_2.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_2.left = %std_add_1.out : i32
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_10 {
        calyx.assign %std_slice_0.in = %std_add_2.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_1.write_data = %std_add_3.out : i32
        calyx.assign %arg_mem_1.write_en = %true : i1
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %std_add_2.left = %std_add_1.out : i32
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.assign %std_add_3.left = %load_0_reg.out : i32
        calyx.assign %std_add_3.right = %c1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_5
          calyx.enable @bb0_8
          calyx.enable @bb0_10
        }
      }
    }
  }
  calyx.component @sort_radix_inner_loop_2(%in0: i32, %in2: i32, %in3: i32, %in4: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c3_i32 = hw.constant 3 : i32
    %c512_i32 = hw.constant 512 : i32
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_3.left, %std_add_3.right, %std_add_3.out = calyx.std_add @std_add_3 : i32, i32, i32
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_1_reg.in, %muli_1_reg.write_en, %muli_1_reg.clk, %muli_1_reg.reset, %muli_1_reg.out, %muli_1_reg.done = calyx.register @muli_1_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_1.clk, %std_mult_pipe_1.reset, %std_mult_pipe_1.go, %std_mult_pipe_1.left, %std_mult_pipe_1.right, %std_mult_pipe_1.out, %std_mult_pipe_1.done = calyx.std_mult_pipe @std_mult_pipe_1 : i1, i1, i1, i32, i32, i32, i1
    %std_and_0.left, %std_and_0.right, %std_and_0.out = calyx.std_and @std_and_0 : i32, i32, i32
    %std_srsh_0.left, %std_srsh_0.right, %std_srsh_0.out = calyx.std_srsh @std_srsh_0 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c4_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_2.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_mult_pipe_1.left = %std_and_0.out : i32
        calyx.assign %std_mult_pipe_1.right = %c512_i32 : i32
        calyx.assign %muli_1_reg.in = %std_mult_pipe_1.out : i32
        calyx.assign %muli_1_reg.write_en = %std_mult_pipe_1.done : i1
        %0 = comb.xor %std_mult_pipe_1.done, %true : i1
        calyx.assign %std_mult_pipe_1.go = %0 ? %true : i1
        calyx.assign %std_and_0.left = %std_srsh_0.out : i32
        calyx.assign %std_srsh_0.left = %arg_mem_0.read_data : i32
        calyx.assign %std_srsh_0.right = %in3 : i32
        calyx.assign %std_and_0.right = %c3_i32 : i32
        calyx.group_done %muli_1_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_slice_1.in = %std_add_2.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_2.left = %std_add_1.out : i32
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_10 {
        calyx.assign %std_slice_0.in = %std_add_2.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_1.write_data = %std_add_3.out : i32
        calyx.assign %arg_mem_1.write_en = %true : i1
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %std_add_2.left = %std_add_1.out : i32
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.assign %std_add_3.left = %load_0_reg.out : i32
        calyx.assign %std_add_3.right = %c1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_5
          calyx.enable @bb0_8
          calyx.enable @bb0_10
        }
      }
    }
  }
  calyx.component @sort_radix_inner_loop_3(%in0: i32, %in2: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c-1_i32 = hw.constant -1 : i32
    %c16_i32 = hw.constant 16 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i32, i1, i1, i1, i32, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in0 : i32
        calyx.assign %std_mult_pipe_0.right = %c16_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_3 {
        calyx.assign %std_slice_2.in = %std_add_1.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_1.left = %std_add_0.out : i32
        calyx.assign %std_add_0.left = %in2 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.assign %std_add_1.right = %c-1_i32 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %std_slice_1.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_1_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_1_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_0.left = %in2 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_6 {
        calyx.assign %std_slice_0.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_0.write_data = %std_add_2.out : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %std_add_0.left = %in2 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.assign %std_add_2.left = %load_1_reg.out : i32
        calyx.assign %std_add_2.right = %load_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_3
          calyx.enable @bb0_4
          calyx.enable @bb0_6
        }
      }
    }
  }
  calyx.component @sort_radix_inner_loop_4(%in0: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c16_i32 = hw.constant 16 : i32
    %c-1_i32 = hw.constant -1 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i7
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i7
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[128] x 32> [7] : i7, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_1 {
        calyx.assign %std_slice_2.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i7
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %c-1_i32 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_mult_pipe_0.left = %in0 : i32
        calyx.assign %std_mult_pipe_0.right = %c16_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %std_slice_1.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %std_add_1.left = %muli_0_reg.out : i32
        calyx.assign %std_add_1.right = %c-1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
      calyx.group @bb0_6 {
        calyx.assign %std_slice_0.in = %in0 : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i7
        calyx.assign %arg_mem_0.write_data = %std_add_2.out : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %std_add_2.left = %load_0_reg.out : i32
        calyx.assign %std_add_2.right = %arg_mem_1.read_data : i32
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_1
          calyx.enable @bb0_2
          calyx.enable @bb0_4
          calyx.enable @bb0_6
        }
      }
    }
  }
  calyx.component @sort_radix_inner_loop_5(%in0: i32, %in2: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c16_i32 = hw.constant 16 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i7
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[128] x 32> [7] : i7, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in0 : i32
        calyx.assign %std_mult_pipe_0.right = %c16_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_2.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_0.left = %in2 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_3 {
        calyx.assign %std_slice_1.in = %in0 : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i7
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.group_done %arg_mem_1.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_slice_0.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_0.write_data = %std_add_1.out : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %std_add_0.left = %in2 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.assign %std_add_1.left = %load_0_reg.out : i32
        calyx.assign %std_add_1.right = %arg_mem_1.read_data : i32
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_3
          calyx.enable @bb0_5
        }
      }
    }
  }
  calyx.component @sort_radix_inner_loop_6(%in0: i32, %in2: i32, %in3: i32, %in4: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c3_i32 = hw.constant 3 : i32
    %c512_i32 = hw.constant 512 : i32
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %std_slice_4.in, %std_slice_4.out = calyx.std_slice @std_slice_4 : i32, i11
    %std_slice_3.in, %std_slice_3.out = calyx.std_slice @std_slice_3 : i32, i11
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i32, i1, i1, i1, i32, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_1_reg.in, %muli_1_reg.write_en, %muli_1_reg.clk, %muli_1_reg.reset, %muli_1_reg.out, %muli_1_reg.done = calyx.register @muli_1_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_1.clk, %std_mult_pipe_1.reset, %std_mult_pipe_1.go, %std_mult_pipe_1.left, %std_mult_pipe_1.right, %std_mult_pipe_1.out, %std_mult_pipe_1.done = calyx.std_mult_pipe @std_mult_pipe_1 : i1, i1, i1, i32, i32, i32, i1
    %std_and_0.left, %std_and_0.right, %std_and_0.out = calyx.std_and @std_and_0 : i32, i32, i32
    %std_srsh_0.left, %std_srsh_0.right, %std_srsh_0.out = calyx.std_srsh @std_srsh_0 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_2.addr0, %arg_mem_2.clk, %arg_mem_2.reset, %arg_mem_2.content_en, %arg_mem_2.write_en, %arg_mem_2.write_data, %arg_mem_2.read_data, %arg_mem_2.done = calyx.seq_mem @arg_mem_2 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c4_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_4.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_4.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_mult_pipe_1.left = %std_and_0.out : i32
        calyx.assign %std_mult_pipe_1.right = %c512_i32 : i32
        calyx.assign %muli_1_reg.in = %std_mult_pipe_1.out : i32
        calyx.assign %muli_1_reg.write_en = %std_mult_pipe_1.done : i1
        %0 = comb.xor %std_mult_pipe_1.done, %true : i1
        calyx.assign %std_mult_pipe_1.go = %0 ? %true : i1
        calyx.assign %std_and_0.left = %std_srsh_0.out : i32
        calyx.assign %std_srsh_0.left = %arg_mem_0.read_data : i32
        calyx.assign %std_srsh_0.right = %in3 : i32
        calyx.assign %std_and_0.right = %c3_i32 : i32
        calyx.group_done %muli_1_reg.done : i1
      }
      calyx.group @bb0_7 {
        calyx.assign %std_slice_3.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_3.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_slice_2.in = %load_0_reg.out : i32
        calyx.assign %arg_mem_2.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_2.write_data = %arg_mem_0.read_data : i32
        calyx.assign %arg_mem_2.write_en = %true : i1
        calyx.assign %arg_mem_2.content_en = %true : i1
        calyx.group_done %arg_mem_2.done : i1
      }
      calyx.group @bb0_9 {
        calyx.assign %std_slice_1.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_1_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_1_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_11 {
        calyx.assign %std_slice_0.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_1.write_data = %std_add_2.out : i32
        calyx.assign %arg_mem_1.write_en = %true : i1
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.left = %load_1_reg.out : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_5
          calyx.enable @bb0_7
          calyx.enable @bb0_8
          calyx.enable @bb0_9
          calyx.enable @bb0_11
        }
      }
    }
  }
  calyx.component @sort_radix_inner_loop_7(%in0: i32, %in2: i32, %in3: i32, %in4: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c3_i32 = hw.constant 3 : i32
    %c512_i32 = hw.constant 512 : i32
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %std_slice_4.in, %std_slice_4.out = calyx.std_slice @std_slice_4 : i32, i11
    %std_slice_3.in, %std_slice_3.out = calyx.std_slice @std_slice_3 : i32, i11
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i32, i1, i1, i1, i32, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_1_reg.in, %muli_1_reg.write_en, %muli_1_reg.clk, %muli_1_reg.reset, %muli_1_reg.out, %muli_1_reg.done = calyx.register @muli_1_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_1.clk, %std_mult_pipe_1.reset, %std_mult_pipe_1.go, %std_mult_pipe_1.left, %std_mult_pipe_1.right, %std_mult_pipe_1.out, %std_mult_pipe_1.done = calyx.std_mult_pipe @std_mult_pipe_1 : i1, i1, i1, i32, i32, i32, i1
    %std_and_0.left, %std_and_0.right, %std_and_0.out = calyx.std_and @std_and_0 : i32, i32, i32
    %std_srsh_0.left, %std_srsh_0.right, %std_srsh_0.out = calyx.std_srsh @std_srsh_0 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_2.addr0, %arg_mem_2.clk, %arg_mem_2.reset, %arg_mem_2.content_en, %arg_mem_2.write_en, %arg_mem_2.write_data, %arg_mem_2.read_data, %arg_mem_2.done = calyx.seq_mem @arg_mem_2 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c4_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_4.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_4.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_mult_pipe_1.left = %std_and_0.out : i32
        calyx.assign %std_mult_pipe_1.right = %c512_i32 : i32
        calyx.assign %muli_1_reg.in = %std_mult_pipe_1.out : i32
        calyx.assign %muli_1_reg.write_en = %std_mult_pipe_1.done : i1
        %0 = comb.xor %std_mult_pipe_1.done, %true : i1
        calyx.assign %std_mult_pipe_1.go = %0 ? %true : i1
        calyx.assign %std_and_0.left = %std_srsh_0.out : i32
        calyx.assign %std_srsh_0.left = %arg_mem_0.read_data : i32
        calyx.assign %std_srsh_0.right = %in3 : i32
        calyx.assign %std_and_0.right = %c3_i32 : i32
        calyx.group_done %muli_1_reg.done : i1
      }
      calyx.group @bb0_7 {
        calyx.assign %std_slice_3.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_3.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_slice_2.in = %load_0_reg.out : i32
        calyx.assign %arg_mem_2.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_2.write_data = %arg_mem_0.read_data : i32
        calyx.assign %arg_mem_2.write_en = %true : i1
        calyx.assign %arg_mem_2.content_en = %true : i1
        calyx.group_done %arg_mem_2.done : i1
      }
      calyx.group @bb0_9 {
        calyx.assign %std_slice_1.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_1_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_1_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_11 {
        calyx.assign %std_slice_0.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_1.write_data = %std_add_2.out : i32
        calyx.assign %arg_mem_1.write_en = %true : i1
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.left = %load_1_reg.out : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_5
          calyx.enable @bb0_7
          calyx.enable @bb0_8
          calyx.enable @bb0_9
          calyx.enable @bb0_11
        }
      }
    }
  }
  calyx.component @init_inner_loop_0(%in0: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_slice_0.in = %in0 : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_0.write_data = %c0_i32 : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.enable @bb0_0
      }
    }
  }
  calyx.component @hist_inner_loop_0(%in0: i32, %in2: i32, %in3: i32, %in4: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c3_i32 = hw.constant 3 : i32
    %c512_i32 = hw.constant 512 : i32
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_3.left, %std_add_3.right, %std_add_3.out = calyx.std_add @std_add_3 : i32, i32, i32
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_1_reg.in, %muli_1_reg.write_en, %muli_1_reg.clk, %muli_1_reg.reset, %muli_1_reg.out, %muli_1_reg.done = calyx.register @muli_1_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_1.clk, %std_mult_pipe_1.reset, %std_mult_pipe_1.go, %std_mult_pipe_1.left, %std_mult_pipe_1.right, %std_mult_pipe_1.out, %std_mult_pipe_1.done = calyx.std_mult_pipe @std_mult_pipe_1 : i1, i1, i1, i32, i32, i32, i1
    %std_and_0.left, %std_and_0.right, %std_and_0.out = calyx.std_and @std_and_0 : i32, i32, i32
    %std_srsh_0.left, %std_srsh_0.right, %std_srsh_0.out = calyx.std_srsh @std_srsh_0 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c4_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_2.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_mult_pipe_1.left = %std_and_0.out : i32
        calyx.assign %std_mult_pipe_1.right = %c512_i32 : i32
        calyx.assign %muli_1_reg.in = %std_mult_pipe_1.out : i32
        calyx.assign %muli_1_reg.write_en = %std_mult_pipe_1.done : i1
        %0 = comb.xor %std_mult_pipe_1.done, %true : i1
        calyx.assign %std_mult_pipe_1.go = %0 ? %true : i1
        calyx.assign %std_and_0.left = %std_srsh_0.out : i32
        calyx.assign %std_srsh_0.left = %arg_mem_0.read_data : i32
        calyx.assign %std_srsh_0.right = %in3 : i32
        calyx.assign %std_and_0.right = %c3_i32 : i32
        calyx.group_done %muli_1_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_slice_1.in = %std_add_2.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_2.left = %std_add_1.out : i32
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_10 {
        calyx.assign %std_slice_0.in = %std_add_2.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_1.write_data = %std_add_3.out : i32
        calyx.assign %arg_mem_1.write_en = %true : i1
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %std_add_2.left = %std_add_1.out : i32
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.assign %std_add_3.left = %load_0_reg.out : i32
        calyx.assign %std_add_3.right = %c1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_5
          calyx.enable @bb0_8
          calyx.enable @bb0_10
        }
      }
    }
  }
  calyx.component @local_scan_inner_loop_0(%in0: i32, %in2: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c-1_i32 = hw.constant -1 : i32
    %c16_i32 = hw.constant 16 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i32, i1, i1, i1, i32, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c16_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_3 {
        calyx.assign %std_slice_2.in = %std_add_1.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_1.left = %std_add_0.out : i32
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.assign %std_add_1.right = %c-1_i32 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %std_slice_1.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_1_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_1_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_6 {
        calyx.assign %std_slice_0.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_0.write_data = %std_add_2.out : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.assign %std_add_2.left = %load_1_reg.out : i32
        calyx.assign %std_add_2.right = %load_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_3
          calyx.enable @bb0_4
          calyx.enable @bb0_6
        }
      }
    }
  }
  calyx.component @sum_scan_inner_loop_0(%in0: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c16_i32 = hw.constant 16 : i32
    %c-1_i32 = hw.constant -1 : i32
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i7
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i7
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[128] x 32> [7] : i7, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_1 {
        calyx.assign %std_slice_2.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_2.out : i7
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %c-1_i32 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_mult_pipe_0.left = %in0 : i32
        calyx.assign %std_mult_pipe_0.right = %c16_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %std_slice_1.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %std_add_1.left = %muli_0_reg.out : i32
        calyx.assign %std_add_1.right = %c-1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
      calyx.group @bb0_6 {
        calyx.assign %std_slice_0.in = %in0 : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i7
        calyx.assign %arg_mem_0.write_data = %std_add_2.out : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %std_add_2.left = %load_0_reg.out : i32
        calyx.assign %std_add_2.right = %arg_mem_1.read_data : i32
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_1
          calyx.enable @bb0_2
          calyx.enable @bb0_4
          calyx.enable @bb0_6
        }
      }
    }
  }
  calyx.component @last_step_scan_inner_loop_0(%in0: i32, %in2: i32, %in3: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c16_i32 = hw.constant 16 : i32
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c16_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_1.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_0.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_0.done : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %std_slice_0.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_0.write_data = %std_add_1.out : i32
        calyx.assign %arg_mem_0.write_en = %true : i1
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.assign %std_add_1.left = %load_0_reg.out : i32
        calyx.assign %std_add_1.right = %in3 : i32
        calyx.group_done %arg_mem_0.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_4
        }
      }
    }
  }
  calyx.component @update_inner_loop_0(%in0: i32, %in2: i32, %in3: i32, %in4: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c3_i32 = hw.constant 3 : i32
    %c512_i32 = hw.constant 512 : i32
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %std_slice_4.in, %std_slice_4.out = calyx.std_slice @std_slice_4 : i32, i11
    %std_slice_3.in, %std_slice_3.out = calyx.std_slice @std_slice_3 : i32, i11
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i11
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i11
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i11
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i32, i1, i1, i1, i32, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %muli_1_reg.in, %muli_1_reg.write_en, %muli_1_reg.clk, %muli_1_reg.reset, %muli_1_reg.out, %muli_1_reg.done = calyx.register @muli_1_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_1.clk, %std_mult_pipe_1.reset, %std_mult_pipe_1.go, %std_mult_pipe_1.left, %std_mult_pipe_1.right, %std_mult_pipe_1.out, %std_mult_pipe_1.done = calyx.std_mult_pipe @std_mult_pipe_1 : i1, i1, i1, i32, i32, i32, i1
    %std_and_0.left, %std_and_0.right, %std_and_0.out = calyx.std_and @std_and_0 : i32, i32, i32
    %std_srsh_0.left, %std_srsh_0.right, %std_srsh_0.out = calyx.std_srsh @std_srsh_0 : i32, i32, i32
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %arg_mem_2.addr0, %arg_mem_2.clk, %arg_mem_2.reset, %arg_mem_2.content_en, %arg_mem_2.write_en, %arg_mem_2.write_data, %arg_mem_2.read_data, %arg_mem_2.done = calyx.seq_mem @arg_mem_2 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[2048] x 32> [11] : i11, i1, i1, i1, i1, i32, i32, i1
    calyx.wires {
      calyx.group @bb0_0 {
        calyx.assign %std_mult_pipe_0.left = %in2 : i32
        calyx.assign %std_mult_pipe_0.right = %c4_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_4.in = %std_add_0.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_4.out : i11
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %std_add_0.left = %in0 : i32
        calyx.assign %std_add_0.right = %muli_0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_mult_pipe_1.left = %std_and_0.out : i32
        calyx.assign %std_mult_pipe_1.right = %c512_i32 : i32
        calyx.assign %muli_1_reg.in = %std_mult_pipe_1.out : i32
        calyx.assign %muli_1_reg.write_en = %std_mult_pipe_1.done : i1
        %0 = comb.xor %std_mult_pipe_1.done, %true : i1
        calyx.assign %std_mult_pipe_1.go = %0 ? %true : i1
        calyx.assign %std_and_0.left = %std_srsh_0.out : i32
        calyx.assign %std_srsh_0.left = %arg_mem_0.read_data : i32
        calyx.assign %std_srsh_0.right = %in3 : i32
        calyx.assign %std_and_0.right = %c3_i32 : i32
        calyx.group_done %muli_1_reg.done : i1
      }
      calyx.group @bb0_7 {
        calyx.assign %std_slice_3.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_3.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_slice_2.in = %load_0_reg.out : i32
        calyx.assign %arg_mem_2.addr0 = %std_slice_2.out : i11
        calyx.assign %arg_mem_2.write_data = %arg_mem_0.read_data : i32
        calyx.assign %arg_mem_2.write_en = %true : i1
        calyx.assign %arg_mem_2.content_en = %true : i1
        calyx.group_done %arg_mem_2.done : i1
      }
      calyx.group @bb0_9 {
        calyx.assign %std_slice_1.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_1.out : i11
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_1_reg.in = %arg_mem_1.read_data : i32
        calyx.assign %load_1_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_11 {
        calyx.assign %std_slice_0.in = %std_add_1.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_0.out : i11
        calyx.assign %arg_mem_1.write_data = %std_add_2.out : i32
        calyx.assign %arg_mem_1.write_en = %true : i1
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %std_add_1.left = %muli_1_reg.out : i32
        calyx.assign %std_add_1.right = %in4 : i32
        calyx.assign %std_add_2.left = %load_1_reg.out : i32
        calyx.assign %std_add_2.right = %c1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.enable @bb0_5
          calyx.enable @bb0_7
          calyx.enable @bb0_8
          calyx.enable @bb0_9
          calyx.enable @bb0_11
        }
      }
    }
  }
}
