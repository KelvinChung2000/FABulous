module hycube #(
    parameter MaxFramePerCol = 32,
    parameter FrameBitsPerRow = 32,
    // Emulation parameter
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0
)
(
    input [31:0] Tile_X1Y0_N_in,
    output [31:0] Tile_X1Y0_N_out,
    input [31:0] Tile_X2Y0_N_in,
    output [31:0] Tile_X2Y0_N_out,
    input [31:0] Tile_X0Y1_W_in,
    output [31:0] Tile_X0Y1_W_out,
    input [31:0] Tile_X3Y1_E_in,
    output [31:0] Tile_X3Y1_E_out,
    input [31:0] Tile_X0Y2_W_in,
    output [31:0] Tile_X0Y2_W_out,
    input [31:0] Tile_X3Y2_E_in,
    output [31:0] Tile_X3Y2_E_out,
    input [31:0] Tile_X1Y3_S_in,
    output [31:0] Tile_X1Y3_S_out,
    input [31:0] Tile_X2Y3_S_in,
    output [31:0] Tile_X2Y3_S_out,
    input [FrameBitsPerRow * 4 - 1:0] FrameData,
    input [MaxFramePerCol * 4 - 1:0] FrameStrobe,
    input UserCLK
);

reg cfg;
assign cfg = EMULATION_CONFIG;
// User Clock wire
reg Tile_X0Y1_UserCLK;
reg Tile_X0Y0_UserCLK_o;
reg Tile_X1Y1_UserCLK;
reg Tile_X1Y0_UserCLK_o;
reg Tile_X2Y1_UserCLK;
reg Tile_X2Y0_UserCLK_o;
reg Tile_X3Y1_UserCLK;
reg Tile_X3Y0_UserCLK_o;
reg Tile_X0Y2_UserCLK;
reg Tile_X0Y1_UserCLK_o;
reg Tile_X1Y2_UserCLK;
reg Tile_X1Y1_UserCLK_o;
reg Tile_X2Y2_UserCLK;
reg Tile_X2Y1_UserCLK_o;
reg Tile_X3Y2_UserCLK;
reg Tile_X3Y1_UserCLK_o;
reg Tile_X0Y3_UserCLK;
reg Tile_X0Y2_UserCLK_o;
reg Tile_X1Y3_UserCLK;
reg Tile_X1Y2_UserCLK_o;
reg Tile_X2Y3_UserCLK;
reg Tile_X2Y2_UserCLK_o;
reg Tile_X3Y3_UserCLK;
reg Tile_X3Y2_UserCLK_o;
reg Tile_X0Y3_UserCLK_o;
reg Tile_X1Y3_UserCLK_o;
reg Tile_X2Y3_UserCLK_o;
reg Tile_X3Y3_UserCLK_o;

// Frame Data wire
reg [FrameBitsPerRow - 1:0] Tile_X0Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Row0_FrameData;
reg [FrameBitsPerRow - 1:0] Row1_FrameData;
reg [FrameBitsPerRow - 1:0] Row2_FrameData;
reg [FrameBitsPerRow - 1:0] Row3_FrameData;

// Frame Strobe wire
reg [MaxFramePerCol - 1:0] Tile_X0Y0_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X1Y0_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X2Y0_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X3Y0_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X0Y1_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X1Y1_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X2Y1_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X3Y1_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X0Y2_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X1Y2_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X2Y2_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X3Y2_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X0Y3_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X1Y3_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X2Y3_FrameStrobe;
reg [MaxFramePerCol - 1:0] Tile_X3Y3_FrameStrobe;
reg [MaxFramePerCol - 1:0] Col0_FrameStrobe;
reg [MaxFramePerCol - 1:0] Col1_FrameStrobe;
reg [MaxFramePerCol - 1:0] Col2_FrameStrobe;
reg [MaxFramePerCol - 1:0] Col3_FrameStrobe;

// Tile to Tile wire
reg [31:0] Tile_X1Y0_out2;
reg [31:0] Tile_X2Y0_out2;
reg [31:0] Tile_X0Y1_out1;
reg [31:0] Tile_X1Y1_out0;
reg [31:0] Tile_X1Y1_out1;
reg [31:0] Tile_X1Y1_out2;
reg [31:0] Tile_X1Y1_out3;
reg [31:0] Tile_X2Y1_out0;
reg [31:0] Tile_X2Y1_out1;
reg [31:0] Tile_X2Y1_out2;
reg [31:0] Tile_X2Y1_out3;
reg [31:0] Tile_X3Y1_out3;
reg [31:0] Tile_X0Y2_out1;
reg [31:0] Tile_X1Y2_out0;
reg [31:0] Tile_X1Y2_out1;
reg [31:0] Tile_X1Y2_out2;
reg [31:0] Tile_X1Y2_out3;
reg [31:0] Tile_X2Y2_out0;
reg [31:0] Tile_X2Y2_out1;
reg [31:0] Tile_X2Y2_out2;
reg [31:0] Tile_X2Y2_out3;
reg [31:0] Tile_X3Y2_out3;
reg [31:0] Tile_X1Y3_out0;
reg [31:0] Tile_X2Y3_out0;

