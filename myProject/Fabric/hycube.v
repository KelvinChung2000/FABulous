module hycube #(
    parameter MaxFramePerCol = 32,
    parameter FrameBitsPerRow = 32
)(
    input Tile_X1Y0_in,
    output Tile_X1Y0_out,
    input Tile_X2Y0_in,
    output Tile_X2Y0_out,
    input Tile_X3Y0_in,
    output Tile_X3Y0_out,
    input Tile_X4Y0_in,
    output Tile_X4Y0_out,
    input Tile_X0Y1_in,
    output Tile_X0Y1_out,
    input Tile_X5Y1_in,
    output Tile_X5Y1_out,
    input Tile_X0Y2_in,
    output Tile_X0Y2_out,
    input Tile_X5Y2_in,
    output Tile_X5Y2_out,
    input Tile_X0Y3_in,
    output Tile_X0Y3_out,
    input Tile_X5Y3_in,
    output Tile_X5Y3_out,
    input Tile_X0Y4_in,
    output Tile_X0Y4_out,
    input Tile_X5Y4_in,
    output Tile_X5Y4_out,
    input Tile_X1Y5_in,
    output Tile_X1Y5_out,
    input Tile_X2Y5_in,
    output Tile_X2Y5_out,
    input Tile_X3Y5_in,
    output Tile_X3Y5_out,
    input Tile_X4Y5_in,
    output Tile_X4Y5_out,
    input [FrameBitsPerRow * 6 - 1:0] FrameData,
    input [MaxFramePerCol * 6 - 1:0] FrameStrobe,
    input UserCLK
);

// User Clock wire
wire Tile_X0Y1_UserCLK;
wire Tile_X0Y0_UserCLK_o;
wire Tile_X1Y1_UserCLK;
wire Tile_X1Y0_UserCLK_o;
wire Tile_X2Y1_UserCLK;
wire Tile_X2Y0_UserCLK_o;
wire Tile_X3Y1_UserCLK;
wire Tile_X3Y0_UserCLK_o;
wire Tile_X4Y1_UserCLK;
wire Tile_X4Y0_UserCLK_o;
wire Tile_X5Y1_UserCLK;
wire Tile_X5Y0_UserCLK_o;
wire Tile_X0Y2_UserCLK;
wire Tile_X0Y1_UserCLK_o;
wire Tile_X1Y2_UserCLK;
wire Tile_X1Y1_UserCLK_o;
wire Tile_X2Y2_UserCLK;
wire Tile_X2Y1_UserCLK_o;
wire Tile_X3Y2_UserCLK;
wire Tile_X3Y1_UserCLK_o;
wire Tile_X4Y2_UserCLK;
wire Tile_X4Y1_UserCLK_o;
wire Tile_X5Y2_UserCLK;
wire Tile_X5Y1_UserCLK_o;
wire Tile_X0Y3_UserCLK;
wire Tile_X0Y2_UserCLK_o;
wire Tile_X1Y3_UserCLK;
wire Tile_X1Y2_UserCLK_o;
wire Tile_X2Y3_UserCLK;
wire Tile_X2Y2_UserCLK_o;
wire Tile_X3Y3_UserCLK;
wire Tile_X3Y2_UserCLK_o;
wire Tile_X4Y3_UserCLK;
wire Tile_X4Y2_UserCLK_o;
wire Tile_X5Y3_UserCLK;
wire Tile_X5Y2_UserCLK_o;
wire Tile_X0Y4_UserCLK;
wire Tile_X0Y3_UserCLK_o;
wire Tile_X1Y4_UserCLK;
wire Tile_X1Y3_UserCLK_o;
wire Tile_X2Y4_UserCLK;
wire Tile_X2Y3_UserCLK_o;
wire Tile_X3Y4_UserCLK;
wire Tile_X3Y3_UserCLK_o;
wire Tile_X4Y4_UserCLK;
wire Tile_X4Y3_UserCLK_o;
wire Tile_X5Y4_UserCLK;
wire Tile_X5Y3_UserCLK_o;
wire Tile_X0Y5_UserCLK;
wire Tile_X0Y4_UserCLK_o;
wire Tile_X1Y5_UserCLK;
wire Tile_X1Y4_UserCLK_o;
wire Tile_X2Y5_UserCLK;
wire Tile_X2Y4_UserCLK_o;
wire Tile_X3Y5_UserCLK;
wire Tile_X3Y4_UserCLK_o;
wire Tile_X4Y5_UserCLK;
wire Tile_X4Y4_UserCLK_o;
wire Tile_X5Y5_UserCLK;
wire Tile_X5Y4_UserCLK_o;
wire Tile_X0Y5_UserCLK_o;
wire Tile_X1Y5_UserCLK_o;
wire Tile_X2Y5_UserCLK_o;
wire Tile_X3Y5_UserCLK_o;
wire Tile_X4Y5_UserCLK_o;
wire Tile_X5Y5_UserCLK_o;

