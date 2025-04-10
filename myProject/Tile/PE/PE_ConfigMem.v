module PE_ConfigMem #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    parameter NoConfigBits = 51,
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
// config bit 0 at frame 6 bit 5
assign ConfigBits[0] = tileConf[13];
assign ConfigBits_N[0] = ~tileConf[13];
// config bit 1 at frame 6 bit 6
assign ConfigBits[1] = tileConf[14];
assign ConfigBits_N[1] = ~tileConf[14];
// config bit 2 at frame 6 bit 7
assign ConfigBits[2] = tileConf[15];
assign ConfigBits_N[2] = ~tileConf[15];
// config bit 3 at frame 5 bit 0
assign ConfigBits[3] = tileConf[16];
assign ConfigBits_N[3] = ~tileConf[16];
// config bit 4 at frame 5 bit 1
assign ConfigBits[4] = tileConf[17];
assign ConfigBits_N[4] = ~tileConf[17];
// config bit 5 at frame 5 bit 2
assign ConfigBits[5] = tileConf[18];
assign ConfigBits_N[5] = ~tileConf[18];
// config bit 6 at frame 5 bit 3
assign ConfigBits[6] = tileConf[19];
assign ConfigBits_N[6] = ~tileConf[19];
// config bit 7 at frame 5 bit 4
assign ConfigBits[7] = tileConf[20];
assign ConfigBits_N[7] = ~tileConf[20];
// config bit 8 at frame 5 bit 5
assign ConfigBits[8] = tileConf[21];
assign ConfigBits_N[8] = ~tileConf[21];
// config bit 9 at frame 5 bit 6
assign ConfigBits[9] = tileConf[22];
assign ConfigBits_N[9] = ~tileConf[22];
// config bit 10 at frame 5 bit 7
assign ConfigBits[10] = tileConf[23];
assign ConfigBits_N[10] = ~tileConf[23];
// config bit 11 at frame 4 bit 0
assign ConfigBits[11] = tileConf[24];
assign ConfigBits_N[11] = ~tileConf[24];
// config bit 12 at frame 4 bit 1
assign ConfigBits[12] = tileConf[25];
assign ConfigBits_N[12] = ~tileConf[25];
// config bit 13 at frame 4 bit 2
assign ConfigBits[13] = tileConf[26];
assign ConfigBits_N[13] = ~tileConf[26];
// config bit 14 at frame 4 bit 3
assign ConfigBits[14] = tileConf[27];
assign ConfigBits_N[14] = ~tileConf[27];
// config bit 15 at frame 4 bit 4
assign ConfigBits[15] = tileConf[28];
assign ConfigBits_N[15] = ~tileConf[28];
// config bit 16 at frame 4 bit 5
assign ConfigBits[16] = tileConf[29];
assign ConfigBits_N[16] = ~tileConf[29];
// config bit 17 at frame 4 bit 6
assign ConfigBits[17] = tileConf[30];
assign ConfigBits_N[17] = ~tileConf[30];
// config bit 18 at frame 4 bit 7
assign ConfigBits[18] = tileConf[31];
assign ConfigBits_N[18] = ~tileConf[31];
// config bit 19 at frame 3 bit 0
assign ConfigBits[19] = tileConf[32];
assign ConfigBits_N[19] = ~tileConf[32];
// config bit 20 at frame 3 bit 1
assign ConfigBits[20] = tileConf[33];
assign ConfigBits_N[20] = ~tileConf[33];
// config bit 21 at frame 3 bit 2
assign ConfigBits[21] = tileConf[34];
assign ConfigBits_N[21] = ~tileConf[34];
// config bit 22 at frame 3 bit 3
assign ConfigBits[22] = tileConf[35];
assign ConfigBits_N[22] = ~tileConf[35];
// config bit 23 at frame 3 bit 4
assign ConfigBits[23] = tileConf[36];
assign ConfigBits_N[23] = ~tileConf[36];
// config bit 24 at frame 3 bit 5
assign ConfigBits[24] = tileConf[37];
assign ConfigBits_N[24] = ~tileConf[37];
// config bit 25 at frame 3 bit 6
assign ConfigBits[25] = tileConf[38];
assign ConfigBits_N[25] = ~tileConf[38];
// config bit 26 at frame 3 bit 7
assign ConfigBits[26] = tileConf[39];
assign ConfigBits_N[26] = ~tileConf[39];
// config bit 27 at frame 2 bit 0
assign ConfigBits[27] = tileConf[40];
assign ConfigBits_N[27] = ~tileConf[40];
// config bit 28 at frame 2 bit 1
assign ConfigBits[28] = tileConf[41];
assign ConfigBits_N[28] = ~tileConf[41];
// config bit 29 at frame 2 bit 2
assign ConfigBits[29] = tileConf[42];
assign ConfigBits_N[29] = ~tileConf[42];
// config bit 30 at frame 2 bit 3
assign ConfigBits[30] = tileConf[43];
assign ConfigBits_N[30] = ~tileConf[43];
// config bit 31 at frame 2 bit 4
assign ConfigBits[31] = tileConf[44];
assign ConfigBits_N[31] = ~tileConf[44];
// config bit 32 at frame 2 bit 5
assign ConfigBits[32] = tileConf[45];
assign ConfigBits_N[32] = ~tileConf[45];
// config bit 33 at frame 2 bit 6
assign ConfigBits[33] = tileConf[46];
assign ConfigBits_N[33] = ~tileConf[46];
// config bit 34 at frame 2 bit 7
assign ConfigBits[34] = tileConf[47];
assign ConfigBits_N[34] = ~tileConf[47];
// config bit 35 at frame 1 bit 0
assign ConfigBits[35] = tileConf[48];
assign ConfigBits_N[35] = ~tileConf[48];
// config bit 36 at frame 1 bit 1
assign ConfigBits[36] = tileConf[49];
assign ConfigBits_N[36] = ~tileConf[49];
// config bit 37 at frame 1 bit 2
assign ConfigBits[37] = tileConf[50];
assign ConfigBits_N[37] = ~tileConf[50];
// config bit 38 at frame 1 bit 3
assign ConfigBits[38] = tileConf[51];
assign ConfigBits_N[38] = ~tileConf[51];
// config bit 39 at frame 1 bit 4
assign ConfigBits[39] = tileConf[52];
assign ConfigBits_N[39] = ~tileConf[52];
// config bit 40 at frame 1 bit 5
assign ConfigBits[40] = tileConf[53];
assign ConfigBits_N[40] = ~tileConf[53];
// config bit 41 at frame 1 bit 6
assign ConfigBits[41] = tileConf[54];
assign ConfigBits_N[41] = ~tileConf[54];
// config bit 42 at frame 1 bit 7
assign ConfigBits[42] = tileConf[55];
assign ConfigBits_N[42] = ~tileConf[55];
// config bit 43 at frame 0 bit 0
assign ConfigBits[43] = tileConf[56];
assign ConfigBits_N[43] = ~tileConf[56];
// config bit 44 at frame 0 bit 1
assign ConfigBits[44] = tileConf[57];
assign ConfigBits_N[44] = ~tileConf[57];
// config bit 45 at frame 0 bit 2
assign ConfigBits[45] = tileConf[58];
assign ConfigBits_N[45] = ~tileConf[58];
// config bit 46 at frame 0 bit 3
assign ConfigBits[46] = tileConf[59];
assign ConfigBits_N[46] = ~tileConf[59];
// config bit 47 at frame 0 bit 4
assign ConfigBits[47] = tileConf[60];
assign ConfigBits_N[47] = ~tileConf[60];
// config bit 48 at frame 0 bit 5
assign ConfigBits[48] = tileConf[61];
assign ConfigBits_N[48] = ~tileConf[61];
// config bit 49 at frame 0 bit 6
assign ConfigBits[49] = tileConf[62];
assign ConfigBits_N[49] = ~tileConf[62];
// config bit 50 at frame 0 bit 7
assign ConfigBits[50] = tileConf[63];
assign ConfigBits_N[50] = ~tileConf[63];
end
else begin
// instantiate frame latches
    LHQD1 #() Inst_frame6_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[6]),
        .Q(ConfigBits[0]),
        .QN(ConfigBits_N[0])
    );

    LHQD1 #() Inst_frame6_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[6]),
        .Q(ConfigBits[1]),
        .QN(ConfigBits_N[1])
    );

    LHQD1 #() Inst_frame6_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[6]),
        .Q(ConfigBits[2]),
        .QN(ConfigBits_N[2])
    );

    LHQD1 #() Inst_frame5_bit0 (
        .D(FrameData[0]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[3]),
        .QN(ConfigBits_N[3])
    );

    LHQD1 #() Inst_frame5_bit1 (
        .D(FrameData[1]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[4]),
        .QN(ConfigBits_N[4])
    );

    LHQD1 #() Inst_frame5_bit2 (
        .D(FrameData[2]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[5]),
        .QN(ConfigBits_N[5])
    );

    LHQD1 #() Inst_frame5_bit3 (
        .D(FrameData[3]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[6]),
        .QN(ConfigBits_N[6])
    );

    LHQD1 #() Inst_frame5_bit4 (
        .D(FrameData[4]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[7]),
        .QN(ConfigBits_N[7])
    );

    LHQD1 #() Inst_frame5_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[8]),
        .QN(ConfigBits_N[8])
    );

    LHQD1 #() Inst_frame5_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[9]),
        .QN(ConfigBits_N[9])
    );

    LHQD1 #() Inst_frame5_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[5]),
        .Q(ConfigBits[10]),
        .QN(ConfigBits_N[10])
    );

    LHQD1 #() Inst_frame4_bit0 (
        .D(FrameData[0]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[11]),
        .QN(ConfigBits_N[11])
    );

    LHQD1 #() Inst_frame4_bit1 (
        .D(FrameData[1]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[12]),
        .QN(ConfigBits_N[12])
    );

    LHQD1 #() Inst_frame4_bit2 (
        .D(FrameData[2]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[13]),
        .QN(ConfigBits_N[13])
    );

    LHQD1 #() Inst_frame4_bit3 (
        .D(FrameData[3]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[14]),
        .QN(ConfigBits_N[14])
    );

    LHQD1 #() Inst_frame4_bit4 (
        .D(FrameData[4]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[15]),
        .QN(ConfigBits_N[15])
    );

    LHQD1 #() Inst_frame4_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[16]),
        .QN(ConfigBits_N[16])
    );

    LHQD1 #() Inst_frame4_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[17]),
        .QN(ConfigBits_N[17])
    );

    LHQD1 #() Inst_frame4_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[4]),
        .Q(ConfigBits[18]),
        .QN(ConfigBits_N[18])
    );

    LHQD1 #() Inst_frame3_bit0 (
        .D(FrameData[0]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[19]),
        .QN(ConfigBits_N[19])
    );

    LHQD1 #() Inst_frame3_bit1 (
        .D(FrameData[1]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[20]),
        .QN(ConfigBits_N[20])
    );

    LHQD1 #() Inst_frame3_bit2 (
        .D(FrameData[2]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[21]),
        .QN(ConfigBits_N[21])
    );

    LHQD1 #() Inst_frame3_bit3 (
        .D(FrameData[3]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[22]),
        .QN(ConfigBits_N[22])
    );

    LHQD1 #() Inst_frame3_bit4 (
        .D(FrameData[4]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[23]),
        .QN(ConfigBits_N[23])
    );

    LHQD1 #() Inst_frame3_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[24]),
        .QN(ConfigBits_N[24])
    );

    LHQD1 #() Inst_frame3_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[25]),
        .QN(ConfigBits_N[25])
    );

    LHQD1 #() Inst_frame3_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[3]),
        .Q(ConfigBits[26]),
        .QN(ConfigBits_N[26])
    );

    LHQD1 #() Inst_frame2_bit0 (
        .D(FrameData[0]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[27]),
        .QN(ConfigBits_N[27])
    );

    LHQD1 #() Inst_frame2_bit1 (
        .D(FrameData[1]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[28]),
        .QN(ConfigBits_N[28])
    );

    LHQD1 #() Inst_frame2_bit2 (
        .D(FrameData[2]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[29]),
        .QN(ConfigBits_N[29])
    );

    LHQD1 #() Inst_frame2_bit3 (
        .D(FrameData[3]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[30]),
        .QN(ConfigBits_N[30])
    );

    LHQD1 #() Inst_frame2_bit4 (
        .D(FrameData[4]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[31]),
        .QN(ConfigBits_N[31])
    );

    LHQD1 #() Inst_frame2_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[32]),
        .QN(ConfigBits_N[32])
    );

    LHQD1 #() Inst_frame2_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[33]),
        .QN(ConfigBits_N[33])
    );

    LHQD1 #() Inst_frame2_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[2]),
        .Q(ConfigBits[34]),
        .QN(ConfigBits_N[34])
    );

    LHQD1 #() Inst_frame1_bit0 (
        .D(FrameData[0]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[35]),
        .QN(ConfigBits_N[35])
    );

    LHQD1 #() Inst_frame1_bit1 (
        .D(FrameData[1]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[36]),
        .QN(ConfigBits_N[36])
    );

    LHQD1 #() Inst_frame1_bit2 (
        .D(FrameData[2]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[37]),
        .QN(ConfigBits_N[37])
    );

    LHQD1 #() Inst_frame1_bit3 (
        .D(FrameData[3]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[38]),
        .QN(ConfigBits_N[38])
    );

    LHQD1 #() Inst_frame1_bit4 (
        .D(FrameData[4]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[39]),
        .QN(ConfigBits_N[39])
    );

    LHQD1 #() Inst_frame1_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[40]),
        .QN(ConfigBits_N[40])
    );

    LHQD1 #() Inst_frame1_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[41]),
        .QN(ConfigBits_N[41])
    );

    LHQD1 #() Inst_frame1_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[1]),
        .Q(ConfigBits[42]),
        .QN(ConfigBits_N[42])
    );

    LHQD1 #() Inst_frame0_bit0 (
        .D(FrameData[0]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[43]),
        .QN(ConfigBits_N[43])
    );

    LHQD1 #() Inst_frame0_bit1 (
        .D(FrameData[1]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[44]),
        .QN(ConfigBits_N[44])
    );

    LHQD1 #() Inst_frame0_bit2 (
        .D(FrameData[2]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[45]),
        .QN(ConfigBits_N[45])
    );

    LHQD1 #() Inst_frame0_bit3 (
        .D(FrameData[3]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[46]),
        .QN(ConfigBits_N[46])
    );

    LHQD1 #() Inst_frame0_bit4 (
        .D(FrameData[4]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[47]),
        .QN(ConfigBits_N[47])
    );

    LHQD1 #() Inst_frame0_bit5 (
        .D(FrameData[5]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[48]),
        .QN(ConfigBits_N[48])
    );

    LHQD1 #() Inst_frame0_bit6 (
        .D(FrameData[6]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[49]),
        .QN(ConfigBits_N[49])
    );

    LHQD1 #() Inst_frame0_bit7 (
        .D(FrameData[7]),
        .E(FrameStrobe[0]),
        .Q(ConfigBits[50]),
        .QN(ConfigBits_N[50])
    );

end

endgenerate

endmodule

