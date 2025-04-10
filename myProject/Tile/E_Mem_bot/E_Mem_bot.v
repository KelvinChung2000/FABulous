module E_Mem_bot #(
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
    input wire[31:0] addr_i,
    // EAST
    // SOUTH
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
reg [31:0] addr0;
reg reset;
reg [31:0] write_data;
reg write_en;
reg [31:0] read_data;

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

// Instantiate BEL Mem
Mem #() Inst_Mem (
    .addr0(addr0),
    .reset(reset),
    .write_data(write_data),
    .write_en(write_en),
    .read_data(read_data),
    .clk(UserCLK)
);

// Init Switch Matrix
E_Mem_bot_switch_matrix #() Inst_E_Mem_bot_switch_matrix (
    .out3(out3),
    .addr0(addr0),
    .write_data(write_data),
    .read_data(read_data),
    .addr_i(addr_i),
    .in3(in3)
);

endmodule

