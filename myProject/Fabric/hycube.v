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

// User Clock wire// Frame Data wire// Frame Strobe wire// Tile to Tile wire// Frame Data connection// Frame Strobe connection// Create Tiles
endmodule
