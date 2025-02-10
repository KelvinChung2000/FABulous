module PE #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 77
)(
    // NORTH,
    input [31:0] in0,
    output [31:0] out0,
    // EAST,
    input [31:0] in1,
    output [31:0] out1,
    input [1:0] spanIn,
    // SOUTH,
    input [31:0] in2,
    output [31:0] out2,
    // WEST,
    input [31:0] in3,
    output [31:0] out3,
    output [1:0] spanOut,
    input UserCLK,
    output UserCLKo,
    input [FrameBitsPerRow - 1:0] FrameData,
    output [FrameBitsPerRow - 1:0] FrameData_O,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creation
wire [31:0] data_in1;
wire [31:0] data_in2;
wire [31:0] data_in3;
wire [31:0] data_out;
wire [31:0] const_out;
wire [31:0] RES_reg_in;
wire [31:0] RES_reg_out;
wire [31:0] N_reg_in;
wire [31:0] N_reg_out;
wire [31:0] E_reg_in;
wire [31:0] E_reg_out;
wire [31:0] S_reg_in;
wire [31:0] S_reg_out;
wire [31:0] W_reg_in;
wire [31:0] W_reg_out;

// ConfigBits Wires
wire [NoConfigBits - 1:0] ConfigBits;
wire [NoConfigBits - 1:0] ConfigBits_N;

// Buffering incoming and out outgoing wires

// FrameData Buffer
wire [FrameBitsPerRow - 1:0] FrameData_internal;

my_buf_pack #(
    .WIDTH(FrameBitsPerRow)
) data_inbuf (
    .A(FrameData),
    .X(FrameData_internal)
);

my_buf_pack #(
    .WIDTH(FrameBitsPerRow)
) data_outbuf (
    .A(FrameData_internal),
    .X(FrameData_O)
);

// FrameStrobe Buffer
wire [MaxFramesPerCol - 1:0] FrameStrobe_internal;

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

// Buffer spanning wire: spanIn->spanOut
wire [1:0] spanIn_to_spanOut;
my_buf_pack #(
    .WIDTH(2)
) spanIn_inbuf (
    .A(spanIn[1:2]),
    .X(spanIn_to_spanOut)
);

my_buf_pack #(
    .WIDTH(2)
) spanOut_outbuf (
    .A(spanIn_to_spanOut),
    .X(spanOut[1:0])
);

// Init Configuration storage latches
PE_ConfigMem #() Inst_PE_ConfigMem (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);

// Instantiate BEL ALU
ALU #() Inst_ALU (
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3),
    .data_out(data_out),
    .clk(UserCLK),
    .ConfigBits(ConfigBits[3:0])
);

// Instantiate BEL const_unit
const_unit #() Inst_const_unit (
    .const_out(const_out),
    .clk(UserCLK),
    .ConfigBits(ConfigBits[7:4])
);

// Instantiate BEL reg_unit
reg_unit #() Inst_RES_reg_unit (
    .reg_in(RES_reg_in),
    .reg_out(RES_reg_out),
    .clk(UserCLK),
    .ConfigBits(ConfigBits[11:8])
);

// Instantiate BEL reg_unit
reg_unit #() Inst_N_reg_unit (
    .reg_in(N_reg_in),
    .reg_out(N_reg_out),
    .clk(UserCLK),
    .ConfigBits(ConfigBits[15:12])
);

// Instantiate BEL reg_unit
reg_unit #() Inst_E_reg_unit (
    .reg_in(E_reg_in),
    .reg_out(E_reg_out),
    .clk(UserCLK),
    .ConfigBits(ConfigBits[19:16])
);

// Instantiate BEL reg_unit
reg_unit #() Inst_S_reg_unit (
    .reg_in(S_reg_in),
    .reg_out(S_reg_out),
    .clk(UserCLK),
    .ConfigBits(ConfigBits[23:20])
);

// Instantiate BEL reg_unit
reg_unit #() Inst_W_reg_unit (
    .reg_in(W_reg_in),
    .reg_out(W_reg_out),
    .clk(UserCLK),
    .ConfigBits(ConfigBits[27:24])
);

// Init Switch Matrix
PE_SwitchMatrix #() Inst_PE_SwitchMatrix (
    .ConfigBits(ConfigBits[76:28]),
    .ConfigBits_N(ConfigBits_N[76:28])
);

endmodule
