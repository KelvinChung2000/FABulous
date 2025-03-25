(* techmap_celltype = "\$__add_wrapper" *)
module wrap_ALU__add #(
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
\$_add #(
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

(* techmap_celltype = "\$__and_wrapper" *)
module wrap_ALU__and #(
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

(* techmap_celltype = "\$__mul_wrapper" *)
module wrap_ALU__mul #(
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
\$_mul #(
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
module wrap_ALU__or #(
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

(* techmap_celltype = "\$__sub_wrapper" *)
module wrap_ALU__sub #(
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
\$_sub #(
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

(* techmap_celltype = "\$__xor_wrapper" *)
module wrap_ALU__xor #(
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
\$_xor #(
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

