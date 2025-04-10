module E_Mem_bot #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    parameter NoConfigBits = 2,
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

// ConfigBits Wires
reg [NoConfigBits - 1:0] ConfigBits;
reg [NoConfigBits - 1:0] ConfigBits_N;

// Buffering incoming and out outgoing wires
// FrameData Buffer
reg [FrameBitsPerRow - 1:0] FrameData_internal;

my_buf_pack #(
    .WIDTH(FrameBitsPerRow)
) data_inbuf (
    .A(FrameData),
    .X(FrameData_internal)
);

my_buf_pack #(
    .WIDTH(FrameBitsPerRow)
) data_outbuf (
    .A(FrameData_internal),
    .X(FrameData_o)
);

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

// Init Configuration storage latches

E_Mem_bot_ConfigMem #(
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(X_CORD),
    .Y_CORD(Y_CORD)
) Inst_E_Mem_bot_ConfigMem (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);

// Instantiate BEL Mem
Mem #() Inst_Mem (
    .addr0(addr0),
    .reset(reset),
    .write_data(write_data),
    .write_en(write_en),
    .read_data(read_data),
    .clk(UserCLK),
    .read_allow(ConfigBits[0]),
    .write_allow(ConfigBits[1])
);

// Init Switch Matrix
E_Mem_bot_switch_matrix #() Inst_E_Mem_bot_switch_matrix (
    .out3(out3),
    .addr0(addr0),
    .write_data(write_data),
    .read_data(read_data),
    .addr_i(addr_i),
    .in3(in3),
    .ConfigBits(ConfigBits[1:2]),
    .ConfigBits_N(ConfigBits_N[1:2])
);

endmodule