// Frame Data wire
wire [FrameBitsPerRow - 1:0] Tile_X0Y0_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X1Y0_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X2Y0_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X3Y0_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X4Y0_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X5Y0_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X0Y1_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X1Y1_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X2Y1_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X3Y1_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X4Y1_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X5Y1_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X0Y2_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X1Y2_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X2Y2_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X3Y2_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X4Y2_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X5Y2_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X0Y3_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X1Y3_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X2Y3_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X3Y3_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X4Y3_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X5Y3_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X0Y4_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X1Y4_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X2Y4_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X3Y4_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X4Y4_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X5Y4_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X0Y5_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X1Y5_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X2Y5_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X3Y5_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X4Y5_FrameData;
wire [FrameBitsPerRow - 1:0] Tile_X5Y5_FrameData;
wire [FrameBitsPerRow - 1:0] Row0_FrameData;
wire [FrameBitsPerRow - 1:0] Row1_FrameData;
wire [FrameBitsPerRow - 1:0] Row2_FrameData;
wire [FrameBitsPerRow - 1:0] Row3_FrameData;
wire [FrameBitsPerRow - 1:0] Row4_FrameData;
wire [FrameBitsPerRow - 1:0] Row5_FrameData;

// Frame Strobe wire
wire [MaxFramePerCol - 1:0] Tile_X0Y0_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X1Y0_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X2Y0_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X3Y0_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X4Y0_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X5Y0_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X0Y1_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X1Y1_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X2Y1_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X3Y1_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X4Y1_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X5Y1_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X0Y2_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X1Y2_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X2Y2_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X3Y2_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X4Y2_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X5Y2_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X0Y3_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X1Y3_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X2Y3_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X3Y3_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X4Y3_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X5Y3_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X0Y4_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X1Y4_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X2Y4_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X3Y4_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X4Y4_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X5Y4_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X0Y5_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X1Y5_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X2Y5_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X3Y5_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X4Y5_FrameStrobe;
wire [MaxFramePerCol - 1:0] Tile_X5Y5_FrameStrobe;
wire [MaxFramePerCol - 1:0] Col0_FrameStrobe;
wire [MaxFramePerCol - 1:0] Col1_FrameStrobe;
wire [MaxFramePerCol - 1:0] Col2_FrameStrobe;
wire [MaxFramePerCol - 1:0] Col3_FrameStrobe;
wire [MaxFramePerCol - 1:0] Col4_FrameStrobe;
wire [MaxFramePerCol - 1:0] Col5_FrameStrobe;

