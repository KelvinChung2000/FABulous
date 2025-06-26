module attributes {calyx.entrypoint = "main"} {
  calyx.component @main(%in0: i32, %in1: i64, %in2: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %mem_3.addr0, %mem_3.clk, %mem_3.reset, %mem_3.content_en, %mem_3.write_en, %mem_3.write_data, %mem_3.read_data, %mem_3.done = calyx.seq_mem @mem_3 <[256] x 64> [8] {external = true} : i8, i1, i1, i1, i1, i64, i64, i1
    %mem_2.addr0, %mem_2.clk, %mem_2.reset, %mem_2.content_en, %mem_2.write_en, %mem_2.write_data, %mem_2.read_data, %mem_2.done = calyx.seq_mem @mem_2 <[10] x 64> [4] {external = true} : i4, i1, i1, i1, i1, i64, i64, i1
    %mem_1.addr0, %mem_1.clk, %mem_1.reset, %mem_1.content_en, %mem_1.write_en, %mem_1.write_data, %mem_1.read_data, %mem_1.done = calyx.seq_mem @mem_1 <[256] x 8> [8] {external = true} : i8, i1, i1, i1, i1, i8, i8, i1
    %mem_0.addr0, %mem_0.clk, %mem_0.reset, %mem_0.content_en, %mem_0.write_en, %mem_0.write_data, %mem_0.read_data, %mem_0.done = calyx.seq_mem @mem_0 <[4096] x 64> [12] {external = true} : i12, i1, i1, i1, i1, i64, i64, i1
    %bfs_queue_inner_loop_0_instance.in0, %bfs_queue_inner_loop_0_instance.in1, %bfs_queue_inner_loop_0_instance.in4, %bfs_queue_inner_loop_0_instance.clk, %bfs_queue_inner_loop_0_instance.reset, %bfs_queue_inner_loop_0_instance.go, %bfs_queue_inner_loop_0_instance.out0, %bfs_queue_inner_loop_0_instance.done = calyx.instance @bfs_queue_inner_loop_0_instance of @bfs_queue_inner_loop_0 : i32, i64, i32, i1, i1, i1, i64, i1
    calyx.wires {
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.invoke @bfs_queue_inner_loop_0_instance[arg_mem_0 = mem_0, arg_mem_1 = mem_1, arg_mem_2 = mem_2, arg_mem_3 = mem_3](%bfs_queue_inner_loop_0_instance.in0 = %in0, %bfs_queue_inner_loop_0_instance.in1 = %in1, %bfs_queue_inner_loop_0_instance.in4 = %in2) -> (i32, i64, i32)
        }
      }
    }
  } {toplevel}
  calyx.component @bfs_queue_inner_loop_0(%in0: i32, %in1: i64, %in4: i32, %clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%out0: i64, %done: i1 {done}) {
    %true = hw.constant true
    %false = hw.constant false
    %c127_i32 = hw.constant 127 : i32
    %c1_i32 = hw.constant 1 : i32
    %c1_i64 = hw.constant 1 : i64
    %c0_i64 = hw.constant 0 : i64
    %c255_i64 = hw.constant 255 : i64
    %c-1_i64 = hw.constant -1 : i64
    %c256_i64 = hw.constant 256 : i64
    %std_slice_9.in, %std_slice_9.out = calyx.std_slice @std_slice_9 : i32, i12
    %std_slice_8.in, %std_slice_8.out = calyx.std_slice @std_slice_8 : i32, i8
    %std_slice_7.in, %std_slice_7.out = calyx.std_slice @std_slice_7 : i32, i8
    %std_slice_6.in, %std_slice_6.out = calyx.std_slice @std_slice_6 : i32, i8
    %std_slice_5.in, %std_slice_5.out = calyx.std_slice @std_slice_5 : i32, i4
    %std_slice_4.in, %std_slice_4.out = calyx.std_slice @std_slice_4 : i32, i4
    %std_slice_3.in, %std_slice_3.out = calyx.std_slice @std_slice_3 : i32, i8
    %remsi_0_reg.in, %remsi_0_reg.write_en, %remsi_0_reg.clk, %remsi_0_reg.reset, %remsi_0_reg.out, %remsi_0_reg.done = calyx.register @remsi_0_reg : i64, i1, i1, i1, i64, i1
    %std_rems_pipe_0.clk, %std_rems_pipe_0.reset, %std_rems_pipe_0.go, %std_rems_pipe_0.left, %std_rems_pipe_0.right, %std_rems_pipe_0.out_remainder, %std_rems_pipe_0.done = calyx.std_rems_pipe @std_rems_pipe_0 : i1, i1, i1, i64, i64, i64, i1
    %std_add_3.left, %std_add_3.right, %std_add_3.out = calyx.std_add @std_add_3 : i64, i64, i64
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i64, i32
    %std_add_2.left, %std_add_2.right, %std_add_2.out = calyx.std_add @std_add_2 : i64, i64, i64
    %std_eq_1.left, %std_eq_1.right, %std_eq_1.out = calyx.std_eq @std_eq_1 : i64, i64, i1
    %std_add_1.left, %std_add_1.right, %std_add_1.out = calyx.std_add @std_add_1 : i64, i64, i64
    %load_2_reg.in, %load_2_reg.write_en, %load_2_reg.clk, %load_2_reg.reset, %load_2_reg.out, %load_2_reg.done = calyx.register @load_2_reg : i64, i1, i1, i1, i64, i1
    %std_pad_0.in, %std_pad_0.out = calyx.std_pad @std_pad_0 : i8, i32
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i8
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %std_signext_1.in, %std_signext_1.out = calyx.std_signext @std_signext_1 : i8, i32
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i8, i1, i1, i1, i8, i1
    %std_eq_0.left, %std_eq_0.right, %std_eq_0.out = calyx.std_eq @std_eq_0 : i32, i32, i1
    %std_signext_0.in, %std_signext_0.out = calyx.std_signext @std_signext_0 : i8, i32
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i8, i1, i1, i1, i8, i1
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i64, i32
    %if_res_1_reg.in, %if_res_1_reg.write_en, %if_res_1_reg.clk, %if_res_1_reg.reset, %if_res_1_reg.out, %if_res_1_reg.done = calyx.register @if_res_1_reg : i64, i1, i1, i1, i64, i1
    %if_res_0_reg.in, %if_res_0_reg.write_en, %if_res_0_reg.clk, %if_res_0_reg.reset, %if_res_0_reg.out, %if_res_0_reg.done = calyx.register @if_res_0_reg : i64, i1, i1, i1, i64, i1
    %ret_arg0_reg.in, %ret_arg0_reg.write_en, %ret_arg0_reg.clk, %ret_arg0_reg.reset, %ret_arg0_reg.out, %ret_arg0_reg.done = calyx.register @ret_arg0_reg : i64, i1, i1, i1, i64, i1
    %arg_mem_3.addr0, %arg_mem_3.clk, %arg_mem_3.reset, %arg_mem_3.content_en, %arg_mem_3.write_en, %arg_mem_3.write_data, %arg_mem_3.read_data, %arg_mem_3.done = calyx.seq_mem @arg_mem_3 <[256] x 64> [8] : i8, i1, i1, i1, i1, i64, i64, i1
    %arg_mem_2.addr0, %arg_mem_2.clk, %arg_mem_2.reset, %arg_mem_2.content_en, %arg_mem_2.write_en, %arg_mem_2.write_data, %arg_mem_2.read_data, %arg_mem_2.done = calyx.seq_mem @arg_mem_2 <[10] x 64> [4] : i4, i1, i1, i1, i1, i64, i64, i1
    %arg_mem_1.addr0, %arg_mem_1.clk, %arg_mem_1.reset, %arg_mem_1.content_en, %arg_mem_1.write_en, %arg_mem_1.write_data, %arg_mem_1.read_data, %arg_mem_1.done = calyx.seq_mem @arg_mem_1 <[256] x 8> [8] : i8, i1, i1, i1, i1, i8, i8, i1
    %arg_mem_0.addr0, %arg_mem_0.clk, %arg_mem_0.reset, %arg_mem_0.content_en, %arg_mem_0.write_en, %arg_mem_0.write_data, %arg_mem_0.read_data, %arg_mem_0.done = calyx.seq_mem @arg_mem_0 <[4096] x 64> [12] : i12, i1, i1, i1, i1, i64, i64, i1
    calyx.wires {
      calyx.assign %out0 = %ret_arg0_reg.out : i64
      calyx.group @then_br_0 {
        calyx.assign %if_res_0_reg.in = %c255_i64 : i64
        calyx.assign %if_res_0_reg.write_en = %true : i1
        calyx.group_done %if_res_0_reg.done : i1
      }
      calyx.group @else_br_0 {
        calyx.assign %if_res_0_reg.in = %std_add_2.out : i64
        calyx.assign %if_res_0_reg.write_en = %true : i1
        calyx.assign %std_add_2.left = %in1 : i64
        calyx.assign %std_add_2.right = %c-1_i64 : i64
        calyx.group_done %if_res_0_reg.done : i1
      }
      calyx.group @then_br_1 {
        calyx.assign %if_res_1_reg.in = %remsi_0_reg.out : i64
        calyx.assign %if_res_1_reg.write_en = %true : i1
        calyx.group_done %if_res_1_reg.done : i1
      }
      calyx.group @else_br_1 {
        calyx.assign %if_res_1_reg.in = %in1 : i64
        calyx.assign %if_res_1_reg.write_en = %true : i1
        calyx.group_done %if_res_1_reg.done : i1
      }
      calyx.group @bb0_0 {
        calyx.assign %std_slice_9.in = %in0 : i32
        calyx.assign %arg_mem_0.addr0 = %std_slice_9.out : i12
        calyx.assign %arg_mem_0.content_en = %true : i1
        calyx.assign %arg_mem_0.write_en = %false : i1
        calyx.group_done %arg_mem_0.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_8.in = %std_slice_0.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_8.out : i8
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_0_reg.in = %arg_mem_1.read_data : i8
        calyx.assign %load_0_reg.write_en = %arg_mem_1.done : i1
        calyx.assign %std_slice_0.in = %arg_mem_0.read_data : i64
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.comb_group @bb0_4 {
        calyx.assign %std_eq_0.left = %std_signext_0.out : i32
        calyx.assign %std_eq_0.right = %c127_i32 : i32
        calyx.assign %std_signext_0.in = %load_0_reg.out : i8
      }
      calyx.group @bb0_5 {
        calyx.assign %std_slice_7.in = %in4 : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_7.out : i8
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %arg_mem_1.write_en = %false : i1
        calyx.assign %load_1_reg.in = %arg_mem_1.read_data : i8
        calyx.assign %load_1_reg.write_en = %arg_mem_1.done : i1
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_9 {
        calyx.assign %std_slice_6.in = %std_slice_0.out : i32
        calyx.assign %arg_mem_1.addr0 = %std_slice_6.out : i8
        calyx.assign %arg_mem_1.write_data = %std_slice_1.out : i8
        calyx.assign %arg_mem_1.write_en = %true : i1
        calyx.assign %arg_mem_1.content_en = %true : i1
        calyx.assign %std_slice_0.in = %arg_mem_0.read_data : i64
        calyx.assign %std_slice_1.in = %std_add_0.out : i32
        calyx.assign %std_add_0.left = %std_signext_1.out : i32
        calyx.assign %std_signext_1.in = %load_1_reg.out : i8
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %arg_mem_1.done : i1
      }
      calyx.group @bb0_11 {
        calyx.assign %std_slice_5.in = %std_pad_0.out : i32
        calyx.assign %arg_mem_2.addr0 = %std_slice_5.out : i4
        calyx.assign %arg_mem_2.content_en = %true : i1
        calyx.assign %arg_mem_2.write_en = %false : i1
        calyx.assign %load_2_reg.in = %arg_mem_2.read_data : i64
        calyx.assign %load_2_reg.write_en = %arg_mem_2.done : i1
        calyx.assign %std_pad_0.in = %std_slice_1.out : i8
        calyx.assign %std_slice_1.in = %std_add_0.out : i32
        calyx.assign %std_add_0.left = %std_signext_1.out : i32
        calyx.assign %std_signext_1.in = %load_1_reg.out : i8
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.group_done %load_2_reg.done : i1
      }
      calyx.group @bb0_13 {
        calyx.assign %std_slice_4.in = %std_pad_0.out : i32
        calyx.assign %arg_mem_2.addr0 = %std_slice_4.out : i4
        calyx.assign %arg_mem_2.write_data = %std_add_1.out : i64
        calyx.assign %arg_mem_2.write_en = %true : i1
        calyx.assign %arg_mem_2.content_en = %true : i1
        calyx.assign %std_pad_0.in = %std_slice_1.out : i8
        calyx.assign %std_slice_1.in = %std_add_0.out : i32
        calyx.assign %std_add_0.left = %std_signext_1.out : i32
        calyx.assign %std_signext_1.in = %load_1_reg.out : i8
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.assign %std_add_1.left = %load_2_reg.out : i64
        calyx.assign %std_add_1.right = %c1_i64 : i64
        calyx.group_done %arg_mem_2.done : i1
      }
      calyx.comb_group @bb0_14 {
        calyx.assign %std_eq_1.left = %in1 : i64
        calyx.assign %std_eq_1.right = %c0_i64 : i64
      }
      calyx.group @bb0_17 {
        calyx.assign %std_slice_3.in = %std_slice_2.out : i32
        calyx.assign %arg_mem_3.addr0 = %std_slice_3.out : i8
        calyx.assign %arg_mem_3.write_data = %arg_mem_0.read_data : i64
        calyx.assign %arg_mem_3.write_en = %true : i1
        calyx.assign %arg_mem_3.content_en = %true : i1
        calyx.assign %std_slice_2.in = %if_res_0_reg.out : i64
        calyx.group_done %arg_mem_3.done : i1
      }
      calyx.group @bb0_19 {
        calyx.assign %std_rems_pipe_0.left = %std_add_3.out : i64
        calyx.assign %std_rems_pipe_0.right = %c256_i64 : i64
        calyx.assign %remsi_0_reg.in = %std_rems_pipe_0.out_remainder : i64
        calyx.assign %remsi_0_reg.write_en = %std_rems_pipe_0.done : i1
        %0 = comb.xor %std_rems_pipe_0.done, %true : i1
        calyx.assign %std_rems_pipe_0.go = %0 ? %true : i1
        calyx.assign %std_add_3.left = %in1 : i64
        calyx.assign %std_add_3.right = %c1_i64 : i64
        calyx.group_done %remsi_0_reg.done : i1
      }
      calyx.group @ret_assign_0 {
        calyx.assign %ret_arg0_reg.in = %if_res_1_reg.out : i64
        calyx.assign %ret_arg0_reg.write_en = %true : i1
        calyx.group_done %ret_arg0_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_2
          calyx.if %std_eq_0.out with @bb0_4 {
            calyx.seq {
              calyx.seq {
                calyx.enable @bb0_5
                calyx.enable @bb0_9
                calyx.enable @bb0_11
                calyx.enable @bb0_13
                calyx.if %std_eq_1.out with @bb0_14 {
                  calyx.seq {
                    calyx.enable @then_br_0
                  }
                } else {
                  calyx.seq {
                    calyx.enable @else_br_0
                  }
                }
                calyx.enable @bb0_17
                calyx.enable @bb0_19
              }
              calyx.enable @then_br_1
            }
          } else {
            calyx.seq {
              calyx.enable @else_br_1
            }
          }
          calyx.enable @ret_assign_0
        }
      }
    }
  }
}
