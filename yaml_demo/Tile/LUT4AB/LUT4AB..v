module LUT4AB #(
    parameter MaxFramesPerCol = 20,
    parameter FrameBitsPerRow = 32
)(
    // NORTH,
    output [3:0] N1BEG,
    input [3:0] N1END,
    output [7:0] N2BEG,
    input [7:0] N2MID,
    output [7:0] N2BEGb,
    input [7:0] N2END,
    output [3:0] N4BEG,
    input [3:0] N4END,
    output [3:0] NN4BEG,
    input [3:0] NN4END,
    output Co,
    input Ci,
    // EAST,
    output [3:0] E1BEG,
    input [3:0] E1END,
    output [7:0] E2BEG,
    input [7:0] E2MID,
    output [7:0] E2BEGb,
    input [7:0] E2END,
    output [3:0] EE4BEG,
    input [3:0] EE4END,
    output [1:0] E6BEG,
    input [1:0] E6END,
    // SOUTH,
    output [3:0] S1BEG,
    input [3:0] S1END,
    output [7:0] S2BEG,
    input [7:0] S2MID,
    output [7:0] S2BEGb,
    input [7:0] S2END,
    output [3:0] S4BEG,
    input [3:0] S4END,
    output [3:0] SS4BEG,
    input [3:0] SS4END,
    // WEST,
    output [3:0] W1BEG,
    input [3:0] W1END,
    output [7:0] W2BEG,
    input [7:0] W2MID,
    output [7:0] W2BEGb,
    input [7:0] W2END,
    output [3:0] WW4BEG,
    input [3:0] WW4END,
    output [1:0] W6BEG,
    input [1:0] W6END,
    input UserCLK,
    input UserCLK,
    input UserCLK,
    input UserCLK,
    input UserCLK,
    input UserCLK,
    input UserCLK,
    input UserCLK,
    input UserCLK,
    output UserCLKo,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creationreg [18:0] LA_ConfigBits;reg LA_UserCLK;reg [18:0] LB_ConfigBits;reg LB_UserCLK;reg [18:0] LC_ConfigBits;reg LC_UserCLK;reg [18:0] LD_ConfigBits;reg LD_UserCLK;reg [18:0] LE_ConfigBits;reg LE_UserCLK;reg [18:0] LF_ConfigBits;reg LF_UserCLK;reg [18:0] LG_ConfigBits;reg LG_UserCLK;reg [18:0] LH_ConfigBits;reg LH_UserCLK;reg [1:0] ConfigBits;// Buffering incoming and out outgoing wires// FrameStrobe Bufferreg [MaxFramesPerCol - 1:0] FrameStrobe_internal;my_buf_pack #(
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
// Buffer spanning wire: N4END->N4BEGreg [11:0] N4END_to_N4BEG;my_buf_pack #(
    .WIDTH(12)
) N4END_inbuf (
    .A(N4END[3:4]),
    .X(N4END_to_N4BEG)
);
my_buf_pack #(
    .WIDTH(12)
) N4BEG_outbuf (
    .A(N4END_to_N4BEG),
    .X(N4BEG[11:0])
);
// Buffer spanning wire: NN4END->NN4BEGreg [11:0] NN4END_to_NN4BEG;my_buf_pack #(
    .WIDTH(12)
) NN4END_inbuf (
    .A(NN4END[3:4]),
    .X(NN4END_to_NN4BEG)
);
my_buf_pack #(
    .WIDTH(12)
) NN4BEG_outbuf (
    .A(NN4END_to_NN4BEG),
    .X(NN4BEG[11:0])
);
// Buffer spanning wire: EE4END->EE4BEGreg [11:0] EE4END_to_EE4BEG;my_buf_pack #(
    .WIDTH(12)
) EE4END_inbuf (
    .A(EE4END[3:4]),
    .X(EE4END_to_EE4BEG)
);
my_buf_pack #(
    .WIDTH(12)
) EE4BEG_outbuf (
    .A(EE4END_to_EE4BEG),
    .X(EE4BEG[11:0])
);
// Buffer spanning wire: E6END->E6BEGreg [9:0] E6END_to_E6BEG;my_buf_pack #(
    .WIDTH(10)
) E6END_inbuf (
    .A(E6END[1:2]),
    .X(E6END_to_E6BEG)
);
my_buf_pack #(
    .WIDTH(10)
) E6BEG_outbuf (
    .A(E6END_to_E6BEG),
    .X(E6BEG[9:0])
);
// Buffer spanning wire: S4END->S4BEGreg [11:0] S4END_to_S4BEG;my_buf_pack #(
    .WIDTH(12)
) S4END_inbuf (
    .A(S4END[3:4]),
    .X(S4END_to_S4BEG)
);
my_buf_pack #(
    .WIDTH(12)
) S4BEG_outbuf (
    .A(S4END_to_S4BEG),
    .X(S4BEG[11:0])
);
// Buffer spanning wire: SS4END->SS4BEGreg [11:0] SS4END_to_SS4BEG;my_buf_pack #(
    .WIDTH(12)
) SS4END_inbuf (
    .A(SS4END[3:4]),
    .X(SS4END_to_SS4BEG)
);
my_buf_pack #(
    .WIDTH(12)
) SS4BEG_outbuf (
    .A(SS4END_to_SS4BEG),
    .X(SS4BEG[11:0])
);
// Buffer spanning wire: WW4END->WW4BEGreg [11:0] WW4END_to_WW4BEG;my_buf_pack #(
    .WIDTH(12)
) WW4END_inbuf (
    .A(WW4END[3:4]),
    .X(WW4END_to_WW4BEG)
);
my_buf_pack #(
    .WIDTH(12)
) WW4BEG_outbuf (
    .A(WW4END_to_WW4BEG),
    .X(WW4BEG[11:0])
);
// Buffer spanning wire: W6END->W6BEGreg [9:0] W6END_to_W6BEG;my_buf_pack #(
    .WIDTH(10)
) W6END_inbuf (
    .A(W6END[1:2]),
    .X(W6END_to_W6BEG)
);
my_buf_pack #(
    .WIDTH(10)
) W6BEG_outbuf (
    .A(W6END_to_W6BEG),
    .X(W6BEG[9:0])
);
// Buffer spanning wire: J2MID_ABa_END->J2MID_ABa_BEGreg [-5:0] J2MID_ABa_END_to_J2MID_ABa_BEG;
endmodule
