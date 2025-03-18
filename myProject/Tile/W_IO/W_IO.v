module W_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    // Emulation Parameters
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0
)
(
    // NORTH
    // EAST
    input [31:0] in1,
    output [31:0] out1,
    // SOUTH
    // WEST
    input [31:0] in,
    output [31:0] out,
    input UserCLK,
    output UserCLKo,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creation
reg [31:0] W_from_fabric;
reg [31:0] W_to_fabric;
reg [31:0] W_in;
reg [31:0] W_out;

// Buffering incoming and out outgoing wires
// FrameStrobe Buffer
reg [MaxFramesPerCol - 1:0] FrameStrobe_internal;

my_buf_pack #(
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

// User Clock Buffer
clk_buf #() inst_clk_buf (
    .A(UserCLK),
    .X(UserCLKo)
);

// Instantiate BEL W_IO
IO #() Inst_W_IO (
    .from_fabric(W_from_fabric),
    .to_fabric(W_to_fabric),
    .in(W_in),
    .out(W_out)
);

// Init Switch Matrix
W_IO_switch_matrix #() Inst_W_IO_switch_matrix (
    .out1(out1),
    .W_from_fabric(W_from_fabric),
    .W_to_fabric(W_to_fabric),
    .in1(in1)
);

endmodule