// Tile to Tile wire
wire [31:0] Tile_X1Y0_out0;
wire [31:0] Tile_X1Y0_out2;
wire [31:0] Tile_X2Y0_out0;
wire [31:0] Tile_X2Y0_out2;
wire [31:0] Tile_X3Y0_out0;
wire [31:0] Tile_X3Y0_out2;
wire [31:0] Tile_X4Y0_out0;
wire [31:0] Tile_X4Y0_out2;
wire [31:0] Tile_X0Y1_out1;
wire [31:0] Tile_X0Y1_out3;
wire [31:0] Tile_X1Y1_out0;
wire [31:0] Tile_X1Y1_out1;
wire [31:0] Tile_X1Y1_out2;
wire [31:0] Tile_X1Y1_out3;
wire [31:0] Tile_X2Y1_out0;
wire [31:0] Tile_X2Y1_out1;
wire [31:0] Tile_X2Y1_out2;
wire [31:0] Tile_X2Y1_out3;
wire [31:0] Tile_X3Y1_out0;
wire [31:0] Tile_X3Y1_out1;
wire [31:0] Tile_X3Y1_out2;
wire [31:0] Tile_X3Y1_out3;
wire [31:0] Tile_X4Y1_out0;
wire [31:0] Tile_X4Y1_out1;
wire [31:0] Tile_X4Y1_out2;
wire [31:0] Tile_X4Y1_out3;
wire [31:0] Tile_X5Y1_out1;
wire [31:0] Tile_X5Y1_out3;
wire [31:0] Tile_X0Y2_out1;
wire [31:0] Tile_X0Y2_out3;
wire [31:0] Tile_X1Y2_out0;
wire [31:0] Tile_X1Y2_out1;
wire [31:0] Tile_X1Y2_out2;
wire [31:0] Tile_X1Y2_out3;
wire [31:0] Tile_X2Y2_out0;
wire [31:0] Tile_X2Y2_out1;
wire [31:0] Tile_X2Y2_out2;
wire [31:0] Tile_X2Y2_out3;
wire [31:0] Tile_X3Y2_out0;
wire [31:0] Tile_X3Y2_out1;
wire [31:0] Tile_X3Y2_out2;
wire [31:0] Tile_X3Y2_out3;
wire [31:0] Tile_X4Y2_out0;
wire [31:0] Tile_X4Y2_out1;
wire [31:0] Tile_X4Y2_out2;
wire [31:0] Tile_X4Y2_out3;
wire [31:0] Tile_X5Y2_out1;
wire [31:0] Tile_X5Y2_out3;
wire [31:0] Tile_X0Y3_out1;
wire [31:0] Tile_X0Y3_out3;
wire [31:0] Tile_X1Y3_out0;
wire [31:0] Tile_X1Y3_out1;
wire [31:0] Tile_X1Y3_out2;
wire [31:0] Tile_X1Y3_out3;
wire [31:0] Tile_X2Y3_out0;
wire [31:0] Tile_X2Y3_out1;
wire [31:0] Tile_X2Y3_out2;
wire [31:0] Tile_X2Y3_out3;
wire [31:0] Tile_X3Y3_out0;
wire [31:0] Tile_X3Y3_out1;
wire [31:0] Tile_X3Y3_out2;
wire [31:0] Tile_X3Y3_out3;
wire [31:0] Tile_X4Y3_out0;
wire [31:0] Tile_X4Y3_out1;
wire [31:0] Tile_X4Y3_out2;
wire [31:0] Tile_X4Y3_out3;
wire [31:0] Tile_X5Y3_out1;
wire [31:0] Tile_X5Y3_out3;
wire [31:0] Tile_X0Y4_out1;
wire [31:0] Tile_X0Y4_out3;
wire [31:0] Tile_X1Y4_out0;
wire [31:0] Tile_X1Y4_out1;
wire [31:0] Tile_X1Y4_out2;
wire [31:0] Tile_X1Y4_out3;
wire [31:0] Tile_X2Y4_out0;
wire [31:0] Tile_X2Y4_out1;
wire [31:0] Tile_X2Y4_out2;
wire [31:0] Tile_X2Y4_out3;
wire [31:0] Tile_X3Y4_out0;
wire [31:0] Tile_X3Y4_out1;
wire [31:0] Tile_X3Y4_out2;
wire [31:0] Tile_X3Y4_out3;
wire [31:0] Tile_X4Y4_out0;
wire [31:0] Tile_X4Y4_out1;
wire [31:0] Tile_X4Y4_out2;
wire [31:0] Tile_X4Y4_out3;
wire [31:0] Tile_X5Y4_out1;
wire [31:0] Tile_X5Y4_out3;
wire [31:0] Tile_X1Y5_out0;
wire [31:0] Tile_X1Y5_out2;
wire [31:0] Tile_X2Y5_out0;
wire [31:0] Tile_X2Y5_out2;
wire [31:0] Tile_X3Y5_out0;
wire [31:0] Tile_X3Y5_out2;
wire [31:0] Tile_X4Y5_out0;
wire [31:0] Tile_X4Y5_out2;

// Frame Data connection
assign Row0_FrameData = FrameData[FrameBitsPerRow * 1 - 1:FrameBitsPerRow * 0];

assign Row1_FrameData = FrameData[FrameBitsPerRow * 2 - 1:FrameBitsPerRow * 1];

assign Row2_FrameData = FrameData[FrameBitsPerRow * 3 - 1:FrameBitsPerRow * 2];

assign Row3_FrameData = FrameData[FrameBitsPerRow * 4 - 1:FrameBitsPerRow * 3];

assign Row4_FrameData = FrameData[FrameBitsPerRow * 5 - 1:FrameBitsPerRow * 4];

assign Row5_FrameData = FrameData[FrameBitsPerRow * 6 - 1:FrameBitsPerRow * 5];


// Frame Strobe connection
assign Col0_FrameStrobe = FrameStrobe[MaxFramePerCol * 1 - 1:MaxFramePerCol * 0];

assign Col1_FrameStrobe = FrameStrobe[MaxFramePerCol * 2 - 1:MaxFramePerCol * 1];

assign Col2_FrameStrobe = FrameStrobe[MaxFramePerCol * 3 - 1:MaxFramePerCol * 2];

assign Col3_FrameStrobe = FrameStrobe[MaxFramePerCol * 4 - 1:MaxFramePerCol * 3];

assign Col4_FrameStrobe = FrameStrobe[MaxFramePerCol * 5 - 1:MaxFramePerCol * 4];

