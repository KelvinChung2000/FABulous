module E_IO_ConfigMem #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 0,
    // Emulation parameter
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0
)
(
    input [FrameBitsPerRow - 1:0] FrameData,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [NoConfigBits - 1:0] ConfigBits,
    output [NoConfigBits - 1:0] ConfigBits_N
);

generate
if(EMULATION_ENABLE == 0) begin
// instantiate frame latches
end
else begin
assign ConfigBits = EMULATION_CONFIG;
assign ConfigBits_N = EMULATION_CONFIG;
end

endgenerate

endmodule