// Frame Data connection
assign Row0_FrameData = FrameData[FrameBitsPerRow * 1 - 1:FrameBitsPerRow * 0];
assign Row1_FrameData = FrameData[FrameBitsPerRow * 2 - 1:FrameBitsPerRow * 1];
assign Row2_FrameData = FrameData[FrameBitsPerRow * 3 - 1:FrameBitsPerRow * 2];
assign Row3_FrameData = FrameData[FrameBitsPerRow * 4 - 1:FrameBitsPerRow * 3];

// Frame Strobe connection
assign Col0_FrameStrobe = FrameStrobe[MaxFramePerCol * 1 - 1:MaxFramePerCol * 0];
assign Col1_FrameStrobe = FrameStrobe[MaxFramePerCol * 2 - 1:MaxFramePerCol * 1];
assign Col2_FrameStrobe = FrameStrobe[MaxFramePerCol * 3 - 1:MaxFramePerCol * 2];
assign Col3_FrameStrobe = FrameStrobe[MaxFramePerCol * 4 - 1:MaxFramePerCol * 3];
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

N_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
) N_IO_Tile_X1Y0 (
    .out2(Tile_X1Y0_out2),
    .in2(Tile_X1Y1_out0),
    .N_in(Tile_X1Y0_N_in),
    .N_out(Tile_X1Y0_N_out),
    .UserCLK(Tile_X1Y1_UserCLK),
    .UserCLK_o(Tile_X1Y0_UserCLK_o),
    .FrameData(Tile_X0Y0_FrameData),
    .FrameData_o(Tile_X1Y0_FrameData),
    .FrameStrobe(Tile_X1Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y0_FrameStrobe)
);

N_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
) N_IO_Tile_X2Y0 (
    .out2(Tile_X2Y0_out2),
    .in2(Tile_X2Y1_out0),
    .N_in(Tile_X2Y0_N_in),
    .N_out(Tile_X2Y0_N_out),
    .UserCLK(Tile_X2Y1_UserCLK),
    .UserCLK_o(Tile_X2Y0_UserCLK_o),
    .FrameData(Tile_X1Y0_FrameData),
    .FrameData_o(Tile_X2Y0_FrameData),
    .FrameStrobe(Tile_X2Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y0_FrameStrobe)
);

EmptyTile #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X3Y0 (
    .UserCLK(Tile_X3Y1_UserCLK),
    .UserCLK_o(Tile_X3Y0_UserCLK_o),
    .FrameData(Tile_X2Y0_FrameData),
    .FrameData_o(Tile_X3Y0_FrameData),
    .FrameStrobe(Tile_X3Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y0_FrameStrobe)
);

W_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
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
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(6'd34),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(cfg[0:34])
) PE_Tile_X1Y1 (
    .out0(Tile_X1Y1_out0),
    .out1(Tile_X1Y1_out1),
    .out2(Tile_X1Y1_out2),
    .out3(Tile_X1Y1_out3),
    .in0(Tile_X1Y0_out2),
    .in1(Tile_X2Y1_out3),
    .in2(Tile_X1Y2_out0),
    .in3(Tile_X0Y1_out1),
    .UserCLK(Tile_X1Y2_UserCLK),
    .UserCLK_o(Tile_X1Y1_UserCLK_o),
    .FrameData(Tile_X0Y1_FrameData),
    .FrameData_o(Tile_X1Y1_FrameData),
    .FrameStrobe(Tile_X1Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y1_FrameStrobe)
);

PE #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(6'd34),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(cfg[68:102])
) PE_Tile_X2Y1 (
    .out0(Tile_X2Y1_out0),
    .out1(Tile_X2Y1_out1),
    .out2(Tile_X2Y1_out2),
    .out3(Tile_X2Y1_out3),
    .in0(Tile_X2Y0_out2),
    .in1(Tile_X3Y1_out3),
    .in2(Tile_X2Y2_out0),
    .in3(Tile_X1Y1_out1),
    .UserCLK(Tile_X2Y2_UserCLK),
    .UserCLK_o(Tile_X2Y1_UserCLK_o),
    .FrameData(Tile_X1Y1_FrameData),
    .FrameData_o(Tile_X2Y1_FrameData),
    .FrameStrobe(Tile_X2Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y1_FrameStrobe)
);

