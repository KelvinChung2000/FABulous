(* techmap_celltype = "\$sdffe" *)
module wrap_reg_unit__sdffe #(
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

reg [31:0] D_32;
reg [31:0] Q_32;
assign D_32 = D;
assign Q_32 = Q;
\$__sdffe_wrapper #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE),
    .EN_POLARITY(EN_POLARITY)
) _TECHMAP_REPLACE_ (
    .D(D_32),
    .Q(Q_32),
    .CLK(CLK),
    .SRST(SRST),
    .EN(EN)
);

endmodule

(* techmap_celltype = "\$sdff" *)
module wrap_reg_unit__sdff #(
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

reg [31:0] D_32;
reg [31:0] Q_32;
assign D_32 = D;
assign Q_32 = Q;
\$__sdff_wrapper #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE)
) _TECHMAP_REPLACE_ (
    .D(D_32),
    .Q(Q_32),
    .CLK(CLK),
    .SRST(SRST)
);

endmodule

(* techmap_celltype = "\$dff" *)
module wrap_reg_unit__dff #(
    parameter WIDTH = 1,
    parameter CLK_POLARITY = 1
)
(
    input wire[WIDTH:0] D,
    input wire CLK,
    output reg[WIDTH:0] Q
);

reg [31:0] D_32;
reg [31:0] Q_32;
assign D_32 = D;
assign Q_32 = Q;
\$__dff_wrapper #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY)
) _TECHMAP_REPLACE_ (
    .D(D_32),
    .Q(Q_32),
    .CLK(CLK)
);

endmodule

(* techmap_celltype = "\$dffe" *)
module wrap_reg_unit__dffe #(
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

reg [31:0] D_32;
reg [31:0] Q_32;
assign D_32 = D;
assign Q_32 = Q;
\$__dffe_wrapper #(
    .WIDTH(WIDTH),
    .CLK_POLARITY(CLK_POLARITY),
    .EN_POLARITY(EN_POLARITY)
) _TECHMAP_REPLACE_ (
    .D(D_32),
    .Q(Q_32),
    .CLK(CLK),
    .EN(EN)
);

endmodule

