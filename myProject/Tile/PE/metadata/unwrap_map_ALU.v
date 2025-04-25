(* techmap_celltype = "\$__add_wrapper" *)
module unwrap_ALU__add #(
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
\$add #(
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

(* techmap_celltype = "\$__sub_wrapper" *)
module unwrap_ALU__sub #(
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
\$sub #(
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

(* techmap_celltype = "\$__mux_wrapper" *)
module unwrap_ALU__mux #(
    parameter WIDTH = 0
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire S,
    output reg[31:0] Y
);

reg [WIDTH - 1:0] A_orig;
reg [WIDTH - 1:0] B_orig;
reg [WIDTH - 1:0] S_orig;
reg [WIDTH - 1:0] Y_orig;
assign A_orig = A;
assign B_orig = B;
assign S_orig = S;
assign Y = Y_orig;
\$mux #(
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_orig),
    .B(B_orig),
    .S(S_orig),
    .Y(Y_orig)
);

endmodule

(* techmap_celltype = "\$__xor_wrapper" *)
module unwrap_ALU__xor #(
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
\$xor #(
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

(* techmap_celltype = "\$__mul_wrapper" *)
module unwrap_ALU__mul #(
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
\$mul #(
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

(* techmap_celltype = "\$__or_wrapper" *)
module unwrap_ALU__or #(
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
\$or #(
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

