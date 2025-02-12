module N_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 5
)(
    // NORTH,
    output [31:0] out0,
    input [31:0] in0,
    // EAST,
    // SOUTH,
    input [31:0] in2,
    output [31:0] out2,
    // WEST,
    input in,
    output out,
    input UserCLK,
    output UserCLKo,
    input [FrameBitsPerRow - 1:0] FrameData,
    output [FrameBitsPerRow - 1:0] FrameData_O,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creation
wire N_from_fabric;
wire N_to_fabric;
wire N_in;
wire N_out;

// ConfigBits Wires
wire [NoConfigBits - 1:0] ConfigBits;
wire [NoConfigBits - 1:0] ConfigBits_N;

// Buffering incoming and out outgoing wires

// FrameData Buffer
wire [FrameBitsPerRow - 1:0] FrameData_internal;

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
wire [MaxFramesPerCol - 1:0] FrameStrobe_internal;

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
N_IO_ConfigMem #() Inst_N_IO_ConfigMem (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);

// Instantiate BEL IO
IO #() Inst_N_IO (
    .from_fabric(N_from_fabric),
    .to_fabric(N_to_fabric),
    .in(N_in),
    .out(N_out),
    .ConfigBits(ConfigBits[0])
);

// Init Switch Matrix
N_IO_SwitchMatrix #() Inst_N_IO_SwitchMatrix (
    .out0(out0),
    .out2(out2),
    .N_from_fabric(N_from_fabric),
    .in2(in2),
    .in0(in0),
    .ConfigBits(ConfigBits[4:1]),
    .ConfigBits_N(ConfigBits_N[4:1])
);

endmodule
