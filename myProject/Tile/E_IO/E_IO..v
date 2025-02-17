module E_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 5
)(
    // NORTH,
    // EAST,
    output [31:0] out1,
    input [31:0] in1,
    // SOUTH,
    // WEST,
    input [31:0] in3,
    output [31:0] out3,
    input in,
    output out,
    input UserCLK,
    output UserCLKo,
    input [FrameBitsPerRow - 1:0] FrameData,
    output [FrameBitsPerRow - 1:0] FrameData_O,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creationreg E_from_fabric;reg E_to_fabric;reg E_in;reg E_out;// ConfigBits Wiresreg [NoConfigBits - 1:0] ConfigBits;reg [NoConfigBits - 1:0] ConfigBits_N;// Buffering incoming and out outgoing wires// FrameData Bufferreg [FrameBitsPerRow - 1:0] FrameData_internal;my_buf_pack #(
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
// Init Configuration storage latchesE_IO_ConfigMem #() Inst_E_IO_ConfigMem (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);
// Instantiate BEL IOIO #() Inst_E_IO (
    .from_fabric(E_from_fabric),
    .to_fabric(E_to_fabric),
    .in(E_in),
    .out(E_out),
    .ConfigBits(ConfigBits[0])
);
// Init Switch MatrixE_IO_SwitchMatrix #() Inst_E_IO_SwitchMatrix (
    .out1(out1),
    .out3(out3),
    .E_from_fabric(E_from_fabric),
    .in3(in3),
    .in1(in1),
    .ConfigBits(ConfigBits[4:1]),
    .ConfigBits_N(ConfigBits_N[4:1])
);

endmodule
