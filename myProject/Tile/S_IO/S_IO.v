module S_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 2
)(
    // NORTH
    input [31:0] in0,
    output [31:0] out0,
    // EAST
    // SOUTH
    // WEST
    input [31:0] in,
    output [31:0] out,
    input UserCLK,
    output UserCLKo,
    input [FrameBitsPerRow - 1:0] FrameData,
    output [FrameBitsPerRow - 1:0] FrameData_O,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creation
reg [31:0] S_from_fabric;
reg [31:0] S_to_fabric;
reg [31:0] S_in;
reg [31:0] S_out;

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
    .X(FrameData_O)
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
    .X(FrameStrobe_O)
);

// User Clock Buffer
clk_buf #() inst_clk_buf (
    .A(UserCLK),
    .X(UserCLKo)
);

// Init Configuration storage latches

S_IO_ConfigMem #() Inst_S_IO_ConfigMem (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);

// Instantiate BEL IO
IO #() Inst_S_IO (
    .from_fabric(S_from_fabric),
    .to_fabric(S_to_fabric),
    .in(S_in),
    .out(S_out)
);

// Init Switch Matrix
S_IO_SwitchMatrix #() Inst_S_IO_SwitchMatrix (
    .out0(out0),
    .S_from_fabric(S_from_fabric),
    .S_to_fabric(S_to_fabric),
    .in0(in0),
    .ConfigBits(ConfigBits[1:0]),
    .ConfigBits_N(ConfigBits_N[1:0])
);

endmodule
