(* techmap_celltype = "\$add" *)
module wrap_ALU__add #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[A_WIDTH - 1:0] A,
    input wire[B_WIDTH - 1:0] B,
    output reg[Y_WIDTH - 1:0] Y
);

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__add_wrapper #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

(* techmap_celltype = "\$sub" *)
module wrap_ALU__sub #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[A_WIDTH - 1:0] A,
    input wire[B_WIDTH - 1:0] B,
    output reg[Y_WIDTH - 1:0] Y
);

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__sub_wrapper #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

(* techmap_celltype = "\$mux" *)
module wrap_ALU__mux #(
    parameter WIDTH = 0
)
(
    input wire[WIDTH - 1:0] A,
    input wire[WIDTH - 1:0] B,
    input wire[WIDTH - 1:0] S,
    output reg[WIDTH - 1:0] Y
);

reg [31:0] A_32;
reg [31:0] B_32;
reg S_1;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign S_1 = S;
assign Y = Y_32;
\$__mux_wrapper #(
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .S(S_1),
    .Y(Y_32)
);

endmodule

(* techmap_celltype = "\$xor" *)
module wrap_ALU__xor #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[A_WIDTH - 1:0] A,
    input wire[B_WIDTH - 1:0] B,
    output reg[Y_WIDTH - 1:0] Y
);

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__xor_wrapper #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

(* techmap_celltype = "\$mul" *)
module wrap_ALU__mul #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[A_WIDTH - 1:0] A,
    input wire[B_WIDTH - 1:0] B,
    output reg[Y_WIDTH - 1:0] Y
);

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__mul_wrapper #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

(* techmap_celltype = "\$or" *)
module wrap_ALU__or #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 0,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 0,
    parameter Y_WIDTH = 0
)
(
    input wire[A_WIDTH - 1:0] A,
    input wire[B_WIDTH - 1:0] B,
    output reg[Y_WIDTH - 1:0] Y
);

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__or_wrapper #(
    .A_SIGNED(A_SIGNED),
    .A_WIDTH(A_WIDTH),
    .B_SIGNED(B_SIGNED),
    .B_WIDTH(B_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

