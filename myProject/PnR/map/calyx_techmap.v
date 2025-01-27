(* techmap_celltype = "std_add" *)
module simple_techmap(left, right, out);
    parameter WIDTH = 32;

  input [WIDTH-1:0] left;
  input [WIDTH-1:0] right;
  output [WIDTH-1:0] out;

    generate
        ALU #(
        .NoConfigBits(3)
        ) _TECHMAP_REPLACE_ (
            .rst(),
            .en(),
            .clk(),
            .data_in1(left),
            .data_in2(right),
            .data_in3(0),
            .data_out(out),
            .configBits()
        );
    endgenerate


endmodule