module hycube #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    // Emulation parameter
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = ""
)
(
    input wire[31:0] Tile_X1Y7_N_in,
    output reg[31:0] Tile_X1Y7_N_out,
    input wire[31:0] Tile_X2Y7_N_in,
    output reg[31:0] Tile_X2Y7_N_out,
    input wire[31:0] Tile_X3Y7_N_in,
    output reg[31:0] Tile_X3Y7_N_out,
    input wire[31:0] Tile_X4Y7_N_in,
    output reg[31:0] Tile_X4Y7_N_out,
    input wire[31:0] Tile_X0Y6_W_in,
    output reg[31:0] Tile_X0Y6_W_out,
    input wire[31:0] Tile_X0Y5_W_in,
    output reg[31:0] Tile_X0Y5_W_out,
    input wire[31:0] Tile_X0Y4_W_in,
    output reg[31:0] Tile_X0Y4_W_out,
    input wire[31:0] Tile_X0Y3_W_in,
    output reg[31:0] Tile_X0Y3_W_out,
    input wire[31:0] Tile_X0Y2_W_in,
    output reg[31:0] Tile_X0Y2_W_out,
    input wire[31:0] Tile_X0Y1_W_in,
    output reg[31:0] Tile_X0Y1_W_out,
    input wire[31:0] Tile_X1Y0_S_in,
    output reg[31:0] Tile_X1Y0_S_out,
    input wire[31:0] Tile_X2Y0_S_in,
    output reg[31:0] Tile_X2Y0_S_out,
    input wire[31:0] Tile_X3Y0_S_in,
    output reg[31:0] Tile_X3Y0_S_out,
    input wire[31:0] Tile_X4Y0_S_in,
    output reg[31:0] Tile_X4Y0_S_out,
    input wire[FrameBitsPerRow * 8 - 1:0] FrameData,
    input wire[MaxFramesPerCol * 6 - 1:0] FrameStrobe,
    input wire UserCLK
);

// User Clock wire
reg Tile_X0Y8_UserCLK;
reg Tile_X0Y7_UserCLK_o;
reg Tile_X1Y8_UserCLK;
reg Tile_X1Y7_UserCLK_o;
reg Tile_X2Y8_UserCLK;
reg Tile_X2Y7_UserCLK_o;
reg Tile_X3Y8_UserCLK;
reg Tile_X3Y7_UserCLK_o;
reg Tile_X4Y8_UserCLK;
reg Tile_X4Y7_UserCLK_o;
reg Tile_X5Y8_UserCLK;
reg Tile_X5Y7_UserCLK_o;
reg Tile_X0Y7_UserCLK;
reg Tile_X0Y6_UserCLK_o;
reg Tile_X1Y7_UserCLK;
reg Tile_X1Y6_UserCLK_o;
reg Tile_X2Y7_UserCLK;
reg Tile_X2Y6_UserCLK_o;
reg Tile_X3Y7_UserCLK;
reg Tile_X3Y6_UserCLK_o;
reg Tile_X4Y7_UserCLK;
reg Tile_X4Y6_UserCLK_o;
reg Tile_X5Y7_UserCLK;
reg Tile_X5Y6_UserCLK_o;
reg Tile_X0Y5_UserCLK_o;
reg Tile_X1Y5_UserCLK_o;
reg Tile_X2Y5_UserCLK_o;
reg Tile_X3Y5_UserCLK_o;
reg Tile_X4Y5_UserCLK_o;
reg Tile_X5Y5_UserCLK_o;
reg Tile_X0Y5_UserCLK;
reg Tile_X0Y4_UserCLK_o;
reg Tile_X1Y5_UserCLK;
reg Tile_X1Y4_UserCLK_o;
reg Tile_X2Y5_UserCLK;
reg Tile_X2Y4_UserCLK_o;
reg Tile_X3Y5_UserCLK;
reg Tile_X3Y4_UserCLK_o;
reg Tile_X4Y5_UserCLK;
reg Tile_X4Y4_UserCLK_o;
reg Tile_X5Y5_UserCLK;
reg Tile_X5Y4_UserCLK_o;
reg Tile_X0Y4_UserCLK;
reg Tile_X0Y3_UserCLK_o;
reg Tile_X1Y4_UserCLK;
reg Tile_X1Y3_UserCLK_o;
reg Tile_X2Y4_UserCLK;
reg Tile_X2Y3_UserCLK_o;
reg Tile_X3Y4_UserCLK;
reg Tile_X3Y3_UserCLK_o;
reg Tile_X4Y4_UserCLK;
reg Tile_X4Y3_UserCLK_o;
reg Tile_X5Y4_UserCLK;
reg Tile_X5Y3_UserCLK_o;
reg Tile_X0Y3_UserCLK;
reg Tile_X0Y2_UserCLK_o;
reg Tile_X1Y3_UserCLK;
reg Tile_X1Y2_UserCLK_o;
reg Tile_X2Y3_UserCLK;
reg Tile_X2Y2_UserCLK_o;
reg Tile_X3Y3_UserCLK;
reg Tile_X3Y2_UserCLK_o;
reg Tile_X4Y3_UserCLK;
reg Tile_X4Y2_UserCLK_o;
reg Tile_X5Y3_UserCLK;
reg Tile_X5Y2_UserCLK_o;
reg Tile_X0Y2_UserCLK;
reg Tile_X0Y1_UserCLK_o;
reg Tile_X1Y2_UserCLK;
reg Tile_X1Y1_UserCLK_o;
reg Tile_X2Y2_UserCLK;
reg Tile_X2Y1_UserCLK_o;
reg Tile_X3Y2_UserCLK;
reg Tile_X3Y1_UserCLK_o;
reg Tile_X4Y2_UserCLK;
reg Tile_X4Y1_UserCLK_o;
reg Tile_X5Y2_UserCLK;
reg Tile_X5Y1_UserCLK_o;
reg Tile_X0Y1_UserCLK;
reg Tile_X0Y0_UserCLK_o;
reg Tile_X1Y1_UserCLK;
reg Tile_X1Y0_UserCLK_o;
reg Tile_X2Y1_UserCLK;
reg Tile_X2Y0_UserCLK_o;
reg Tile_X3Y1_UserCLK;
reg Tile_X3Y0_UserCLK_o;
reg Tile_X4Y1_UserCLK;
reg Tile_X4Y0_UserCLK_o;
reg Tile_X5Y1_UserCLK;
reg Tile_X5Y0_UserCLK_o;

