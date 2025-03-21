module EmptyTile #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    // Emulation Parameters
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0
)
(
    input UserCLK,
    output UserCLK_o,
    input [FrameBitsPerRow - 1:0] FrameData,
    output [FrameBitsPerRow - 1:0] FrameData_o,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_o
);
assign FrameData_o = FrameData;
assign FrameStrobe_o = FrameStrobe;
assign UserCLK_o = UserCLK;
endmodule