assign Col5_FrameStrobe = FrameStrobe[MaxFramePerCol * 6 - 1:MaxFramePerCol * 5];

// Create Tiles
EmptyTile #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X0Y0 (
    .UserCLK(Tile_X0Y1_UserCLK),
    .UserCLK_o(Tile_X0Y0_UserCLK_o),
    .FrameData(Row0_FrameData),
    .FrameData_o(Tile_X0Y0_FrameData),
    .FrameStrobe(Tile_X0Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y0_FrameStrobe)
);

N_IO #() N_IO_Tile_X1Y0 (
    .out0(Tile_X1Y0_out0),
    .out2(Tile_X1Y0_out2),
    .in2(Tile_X1Y1_out0),
    .N_in(Tile_X1Y0_in),
    .N_out(Tile_X1Y0_out),
    .UserCLK(Tile_X1Y1_UserCLK),
    .UserCLK_o(Tile_X1Y0_UserCLK_o),
    .FrameData(Tile_X0Y0_FrameData),
    .FrameData_o(Tile_X1Y0_FrameData),
    .FrameStrobe(Tile_X1Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y0_FrameStrobe)
);

N_IO #() N_IO_Tile_X2Y0 (
    .out0(Tile_X2Y0_out0),
    .out2(Tile_X2Y0_out2),
    .in2(Tile_X2Y1_out0),
    .N_in(Tile_X2Y0_in),
    .N_out(Tile_X2Y0_out),
    .UserCLK(Tile_X2Y1_UserCLK),
    .UserCLK_o(Tile_X2Y0_UserCLK_o),
    .FrameData(Tile_X1Y0_FrameData),
    .FrameData_o(Tile_X2Y0_FrameData),
    .FrameStrobe(Tile_X2Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y0_FrameStrobe)
);

N_IO #() N_IO_Tile_X3Y0 (
    .out0(Tile_X3Y0_out0),
    .out2(Tile_X3Y0_out2),
    .in2(Tile_X3Y1_out0),
    .N_in(Tile_X3Y0_in),
    .N_out(Tile_X3Y0_out),
    .UserCLK(Tile_X3Y1_UserCLK),
    .UserCLK_o(Tile_X3Y0_UserCLK_o),
    .FrameData(Tile_X2Y0_FrameData),
    .FrameData_o(Tile_X3Y0_FrameData),
    .FrameStrobe(Tile_X3Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y0_FrameStrobe)
);

N_IO #() N_IO_Tile_X4Y0 (
    .out0(Tile_X4Y0_out0),
    .out2(Tile_X4Y0_out2),
    .in2(Tile_X4Y1_out0),
    .N_in(Tile_X4Y0_in),
    .N_out(Tile_X4Y0_out),
    .UserCLK(Tile_X4Y1_UserCLK),
    .UserCLK_o(Tile_X4Y0_UserCLK_o),
    .FrameData(Tile_X3Y0_FrameData),
    .FrameData_o(Tile_X4Y0_FrameData),
    .FrameStrobe(Tile_X4Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y0_FrameStrobe)
);

EmptyTile #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X5Y0 (
    .UserCLK(Tile_X5Y1_UserCLK),
    .UserCLK_o(Tile_X5Y0_UserCLK_o),
    .FrameData(Tile_X4Y0_FrameData),
    .FrameData_o(Tile_X5Y0_FrameData),
    .FrameStrobe(Tile_X5Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y0_FrameStrobe)
);

W_IO #() W_IO_Tile_X0Y1 (
    .out1(Tile_X0Y1_out1),
    .out3(Tile_X0Y1_out3),
    .in3(Tile_X1Y1_out1),
    .W_in(Tile_X0Y1_in),
    .W_out(Tile_X0Y1_out),
    .UserCLK(Tile_X0Y2_UserCLK),
    .UserCLK_o(Tile_X0Y1_UserCLK_o),
    .FrameData(Row1_FrameData),
    .FrameData_o(Tile_X0Y1_FrameData),
    .FrameStrobe(Tile_X0Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y1_FrameStrobe)
);

PE #() PE_Tile_X1Y1 (
    .out0(Tile_X1Y1_out0),
    .out1(Tile_X1Y1_out1),
    .out2(Tile_X1Y1_out2),
    .out3(Tile_X1Y1_out3),
    .in0(Tile_X1Y0_out2),
    .in1(Tile_X0Y1_out3),
    .in2(Tile_X1Y2_out0),
    .in3(Tile_X2Y1_out1),
    .UserCLK(Tile_X1Y2_UserCLK),
    .UserCLK_o(Tile_X1Y1_UserCLK_o),
    .FrameData(Tile_X0Y1_FrameData),
    .FrameData_o(Tile_X1Y1_FrameData),
    .FrameStrobe(Tile_X1Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y1_FrameStrobe)
);