// Frame Data wire
reg [FrameBitsPerRow - 1:0] Tile_X0Y7_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y7_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y7_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y7_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y7_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y7_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y6_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y6_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y6_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y6_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y6_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y6_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y5_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y5_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y5_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y5_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y5_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y5_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y4_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y4_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y4_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y4_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y4_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y4_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X4Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X5Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Row7_FrameData;
reg [FrameBitsPerRow - 1:0] Row6_FrameData;
reg [FrameBitsPerRow - 1:0] Row5_FrameData;
reg [FrameBitsPerRow - 1:0] Row4_FrameData;
reg [FrameBitsPerRow - 1:0] Row3_FrameData;
reg [FrameBitsPerRow - 1:0] Row2_FrameData;
reg [FrameBitsPerRow - 1:0] Row1_FrameData;
reg [FrameBitsPerRow - 1:0] Row0_FrameData;

// Frame Strobe wire
reg [MaxFramesPerCol - 1:0] Tile_X0Y7_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y7_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y7_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y7_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y7_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y7_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y6_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y6_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y6_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y6_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y6_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y6_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y5_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y5_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y5_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y5_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y5_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y5_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y4_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y4_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y4_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y4_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y4_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y4_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X4Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X5Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col4_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col5_FrameStrobe;

// Tile to Tile wire
reg [31:0] Tile_X1Y7_out2;
reg [31:0] Tile_X2Y7_out2;
reg [31:0] Tile_X3Y7_out2;
reg [31:0] Tile_X4Y7_out2;
reg [31:0] Tile_X0Y6_out1;
reg [31:0] Tile_X1Y6_out0;
reg [31:0] Tile_X1Y6_out1;
reg [31:0] Tile_X1Y6_out2;
reg [31:0] Tile_X1Y6_out3;
reg [31:0] Tile_X2Y6_out0;
reg [31:0] Tile_X2Y6_out1;
reg [31:0] Tile_X2Y6_out2;
reg [31:0] Tile_X2Y6_out3;
reg [31:0] Tile_X3Y6_out0;
reg [31:0] Tile_X3Y6_out1;
reg [31:0] Tile_X3Y6_out2;
reg [31:0] Tile_X3Y6_out3;
reg [31:0] Tile_X4Y6_out0;
reg [31:0] Tile_X4Y6_out1;
reg [31:0] Tile_X4Y6_out2;
reg [31:0] Tile_X4Y6_out3;
reg [31:0] Tile_X5Y6_addr_o;
reg [31:0] Tile_X5Y6_out3;
reg [31:0] Tile_X0Y5_out1;
reg [31:0] Tile_X1Y5_out0;
reg [31:0] Tile_X1Y5_out1;
reg [31:0] Tile_X1Y5_out2;
reg [31:0] Tile_X1Y5_out3;
reg [31:0] Tile_X2Y5_out0;
reg [31:0] Tile_X2Y5_out1;
reg [31:0] Tile_X2Y5_out2;
reg [31:0] Tile_X2Y5_out3;
reg [31:0] Tile_X3Y5_out0;
reg [31:0] Tile_X3Y5_out1;
reg [31:0] Tile_X3Y5_out2;
reg [31:0] Tile_X3Y5_out3;
reg [31:0] Tile_X4Y5_out0;
reg [31:0] Tile_X4Y5_out1;
reg [31:0] Tile_X4Y5_out2;
reg [31:0] Tile_X4Y5_out3;
reg [31:0] Tile_X5Y5_out3;
reg [31:0] Tile_X0Y4_out1;
reg [31:0] Tile_X1Y4_out0;
reg [31:0] Tile_X1Y4_out1;
reg [31:0] Tile_X1Y4_out2;
reg [31:0] Tile_X1Y4_out3;
reg [31:0] Tile_X2Y4_out0;
reg [31:0] Tile_X2Y4_out1;
reg [31:0] Tile_X2Y4_out2;
reg [31:0] Tile_X2Y4_out3;
reg [31:0] Tile_X3Y4_out0;
reg [31:0] Tile_X3Y4_out1;
reg [31:0] Tile_X3Y4_out2;
reg [31:0] Tile_X3Y4_out3;
reg [31:0] Tile_X4Y4_out0;
reg [31:0] Tile_X4Y4_out1;
reg [31:0] Tile_X4Y4_out2;
reg [31:0] Tile_X4Y4_out3;
reg [31:0] Tile_X5Y4_addr_o;
reg [31:0] Tile_X5Y4_out3;
reg [31:0] Tile_X0Y3_out1;
reg [31:0] Tile_X1Y3_out0;
reg [31:0] Tile_X1Y3_out1;
reg [31:0] Tile_X1Y3_out2;
reg [31:0] Tile_X1Y3_out3;
reg [31:0] Tile_X2Y3_out0;
reg [31:0] Tile_X2Y3_out1;
reg [31:0] Tile_X2Y3_out2;
reg [31:0] Tile_X2Y3_out3;
reg [31:0] Tile_X3Y3_out0;
reg [31:0] Tile_X3Y3_out1;
reg [31:0] Tile_X3Y3_out2;
reg [31:0] Tile_X3Y3_out3;
reg [31:0] Tile_X4Y3_out0;
reg [31:0] Tile_X4Y3_out1;
reg [31:0] Tile_X4Y3_out2;
reg [31:0] Tile_X4Y3_out3;
reg [31:0] Tile_X5Y3_out3;
reg [31:0] Tile_X0Y2_out1;
reg [31:0] Tile_X1Y2_out0;
reg [31:0] Tile_X1Y2_out1;
reg [31:0] Tile_X1Y2_out2;
reg [31:0] Tile_X1Y2_out3;
reg [31:0] Tile_X2Y2_out0;
reg [31:0] Tile_X2Y2_out1;
reg [31:0] Tile_X2Y2_out2;
reg [31:0] Tile_X2Y2_out3;
reg [31:0] Tile_X3Y2_out0;
reg [31:0] Tile_X3Y2_out1;
reg [31:0] Tile_X3Y2_out2;
reg [31:0] Tile_X3Y2_out3;
reg [31:0] Tile_X4Y2_out0;
reg [31:0] Tile_X4Y2_out1;
reg [31:0] Tile_X4Y2_out2;
reg [31:0] Tile_X4Y2_out3;
reg [31:0] Tile_X5Y2_addr_o;
reg [31:0] Tile_X5Y2_out3;
reg [31:0] Tile_X0Y1_out1;
reg [31:0] Tile_X1Y1_out0;
reg [31:0] Tile_X1Y1_out1;
reg [31:0] Tile_X1Y1_out2;
reg [31:0] Tile_X1Y1_out3;
reg [31:0] Tile_X2Y1_out0;
reg [31:0] Tile_X2Y1_out1;
reg [31:0] Tile_X2Y1_out2;
reg [31:0] Tile_X2Y1_out3;
reg [31:0] Tile_X3Y1_out0;
reg [31:0] Tile_X3Y1_out1;
reg [31:0] Tile_X3Y1_out2;
reg [31:0] Tile_X3Y1_out3;
reg [31:0] Tile_X4Y1_out0;
reg [31:0] Tile_X4Y1_out1;
reg [31:0] Tile_X4Y1_out2;
reg [31:0] Tile_X4Y1_out3;
reg [31:0] Tile_X5Y1_out3;
reg [31:0] Tile_X1Y0_out0;
reg [31:0] Tile_X2Y0_out0;
reg [31:0] Tile_X3Y0_out0;
reg [31:0] Tile_X4Y0_out0;

