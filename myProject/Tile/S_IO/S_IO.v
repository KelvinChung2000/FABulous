module S_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    // Emulation Parameters
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0
)
(
    // NORTH
    input [31:0] in0,
    output [31:0] out0,
    // EAST
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
reg [31:0] S_from_fabric;
reg [31:0] S_to_fabric;
reg [31:0] S_in;
reg [31:0] S_out;

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

// Instantiate BEL S_IO
IO #() Inst_S_IO (
    .from_fabric(S_from_fabric),
    .to_fabric(S_to_fabric),
    .in(S_in),
    .out(S_out)
);

// Init Switch Matrix
S_IO_switch_matrix #() Inst_S_IO_switch_matrix (
    .out0(out0),
    .S_from_fabric(S_from_fabric),
    .S_to_fabric(S_to_fabric),
    .in0(in0)
);

endmodule
