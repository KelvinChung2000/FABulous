module hycube #(
    parameter MaxFramePerCol = 32,
    parameter FrameBitsPerRow = 32
)(
    input [31:0] Tile_X1Y0_in,
    output [31:0] Tile_X1Y0_out,
    input [31:0] Tile_X2Y0_in,
    output [31:0] Tile_X2Y0_out,
    input [31:0] Tile_X0Y1_in,
    output [31:0] Tile_X0Y1_out,
    input [31:0] Tile_X3Y1_in,
    output [31:0] Tile_X3Y1_out,
    input [31:0] Tile_X0Y2_in,
    output [31:0] Tile_X0Y2_out,
    input [31:0] Tile_X3Y2_in,
    output [31:0] Tile_X3Y2_out,
    input [31:0] Tile_X1Y3_in,
    output [31:0] Tile_X1Y3_out,
    input [31:0] Tile_X2Y3_in,
    output [31:0] Tile_X2Y3_out,
    input [FrameBitsPerRow * 4 - 1:0] FrameData,
    input [MaxFramePerCol * 4 - 1:0] FrameStrobe,
    input UserCLK
);

// User Clock wire

// Frame Data wire

// Frame Strobe wire

// Tile to Tile wire

// Frame Data connection

// Frame Strobe connection
// Create Tiles
endmodule
