(* techmap_celltype = "\$mux" *)
module wrap_Mem__mux #(
    parameter WIDTH = 0
)
(
    input wire[WIDTH - 1:0] A,
    input wire[WIDTH - 1:0] B,
    input wire[WIDTH - 1:0] S,
    output reg[WIDTH - 1:0] Y
);

reg A_1;
reg B_1;
reg S_1;
reg Y_1;
assign A_1 = A;
assign B_1 = B;
assign S_1 = S;
assign Y = Y_1;
\$__mux_wrapper #(
    .WIDTH(WIDTH)
) _TECHMAP_REPLACE_ (
    .A(A_1),
    .B(B_1),
    .S(S_1),
    .Y(Y_1)
);

endmodule

(* techmap_celltype = "\$mem_v2" *)
module wrap_Mem__mem_v2 #(
    parameter ABITS = 0,
    parameter INIT = 0,
    parameter MEMID = 0,
    parameter OFFSET = 0,
    parameter RD_ARST_VALUE = 0,
    parameter RD_CE_OVER_SRST = 0,
    parameter RD_CLK_ENABLE = 0,
    parameter RD_CLK_POLARITY = 0,
    parameter RD_COLLISION_X_MASK = 0,
    parameter RD_INIT_VALUE = 0,
    parameter RD_PORTS = 0,
    parameter RD_SRST_VALUE = 0,
    parameter RD_TRANSPARENCY_MASK = 0,
    parameter RD_WIDE_CONTINUATION = 0,
    parameter SIZE = 0,
    parameter WIDTH = 0,
    parameter WR_CLK_ENABLE = 0,
    parameter WR_CLK_POLARITY = 0,
    parameter WR_PORTS = 0,
    parameter WR_PRIORITY_MASK = 0,
    parameter WR_WIDE_CONTINUATION = 0
)
(
    input wire[WIDTH - 1:0] RD_ADDR,
    input wire[WIDTH - 1:0] RD_ARST,
    input wire[WIDTH - 1:0] RD_CLK,
    output reg[WIDTH - 1:0] RD_DATA,
    input wire[WIDTH - 1:0] RD_EN,
    input wire[WIDTH - 1:0] RD_SRST,
    input wire[WIDTH - 1:0] WR_ADDR,
    input wire[WIDTH - 1:0] WR_CLK,
    input wire[WIDTH - 1:0] WR_DATA,
    input wire[WIDTH - 1:0] WR_EN
);

reg [3:0] RD_ADDR_4;
reg RD_ARST_1;
reg RD_CLK_1;
reg [31:0] RD_DATA_32;
reg RD_EN_1;
reg RD_SRST_1;
reg [3:0] WR_ADDR_4;
reg WR_CLK_1;
reg [31:0] WR_DATA_32;
reg [31:0] WR_EN_32;
assign RD_ADDR_4 = RD_ADDR;
assign RD_ARST_1 = RD_ARST;
assign RD_CLK_1 = RD_CLK;
assign RD_DATA = RD_DATA_32;
assign RD_EN_1 = RD_EN;
assign RD_SRST_1 = RD_SRST;
assign WR_ADDR_4 = WR_ADDR;
assign WR_CLK_1 = WR_CLK;
assign WR_DATA_32 = WR_DATA;
assign WR_EN_32 = WR_EN;
\$__mem_v2_wrapper #(
    .ABITS(ABITS),
    .INIT(INIT),
    .MEMID(MEMID),
    .OFFSET(OFFSET),
    .RD_ARST_VALUE(RD_ARST_VALUE),
    .RD_CE_OVER_SRST(RD_CE_OVER_SRST),
    .RD_CLK_ENABLE(RD_CLK_ENABLE),
    .RD_CLK_POLARITY(RD_CLK_POLARITY),
    .RD_COLLISION_X_MASK(RD_COLLISION_X_MASK),
    .RD_INIT_VALUE(RD_INIT_VALUE),
    .RD_PORTS(RD_PORTS),
    .RD_SRST_VALUE(RD_SRST_VALUE),
    .RD_TRANSPARENCY_MASK(RD_TRANSPARENCY_MASK),
    .RD_WIDE_CONTINUATION(RD_WIDE_CONTINUATION),
    .SIZE(SIZE),
    .WIDTH(WIDTH),
    .WR_CLK_ENABLE(WR_CLK_ENABLE),
    .WR_CLK_POLARITY(WR_CLK_POLARITY),
    .WR_PORTS(WR_PORTS),
    .WR_PRIORITY_MASK(WR_PRIORITY_MASK),
    .WR_WIDE_CONTINUATION(WR_WIDE_CONTINUATION)
) _TECHMAP_REPLACE_ (
    .RD_ADDR(RD_ADDR_4),
    .RD_ARST(RD_ARST_1),
    .RD_CLK(RD_CLK_1),
    .RD_DATA(RD_DATA_32),
    .RD_EN(RD_EN_1),
    .RD_SRST(RD_SRST_1),
    .WR_ADDR(WR_ADDR_4),
    .WR_CLK(WR_CLK_1),
    .WR_DATA(WR_DATA_32),
    .WR_EN(WR_EN_32)
);

endmodule

