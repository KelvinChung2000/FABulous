(* techmap_celltype = "\$__sdffe_wrapper" *)
module unwrap_reg_unit__sdffe #(
    parameter CLK_POLARITY = 0,
    parameter EN_POLARITY = 0,
    parameter SRST_POLARITY = 0,
    parameter SRST_VALUE = 0,
    parameter WIDTH = 0
)
(
    input wire CLK,
    input wire[31:0] D,
    input wire EN,
    output reg[31:0] Q,
    input wire SRST
);

reg [WIDTH - 1:0] CLK_orig;
reg [WIDTH - 1:0] D_orig;
reg [WIDTH - 1:0] EN_orig;
reg [WIDTH - 1:0] Q_orig;
reg [WIDTH - 1:0] SRST_orig;
assign CLK_orig = CLK;
assign D_orig = D;
assign EN_orig = EN;
assign Q = Q_orig;
assign SRST_orig = SRST;
\$sdffe #(
    .CLK_POLARITY(CLK_POLARITY),
    .EN_POLARITY(EN_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_orig),
    .D(D_orig),
    .EN(EN_orig),
    .Q(Q_orig),
    .SRST(SRST_orig)
);

endmodule

(* techmap_celltype = "\$__sdff_wrapper" *)
module unwrap_reg_unit__sdff #(
    parameter CLK_POLARITY = 0,
    parameter SRST_POLARITY = 0,
    parameter SRST_VALUE = 0,
    parameter WIDTH = 0
)
(
    input wire CLK,
    input wire[31:0] D,
    output reg[31:0] Q,
    input wire SRST
);

reg [WIDTH - 1:0] CLK_orig;
reg [WIDTH - 1:0] D_orig;
reg [WIDTH - 1:0] Q_orig;
reg [WIDTH - 1:0] SRST_orig;
assign CLK_orig = CLK;
assign D_orig = D;
assign Q = Q_orig;
assign SRST_orig = SRST;
\$sdff #(
    .CLK_POLARITY(CLK_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_orig),
    .D(D_orig),
    .Q(Q_orig),
    .SRST(SRST_orig)
);

endmodule

(* techmap_celltype = "\$__dff_wrapper" *)
module unwrap_reg_unit__dff #(
    parameter CLK_POLARITY = 0,
    parameter WIDTH = 0
)
(
    input wire CLK,
    input wire[31:0] D,
    output reg[31:0] Q
);

reg [WIDTH - 1:0] CLK_orig;
reg [WIDTH - 1:0] D_orig;
reg [WIDTH - 1:0] Q_orig;
assign CLK_orig = CLK;
assign D_orig = D;
assign Q = Q_orig;
\$dff #(
    .CLK_POLARITY(CLK_POLARITY),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_orig),
    .D(D_orig),
    .Q(Q_orig)
);

endmodule

(* techmap_celltype = "\$__dffe_wrapper" *)
module unwrap_reg_unit__dffe #(
    parameter CLK_POLARITY = 0,
    parameter EN_POLARITY = 0,
    parameter WIDTH = 0
)
(
    input wire CLK,
    input wire[31:0] D,
    input wire EN,
    output reg[31:0] Q
);

reg [WIDTH - 1:0] CLK_orig;
reg [WIDTH - 1:0] D_orig;
reg [WIDTH - 1:0] EN_orig;
reg [WIDTH - 1:0] Q_orig;
assign CLK_orig = CLK;
assign D_orig = D;
assign EN_orig = EN;
assign Q = Q_orig;
\$dffe #(
    .CLK_POLARITY(CLK_POLARITY),
    .EN_POLARITY(EN_POLARITY),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_orig),
    .D(D_orig),
    .EN(EN_orig),
    .Q(Q_orig)
);

endmodule

