(* techmap_celltype = "\$sdff" *)
module wrap_reg_unit__sdff #(
    parameter CLK_POLARITY = 0,
    parameter SRST_POLARITY = 0,
    parameter SRST_VALUE = 0,
    parameter WIDTH = 0
)
(
    input wire[WIDTH - 1:0] CLK,
    input wire[WIDTH - 1:0] D,
    output reg[WIDTH - 1:0] Q,
    input wire[WIDTH - 1:0] SRST
);

reg CLK_1;
reg [31:0] D_32;
reg [31:0] Q_32;
reg SRST_1;
assign CLK_1 = CLK;
assign D_32 = D;
assign Q = Q_32;
assign SRST_1 = SRST;
\$__sdff_wrapper #(
    .CLK_POLARITY(CLK_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_1),
    .D(D_32),
    .Q(Q_32),
    .SRST(SRST_1)
);

endmodule

(* techmap_celltype = "\$dff" *)
module wrap_reg_unit__dff #(
    parameter CLK_POLARITY = 0,
    parameter WIDTH = 0
)
(
    input wire[WIDTH - 1:0] CLK,
    input wire[WIDTH - 1:0] D,
    output reg[WIDTH - 1:0] Q
);

reg CLK_1;
reg [31:0] D_32;
reg [31:0] Q_32;
assign CLK_1 = CLK;
assign D_32 = D;
assign Q = Q_32;
\$__dff_wrapper #(
    .CLK_POLARITY(CLK_POLARITY),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_1),
    .D(D_32),
    .Q(Q_32)
);

endmodule

(* techmap_celltype = "\$dffe" *)
module wrap_reg_unit__dffe #(
    parameter CLK_POLARITY = 0,
    parameter EN_POLARITY = 0,
    parameter WIDTH = 0
)
(
    input wire[WIDTH - 1:0] CLK,
    input wire[WIDTH - 1:0] D,
    input wire[WIDTH - 1:0] EN,
    output reg[WIDTH - 1:0] Q
);

reg CLK_1;
reg [31:0] D_32;
reg EN_1;
reg [31:0] Q_32;
assign CLK_1 = CLK;
assign D_32 = D;
assign EN_1 = EN;
assign Q = Q_32;
\$__dffe_wrapper #(
    .CLK_POLARITY(CLK_POLARITY),
    .EN_POLARITY(EN_POLARITY),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_1),
    .D(D_32),
    .EN(EN_1),
    .Q(Q_32)
);

endmodule

(* techmap_celltype = "\$sdffe" *)
module wrap_reg_unit__sdffe #(
    parameter CLK_POLARITY = 0,
    parameter EN_POLARITY = 0,
    parameter SRST_POLARITY = 0,
    parameter SRST_VALUE = 0,
    parameter WIDTH = 0
)
(
    input wire[WIDTH - 1:0] CLK,
    input wire[WIDTH - 1:0] D,
    input wire[WIDTH - 1:0] EN,
    output reg[WIDTH - 1:0] Q,
    input wire[WIDTH - 1:0] SRST
);

reg CLK_1;
reg [31:0] D_32;
reg EN_1;
reg [31:0] Q_32;
reg SRST_1;
assign CLK_1 = CLK;
assign D_32 = D;
assign EN_1 = EN;
assign Q = Q_32;
assign SRST_1 = SRST;
\$__sdffe_wrapper #(
    .CLK_POLARITY(CLK_POLARITY),
    .EN_POLARITY(EN_POLARITY),
    .SRST_POLARITY(SRST_POLARITY),
    .SRST_VALUE(SRST_VALUE),
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .CLK(CLK_1),
    .D(D_32),
    .EN(EN_1),
    .Q(Q_32),
    .SRST(SRST_1)
);

endmodule

