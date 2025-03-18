module E_IO #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    // Emulation Parameters
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0
)
(
    // NORTH
    // EAST
    // SOUTH
    // WEST
    input [31:0] in3,
    output [31:0] out3,
    input [31:0] in,
    output [31:0] out,
    input UserCLK,
    output UserCLKo,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creation
reg [31:0] E_from_fabric;
reg [31:0] E_to_fabric;
reg [31:0] E_in;
reg [31:0] E_out;

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

// Instantiate BEL E_IO
IO #() Inst_E_IO (
    .from_fabric(E_from_fabric),
    .to_fabric(E_to_fabric),
    .in(E_in),
    .out(E_out)
);

// Init Switch Matrix
E_IO_switch_matrix #() Inst_E_IO_switch_matrix (
    .out3(out3),
    .E_from_fabric(E_from_fabric),
    .E_to_fabric(E_to_fabric),
    .in3(in3)
);

endmodule
