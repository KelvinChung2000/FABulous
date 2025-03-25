(* techmap_celltype = "\$__and_wrapper" *)
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

reg A_ORIG;
reg B_ORIG;
reg Y_ORIG;
assign A_ORIG = A;
assign B_ORIG = B;
assign Y = Y_ORIG;
\$_and #(
    .A_WIDTH(A_WIDTH),
    .A_SIGNED(A_SIGNED),
    .B_WIDTH(B_WIDTH),
    .B_SIGNED(B_SIGNED),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_ORIG),
    .B(B_ORIG),
    .Y(Y_ORIG)
);

endmodule

(* techmap_celltype = "\$__or_wrapper" *)
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

reg A_ORIG;
reg B_ORIG;
reg Y_ORIG;
assign A_ORIG = A;
assign B_ORIG = B;
assign Y = Y_ORIG;
\$_or #(
    .A_WIDTH(A_WIDTH),
    .A_SIGNED(A_SIGNED),
    .B_WIDTH(B_WIDTH),
    .B_SIGNED(B_SIGNED),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_ORIG),
    .B(B_ORIG),
    .Y(Y_ORIG)
);

endmodule

