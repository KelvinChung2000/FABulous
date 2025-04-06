(* techmap_celltype = "\$__sdffe_wrapper" *)
module unwrap_reg_unit__sdffe #(
    parameter WIDTH = 1,
    parameter CLK_POLARITY = 1,
    parameter SRST_POLARITY = 1,
    parameter SRST_VALUE = 0,
    parameter EN_POLARITY = 1
)
(
    input wire[WIDTH:0] D,
    input wire CLK,
    output reg[WIDTH:0] Q,
    input wire SRST,
    input wire EN
);

reg [31:0] D_ORIG;
reg [31:0] Q_ORIG;
assign D_ORIG = D;
assign Q_ORIG = Q;
\$sdffe #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE),
    .EN_POLARITY(EN_POLARITY)
) _TECHMAP_REPLACE_ (
    .D(D_ORIG),
    .Q(Q_ORIG),
    .CLK(CLK),
    .SRST(SRST),
    .EN(EN)
);

endmodule

(* techmap_celltype = "\$__sdff_wrapper" *)
module unwrap_reg_unit__sdff #(
    parameter WIDTH = 1,
    parameter CLK_POLARITY = 1,
    parameter SRST_POLARITY = 1,
    parameter SRST_VALUE = 0
)
(
    input wire[WIDTH:0] D,
    input wire CLK,
    output reg[WIDTH:0] Q,
    input wire SRST
);

reg [31:0] D_ORIG;
reg [31:0] Q_ORIG;
assign D_ORIG = D;
assign Q_ORIG = Q;
\$sdff #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE)
) _TECHMAP_REPLACE_ (
    .D(D_ORIG),
    .Q(Q_ORIG),
    .CLK(CLK),
    .SRST(SRST)
);

endmodule

(* techmap_celltype = "\$__dff_wrapper" *)
module unwrap_reg_unit__dff #(
    parameter WIDTH = 1,
    parameter CLK_POLARITY = 1
)
(
    input wire[WIDTH:0] D,
    input wire CLK,
    output reg[WIDTH:0] Q
);

reg [31:0] D_ORIG;
reg [31:0] Q_ORIG;
assign D_ORIG = D;
assign Q_ORIG = Q;
\$dff #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY)
) _TECHMAP_REPLACE_ (
    .D(D_ORIG),
    .Q(Q_ORIG),
    .CLK(CLK)
);

endmodule

(* techmap_celltype = "\$__dffe_wrapper" *)
module unwrap_reg_unit__dffe #(
    parameter WIDTH = 1,
    parameter CLK_POLARITY = 1,
    parameter EN_POLARITY = 1
)
(
    input wire[WIDTH:0] D,
    input wire CLK,
    output reg[WIDTH:0] Q,
    input wire EN
);

reg [31:0] D_ORIG;
reg [31:0] Q_ORIG;
assign D_ORIG = D;
assign Q_ORIG = Q;
\$dffe #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY),
    .EN_POLARITY(EN_POLARITY)
) _TECHMAP_REPLACE_ (
    .D(D_ORIG),
    .Q(Q_ORIG),
    .CLK(CLK),
    .EN(EN)
);

endmodule