// Frame Data connection
assign Row7_FrameData = FrameData[FrameBitsPerRow * 8 - 1:FrameBitsPerRow * 7];
assign Row6_FrameData = FrameData[FrameBitsPerRow * 7 - 1:FrameBitsPerRow * 6];
assign Row5_FrameData = FrameData[FrameBitsPerRow * 6 - 1:FrameBitsPerRow * 5];
assign Row4_FrameData = FrameData[FrameBitsPerRow * 5 - 1:FrameBitsPerRow * 4];
assign Row3_FrameData = FrameData[FrameBitsPerRow * 4 - 1:FrameBitsPerRow * 3];
assign Row2_FrameData = FrameData[FrameBitsPerRow * 3 - 1:FrameBitsPerRow * 2];
assign Row1_FrameData = FrameData[FrameBitsPerRow * 2 - 1:FrameBitsPerRow * 1];
assign Row0_FrameData = FrameData[FrameBitsPerRow * 1 - 1:FrameBitsPerRow * 0];

// Frame Strobe connection
assign Tile_X0Y6_FrameStrobe = FrameStrobe[MaxFramesPerCol * 1 - 1:MaxFramesPerCol * 0];
assign Tile_X1Y6_FrameStrobe = FrameStrobe[MaxFramesPerCol * 2 - 1:MaxFramesPerCol * 1];
assign Tile_X2Y6_FrameStrobe = FrameStrobe[MaxFramesPerCol * 3 - 1:MaxFramesPerCol * 2];
assign Tile_X3Y6_FrameStrobe = FrameStrobe[MaxFramesPerCol * 4 - 1:MaxFramesPerCol * 3];
assign Tile_X4Y6_FrameStrobe = FrameStrobe[MaxFramesPerCol * 5 - 1:MaxFramesPerCol * 4];
assign Tile_X5Y6_FrameStrobe = FrameStrobe[MaxFramesPerCol * 6 - 1:MaxFramesPerCol * 5];
// Create Tiles
EmptyTile #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X0Y7 (
    .UserCLK(Tile_X0Y8_UserCLK),
    .UserCLK_o(Tile_X0Y7_UserCLK_o),
    .FrameData(Row7_FrameData),
    .FrameData_o(Tile_X0Y7_FrameData),
    .FrameStrobe(Col0_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y7_FrameStrobe)
);

N_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(3'd7)
) N_IO_Tile_X1Y7 (
    .out2(Tile_X1Y7_out2),
    .N_in(Tile_X1Y7_N_in),
    .N_out(Tile_X1Y7_N_out),
    .UserCLK(Tile_X1Y8_UserCLK),
    .UserCLK_o(Tile_X1Y7_UserCLK_o),
    .FrameData(Tile_X0Y7_FrameData),
    .FrameData_o(Tile_X1Y7_FrameData),
    .FrameStrobe(Col1_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y7_FrameStrobe)
);

N_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(3'd7)
) N_IO_Tile_X2Y7 (
    .out2(Tile_X2Y7_out2),
    .N_in(Tile_X2Y7_N_in),
    .N_out(Tile_X2Y7_N_out),
    .UserCLK(Tile_X2Y8_UserCLK),
    .UserCLK_o(Tile_X2Y7_UserCLK_o),
    .FrameData(Tile_X1Y7_FrameData),
    .FrameData_o(Tile_X2Y7_FrameData),
    .FrameStrobe(Col2_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y7_FrameStrobe)
);

