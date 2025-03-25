module N_IO #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    // Emulation Parameters
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0,
    parameter X_CORD = -1,
    parameter Y_CORD = -1
)
(
    // NORTH
    // EAST
    // SOUTH
    input wire[31:0] in2,
    output reg[31:0] out2,
    // WEST
    input wire[31:0] N_in,
    output reg[31:0] N_out,
    input wire UserCLK,
    output reg UserCLK_o,
    input wire[FrameBitsPerRow - 1:0] FrameData,
    output reg[FrameBitsPerRow - 1:0] FrameData_o,
    input wire[MaxFramesPerCol - 1:0] FrameStrobe,
    output reg[MaxFramesPerCol - 1:0] FrameStrobe_o
);

// Signal Creation
reg [31:0] N_from_fabric;
reg [31:0] N_to_fabric;

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
    .X(FrameStrobe_o)
);

// User Clock Buffer
clk_buf #() inst_clk_buf (
    .A(UserCLK),
    .X(UserCLK_o)
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

