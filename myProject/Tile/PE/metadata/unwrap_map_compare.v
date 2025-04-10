(* techmap_celltype = "\$__lt_wrapper" *)
module unwrap_compare__lt #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    output reg[31:0] Y
);

reg [A_WIDTH - 1:0] A_orig;
reg [B_WIDTH - 1:0] B_orig;
reg [Y_WIDTH - 1:0] Y_orig;
assign A_orig = A;
assign B_orig = B;
assign Y = Y_orig;
\$lt #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_orig),
    .B(B_orig),
    .Y(Y_orig)
);

endmodule

(* techmap_celltype = "\$__le_wrapper" *)
module unwrap_compare__le #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    output reg[31:0] Y
);

reg [A_WIDTH - 1:0] A_orig;
reg [B_WIDTH - 1:0] B_orig;
reg [Y_WIDTH - 1:0] Y_orig;
assign A_orig = A;
assign B_orig = B;
assign Y = Y_orig;
\$le #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_orig),
    .B(B_orig),
    .Y(Y_orig)
);

endmodule

(* techmap_celltype = "\$__eq_wrapper" *)
module unwrap_compare__eq #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    output reg[31:0] Y
);

reg [A_WIDTH - 1:0] A_orig;
reg [B_WIDTH - 1:0] B_orig;
reg [Y_WIDTH - 1:0] Y_orig;
assign A_orig = A;
assign B_orig = B;
assign Y = Y_orig;
\$eq #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_orig),
    .B(B_orig),
    .Y(Y_orig)
);

endmodule