N_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(3'd7)
) N_IO_Tile_X3Y7 (
    .out2(Tile_X3Y7_out2),
    .N_in(Tile_X3Y7_N_in),
    .N_out(Tile_X3Y7_N_out),
    .UserCLK(Tile_X3Y8_UserCLK),
    .UserCLK_o(Tile_X3Y7_UserCLK_o),
    .FrameData(Tile_X2Y7_FrameData),
    .FrameData_o(Tile_X3Y7_FrameData),
    .FrameStrobe(Col3_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y7_FrameStrobe)
);

N_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(3'd7)
) N_IO_Tile_X4Y7 (
    .out2(Tile_X4Y7_out2),
    .N_in(Tile_X4Y7_N_in),
    .N_out(Tile_X4Y7_N_out),
    .UserCLK(Tile_X4Y8_UserCLK),
    .UserCLK_o(Tile_X4Y7_UserCLK_o),
    .FrameData(Tile_X3Y7_FrameData),
    .FrameData_o(Tile_X4Y7_FrameData),
    .FrameStrobe(Col4_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y7_FrameStrobe)
);

EmptyTile #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X5Y7 (
    .UserCLK(Tile_X5Y8_UserCLK),
    .UserCLK_o(Tile_X5Y7_UserCLK_o),
    .FrameData(Tile_X4Y7_FrameData),
    .FrameData_o(Tile_X5Y7_FrameData),
    .FrameStrobe(Col5_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y7_FrameStrobe)
);

