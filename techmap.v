(* techmap_celltype = "$add" *)
module std_add_techmap #(
    parameter WIDTH = 32
) (
    input [31:0] A,
    input [31:0] B,
    output [31:0] Y
);
    generate
        ALU #(
            .NoConfigBits(3)
        ) __TECHMAP_REPLACE__ (
            .rst(),
            .en(),
            .clk(),
            .data_in1(A),
            .data_in2(B),
            .data_in3(),
            .data_out(Y),
            .ConfigBits()
        );
    endgenerate
endmodule
