(* techmap_celltype = "std_add" *)
module std_add_techmap #(
    parameter WIDTH = 32
) (
    input [31:0] left,
    input [31:0] right,
    output [31:0] out
);
    generate
        ALU #(
            .NoConfigBits(3)
        ) __TECHMAP_REPLACE__ (
            .rst(),
            .en(),
            .clk(),
            .data_in1(left),
            .data_in2(right),
            .data_in3(),
            .data_out(out),
            .ConfigBits()
        );
    endgenerate
endmodule