PE #() PE_Tile_X2Y1 (
    .out0(Tile_X2Y1_out0),
    .out1(Tile_X2Y1_out1),
    .out2(Tile_X2Y1_out2),
    .out3(Tile_X2Y1_out3),
    .in0(Tile_X2Y0_out2),
    .in1(Tile_X1Y1_out3),
    .in2(Tile_X2Y2_out0),
    .in3(Tile_X3Y1_out1),
    .UserCLK(Tile_X2Y2_UserCLK),
    .UserCLK_o(Tile_X2Y1_UserCLK_o),
    .FrameData(Tile_X1Y1_FrameData),
    .FrameData_o(Tile_X2Y1_FrameData),
    .FrameStrobe(Tile_X2Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y1_FrameStrobe)
);

PE #() PE_Tile_X3Y1 (
    .out0(Tile_X3Y1_out0),
    .out1(Tile_X3Y1_out1),
    .out2(Tile_X3Y1_out2),
    .out3(Tile_X3Y1_out3),
    .in0(Tile_X3Y0_out2),
    .in1(Tile_X2Y1_out3),
    .in2(Tile_X3Y2_out0),
    .in3(Tile_X4Y1_out1),
    .UserCLK(Tile_X3Y2_UserCLK),
    .UserCLK_o(Tile_X3Y1_UserCLK_o),
    .FrameData(Tile_X2Y1_FrameData),
    .FrameData_o(Tile_X3Y1_FrameData),
    .FrameStrobe(Tile_X3Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y1_FrameStrobe)
);

PE #() PE_Tile_X4Y1 (
    .out0(Tile_X4Y1_out0),
    .out1(Tile_X4Y1_out1),
    .out2(Tile_X4Y1_out2),
    .out3(Tile_X4Y1_out3),
    .in0(Tile_X4Y0_out2),
    .in1(Tile_X3Y1_out3),
    .in2(Tile_X4Y2_out0),
    .in3(Tile_X5Y1_out1),
    .UserCLK(Tile_X4Y2_UserCLK),
    .UserCLK_o(Tile_X4Y1_UserCLK_o),
    .FrameData(Tile_X3Y1_FrameData),
    .FrameData_o(Tile_X4Y1_FrameData),
    .FrameStrobe(Tile_X4Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y1_FrameStrobe)
);

E_IO #() E_IO_Tile_X5Y1 (
    .out1(Tile_X5Y1_out1),
    .out3(Tile_X5Y1_out3),
    .in1(Tile_X4Y1_out3),
    .E_in(Tile_X5Y1_in),
    .E_out(Tile_X5Y1_out),
    .UserCLK(Tile_X5Y2_UserCLK),
    .UserCLK_o(Tile_X5Y1_UserCLK_o),
    .FrameData(Tile_X4Y1_FrameData),
    .FrameData_o(Tile_X5Y1_FrameData),
    .FrameStrobe(Tile_X5Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y1_FrameStrobe)
);

W_IO #() W_IO_Tile_X0Y2 (
    .out1(Tile_X0Y2_out1),
    .out3(Tile_X0Y2_out3),
    .in3(Tile_X1Y2_out1),
    .W_in(Tile_X0Y2_in),
    .W_out(Tile_X0Y2_out),
    .UserCLK(Tile_X0Y3_UserCLK),
    .UserCLK_o(Tile_X0Y2_UserCLK_o),
    .FrameData(Row2_FrameData),
    .FrameData_o(Tile_X0Y2_FrameData),
    .FrameStrobe(Tile_X0Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y2_FrameStrobe)
);

PE #() PE_Tile_X1Y2 (
    .out0(Tile_X1Y2_out0),
    .out1(Tile_X1Y2_out1),
    .out2(Tile_X1Y2_out2),
    .out3(Tile_X1Y2_out3),
    .in0(Tile_X1Y1_out2),
    .in1(Tile_X0Y2_out3),
    .in2(Tile_X1Y3_out0),
    .in3(Tile_X2Y2_out1),
    .UserCLK(Tile_X1Y3_UserCLK),
    .UserCLK_o(Tile_X1Y2_UserCLK_o),
    .FrameData(Tile_X0Y2_FrameData),
    .FrameData_o(Tile_X1Y2_FrameData),
    .FrameStrobe(Tile_X1Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y2_FrameStrobe)
);

