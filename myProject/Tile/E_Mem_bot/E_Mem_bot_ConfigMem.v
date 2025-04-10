module E_Mem_bot_ConfigMem #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    parameter NoConfigBits = 2,
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


generate
if(EMULATION_ENABLE) begin
reg [63:0] cfg [0:47];
initial $readmemh(EMULATION_CONFIG, cfg);
reg [63:0] tileConf;
assign tileConf = cfg[Y_CORD * 6 + X_CORD];
// config bit 0 at frame 0 bit 6
assign ConfigBits[0] = tileConf[62];
assign ConfigBits_N[0] = ~tileConf[62];
// config bit 1 at frame 0 bit 7
assign ConfigBits[1] = tileConf[63];
assign ConfigBits_N[1] = ~tileConf[63];
end
else begin
// instantiate frame latches
    LHQD1 #() Inst_frame0_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[0]),
        .QN(ConfigBits_N[0])
    );

    LHQD1 #() Inst_frame0_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[1]),
        .QN(ConfigBits_N[1])
    );

end

endgenerate

endmodule

