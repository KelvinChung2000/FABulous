module PE_ConfigMem #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 34,
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
    LHQD1 #() Inst_frame0_bit31 (
        .D(FrameData[31]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[33]),
        .QN(ConfigBits_N[33])
    );

    LHQD1 #() Inst_frame0_bit30 (
        .D(FrameData[30]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[32]),
        .QN(ConfigBits_N[32])
    );

    LHQD1 #() Inst_frame0_bit29 (
        .D(FrameData[29]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[31]),
        .QN(ConfigBits_N[31])
    );

    LHQD1 #() Inst_frame0_bit28 (
        .D(FrameData[28]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[30]),
        .QN(ConfigBits_N[30])
    );

    LHQD1 #() Inst_frame0_bit27 (
        .D(FrameData[27]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[29]),
        .QN(ConfigBits_N[29])
    );

    LHQD1 #() Inst_frame0_bit26 (
        .D(FrameData[26]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[28]),
        .QN(ConfigBits_N[28])
    );

    LHQD1 #() Inst_frame0_bit25 (
        .D(FrameData[25]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[27]),
        .QN(ConfigBits_N[27])
    );

    LHQD1 #() Inst_frame0_bit24 (
        .D(FrameData[24]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[26]),
        .QN(ConfigBits_N[26])
    );

    LHQD1 #() Inst_frame0_bit23 (
        .D(FrameData[23]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[25]),
        .QN(ConfigBits_N[25])
    );

    LHQD1 #() Inst_frame0_bit22 (
        .D(FrameData[22]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[24]),
        .QN(ConfigBits_N[24])
    );

    LHQD1 #() Inst_frame0_bit21 (
        .D(FrameData[21]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[23]),
        .QN(ConfigBits_N[23])
    );

    LHQD1 #() Inst_frame0_bit20 (
        .D(FrameData[20]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[22]),
        .QN(ConfigBits_N[22])
    );

    LHQD1 #() Inst_frame0_bit19 (
        .D(FrameData[19]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[21]),
        .QN(ConfigBits_N[21])
    );

    LHQD1 #() Inst_frame0_bit18 (
        .D(FrameData[18]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[20]),
        .QN(ConfigBits_N[20])
    );

    LHQD1 #() Inst_frame0_bit17 (
        .D(FrameData[17]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[19]),
        .QN(ConfigBits_N[19])
    );

    LHQD1 #() Inst_frame0_bit16 (
        .D(FrameData[16]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[18]),
        .QN(ConfigBits_N[18])
    );

    LHQD1 #() Inst_frame0_bit15 (
        .D(FrameData[15]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[17]),
        .QN(ConfigBits_N[17])
    );

    LHQD1 #() Inst_frame0_bit14 (
        .D(FrameData[14]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[16]),
        .QN(ConfigBits_N[16])
    );

    LHQD1 #() Inst_frame0_bit13 (
        .D(FrameData[13]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[15]),
        .QN(ConfigBits_N[15])
    );

    LHQD1 #() Inst_frame0_bit12 (
        .D(FrameData[12]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[14]),
        .QN(ConfigBits_N[14])
    );

    LHQD1 #() Inst_frame0_bit11 (
        .D(FrameData[11]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[13]),
        .QN(ConfigBits_N[13])
    );

    LHQD1 #() Inst_frame0_bit10 (
        .D(FrameData[10]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[12]),
        .QN(ConfigBits_N[12])
    );

    LHQD1 #() Inst_frame0_bit9 (
        .D(FrameData[9]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[11]),
        .QN(ConfigBits_N[11])
    );

    LHQD1 #() Inst_frame0_bit8 (
        .D(FrameData[8]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[10]),
        .QN(ConfigBits_N[10])
    );

    LHQD1 #() Inst_frame0_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[9]),
        .QN(ConfigBits_N[9])
    );

    LHQD1 #() Inst_frame0_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[8]),
        .QN(ConfigBits_N[8])
    );

    LHQD1 #() Inst_frame0_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[7]),
        .QN(ConfigBits_N[7])
    );

    LHQD1 #() Inst_frame0_bit4 (
        .D(FrameData[4]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[6]),
        .QN(ConfigBits_N[6])
    );

    LHQD1 #() Inst_frame0_bit3 (
        .D(FrameData[3]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[5]),
        .QN(ConfigBits_N[5])
    );

    LHQD1 #() Inst_frame0_bit2 (
        .D(FrameData[2]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[4]),
        .QN(ConfigBits_N[4])
    );

    LHQD1 #() Inst_frame0_bit1 (
        .D(FrameData[1]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[3]),
        .QN(ConfigBits_N[3])
    );

    LHQD1 #() Inst_frame0_bit0 (
        .D(FrameData[0]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[2]),
        .QN(ConfigBits_N[2])
    );

    LHQD1 #() Inst_frame1_bit31 (
        .D(FrameData[31]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[1]),
        .QN(ConfigBits_N[1])
    );

    LHQD1 #() Inst_frame1_bit30 (
        .D(FrameData[30]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[0]),
        .QN(ConfigBits_N[0])
    );

end
else begin
assign ConfigBits = EMULATION_CONFIG;
assign ConfigBits_N = ~EMULATION_CONFIG;
end

endgenerate

endmodule