PE #() PE_Tile_X2Y2 (
    .out0(Tile_X2Y2_out0),
    .out1(Tile_X2Y2_out1),
    .out2(Tile_X2Y2_out2),
    .out3(Tile_X2Y2_out3),
    .in0(Tile_X2Y1_out2),
    .in1(Tile_X1Y2_out3),
    .in2(Tile_X2Y3_out0),
    .in3(Tile_X3Y2_out1),
    .UserCLK(Tile_X2Y3_UserCLK),
    .UserCLK_o(Tile_X2Y2_UserCLK_o),
    .FrameData(Tile_X1Y2_FrameData),
    .FrameData_o(Tile_X2Y2_FrameData),
    .FrameStrobe(Tile_X2Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y2_FrameStrobe)
);

PE #() PE_Tile_X3Y2 (
    .out0(Tile_X3Y2_out0),
    .out1(Tile_X3Y2_out1),
    .out2(Tile_X3Y2_out2),
    .out3(Tile_X3Y2_out3),
    .in0(Tile_X3Y1_out2),
    .in1(Tile_X2Y2_out3),
    .in2(Tile_X3Y3_out0),
    .in3(Tile_X4Y2_out1),
    .UserCLK(Tile_X3Y3_UserCLK),
    .UserCLK_o(Tile_X3Y2_UserCLK_o),
    .FrameData(Tile_X2Y2_FrameData),
    .FrameData_o(Tile_X3Y2_FrameData),
    .FrameStrobe(Tile_X3Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y2_FrameStrobe)
);

PE #() PE_Tile_X4Y2 (
    .out0(Tile_X4Y2_out0),
    .out1(Tile_X4Y2_out1),
    .out2(Tile_X4Y2_out2),
    .out3(Tile_X4Y2_out3),
    .in0(Tile_X4Y1_out2),
    .in1(Tile_X3Y2_out3),
    .in2(Tile_X4Y3_out0),
    .in3(Tile_X5Y2_out1),
    .UserCLK(Tile_X4Y3_UserCLK),
    .UserCLK_o(Tile_X4Y2_UserCLK_o),
    .FrameData(Tile_X3Y2_FrameData),
    .FrameData_o(Tile_X4Y2_FrameData),
    .FrameStrobe(Tile_X4Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y2_FrameStrobe)
);

E_IO #() E_IO_Tile_X5Y2 (
    .out1(Tile_X5Y2_out1),
    .out3(Tile_X5Y2_out3),
    .in1(Tile_X4Y2_out3),
    .E_in(Tile_X5Y2_in),
    .E_out(Tile_X5Y2_out),
    .UserCLK(Tile_X5Y3_UserCLK),
    .UserCLK_o(Tile_X5Y2_UserCLK_o),
    .FrameData(Tile_X4Y2_FrameData),
    .FrameData_o(Tile_X5Y2_FrameData),
    .FrameStrobe(Tile_X5Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y2_FrameStrobe)
);

W_IO #() W_IO_Tile_X0Y3 (
    .out1(Tile_X0Y3_out1),
    .out3(Tile_X0Y3_out3),
    .in3(Tile_X1Y3_out1),
    .W_in(Tile_X0Y3_in),
    .W_out(Tile_X0Y3_out),
    .UserCLK(Tile_X0Y4_UserCLK),
    .UserCLK_o(Tile_X0Y3_UserCLK_o),
    .FrameData(Row3_FrameData),
    .FrameData_o(Tile_X0Y3_FrameData),
    .FrameStrobe(Tile_X0Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y3_FrameStrobe)
);

PE #() PE_Tile_X1Y3 (
    .out0(Tile_X1Y3_out0),
    .out1(Tile_X1Y3_out1),
    .out2(Tile_X1Y3_out2),
    .out3(Tile_X1Y3_out3),
    .in0(Tile_X1Y2_out2),
    .in1(Tile_X0Y3_out3),
    .in2(Tile_X1Y4_out0),
    .in3(Tile_X2Y3_out1),
    .UserCLK(Tile_X1Y4_UserCLK),
    .UserCLK_o(Tile_X1Y3_UserCLK_o),
    .FrameData(Tile_X0Y3_FrameData),
    .FrameData_o(Tile_X1Y3_FrameData),
    .FrameStrobe(Tile_X1Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y3_FrameStrobe)
);

PE #() PE_Tile_X2Y3 (
    .out0(Tile_X2Y3_out0),
    .out1(Tile_X2Y3_out1),
    .out2(Tile_X2Y3_out2),
    .out3(Tile_X2Y3_out3),
    .in0(Tile_X2Y2_out2),
    .in1(Tile_X1Y3_out3),
    .in2(Tile_X2Y4_out0),
    .in3(Tile_X3Y3_out1),
    .UserCLK(Tile_X2Y4_UserCLK),
    .UserCLK_o(Tile_X2Y3_UserCLK_o),
    .FrameData(Tile_X1Y3_FrameData),
    .FrameData_o(Tile_X2Y3_FrameData),
    .FrameStrobe(Tile_X2Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y3_FrameStrobe)
);

