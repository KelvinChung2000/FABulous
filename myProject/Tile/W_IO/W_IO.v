module W_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 2
)(
    // NORTH
    // EAST
    input [31:0] in1,
    output [31:0] out1,
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
reg [31:0] W_from_fabric;
reg [31:0] W_to_fabric;
reg [31:0] W_in;
reg [31:0] W_out;

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

W_IO_ConfigMem #() Inst_W_IO_ConfigMem (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);

// Instantiate BEL IO
IO #() Inst_W_IO (
    .from_fabric(W_from_fabric),
    .to_fabric(W_to_fabric),
    .in(W_in),
    .out(W_out)
);

// Init Switch Matrix
W_IO_SwitchMatrix #() Inst_W_IO_SwitchMatrix (
    .out1(out1),
    .W_from_fabric(W_from_fabric),
    .W_to_fabric(W_to_fabric),
    .in1(in1),
    .ConfigBits(ConfigBits[1:0]),
    .ConfigBits_N(ConfigBits_N[1:0])
);

endmodule
