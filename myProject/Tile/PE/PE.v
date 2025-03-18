module PE #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 65
)(
    // NORTH
    input [31:0] in0,
    output [31:0] out0,
    // EAST
    input [31:0] in1,
    output [31:0] out1,
    // SOUTH
    input [31:0] in2,
    output [31:0] out2,
    // WEST
    input [31:0] in3,
    output [31:0] out3,
    input UserCLK,
    output UserCLKo,
    input [FrameBitsPerRow - 1:0] FrameData,
    output [FrameBitsPerRow - 1:0] FrameData_O,
    input [MaxFramesPerCol - 1:0] FrameStrobe,
    output [MaxFramesPerCol - 1:0] FrameStrobe_O
);

// Signal Creation
reg [31:0] data_in1;
reg [31:0] data_in2;
reg [31:0] data_in3;
reg [31:0] data_out;
reg [31:0] const_out;
reg RES_en;
reg [31:0] RES_reg_in;
reg RES_rst;
reg [31:0] RES_reg_out;
reg N_en;
reg [31:0] N_reg_in;
reg N_rst;
reg [31:0] N_reg_out;
reg E_en;
reg [31:0] E_reg_in;
reg E_rst;
reg [31:0] E_reg_out;
reg S_en;
reg [31:0] S_reg_in;
reg S_rst;
reg [31:0] S_reg_out;
reg W_en;
reg [31:0] W_reg_in;
reg W_rst;
reg [31:0] W_reg_out;

// ConfigBits Wires
reg [NoConfigBits - 1:0] ConfigBits;
reg [NoConfigBits - 1:0] ConfigBits_N;

// Buffering incoming and out outgoing wires
// FrameData Buffer
reg [FrameBitsPerRow - 1:0] FrameData_internal;

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
    .ALU_func(ConfigBits[2:0])
);

// Instantiate BEL const_unit
const_unit #() Inst_const_unit (
    .const_out(const_out),
    .ConfigBits(ConfigBits[10:3])
);

// Instantiate BEL reg_unit
reg_unit #() Inst_RES_reg_unit (
    .en(RES_en),
    .reg_in(RES_reg_in),
    .rst(RES_rst),
    .reg_out(RES_reg_out),
    .clk(UserCLK)
);

// Instantiate BEL reg_unit
reg_unit #() Inst_N_reg_unit (
    .en(N_en),
    .reg_in(N_reg_in),
    .rst(N_rst),
    .reg_out(N_reg_out),
    .clk(UserCLK)
);

// Instantiate BEL reg_unit
reg_unit #() Inst_E_reg_unit (
    .en(E_en),
    .reg_in(E_reg_in),
    .rst(E_rst),
    .reg_out(E_reg_out),
    .clk(UserCLK)
);

// Instantiate BEL reg_unit
reg_unit #() Inst_S_reg_unit (
    .en(S_en),
    .reg_in(S_reg_in),
    .rst(S_rst),
    .reg_out(S_reg_out),
    .clk(UserCLK)
);

// Instantiate BEL reg_unit
reg_unit #() Inst_W_reg_unit (
    .en(W_en),
    .reg_in(W_reg_in),
    .rst(W_rst),
    .reg_out(W_reg_out),
    .clk(UserCLK)
);

// Init Switch Matrix
PE_SwitchMatrix #() Inst_PE_SwitchMatrix (
    .out0(out0),
    .out1(out1),
    .out2(out2),
    .out3(out3),
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3),
    .RES_reg_in(RES_reg_in),
    .N_reg_in(N_reg_in),
    .E_reg_in(E_reg_in),
    .S_reg_in(S_reg_in),
    .W_reg_in(W_reg_in),
    .data_out(data_out),
    .RES_reg_out(RES_reg_out),
    .in2(in2),
    .in3(in3),
    .in0(in0),
    .in1(in1),
    .N_reg_out(N_reg_out),
    .E_reg_out(E_reg_out),
    .S_reg_out(S_reg_out),
    .W_reg_out(W_reg_out),
    .const_out(const_out),
    .ConfigBits(ConfigBits[64:11]),
    .ConfigBits_N(ConfigBits_N[64:11])
);

endmodule