PE #() PE_Tile_X3Y3 (
    .out0(Tile_X3Y3_out0),
    .out1(Tile_X3Y3_out1),
    .out2(Tile_X3Y3_out2),
    .out3(Tile_X3Y3_out3),
    .in0(Tile_X3Y2_out2),
    .in1(Tile_X2Y3_out3),
    .in2(Tile_X3Y4_out0),
    .in3(Tile_X4Y3_out1),
    .UserCLK(Tile_X3Y4_UserCLK),
    .UserCLK_o(Tile_X3Y3_UserCLK_o),
    .FrameData(Tile_X2Y3_FrameData),
    .FrameData_o(Tile_X3Y3_FrameData),
    .FrameStrobe(Tile_X3Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y3_FrameStrobe)
);

PE #() PE_Tile_X4Y3 (
    .out0(Tile_X4Y3_out0),
    .out1(Tile_X4Y3_out1),
    .out2(Tile_X4Y3_out2),
    .out3(Tile_X4Y3_out3),
    .in0(Tile_X4Y2_out2),
    .in1(Tile_X3Y3_out3),
    .in2(Tile_X4Y4_out0),
    .in3(Tile_X5Y3_out1),
    .UserCLK(Tile_X4Y4_UserCLK),
    .UserCLK_o(Tile_X4Y3_UserCLK_o),
    .FrameData(Tile_X3Y3_FrameData),
    .FrameData_o(Tile_X4Y3_FrameData),
    .FrameStrobe(Tile_X4Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y3_FrameStrobe)
);

E_IO #() E_IO_Tile_X5Y3 (
    .out1(Tile_X5Y3_out1),
    .out3(Tile_X5Y3_out3),
    .in1(Tile_X4Y3_out3),
    .E_in(Tile_X5Y3_in),
    .E_out(Tile_X5Y3_out),
    .UserCLK(Tile_X5Y4_UserCLK),
    .UserCLK_o(Tile_X5Y3_UserCLK_o),
    .FrameData(Tile_X4Y3_FrameData),
    .FrameData_o(Tile_X5Y3_FrameData),
    .FrameStrobe(Tile_X5Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y3_FrameStrobe)
);

W_IO #() W_IO_Tile_X0Y4 (
    .out1(Tile_X0Y4_out1),
    .out3(Tile_X0Y4_out3),
    .in3(Tile_X1Y4_out1),
    .W_in(Tile_X0Y4_in),
    .W_out(Tile_X0Y4_out),
    .UserCLK(Tile_X0Y5_UserCLK),
    .UserCLK_o(Tile_X0Y4_UserCLK_o),
    .FrameData(Row4_FrameData),
    .FrameData_o(Tile_X0Y4_FrameData),
    .FrameStrobe(Tile_X0Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y4_FrameStrobe)
);

PE #() PE_Tile_X1Y4 (
    .out0(Tile_X1Y4_out0),
    .out1(Tile_X1Y4_out1),
    .out2(Tile_X1Y4_out2),
    .out3(Tile_X1Y4_out3),
    .in0(Tile_X1Y3_out2),
    .in1(Tile_X0Y4_out3),
    .in2(Tile_X1Y5_out0),
    .in3(Tile_X2Y4_out1),
    .UserCLK(Tile_X1Y5_UserCLK),
    .UserCLK_o(Tile_X1Y4_UserCLK_o),
    .FrameData(Tile_X0Y4_FrameData),
    .FrameData_o(Tile_X1Y4_FrameData),
    .FrameStrobe(Tile_X1Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y4_FrameStrobe)
);

PE #() PE_Tile_X2Y4 (
    .out0(Tile_X2Y4_out0),
    .out1(Tile_X2Y4_out1),
    .out2(Tile_X2Y4_out2),
    .out3(Tile_X2Y4_out3),
    .in0(Tile_X2Y3_out2),
    .in1(Tile_X1Y4_out3),
    .in2(Tile_X2Y5_out0),
    .in3(Tile_X3Y4_out1),
    .UserCLK(Tile_X2Y5_UserCLK),
    .UserCLK_o(Tile_X2Y4_UserCLK_o),
    .FrameData(Tile_X1Y4_FrameData),
    .FrameData_o(Tile_X2Y4_FrameData),
    .FrameStrobe(Tile_X2Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y4_FrameStrobe)
);

