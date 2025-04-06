(* techmap_celltype = "\$__lt_wrapper" *)
module unwrap_compare__lt #(
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

reg [31:0] A_ORIG;
reg [31:0] B_ORIG;
reg [31:0] Y_ORIG;
assign A_ORIG = A;
assign B_ORIG = B;
assign Y = Y_ORIG;
\$lt #(
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

(* techmap_celltype = "\$__le_wrapper" *)
module unwrap_compare__le #(
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

reg [31:0] A_ORIG;
reg [31:0] B_ORIG;
reg [31:0] Y_ORIG;
assign A_ORIG = A;
assign B_ORIG = B;
assign Y = Y_ORIG;
\$le #(
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

(* techmap_celltype = "\$__eq_wrapper" *)
module unwrap_compare__eq #(
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

reg [31:0] A_ORIG;
reg [31:0] B_ORIG;
reg [31:0] Y_ORIG;
assign A_ORIG = A;
assign B_ORIG = B;
assign Y = Y_ORIG;
\$eq #(
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

