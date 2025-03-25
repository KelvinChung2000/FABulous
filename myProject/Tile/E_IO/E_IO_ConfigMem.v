module E_IO_ConfigMem #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    parameter NoConfigBits = 0,
    // Emulation parameter
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0,
    parameter X_CORD = -1,
    parameter Y_CORD = -1
)
(
    input wire[FrameBitsPerRow - 1:0] FrameData,
    input wire[MaxFramesPerCol - 1:0] FrameStrobe,
    output reg[NoConfigBits - 1:0] ConfigBits,
    output reg[NoConfigBits - 1:0] ConfigBits_N
);

endmodule

