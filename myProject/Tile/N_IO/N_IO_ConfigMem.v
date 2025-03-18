module N_IO_ConfigMem #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 2
)(
    input [FrameBitsPerRow - 1:0] FrameData,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [NoConfigBits - 1:0] ConfigBits,
    output [NoConfigBits - 1:0] ConfigBits_N
);

// instantiate frame latches
LHQD1 #() Inst_frame0_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[1]),
    .QN(ConfigBits_N[1])
);

LHQD1 #() Inst_frame0_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[0]),
    .QN(ConfigBits_N[0])
);

endmodule
