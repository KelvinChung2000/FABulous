module attributes {calyx.entrypoint = "main"} {
  calyx.component @main(%in0: i32, %in1: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %mem_3.addr0, %mem_3.clk, %mem_3.reset, %mem_3.content_en, %mem_3.write_en, %mem_3.write_data, %mem_3.read_data, %mem_3.done = calyx.seq_mem @mem_3 <[900] x 32> [10] {external = true} : i10, i1, i1, i1, i1, i32, i32, i1
    %mem_2.addr0, %mem_2.clk, %mem_2.reset, %mem_2.content_en, %mem_2.write_en, %mem_2.write_data, %mem_2.read_data, %mem_2.done = calyx.seq_mem @mem_2 <[900] x 32> [10] {external = true} : i10, i1, i1, i1, i1, i32, i32, i1
    %mem_1.addr0, %mem_1.clk, %mem_1.reset, %mem_1.content_en, %mem_1.write_en, %mem_1.write_data, %mem_1.read_data, %mem_1.done = calyx.seq_mem @mem_1 <[900] x 32> [10] {external = true} : i10, i1, i1, i1, i1, i32, i32, i1
    %mem_0.addr0, %mem_0.clk, %mem_0.reset, %mem_0.content_en, %mem_0.write_en, %mem_0.write_data, %mem_0.read_data, %mem_0.done = calyx.seq_mem @mem_0 <[900] x 32> [10] {external = true} : i10, i1, i1, i1, i1, i32, i32, i1
    %gemm_instance.in0, %gemm_instance.in1, %gemm_instance.clk, %gemm_instance.reset, %gemm_instance.go, %gemm_instance.done = calyx.instance @gemm_instance of @gemm : i32, i32, i1, i1, i1, i1
    calyx.wires {
      calyx.group @init_gemm_instance {
        calyx.assign %gemm_instance.reset = %true : i1
        calyx.assign %gemm_instance.go = %true : i1
        calyx.group_done %gemm_instance.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @init_gemm_instance
          calyx.invoke @gemm_instance[arg_mem_0 = mem_0, arg_mem_1 = mem_1, arg_mem_2 = mem_2, arg_mem_3 = mem_3](%gemm_instance.in0 = %in0, %gemm_instance.in1 = %in1) -> (i32, i32)
        }
      }
    }
  } {toplevel}
  calyx.component @gemm(%in0: i32, %in1: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c30_i32 = hw.constant 30 : i32
    %c1_i32 = hw.constant 1 : i32
    %c20_i32 = hw.constant 20 : i32
    %c0_i32 = hw.constant 0 : i32
    %std_slice_3.in, %std_slice_3.out = calyx.std_slice @std_slice_3 : i32, i10
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i10
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i10
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i10
    %std_add_6.left, %std_add_6.right, %std_add_6.out = calyx.std_add @std_add_6 : i32, i32, i32
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i32, i1, i1, i1, i32, i1
    %muli_3_reg.in, %muli_3_reg.write_en, %muli_3_reg.clk, %muli_3_reg.reset, %muli_3_reg.out, %muli_3_reg.done = calyx.register @muli_3_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_3.clk, %std_mult_pipe_3.reset, %std_mult_pipe_3.go, %std_mult_pipe_3.left, %std_mult_pipe_3.right, %std_mult_pipe_3.out, %std_mult_pipe_3.done = calyx.std_mult_pipe @std_mult_pipe_3 : i1, i1, i1, i32, i32, i32, i1
    %std_add_5.left, %std_add_5.right, %std_add_5.out = calyx.std_add @std_add_5 : i32, i32, i32
    %muli_2_reg.in, %muli_2_reg.write_en, %muli_2_reg.clk, %muli_2_reg.reset, %muli_2_reg.out, %muli_2_reg.done = calyx.register @muli_2_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_2.clk, %std_mult_pipe_2.reset, %std_mult_pipe_2.go, %std_mult_pipe_2.left, %std_mult_pipe_2.right, %std_mult_pipe_2.out, %std_mult_pipe_2.done = calyx.std_mult_pipe @std_mult_pipe_2 : i1, i1, i1, i32, i32, i32, i1
    %muli_1_reg.in, %muli_1_reg.write_en, %muli_1_reg.clk, %muli_1_reg.reset, %muli_1_reg.out, %muli_1_reg.done = calyx.register @muli_1_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_1.clk, %std_mult_pipe_1.reset, %std_mult_pipe_1.go, %std_mult_pipe_1.left, %std_mult_pipe_1.right, %std_mult_pipe_1.out, %std_mult_pipe_1.done = calyx.std_mult_pipe @std_mult_pipe_1 : i1, i1, i1, i32, i32, i32, i1
    %std_add_4.left, %std_add_4.right, %std_add_4.out = calyx.std_add @std_add_4 : i32, i32, i32
    %std_add_3.left, %std_add_3.right, %std_add_3.out = calyx.std_add @std_add_3 : i32, i32, i32
    %std_slt_2.left, %std_slt_2.right, %std_slt_2.out = calyx.std_slt @std_slt_2 : i32, i32, i1
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i32, i32, i32
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i32, i32, i32
    %std_slt_1.left, %std_slt_1.right, %std_slt_1.out = calyx.std_slt @std_slt_1 : i32, i32, i1
    %muli_0_reg.in, %muli_0_reg.write_en, %muli_0_reg.clk, %muli_0_reg.reset, %muli_0_reg.out, %muli_0_reg.done = calyx.register @muli_0_reg : i32, i1, i1, i1, i32, i1
    %std_mult_pipe_0.clk, %std_mult_pipe_0.reset, %std_mult_pipe_0.go, %std_mult_pipe_0.left, %std_mult_pipe_0.right, %std_mult_pipe_0.out, %std_mult_pipe_0.done = calyx.std_mult_pipe @std_mult_pipe_0 : i1, i1, i1, i32, i32, i32, i1
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_slt_0.left, %std_slt_0.right, %std_slt_0.out = calyx.std_slt @std_slt_0 : i32, i32, i1
    %while_2_arg0_reg.in, %while_2_arg0_reg.write_en, %while_2_arg0_reg.clk, %while_2_arg0_reg.reset, %while_2_arg0_reg.out, %while_2_arg0_reg.done = calyx.register @while_2_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_1_arg0_reg.in, %while_1_arg0_reg.write_en, %while_1_arg0_reg.clk, %while_1_arg0_reg.reset, %while_1_arg0_reg.out, %while_1_arg0_reg.done = calyx.register @while_1_arg0_reg : i32, i1, i1, i1, i32, i1
    %while_0_arg0_reg.in, %while_0_arg0_reg.write_en, %while_0_arg0_reg.clk, %while_0_arg0_reg.reset, %while_0_arg0_reg.out, %while_0_arg0_reg.done = calyx.register @while_0_arg0_reg : i32, i1, i1, i1, i32, i1
    %arg_mem_3.addr0, %arg_mem_3.clk, %arg_mem_3.reset, %arg_mem_3.content_en, %arg_mem_3.write_en, %arg_mem_3.write_data, %arg_mem_3.read_data, %arg_mem_3.done = calyx.seq_mem @arg_mem_3 <[900] x 32> [10] : i10, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_2.addr0, %arg_mem_2.clk, %arg_mem_2.reset, %arg_mem_2.content_en, %arg_mem_2.write_en, %arg_mem_2.write_data, %arg_mem_2.read_data, %arg_mem_2.done = calyx.seq_mem @arg_mem_2 <[900] x 32> [10] : i10, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[900] x 32> [10] : i10, i1, i1, i1, i1, i32, i32, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[900] x 32> [10] : i10, i1, i1, i1, i1, i32, i32, i1
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
      calyx.comb_group @bb0_0 {
        calyx.assign %std_slt_0.left = %while_2_arg0_reg.out : i32
        calyx.assign %std_slt_0.right = %c20_i32 : i32
      }
      calyx.group @bb0_2 {
        calyx.assign %std_mult_pipe_0.left = %while_2_arg0_reg.out : i32
        calyx.assign %std_mult_pipe_0.right = %c30_i32 : i32
        calyx.assign %muli_0_reg.in = %std_mult_pipe_0.out : i32
        calyx.assign %muli_0_reg.write_en = %std_mult_pipe_0.done : i1
        %0 = comb.xor %std_mult_pipe_0.done, %true : i1
        calyx.assign %std_mult_pipe_0.go = %0 ? %true : i1
        calyx.group_done %muli_0_reg.done : i1
      }
      calyx.comb_group @bb0_3 {
        calyx.assign %std_slt_1.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_slt_1.right = %c20_i32 : i32
      }
      calyx.comb_group @bb0_6 {
        calyx.assign %std_slt_2.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_slt_2.right = %c20_i32 : i32
      }
      calyx.group @bb0_9 {
        calyx.assign %std_slice_3.in = %std_add_4.out : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_3.out : i10
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.assign %std_add_4.left = %muli_0_reg.out : i32
        calyx.assign %std_add_4.right = %while_0_arg0_reg.out : i32
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_10 {
        calyx.assign %std_mult_pipe_1.left = %in0 : i32
        calyx.assign %std_mult_pipe_1.right = %arg_mem_0.read_data : i32
        calyx.assign %muli_1_reg.in = %std_mult_pipe_1.out : i32
        calyx.assign %muli_1_reg.write_en = %std_mult_pipe_1.done : i1
        %0 = comb.xor %std_mult_pipe_1.done, %true : i1
        calyx.assign %std_mult_pipe_1.go = %0 ? %true : i1
        calyx.group_done %muli_1_reg.done : i1
      }
      calyx.group @bb0_11 {
        calyx.assign %std_mult_pipe_2.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_mult_pipe_2.right = %c30_i32 : i32
        calyx.assign %muli_2_reg.in = %std_mult_pipe_2.out : i32
        calyx.assign %muli_2_reg.write_en = %std_mult_pipe_2.done : i1
        %0 = comb.xor %std_mult_pipe_2.done, %true : i1
        calyx.assign %std_mult_pipe_2.go = %0 ? %true : i1
        calyx.group_done %muli_2_reg.done : i1
      }
      calyx.group @bb0_13 {
        calyx.assign %std_slice_2.in = %std_add_5.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_2.out : i10
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %std_add_5.left = %muli_2_reg.out : i32
        calyx.assign %std_add_5.right = %while_1_arg0_reg.out : i32
        calyx.group_done %arg_mem_1.done : i1
      }
      calyx.group @bb0_14 {
        calyx.assign %std_mult_pipe_3.left = %muli_1_reg.out : i32
        calyx.assign %std_mult_pipe_3.right = %arg_mem_1.read_data : i32
        calyx.assign %muli_3_reg.in = %std_mult_pipe_3.out : i32
        calyx.assign %muli_3_reg.write_en = %std_mult_pipe_3.done : i1
        %0 = comb.xor %std_mult_pipe_3.done, %true : i1
        calyx.assign %std_mult_pipe_3.go = %0 ? %true : i1
        calyx.group_done %muli_3_reg.done : i1
      }
      calyx.group @bb0_15 {
        calyx.assign %std_slice_1.in = %std_add_2.out : i32
        calyx.assign %arg_mem_3.addr0 = %std_slice_1.out : i10
        calyx.assign %arg_mem_3.content_en = %true : i1
        calyx.assign %arg_mem_3.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_3.read_data : i32
        calyx.assign %load_0_reg.write_en = %arg_mem_3.done : i1
        calyx.assign %std_add_2.left = %muli_0_reg.out : i32
        calyx.assign %std_add_2.right = %while_1_arg0_reg.out : i32
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_17 {
        calyx.assign %std_slice_0.in = %std_add_2.out : i32
        calyx.assign %arg_mem_3.addr0 = %std_slice_0.out : i10
        calyx.assign %arg_mem_3.write_data = %std_add_6.out : i32
        calyx.assign %arg_mem_3.write_en = %true : i1
        calyx.assign %arg_mem_3.content_en = %true : i1
        calyx.assign %std_add_2.left = %muli_0_reg.out : i32
        calyx.assign %std_add_2.right = %while_1_arg0_reg.out : i32
        calyx.assign %std_add_6.left = %load_0_reg.out : i32
        calyx.assign %std_add_6.right = %muli_3_reg.out : i32
        calyx.group_done %arg_mem_3.done : i1
      }
      calyx.group @assign_while_0_latch {
        calyx.assign %while_0_arg0_reg.in = %std_add_3.out : i32
        calyx.assign %while_0_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_3.left = %while_0_arg0_reg.out : i32
        calyx.assign %std_add_3.right = %c1_i32 : i32
        calyx.group_done %while_0_arg0_reg.done : i1
      }
      calyx.group @assign_while_1_latch {
        calyx.assign %while_1_arg0_reg.in = %std_add_1.out : i32
        calyx.assign %while_1_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_1.left = %while_1_arg0_reg.out : i32
        calyx.assign %std_add_1.right = %c1_i32 : i32
        calyx.group_done %while_1_arg0_reg.done : i1
      }
      calyx.group @assign_while_2_latch {
        calyx.assign %while_2_arg0_reg.in = %std_add_0.out : i32
        calyx.assign %while_2_arg0_reg.write_en = %true : i1
        calyx.assign %std_add_0.left = %while_2_arg0_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %while_2_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.par {
          calyx.enable @assign_while_2_init_0
        }
        calyx.while %std_slt_0.out with @bb0_0 {
          calyx.seq {
            calyx.seq {
              calyx.enable @bb0_2
              calyx.par {
                calyx.enable @assign_while_1_init_0
              }
              calyx.while %std_slt_1.out with @bb0_3 {
                calyx.seq {
                  calyx.par {
                    calyx.enable @assign_while_0_init_0
                  }
                  calyx.while %std_slt_2.out with @bb0_6 {
                    calyx.seq {
                      calyx.seq {
                        calyx.enable @bb0_9
                        calyx.enable @bb0_10
                        calyx.enable @bb0_11
                        calyx.enable @bb0_13
                        calyx.enable @bb0_14
                        calyx.enable @bb0_15
                        calyx.enable @bb0_17
                      }
                      calyx.enable @assign_while_0_latch
                    }
                  }
                  calyx.enable @assign_while_1_latch
                }
              }
            }
            calyx.enable @assign_while_2_latch
          }
        }
      }
    }
  }
}
