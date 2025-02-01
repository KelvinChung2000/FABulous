module PE #(
    parameter MaxFramesPerCol = 32,
    parameter FrameBitsPerRow = 32,
    parameter NoConfigBits = 44
)(
    output [31:0] out0,
    output [31:0] out1,
    output [31:0] out2,
    output [31:0] out3,
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input UserCLK,
    output UserCLKo,
    input [FrameBitsPerRow - 1:0] FrameData,
    output [FrameBitsPerRow - 1:0] FrameData_O,
    input [MaxFramePerCol - 1:0] FrameStrobe,
    output [MaxFramePerCol - 1:0] FrameStrobe_O
);
// Signal Creation
wire data_in1;
wire data_in2;
wire data_in3;
wire data_out;
wire const_out;
wire RES_RES_reg_in;
wire RES_RES_reg_out;
wire N_N_reg_in;
wire N_N_reg_out;
wire E_E_reg_in;
wire E_E_reg_out;
wire S_S_reg_in;
wire S_S_reg_out;
wire W_W_reg_in;
wire W_W_reg_out;
// ConfigBits Wires
wire [NoConfigBits - 1:0] ConfigBits;
wire [NoConfigBits - 1:0] ConfigBits_N;
// Buffering incoming and out outgoing wires
wire [FrameBitsPerRow-1:0] FrameData_O_i;
wire [FrameBitsPerRow-1:0] FrameData_i;
// FrameData Buffer
my_buf_pack #(
    .WIDTH(FrameBitsPerRow)
) data_inbuf (
    .A(FrameData),
    .X(FrameData_i)
);

assign FrameData_O_i = FrameData_i;
my_buf_pack #(
    .WIDTH(FrameBitsPerRow)
) data_outbuf (
    .A(FrameData_O_i),
    .X(FrameData_O)
);

// FrameStrobe Buffer
wire [MaxFramesPerCol-1:0] FrameStrobe_i;
wire [MaxFramesPerCol-1:0] FrameStrobe_O_i;
my_buf_pack #(
    .WIDTH(MaxFramesPerCol)
) strobe_inbuf (
    .A(FrameStrobe),
    .X(FrameStrobe_i)
);

assign FrameStrobe_O_i = FrameStrobe_i;
my_buf_pack #(
    .WIDTH(MaxFramesPerCol)
) strobe_outbuf (
    .A(FrameStrobe_O_i),
    .X(FrameStrobe_O)
);

clk_buf #()(
    .A(UserCLK),
    .X(UserCLKo)
);

// Init Configuration storage latches
PE_ConfigMem #()(
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);

// Instantiate BEL ALU
ALU #()(
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3),
    .data_out(data_out)
);

// Instantiate BEL const_unit
const_unit #()(
    .const_out(const_out)
);

// Instantiate BEL reg_unit
reg_unit #()(
    .RES_reg_in(RES_RES_reg_in),
    .RES_reg_out(RES_RES_reg_out)
);

// Instantiate BEL reg_unit
reg_unit #()(
    .N_reg_in(N_N_reg_in),
    .N_reg_out(N_N_reg_out)
);

// Instantiate BEL reg_unit
reg_unit #()(
    .E_reg_in(E_E_reg_in),
    .E_reg_out(E_E_reg_out)
);

// Instantiate BEL reg_unit
reg_unit #()(
    .S_reg_in(S_S_reg_in),
    .S_reg_out(S_S_reg_out)
);

// Instantiate BEL reg_unit
reg_unit #()(
    .W_reg_in(W_W_reg_in),
    .W_reg_out(W_W_reg_out)
);

// Init Switch Matrix
PE_SwitchMatrix #()(
    .data_in1(data_in1),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .data_in1(data_in1),
    .RES_reg_out(RES_reg_out),
    .N_reg_out(N_reg_out),
    .E_reg_out(E_reg_out),
    .S_reg_out(S_reg_out),
    .W_reg_out(W_reg_out),
    .data_in2(data_in2),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .const_out(const_out),
    .data_in2(data_in2),
    .RES_reg_out(RES_reg_out),
    .N_reg_out(N_reg_out),
    .E_reg_out(E_reg_out),
    .S_reg_out(S_reg_out),
    .W_reg_out(W_reg_out),
    .RES_in(RES_in),
    .data_out(data_out),
    .out0(out0),
    .data_out(data_out),
    .out1(out1),
    .data_out(data_out),
    .out2(out2),
    .data_out(data_out),
    .out3(out3),
    .data_out(data_out),
    .out0(out0),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .out1(out1),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .out2(out2),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .out3(out3),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .N_reg_in(N_reg_in),
    .in0(in0),
    .E_reg_in(E_reg_in),
    .in1(in1),
    .S_reg_in(S_reg_in),
    .in2(in2),
    .W_reg_in(W_reg_in),
    .in3(in3),
    .N_reg_in(N_reg_in),
    .N_reg_out(N_reg_out),
    .E_reg_in(E_reg_in),
    .E_reg_out(E_reg_out),
    .S_reg_in(S_reg_in),
    .S_reg_out(S_reg_out),
    .W_reg_in(W_reg_in),
    .W_reg_out(W_reg_out),
    .ConfigBits(ConfigBits[44-1:28]),
    .ConfigBits_N(ConfigBits_N[44-1:28])
);

endmodule
