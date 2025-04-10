(* techmap_celltype = "\$__mux_wrapper" *)
module unwrap_Mem__mux #(
    parameter WIDTH = 0
)
(
    input wire A,
    input wire B,
    input wire S,
    output reg Y
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

(* techmap_celltype = "\$__mem_v2_wrapper" *)
module unwrap_Mem__mem_v2 #(
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
    input wire[3:0] RD_ADDR,
    input wire RD_ARST,
    input wire RD_CLK,
    output reg[31:0] RD_DATA,
    input wire RD_EN,
    input wire RD_SRST,
    input wire[3:0] WR_ADDR,
    input wire WR_CLK,
    input wire[31:0] WR_DATA,
    input wire[31:0] WR_EN
);

reg [WIDTH - 1:0] RD_ADDR_orig;
reg [WIDTH - 1:0] RD_ARST_orig;
reg [WIDTH - 1:0] RD_CLK_orig;
reg [WIDTH - 1:0] RD_DATA_orig;
reg [WIDTH - 1:0] RD_EN_orig;
reg [WIDTH - 1:0] RD_SRST_orig;
reg [WIDTH - 1:0] WR_ADDR_orig;
reg [WIDTH - 1:0] WR_CLK_orig;
reg [WIDTH - 1:0] WR_DATA_orig;
reg [WIDTH - 1:0] WR_EN_orig;
assign RD_ADDR_orig = RD_ADDR;
assign RD_ARST_orig = RD_ARST;
assign RD_CLK_orig = RD_CLK;
assign RD_DATA = RD_DATA_orig;
assign RD_EN_orig = RD_EN;
assign RD_SRST_orig = RD_SRST;
assign WR_ADDR_orig = WR_ADDR;
assign WR_CLK_orig = WR_CLK;
assign WR_DATA_orig = WR_DATA;
assign WR_EN_orig = WR_EN;
\$mem_v2 #(
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
    .RD_ADDR(RD_ADDR_orig),
    .RD_ARST(RD_ARST_orig),
    .RD_CLK(RD_CLK_orig),
    .RD_DATA(RD_DATA_orig),
    .RD_EN(RD_EN_orig),
    .RD_SRST(RD_SRST_orig),
    .WR_ADDR(WR_ADDR_orig),
    .WR_CLK(WR_CLK_orig),
    .WR_DATA(WR_DATA_orig),
    .WR_EN(WR_EN_orig)
);

endmodule