E_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
) E_IO_Tile_X3Y1 (
    .out3(Tile_X3Y1_out3),
    .in3(Tile_X2Y1_out1),
    .E_in(Tile_X3Y1_E_in),
    .E_out(Tile_X3Y1_E_out),
    .UserCLK(Tile_X3Y2_UserCLK),
    .UserCLK_o(Tile_X3Y1_UserCLK_o),
    .FrameData(Tile_X2Y1_FrameData),
    .FrameData_o(Tile_X3Y1_FrameData),
    .FrameStrobe(Tile_X3Y2_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y1_FrameStrobe)
);

W_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
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
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(6'd34),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(cfg[34:68])
) PE_Tile_X1Y2 (
    .out0(Tile_X1Y2_out0),
    .out1(Tile_X1Y2_out1),
    .out2(Tile_X1Y2_out2),
    .out3(Tile_X1Y2_out3),
    .in0(Tile_X1Y1_out2),
    .in1(Tile_X2Y2_out3),
    .in2(Tile_X1Y3_out0),
    .in3(Tile_X0Y2_out1),
    .UserCLK(Tile_X1Y3_UserCLK),
    .UserCLK_o(Tile_X1Y2_UserCLK_o),
    .FrameData(Tile_X0Y2_FrameData),
    .FrameData_o(Tile_X1Y2_FrameData),
    .FrameStrobe(Tile_X1Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y2_FrameStrobe)
);

PE #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(6'd34),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(cfg[102:136])
) PE_Tile_X2Y2 (
    .out0(Tile_X2Y2_out0),
    .out1(Tile_X2Y2_out1),
    .out2(Tile_X2Y2_out2),
    .out3(Tile_X2Y2_out3),
    .in0(Tile_X2Y1_out2),
    .in1(Tile_X3Y2_out3),
    .in2(Tile_X2Y3_out0),
    .in3(Tile_X1Y2_out1),
    .UserCLK(Tile_X2Y3_UserCLK),
    .UserCLK_o(Tile_X2Y2_UserCLK_o),
    .FrameData(Tile_X1Y2_FrameData),
    .FrameData_o(Tile_X2Y2_FrameData),
    .FrameStrobe(Tile_X2Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y2_FrameStrobe)
);

E_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
) E_IO_Tile_X3Y2 (
    .out3(Tile_X3Y2_out3),
    .in3(Tile_X2Y2_out1),
    .E_in(Tile_X3Y2_E_in),
    .E_out(Tile_X3Y2_E_out),
    .UserCLK(Tile_X3Y3_UserCLK),
    .UserCLK_o(Tile_X3Y2_UserCLK_o),
    .FrameData(Tile_X2Y2_FrameData),
    .FrameData_o(Tile_X3Y2_FrameData),
    .FrameStrobe(Tile_X3Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y2_FrameStrobe)
);

EmptyTile #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X0Y3 (
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X0Y3_UserCLK_o),
    .FrameData(Row3_FrameData),
    .FrameData_o(Tile_X0Y3_FrameData),
    .FrameStrobe(Col0_FrameStrobe),
    .FrameStrobe_o(Tile_X0Y3_FrameStrobe)
);

S_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
) S_IO_Tile_X1Y3 (
    .out0(Tile_X1Y3_out0),
    .in0(Tile_X1Y2_out2),
    .S_in(Tile_X1Y3_S_in),
    .S_out(Tile_X1Y3_S_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X1Y3_UserCLK_o),
    .FrameData(Tile_X0Y3_FrameData),
    .FrameData_o(Tile_X1Y3_FrameData),
    .FrameStrobe(Col1_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y3_FrameStrobe)
);

S_IO #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .NoConfigBits(1'd0),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(1'd0)
) S_IO_Tile_X2Y3 (
    .out0(Tile_X2Y3_out0),
    .in0(Tile_X2Y2_out2),
    .S_in(Tile_X2Y3_S_in),
    .S_out(Tile_X2Y3_S_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X2Y3_UserCLK_o),
    .FrameData(Tile_X1Y3_FrameData),
    .FrameData_o(Tile_X2Y3_FrameData),
    .FrameStrobe(Col2_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y3_FrameStrobe)
);

EmptyTile #(
    .MaxFramePerCol(MaxFramePerCol),
    .FrameBitsPerRow(FrameBitsPerRow)
) EmptyTile_Tile_X3Y3 (
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X3Y3_UserCLK_o),
    .FrameData(Tile_X2Y3_FrameData),
    .FrameData_o(Tile_X3Y3_FrameData),
    .FrameStrobe(Col3_FrameStrobe),
    .FrameStrobe_o(Tile_X3Y3_FrameStrobe)
);

endmodule
