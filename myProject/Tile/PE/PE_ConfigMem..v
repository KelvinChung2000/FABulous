module PE_ConfigMem #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 75
)(
    input [FrameBitsPerRow - 1:0] FrameData,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [NoConfigBits - 1:0] ConfigBits,
    output [NoConfigBits - 1:0] ConfigBits_N
);

// instantiate frame latches
endmodule
