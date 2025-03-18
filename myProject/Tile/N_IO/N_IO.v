module N_IO #(
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
    input [31:0] in2,
    output [31:0] out2,
    // WEST
    input [31:0] in,
    output [31:0] out,
    input UserCLK,
    output UserCLKo,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creation
reg [31:0] N_from_fabric;
reg [31:0] N_to_fabric;
reg [31:0] N_in;
reg [31:0] N_out;

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

// Instantiate BEL N_IO
IO #() Inst_N_IO (
    .from_fabric(N_from_fabric),
    .to_fabric(N_to_fabric),
    .in(N_in),
    .out(N_out)
);

// Init Switch Matrix
N_IO_switch_matrix #() Inst_N_IO_switch_matrix (
    .out2(out2),
    .N_from_fabric(N_from_fabric),
    .N_to_fabric(N_to_fabric),
    .in2(in2)
);

endmodule
