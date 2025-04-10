module E_Mem_top #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    // Emulation Parameters
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0,
    parameter X_CORD = -1,
    parameter Y_CORD = -1
)
(
    // NORTH
    // EAST
    // SOUTH
    output reg[31:0] addr_o,
    // WEST
    input wire[31:0] in3,
    output reg[31:0] out3,
    input wire UserCLK,
    output reg UserCLK_o,
    input wire[FrameBitsPerRow - 1:0] FrameData,
    output reg[FrameBitsPerRow - 1:0] FrameData_o,
    input wire[MaxFramesPerCol - 1:0] FrameStrobe,
    output reg[MaxFramesPerCol - 1:0] FrameStrobe_o
);

// Signal Creation

// Buffering incoming and out outgoing wires
// FrameStrobe Buffer
reg [MaxFramesPerCol - 1:0] FrameStrobe_internal;

my_buf_pack #(
    .WIDTH(MaxFramesPerCol)
) strobe_inbuf (
    .A(FrameStrobe),
    .X(FrameStrobe_internal)
);

my_buf_pack #(
    .WIDTH(MaxFramesPerCol)
) strobe_outbuf (
    .A(FrameStrobe_internal),
    .X(FrameStrobe_o)
);

// User Clock Buffer
clk_buf #() inst_clk_buf (
    .A(UserCLK),
    .X(UserCLK_o)
);

// Init Switch Matrix
E_Mem_top_switch_matrix #() Inst_E_Mem_top_switch_matrix (
    .out3(out3),
    .addr_o(addr_o),
    .in3(in3)
);

endmodule

