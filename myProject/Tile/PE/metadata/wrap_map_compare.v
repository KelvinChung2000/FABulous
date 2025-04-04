(* techmap_celltype = "$eq" *)
module wrap_compare__eq #(
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

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__eq_wrapper #(
    .A_WIDTH(A_WIDTH),
    .A_SIGNED(A_SIGNED),
    .B_WIDTH(B_WIDTH),
    .B_SIGNED(B_SIGNED),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

(* techmap_celltype = "$le" *)
module wrap_compare__le #(
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

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__le_wrapper #(
    .A_WIDTH(A_WIDTH),
    .A_SIGNED(A_SIGNED),
    .B_WIDTH(B_WIDTH),
    .B_SIGNED(B_SIGNED),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

(* techmap_celltype = "$lt" *)
module wrap_compare__lt #(
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

reg [31:0] A_32;
reg [31:0] B_32;
reg [31:0] Y_32;
assign A_32 = A;
assign B_32 = B;
assign Y = Y_32;
\$__lt_wrapper #(
    .A_WIDTH(A_WIDTH),
    .A_SIGNED(A_SIGNED),
    .B_WIDTH(B_WIDTH),
    .B_SIGNED(B_SIGNED),
    .Y_WIDTH(Y_WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_32),
    .B(B_32),
    .Y(Y_32)
);

endmodule

