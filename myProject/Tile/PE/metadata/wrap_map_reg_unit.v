(* techmap_celltype = "$and" *)
module wrap_reg_unit__and #(
    parameter A_WIDTH = 1,
    parameter A_SIGNED = 0,
    parameter B_WIDTH = 1,
    parameter B_SIGNED = 0,
    parameter Y_WIDTH = 1
)
(
    input wire[A_WIDTH:0] A,
    input wire[B_WIDTH:0] B,
    output reg[Y_WIDTH:0] Y
);

reg A_1;
reg B_1;
reg Y_1;
assign A_1 = A;
assign B_1 = B;
assign Y = Y_1;
\$__and_wrapper #(
    .A_WIDTH(A_WIDTH),
    .A_SIGNED(A_SIGNED),
    .B_WIDTH(B_WIDTH),
    .B_SIGNED(B_SIGNED),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_1),
    .B(B_1),
    .Y(Y_1)
);

endmodule

(* techmap_celltype = "$or" *)
module wrap_reg_unit__or #(
    parameter A_WIDTH = 1,
    parameter A_SIGNED = 0,
    parameter B_WIDTH = 1,
    parameter B_SIGNED = 0,
    parameter Y_WIDTH = 1
)
(
    input wire[A_WIDTH:0] A,
    input wire[B_WIDTH:0] B,
    output reg[Y_WIDTH:0] Y
);

reg A_1;
reg B_1;
reg Y_1;
assign A_1 = A;
assign B_1 = B;
assign Y = Y_1;
\$__or_wrapper #(
    .A_WIDTH(A_WIDTH),
    .A_SIGNED(A_SIGNED),
    .B_WIDTH(B_WIDTH),
    .B_SIGNED(B_SIGNED),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_1),
    .B(B_1),
    .Y(Y_1)
);

endmodule

