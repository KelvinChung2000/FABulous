module hycube #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    // Emulation parameter
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = ""
)
(
    input wire[31:0] Tile_X1Y3_N_in,
    output reg[31:0] Tile_X1Y3_N_out,
    input wire[31:0] Tile_X2Y3_N_in,
    output reg[31:0] Tile_X2Y3_N_out,
    input wire[31:0] Tile_X0Y2_W_in,
    output reg[31:0] Tile_X0Y2_W_out,
    input wire[31:0] Tile_X3Y2_E_in,
    output reg[31:0] Tile_X3Y2_E_out,
    input wire[31:0] Tile_X0Y1_W_in,
    output reg[31:0] Tile_X0Y1_W_out,
    input wire[31:0] Tile_X3Y1_E_in,
    output reg[31:0] Tile_X3Y1_E_out,
    input wire[31:0] Tile_X1Y0_S_in,
    output reg[31:0] Tile_X1Y0_S_out,
    input wire[31:0] Tile_X2Y0_S_in,
    output reg[31:0] Tile_X2Y0_S_out,
    input wire[FrameBitsPerRow * 4 - 1:0] FrameData,
    input wire[MaxFramesPerCol * 4 - 1:0] FrameStrobe,
    input wire UserCLK
);

// User Clock wire
reg Tile_X0Y1_UserCLK;
reg Tile_X0Y0_UserCLK_o;
reg Tile_X1Y3_UserCLK_o;
reg Tile_X2Y3_UserCLK_o;
reg Tile_X3Y1_UserCLK;
reg Tile_X3Y0_UserCLK_o;
reg Tile_X0Y3_UserCLK;
reg Tile_X0Y2_UserCLK_o;
reg Tile_X1Y3_UserCLK;
reg Tile_X1Y2_UserCLK_o;
reg Tile_X2Y3_UserCLK;
reg Tile_X2Y2_UserCLK_o;
reg Tile_X3Y3_UserCLK;
reg Tile_X3Y2_UserCLK_o;
reg Tile_X0Y2_UserCLK;
reg Tile_X0Y1_UserCLK_o;
reg Tile_X1Y2_UserCLK;
reg Tile_X1Y1_UserCLK_o;
reg Tile_X2Y2_UserCLK;
reg Tile_X2Y1_UserCLK_o;
reg Tile_X3Y2_UserCLK;
reg Tile_X3Y1_UserCLK_o;
reg Tile_X0Y3_UserCLK_o;
reg Tile_X1Y1_UserCLK;
reg Tile_X1Y0_UserCLK_o;
reg Tile_X2Y1_UserCLK;
reg Tile_X2Y0_UserCLK_o;
reg Tile_X3Y3_UserCLK_o;

// Frame Data wire
reg [FrameBitsPerRow - 1:0] Tile_X0Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y2_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y1_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X0Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X1Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X2Y0_FrameData;
reg [FrameBitsPerRow - 1:0] Tile_X3Y3_FrameData;
reg [FrameBitsPerRow - 1:0] Row0_FrameData;
reg [FrameBitsPerRow - 1:0] Row2_FrameData;
reg [FrameBitsPerRow - 1:0] Row1_FrameData;
reg [FrameBitsPerRow - 1:0] Row3_FrameData;

// Frame Strobe wire
reg [MaxFramesPerCol - 1:0] Tile_X0Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X0Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X1Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X2Y0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Tile_X3Y3_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col1_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col2_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col0_FrameStrobe;
reg [MaxFramesPerCol - 1:0] Col3_FrameStrobe;

// Tile to Tile wire
reg [31:0] Tile_X1Y3_out2;
reg [31:0] Tile_X2Y3_out2;
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
reg [31:0] Tile_X1Y0_out0;
reg [31:0] Tile_X2Y0_out0;

// Frame Data connection
assign Row0_FrameData = FrameData[FrameBitsPerRow * 1 - 1:FrameBitsPerRow * 0];
assign Row2_FrameData = FrameData[FrameBitsPerRow * 3 - 1:FrameBitsPerRow * 2];
assign Row1_FrameData = FrameData[FrameBitsPerRow * 2 - 1:FrameBitsPerRow * 1];
assign Row3_FrameData = FrameData[FrameBitsPerRow * 4 - 1:FrameBitsPerRow * 3];

// Frame Strobe connection
assign Col1_FrameStrobe = FrameStrobe[MaxFramesPerCol * 2 - 1:MaxFramesPerCol * 1];
assign Col2_FrameStrobe = FrameStrobe[MaxFramesPerCol * 3 - 1:MaxFramesPerCol * 2];
assign Col0_FrameStrobe = FrameStrobe[MaxFramesPerCol * 1 - 1:MaxFramesPerCol * 0];
assign Col3_FrameStrobe = FrameStrobe[MaxFramesPerCol * 4 - 1:MaxFramesPerCol * 3];
// Create Tiles
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

N_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(2'd3)
) N_IO_Tile_X1Y3 (
    .out2(Tile_X1Y3_out2),
    .N_in(Tile_X1Y3_N_in),
    .N_out(Tile_X1Y3_N_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X1Y3_UserCLK_o),
    .FrameData(Tile_X0Y3_FrameData),
    .FrameData_o(Tile_X1Y3_FrameData),
    .FrameStrobe(Col1_FrameStrobe),
    .FrameStrobe_o(Tile_X1Y3_FrameStrobe)
);

N_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd2),
    .Y_CORD(2'd3)
) N_IO_Tile_X2Y3 (
    .out2(Tile_X2Y3_out2),
    .N_in(Tile_X2Y3_N_in),
    .N_out(Tile_X2Y3_N_out),
    .UserCLK(UserCLK),
    .UserCLK_o(Tile_X2Y3_UserCLK_o),
    .FrameData(Tile_X1Y3_FrameData),
    .FrameData_o(Tile_X2Y3_FrameData),
    .FrameStrobe(Col2_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y3_FrameStrobe)
);

EmptyTile #(
    .MaxFramesPerCol(MaxFramesPerCol),
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
    .in0(Tile_X1Y1_out2),
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
    .in0(Tile_X2Y1_out2),
    .in1(Tile_X3Y2_out3),
    .in3(Tile_X1Y2_out1),
    .UserCLK(Tile_X2Y3_UserCLK),
    .UserCLK_o(Tile_X2Y2_UserCLK_o),
    .FrameData(Tile_X1Y2_FrameData),
    .FrameData_o(Tile_X2Y2_FrameData),
    .FrameStrobe(Tile_X2Y3_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y2_FrameStrobe)
);

E_IO #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(2'd2)
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
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(2'd3),
    .Y_CORD(1'd1)
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

EmptyTile #(
    .MaxFramesPerCol(MaxFramesPerCol),
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
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameBitsPerRow(FrameBitsPerRow),
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(1'd1),
    .Y_CORD(1'd0)
) S_IO_Tile_X1Y0 (
    .out0(Tile_X1Y0_out0),
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
    .S_in(Tile_X2Y0_S_in),
    .S_out(Tile_X2Y0_S_out),
    .UserCLK(Tile_X2Y1_UserCLK),
    .UserCLK_o(Tile_X2Y0_UserCLK_o),
    .FrameData(Tile_X1Y0_FrameData),
    .FrameData_o(Tile_X2Y0_FrameData),
    .FrameStrobe(Tile_X2Y1_FrameStrobe),
    .FrameStrobe_o(Tile_X2Y0_FrameStrobe)
);

EmptyTile #(
    .MaxFramesPerCol(MaxFramesPerCol),
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