PE #() PE_Tile_X3Y4 (
    .out0(Tile_X3Y4_out0),
    .out1(Tile_X3Y4_out1),
    .out2(Tile_X3Y4_out2),
    .out3(Tile_X3Y4_out3),
    .in0(Tile_X3Y3_out2),
    .in1(Tile_X2Y4_out3),
    .in2(Tile_X3Y5_out0),
    .in3(Tile_X4Y4_out1),
    .UserCLK(Tile_X3Y5_UserCLK),
    .UserCLK_o(Tile_X3Y4_UserCLK_o),
    .FrameData(Tile_X2Y4_FrameData),
    .FrameData_o(Tile_X3Y4_FrameData),
    .FrameStrobe(Tile_X3Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y4_FrameStrobe)
);

PE #() PE_Tile_X4Y4 (
    .out0(Tile_X4Y4_out0),
    .out1(Tile_X4Y4_out1),
    .out2(Tile_X4Y4_out2),
    .out3(Tile_X4Y4_out3),
    .in0(Tile_X4Y3_out2),
    .in1(Tile_X3Y4_out3),
    .in2(Tile_X4Y5_out0),
    .in3(Tile_X5Y4_out1),
    .UserCLK(Tile_X4Y5_UserCLK),
    .UserCLK_o(Tile_X4Y4_UserCLK_o),
    .FrameData(Tile_X3Y4_FrameData),
    .FrameData_o(Tile_X4Y4_FrameData),
    .FrameStrobe(Tile_X4Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y4_FrameStrobe)
);

E_IO #() E_IO_Tile_X5Y4 (
    .out1(Tile_X5Y4_out1),
    .out3(Tile_X5Y4_out3),
    .in1(Tile_X4Y4_out3),
    .E_in(Tile_X5Y4_in),
    .E_out(Tile_X5Y4_out),
    .UserCLK(Tile_X5Y5_UserCLK),
    .UserCLK_o(Tile_X5Y4_UserCLK_o),
    .FrameData(Tile_X4Y4_FrameData),
    .FrameData_o(Tile_X5Y4_FrameData),
    .FrameStrobe(Tile_X5Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y4_FrameStrobe)
);

EmptyTile #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X0Y5 (
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X0Y5_UserCLK_o),
    .FrameData(Row5_FrameData),
    .FrameData_o(Tile_X0Y5_FrameData),
    .FrameStrobe(Col0_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y5_FrameStrobe)
);

S_IO #() S_IO_Tile_X1Y5 (
    .out0(Tile_X1Y5_out0),
    .out2(Tile_X1Y5_out2),
    .in0(Tile_X1Y4_out2),
    .S_in(Tile_X1Y5_in),
    .S_out(Tile_X1Y5_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X1Y5_UserCLK_o),
    .FrameData(Tile_X0Y5_FrameData),
    .FrameData_o(Tile_X1Y5_FrameData),
    .FrameStrobe(Col1_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y5_FrameStrobe)
);

S_IO #() S_IO_Tile_X2Y5 (
    .out0(Tile_X2Y5_out0),
    .out2(Tile_X2Y5_out2),
    .in0(Tile_X2Y4_out2),
    .S_in(Tile_X2Y5_in),
    .S_out(Tile_X2Y5_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X2Y5_UserCLK_o),
    .FrameData(Tile_X1Y5_FrameData),
    .FrameData_o(Tile_X2Y5_FrameData),
    .FrameStrobe(Col2_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y5_FrameStrobe)
);

S_IO #() S_IO_Tile_X3Y5 (
    .out0(Tile_X3Y5_out0),
    .out2(Tile_X3Y5_out2),
    .in0(Tile_X3Y4_out2),
    .S_in(Tile_X3Y5_in),
    .S_out(Tile_X3Y5_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X3Y5_UserCLK_o),
    .FrameData(Tile_X2Y5_FrameData),
    .FrameData_o(Tile_X3Y5_FrameData),
    .FrameStrobe(Col3_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y5_FrameStrobe)
);

S_IO #() S_IO_Tile_X4Y5 (
    .out0(Tile_X4Y5_out0),
    .out2(Tile_X4Y5_out2),
    .in0(Tile_X4Y4_out2),
    .S_in(Tile_X4Y5_in),
    .S_out(Tile_X4Y5_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X4Y5_UserCLK_o),
    .FrameData(Tile_X3Y5_FrameData),
    .FrameData_o(Tile_X4Y5_FrameData),
    .FrameStrobe(Col4_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y5_FrameStrobe)
);

EmptyTile #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X5Y5 (
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X5Y5_UserCLK_o),
    .FrameData(Tile_X4Y5_FrameData),
    .FrameData_o(Tile_X5Y5_FrameData),
    .FrameStrobe(Col5_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y5_FrameStrobe)
);

endmodule
