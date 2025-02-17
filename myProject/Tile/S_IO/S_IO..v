module S_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 5
)(
    // NORTH,
    input [31:0] in0,
    output [31:0] out0,
    // EAST,
    // SOUTH,
    output [31:0] out2,
    input [31:0] in2,
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

// Signal Creationreg S_from_fabric;reg S_to_fabric;reg S_in;reg S_out;// ConfigBits Wiresreg [NoConfigBits - 1:0] ConfigBits;reg [NoConfigBits - 1:0] ConfigBits_N;// Buffering incoming and out outgoing wires// FrameData Bufferreg [FrameBitsPerRow - 1:0] FrameData_internal;my_buf_pack #(
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
// FrameStrobe Bufferreg [MaxFramesPerCol - 1:0] FrameStrobe_internal;my_buf_pack #(
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
// User Clock Bufferclk_buf #() inst_clk_buf (
    .A(UserCLK),
    .X(UserCLKo)
);
// Init Configuration storage latchesS_IO_ConfigMem #() Inst_S_IO_ConfigMem (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);
// Instantiate BEL IOIO #() Inst_S_IO (
    .from_fabric(S_from_fabric),
    .to_fabric(S_to_fabric),
    .in(S_in),
    .out(S_out),
    .ConfigBits(ConfigBits[0])
);
// Init Switch MatrixS_IO_SwitchMatrix #() Inst_S_IO_SwitchMatrix (
    .out2(out2),
    .out0(out0),
    .S_from_fabric(S_from_fabric),
    .in0(in0),
    .in2(in2),
    .ConfigBits(ConfigBits[4:1]),
    .ConfigBits_N(ConfigBits_N[4:1])
);

endmodule