W_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd0),
    .Y_CORD(3'd6)
) W_IO_Tile_X0Y6 (
    .out1(Tile_X0Y6_out1),
    .in1(Tile_X1Y6_out3),
    .W_in(Tile_X0Y6_W_in),
    .W_out(Tile_X0Y6_W_out),
    .UserCLK(Tile_X0Y7_UserCLK),
    .UserCLK_o(Tile_X0Y6_UserCLK_o),
    .FrameData(Row6_FrameData),
    .FrameData_o(Tile_X0Y6_FrameData),
    .FrameStrobe(Tile_X0Y7_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y6_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(3'd6)
) PE_Tile_X1Y6 (
    .out0(Tile_X1Y6_out0),
    .out1(Tile_X1Y6_out1),
    .out2(Tile_X1Y6_out2),
    .out3(Tile_X1Y6_out3),
    .in0(Tile_X1Y7_out2),
    .in1(Tile_X2Y6_out3),
    .in3(Tile_X0Y6_out1),
    .UserCLK(Tile_X1Y7_UserCLK),
    .UserCLK_o(Tile_X1Y6_UserCLK_o),
    .FrameData(Tile_X0Y6_FrameData),
    .FrameData_o(Tile_X1Y6_FrameData),
    .FrameStrobe(Tile_X1Y7_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y6_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(3'd6)
) PE_Tile_X2Y6 (
    .out0(Tile_X2Y6_out0),
    .out1(Tile_X2Y6_out1),
    .out2(Tile_X2Y6_out2),
    .out3(Tile_X2Y6_out3),
    .in0(Tile_X2Y7_out2),
    .in1(Tile_X3Y6_out3),
    .in3(Tile_X1Y6_out1),
    .UserCLK(Tile_X2Y7_UserCLK),
    .UserCLK_o(Tile_X2Y6_UserCLK_o),
    .FrameData(Tile_X1Y6_FrameData),
    .FrameData_o(Tile_X2Y6_FrameData),
    .FrameStrobe(Tile_X2Y7_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y6_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(3'd6)
) PE_Tile_X3Y6 (
    .out0(Tile_X3Y6_out0),
    .out1(Tile_X3Y6_out1),
    .out2(Tile_X3Y6_out2),
    .out3(Tile_X3Y6_out3),
    .in0(Tile_X3Y7_out2),
    .in1(Tile_X4Y6_out3),
    .in3(Tile_X2Y6_out1),
    .UserCLK(Tile_X3Y7_UserCLK),
    .UserCLK_o(Tile_X3Y6_UserCLK_o),
    .FrameData(Tile_X2Y6_FrameData),
    .FrameData_o(Tile_X3Y6_FrameData),
    .FrameStrobe(Tile_X3Y7_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y6_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(3'd6)
) PE_Tile_X4Y6 (
    .out0(Tile_X4Y6_out0),
    .out1(Tile_X4Y6_out1),
    .out2(Tile_X4Y6_out2),
    .out3(Tile_X4Y6_out3),
    .in0(Tile_X4Y7_out2),
    .in1(Tile_X5Y6_out3),
    .in3(Tile_X3Y6_out1),
    .UserCLK(Tile_X4Y7_UserCLK),
    .UserCLK_o(Tile_X4Y6_UserCLK_o),
    .FrameData(Tile_X3Y6_FrameData),
    .FrameData_o(Tile_X4Y6_FrameData),
    .FrameStrobe(Tile_X4Y7_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y6_FrameStrobe)
);

E_Mem_top #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd5),
    .Y_CORD(3'd6)
) E_Mem_top_Tile_X5Y6 (
    .addr_o(Tile_X5Y6_addr_o),
    .out3(Tile_X5Y6_out3),
    .in3(Tile_X4Y6_out1),
    .UserCLK(Tile_X5Y7_UserCLK),
    .UserCLK_o(Tile_X5Y6_UserCLK_o),
    .FrameData(Tile_X4Y6_FrameData),
    .FrameData_o(Tile_X5Y6_FrameData),
    .FrameStrobe(Tile_X5Y7_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y6_FrameStrobe)
);

W_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd0),
    .Y_CORD(3'd5)
) W_IO_Tile_X0Y5 (
    .out1(Tile_X0Y5_out1),
    .in1(Tile_X1Y5_out3),
    .W_in(Tile_X0Y5_W_in),
    .W_out(Tile_X0Y5_W_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X0Y5_UserCLK_o),
    .FrameData(Row5_FrameData),
    .FrameData_o(Tile_X0Y5_FrameData),
    .FrameStrobe(Tile_X0Y6_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y5_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(3'd5)
) PE_Tile_X1Y5 (
    .out0(Tile_X1Y5_out0),
    .out1(Tile_X1Y5_out1),
    .out2(Tile_X1Y5_out2),
    .out3(Tile_X1Y5_out3),
    .in0(Tile_X1Y6_out2),
    .in1(Tile_X2Y5_out3),
    .in3(Tile_X0Y5_out1),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X1Y5_UserCLK_o),
    .FrameData(Tile_X0Y5_FrameData),
    .FrameData_o(Tile_X1Y5_FrameData),
    .FrameStrobe(Tile_X1Y6_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y5_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(3'd5)
) PE_Tile_X2Y5 (
    .out0(Tile_X2Y5_out0),
    .out1(Tile_X2Y5_out1),
    .out2(Tile_X2Y5_out2),
    .out3(Tile_X2Y5_out3),
    .in0(Tile_X2Y6_out2),
    .in1(Tile_X3Y5_out3),
    .in3(Tile_X1Y5_out1),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X2Y5_UserCLK_o),
    .FrameData(Tile_X1Y5_FrameData),
    .FrameData_o(Tile_X2Y5_FrameData),
    .FrameStrobe(Tile_X2Y6_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y5_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(3'd5)
) PE_Tile_X3Y5 (
    .out0(Tile_X3Y5_out0),
    .out1(Tile_X3Y5_out1),
    .out2(Tile_X3Y5_out2),
    .out3(Tile_X3Y5_out3),
    .in0(Tile_X3Y6_out2),
    .in1(Tile_X4Y5_out3),
    .in3(Tile_X2Y5_out1),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X3Y5_UserCLK_o),
    .FrameData(Tile_X2Y5_FrameData),
    .FrameData_o(Tile_X3Y5_FrameData),
    .FrameStrobe(Tile_X3Y6_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y5_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(3'd5)
) PE_Tile_X4Y5 (
    .out0(Tile_X4Y5_out0),
    .out1(Tile_X4Y5_out1),
    .out2(Tile_X4Y5_out2),
    .out3(Tile_X4Y5_out3),
    .in0(Tile_X4Y6_out2),
    .in1(Tile_X5Y5_out3),
    .in3(Tile_X3Y5_out1),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X4Y5_UserCLK_o),
    .FrameData(Tile_X3Y5_FrameData),
    .FrameData_o(Tile_X4Y5_FrameData),
    .FrameStrobe(Tile_X4Y6_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y5_FrameStrobe)
);

E_Mem_bot #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd5),
    .Y_CORD(3'd5)
) E_Mem_bot_Tile_X5Y5 (
    .out3(Tile_X5Y5_out3),
    .addr_i(Tile_X5Y6_addr_o),
    .in3(Tile_X4Y5_out1),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X5Y5_UserCLK_o),
    .FrameData(Tile_X4Y5_FrameData),
    .FrameData_o(Tile_X5Y5_FrameData),
    .FrameStrobe(Tile_X5Y6_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y5_FrameStrobe)
);

W_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd0),
    .Y_CORD(3'd4)
) W_IO_Tile_X0Y4 (
    .out1(Tile_X0Y4_out1),
    .in1(Tile_X1Y4_out3),
    .W_in(Tile_X0Y4_W_in),
    .W_out(Tile_X0Y4_W_out),
    .UserCLK(Tile_X0Y5_UserCLK),
    .UserCLK_o(Tile_X0Y4_UserCLK_o),
    .FrameData(Row4_FrameData),
    .FrameData_o(Tile_X0Y4_FrameData),
    .FrameStrobe(Tile_X0Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y4_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(3'd4)
) PE_Tile_X1Y4 (
    .out0(Tile_X1Y4_out0),
    .out1(Tile_X1Y4_out1),
    .out2(Tile_X1Y4_out2),
    .out3(Tile_X1Y4_out3),
    .in0(Tile_X1Y5_out2),
    .in1(Tile_X2Y4_out3),
    .in3(Tile_X0Y4_out1),
    .UserCLK(Tile_X1Y5_UserCLK),
    .UserCLK_o(Tile_X1Y4_UserCLK_o),
    .FrameData(Tile_X0Y4_FrameData),
    .FrameData_o(Tile_X1Y4_FrameData),
    .FrameStrobe(Tile_X1Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y4_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(3'd4)
) PE_Tile_X2Y4 (
    .out0(Tile_X2Y4_out0),
    .out1(Tile_X2Y4_out1),
    .out2(Tile_X2Y4_out2),
    .out3(Tile_X2Y4_out3),
    .in0(Tile_X2Y5_out2),
    .in1(Tile_X3Y4_out3),
    .in3(Tile_X1Y4_out1),
    .UserCLK(Tile_X2Y5_UserCLK),
    .UserCLK_o(Tile_X2Y4_UserCLK_o),
    .FrameData(Tile_X1Y4_FrameData),
    .FrameData_o(Tile_X2Y4_FrameData),
    .FrameStrobe(Tile_X2Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y4_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(3'd4)
) PE_Tile_X3Y4 (
    .out0(Tile_X3Y4_out0),
    .out1(Tile_X3Y4_out1),
    .out2(Tile_X3Y4_out2),
    .out3(Tile_X3Y4_out3),
    .in0(Tile_X3Y5_out2),
    .in1(Tile_X4Y4_out3),
    .in3(Tile_X2Y4_out1),
    .UserCLK(Tile_X3Y5_UserCLK),
    .UserCLK_o(Tile_X3Y4_UserCLK_o),
    .FrameData(Tile_X2Y4_FrameData),
    .FrameData_o(Tile_X3Y4_FrameData),
    .FrameStrobe(Tile_X3Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y4_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(3'd4)
) PE_Tile_X4Y4 (
    .out0(Tile_X4Y4_out0),
    .out1(Tile_X4Y4_out1),
    .out2(Tile_X4Y4_out2),
    .out3(Tile_X4Y4_out3),
    .in0(Tile_X4Y5_out2),
    .in1(Tile_X5Y4_out3),
    .in3(Tile_X3Y4_out1),
    .UserCLK(Tile_X4Y5_UserCLK),
    .UserCLK_o(Tile_X4Y4_UserCLK_o),
    .FrameData(Tile_X3Y4_FrameData),
    .FrameData_o(Tile_X4Y4_FrameData),
    .FrameStrobe(Tile_X4Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y4_FrameStrobe)
);

E_Mem_top #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd5),
    .Y_CORD(3'd4)
) E_Mem_top_Tile_X5Y4 (
    .addr_o(Tile_X5Y4_addr_o),
    .out3(Tile_X5Y4_out3),
    .in3(Tile_X4Y4_out1),
    .UserCLK(Tile_X5Y5_UserCLK),
    .UserCLK_o(Tile_X5Y4_UserCLK_o),
    .FrameData(Tile_X4Y4_FrameData),
    .FrameData_o(Tile_X5Y4_FrameData),
    .FrameStrobe(Tile_X5Y5_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y4_FrameStrobe)
);

W_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd0),
    .Y_CORD(2'd3)
) W_IO_Tile_X0Y3 (
    .out1(Tile_X0Y3_out1),
    .in1(Tile_X1Y3_out3),
    .W_in(Tile_X0Y3_W_in),
    .W_out(Tile_X0Y3_W_out),
    .UserCLK(Tile_X0Y4_UserCLK),
    .UserCLK_o(Tile_X0Y3_UserCLK_o),
    .FrameData(Row3_FrameData),
    .FrameData_o(Tile_X0Y3_FrameData),
    .FrameStrobe(Tile_X0Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y3_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(2'd3)
) PE_Tile_X1Y3 (
    .out0(Tile_X1Y3_out0),
    .out1(Tile_X1Y3_out1),
    .out2(Tile_X1Y3_out2),
    .out3(Tile_X1Y3_out3),
    .in0(Tile_X1Y4_out2),
    .in1(Tile_X2Y3_out3),
    .in3(Tile_X0Y3_out1),
    .UserCLK(Tile_X1Y4_UserCLK),
    .UserCLK_o(Tile_X1Y3_UserCLK_o),
    .FrameData(Tile_X0Y3_FrameData),
    .FrameData_o(Tile_X1Y3_FrameData),
    .FrameStrobe(Tile_X1Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y3_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(2'd3)
) PE_Tile_X2Y3 (
    .out0(Tile_X2Y3_out0),
    .out1(Tile_X2Y3_out1),
    .out2(Tile_X2Y3_out2),
    .out3(Tile_X2Y3_out3),
    .in0(Tile_X2Y4_out2),
    .in1(Tile_X3Y3_out3),
    .in3(Tile_X1Y3_out1),
    .UserCLK(Tile_X2Y4_UserCLK),
    .UserCLK_o(Tile_X2Y3_UserCLK_o),
    .FrameData(Tile_X1Y3_FrameData),
    .FrameData_o(Tile_X2Y3_FrameData),
    .FrameStrobe(Tile_X2Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y3_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(2'd3)
) PE_Tile_X3Y3 (
    .out0(Tile_X3Y3_out0),
    .out1(Tile_X3Y3_out1),
    .out2(Tile_X3Y3_out2),
    .out3(Tile_X3Y3_out3),
    .in0(Tile_X3Y4_out2),
    .in1(Tile_X4Y3_out3),
    .in3(Tile_X2Y3_out1),
    .UserCLK(Tile_X3Y4_UserCLK),
    .UserCLK_o(Tile_X3Y3_UserCLK_o),
    .FrameData(Tile_X2Y3_FrameData),
    .FrameData_o(Tile_X3Y3_FrameData),
    .FrameStrobe(Tile_X3Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y3_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(2'd3)
) PE_Tile_X4Y3 (
    .out0(Tile_X4Y3_out0),
    .out1(Tile_X4Y3_out1),
    .out2(Tile_X4Y3_out2),
    .out3(Tile_X4Y3_out3),
    .in0(Tile_X4Y4_out2),
    .in1(Tile_X5Y3_out3),
    .in3(Tile_X3Y3_out1),
    .UserCLK(Tile_X4Y4_UserCLK),
    .UserCLK_o(Tile_X4Y3_UserCLK_o),
    .FrameData(Tile_X3Y3_FrameData),
    .FrameData_o(Tile_X4Y3_FrameData),
    .FrameStrobe(Tile_X4Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y3_FrameStrobe)
);

E_Mem_bot #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd5),
    .Y_CORD(2'd3)
) E_Mem_bot_Tile_X5Y3 (
    .out3(Tile_X5Y3_out3),
    .addr_i(Tile_X5Y4_addr_o),
    .in3(Tile_X4Y3_out1),
    .UserCLK(Tile_X5Y4_UserCLK),
    .UserCLK_o(Tile_X5Y3_UserCLK_o),
    .FrameData(Tile_X4Y3_FrameData),
    .FrameData_o(Tile_X5Y3_FrameData),
    .FrameStrobe(Tile_X5Y4_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y3_FrameStrobe)
);

W_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd0),
    .Y_CORD(2'd2)
) W_IO_Tile_X0Y2 (
    .out1(Tile_X0Y2_out1),
    .in1(Tile_X1Y2_out3),
    .W_in(Tile_X0Y2_W_in),
    .W_out(Tile_X0Y2_W_out),
    .UserCLK(Tile_X0Y3_UserCLK),
    .UserCLK_o(Tile_X0Y2_UserCLK_o),
    .FrameData(Row2_FrameData),
    .FrameData_o(Tile_X0Y2_FrameData),
    .FrameStrobe(Tile_X0Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y2_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(2'd2)
) PE_Tile_X1Y2 (
    .out0(Tile_X1Y2_out0),
    .out1(Tile_X1Y2_out1),
    .out2(Tile_X1Y2_out2),
    .out3(Tile_X1Y2_out3),
    .in0(Tile_X1Y3_out2),
    .in1(Tile_X2Y2_out3),
    .in3(Tile_X0Y2_out1),
    .UserCLK(Tile_X1Y3_UserCLK),
    .UserCLK_o(Tile_X1Y2_UserCLK_o),
    .FrameData(Tile_X0Y2_FrameData),
    .FrameData_o(Tile_X1Y2_FrameData),
    .FrameStrobe(Tile_X1Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y2_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(2'd2)
) PE_Tile_X2Y2 (
    .out0(Tile_X2Y2_out0),
    .out1(Tile_X2Y2_out1),
    .out2(Tile_X2Y2_out2),
    .out3(Tile_X2Y2_out3),
    .in0(Tile_X2Y3_out2),
    .in1(Tile_X3Y2_out3),
    .in3(Tile_X1Y2_out1),
    .UserCLK(Tile_X2Y3_UserCLK),
    .UserCLK_o(Tile_X2Y2_UserCLK_o),
    .FrameData(Tile_X1Y2_FrameData),
    .FrameData_o(Tile_X2Y2_FrameData),
    .FrameStrobe(Tile_X2Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y2_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(2'd2)
) PE_Tile_X3Y2 (
    .out0(Tile_X3Y2_out0),
    .out1(Tile_X3Y2_out1),
    .out2(Tile_X3Y2_out2),
    .out3(Tile_X3Y2_out3),
    .in0(Tile_X3Y3_out2),
    .in1(Tile_X4Y2_out3),
    .in3(Tile_X2Y2_out1),
    .UserCLK(Tile_X3Y3_UserCLK),
    .UserCLK_o(Tile_X3Y2_UserCLK_o),
    .FrameData(Tile_X2Y2_FrameData),
    .FrameData_o(Tile_X3Y2_FrameData),
    .FrameStrobe(Tile_X3Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y2_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(2'd2)
) PE_Tile_X4Y2 (
    .out0(Tile_X4Y2_out0),
    .out1(Tile_X4Y2_out1),
    .out2(Tile_X4Y2_out2),
    .out3(Tile_X4Y2_out3),
    .in0(Tile_X4Y3_out2),
    .in1(Tile_X5Y2_out3),
    .in3(Tile_X3Y2_out1),
    .UserCLK(Tile_X4Y3_UserCLK),
    .UserCLK_o(Tile_X4Y2_UserCLK_o),
    .FrameData(Tile_X3Y2_FrameData),
    .FrameData_o(Tile_X4Y2_FrameData),
    .FrameStrobe(Tile_X4Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y2_FrameStrobe)
);

E_Mem_top #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd5),
    .Y_CORD(2'd2)
) E_Mem_top_Tile_X5Y2 (
    .addr_o(Tile_X5Y2_addr_o),
    .out3(Tile_X5Y2_out3),
    .in3(Tile_X4Y2_out1),
    .UserCLK(Tile_X5Y3_UserCLK),
    .UserCLK_o(Tile_X5Y2_UserCLK_o),
    .FrameData(Tile_X4Y2_FrameData),
    .FrameData_o(Tile_X5Y2_FrameData),
    .FrameStrobe(Tile_X5Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y2_FrameStrobe)
);

W_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd0),
    .Y_CORD(1'd1)
) W_IO_Tile_X0Y1 (
    .out1(Tile_X0Y1_out1),
    .in1(Tile_X1Y1_out3),
    .W_in(Tile_X0Y1_W_in),
    .W_out(Tile_X0Y1_W_out),
    .UserCLK(Tile_X0Y2_UserCLK),
    .UserCLK_o(Tile_X0Y1_UserCLK_o),
    .FrameData(Row1_FrameData),
    .FrameData_o(Tile_X0Y1_FrameData),
    .FrameStrobe(Tile_X0Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y1_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(1'd1)
) PE_Tile_X1Y1 (
    .out0(Tile_X1Y1_out0),
    .out1(Tile_X1Y1_out1),
    .out2(Tile_X1Y1_out2),
    .out3(Tile_X1Y1_out3),
    .in0(Tile_X1Y2_out2),
    .in1(Tile_X2Y1_out3),
    .in2(Tile_X1Y0_out0),
    .in3(Tile_X0Y1_out1),
    .UserCLK(Tile_X1Y2_UserCLK),
    .UserCLK_o(Tile_X1Y1_UserCLK_o),
    .FrameData(Tile_X0Y1_FrameData),
    .FrameData_o(Tile_X1Y1_FrameData),
    .FrameStrobe(Tile_X1Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y1_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(1'd1)
) PE_Tile_X2Y1 (
    .out0(Tile_X2Y1_out0),
    .out1(Tile_X2Y1_out1),
    .out2(Tile_X2Y1_out2),
    .out3(Tile_X2Y1_out3),
    .in0(Tile_X2Y2_out2),
    .in1(Tile_X3Y1_out3),
    .in2(Tile_X2Y0_out0),
    .in3(Tile_X1Y1_out1),
    .UserCLK(Tile_X2Y2_UserCLK),
    .UserCLK_o(Tile_X2Y1_UserCLK_o),
    .FrameData(Tile_X1Y1_FrameData),
    .FrameData_o(Tile_X2Y1_FrameData),
    .FrameStrobe(Tile_X2Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y1_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(1'd1)
) PE_Tile_X3Y1 (
    .out0(Tile_X3Y1_out0),
    .out1(Tile_X3Y1_out1),
    .out2(Tile_X3Y1_out2),
    .out3(Tile_X3Y1_out3),
    .in0(Tile_X3Y2_out2),
    .in1(Tile_X4Y1_out3),
    .in2(Tile_X3Y0_out0),
    .in3(Tile_X2Y1_out1),
    .UserCLK(Tile_X3Y2_UserCLK),
    .UserCLK_o(Tile_X3Y1_UserCLK_o),
    .FrameData(Tile_X2Y1_FrameData),
    .FrameData_o(Tile_X3Y1_FrameData),
    .FrameStrobe(Tile_X3Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y1_FrameStrobe)
);

PE #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(1'd1)
) PE_Tile_X4Y1 (
    .out0(Tile_X4Y1_out0),
    .out1(Tile_X4Y1_out1),
    .out2(Tile_X4Y1_out2),
    .out3(Tile_X4Y1_out3),
    .in0(Tile_X4Y2_out2),
    .in1(Tile_X5Y1_out3),
    .in2(Tile_X4Y0_out0),
    .in3(Tile_X3Y1_out1),
    .UserCLK(Tile_X4Y2_UserCLK),
    .UserCLK_o(Tile_X4Y1_UserCLK_o),
    .FrameData(Tile_X3Y1_FrameData),
    .FrameData_o(Tile_X4Y1_FrameData),
    .FrameStrobe(Tile_X4Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y1_FrameStrobe)
);

E_Mem_bot #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd5),
    .Y_CORD(1'd1)
) E_Mem_bot_Tile_X5Y1 (
    .out3(Tile_X5Y1_out3),
    .addr_i(Tile_X5Y2_addr_o),
    .in3(Tile_X4Y1_out1),
    .UserCLK(Tile_X5Y2_UserCLK),
    .UserCLK_o(Tile_X5Y1_UserCLK_o),
    .FrameData(Tile_X4Y1_FrameData),
    .FrameData_o(Tile_X5Y1_FrameData),
    .FrameStrobe(Tile_X5Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y1_FrameStrobe)
);

EmptyTile #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X0Y0 (
    .UserCLK(Tile_X0Y1_UserCLK),
    .UserCLK_o(Tile_X0Y0_UserCLK_o),
    .FrameData(Row0_FrameData),
    .FrameData_o(Tile_X0Y0_FrameData),
    .FrameStrobe(Tile_X0Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y0_FrameStrobe)
);

S_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(1'd0)
) S_IO_Tile_X1Y0 (
    .out0(Tile_X1Y0_out0),
    .in0(Tile_X1Y1_out2),
    .S_in(Tile_X1Y0_S_in),
    .S_out(Tile_X1Y0_S_out),
    .UserCLK(Tile_X1Y1_UserCLK),
    .UserCLK_o(Tile_X1Y0_UserCLK_o),
    .FrameData(Tile_X0Y0_FrameData),
    .FrameData_o(Tile_X1Y0_FrameData),
    .FrameStrobe(Tile_X1Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y0_FrameStrobe)
);

S_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(1'd0)
) S_IO_Tile_X2Y0 (
    .out0(Tile_X2Y0_out0),
    .in0(Tile_X2Y1_out2),
    .S_in(Tile_X2Y0_S_in),
    .S_out(Tile_X2Y0_S_out),
    .UserCLK(Tile_X2Y1_UserCLK),
    .UserCLK_o(Tile_X2Y0_UserCLK_o),
    .FrameData(Tile_X1Y0_FrameData),
    .FrameData_o(Tile_X2Y0_FrameData),
    .FrameStrobe(Tile_X2Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y0_FrameStrobe)
);

S_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(1'd0)
) S_IO_Tile_X3Y0 (
    .out0(Tile_X3Y0_out0),
    .in0(Tile_X3Y1_out2),
    .S_in(Tile_X3Y0_S_in),
    .S_out(Tile_X3Y0_S_out),
    .UserCLK(Tile_X3Y1_UserCLK),
    .UserCLK_o(Tile_X3Y0_UserCLK_o),
    .FrameData(Tile_X2Y0_FrameData),
    .FrameData_o(Tile_X3Y0_FrameData),
    .FrameStrobe(Tile_X3Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y0_FrameStrobe)
);

S_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(3'd4),
    .Y_CORD(1'd0)
) S_IO_Tile_X4Y0 (
    .out0(Tile_X4Y0_out0),
    .in0(Tile_X4Y1_out2),
    .S_in(Tile_X4Y0_S_in),
    .S_out(Tile_X4Y0_S_out),
    .UserCLK(Tile_X4Y1_UserCLK),
    .UserCLK_o(Tile_X4Y0_UserCLK_o),
    .FrameData(Tile_X3Y0_FrameData),
    .FrameData_o(Tile_X4Y0_FrameData),
    .FrameStrobe(Tile_X4Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X4Y0_FrameStrobe)
);

EmptyTile #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X5Y0 (
    .UserCLK(Tile_X5Y1_UserCLK),
    .UserCLK_o(Tile_X5Y0_UserCLK_o),
    .FrameData(Tile_X4Y0_FrameData),
    .FrameData_o(Tile_X5Y0_FrameData),
    .FrameStrobe(Tile_X5Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X5Y0_FrameStrobe)
);

endmodule

