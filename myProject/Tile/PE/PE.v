module PE #(
    parameter MaxFramesPerCol = 8,
    parameter FrameBitsPerRow = 8,
    parameter NoConfigBits = 51,
    // Emulation Parameters
    parameter EMULATION_ENABLE = 0,
    parameter EMULATION_CONFIG = 0,
    parameter X_CORD = -1,
    parameter Y_CORD = -1
)
(
    // NORTH
    input wire[31:0] in0,
    output reg[31:0] out0,
    output reg pred_out0,
    input wire pred_in0,
    // EAST
    input wire[31:0] in1,
    output reg[31:0] out1,
    output reg pred_out1,
    input wire pred_in1,
    // SOUTH
    input wire[31:0] in2,
    output reg[31:0] out2,
    output reg pred_out2,
    input wire pred_in2,
    // WEST
    input wire[31:0] in3,
    output reg[31:0] out3,
    output reg pred_out3,
    input wire pred_in3,
    input wire UserCLK,
    output reg UserCLK_o,
    input wire[FrameBitsPerRow - 1:0] FrameData,
    output reg[FrameBitsPerRow - 1:0] FrameData_o,
    input wire[MaxFramesPerCol - 1:0] FrameStrobe,
    output reg[MaxFramesPerCol - 1:0] FrameStrobe_o
);

// Signal Creation
reg [31:0] data_in1;
reg [31:0] data_in2;
reg [31:0] data_in3;
reg [31:0] data_out;
reg [31:0] A;
reg [31:0] B;
reg [31:0] Y;
reg [31:0] const_out;
reg RES_RES_en;
reg [31:0] RES_RES_reg_in;
reg RES_RES_rst;
reg [31:0] RES_RES_reg_out;
reg N_N_en;
reg [31:0] N_N_reg_in;
reg N_N_rst;
reg [31:0] N_N_reg_out;
reg E_E_en;
reg [31:0] E_E_reg_in;
reg E_E_rst;
reg [31:0] E_E_reg_out;
reg S_S_en;
reg [31:0] S_S_reg_in;
reg S_S_rst;
reg [31:0] S_S_reg_out;
reg W_W_en;
reg [31:0] W_W_reg_in;
reg W_W_rst;
reg [31:0] W_W_reg_out;

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
    .X(FrameData_o)
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
    .X(FrameStrobe_o)
);

// User Clock Buffer
clk_buf #() inst_clk_buf (
    .A(UserCLK),
    .X(UserCLK_o)
);

// Init Configuration storage latches

PE_ConfigMem #(
    .EMULATION_ENABLE(EMULATION_ENABLE),
    .EMULATION_CONFIG(EMULATION_CONFIG),
    .X_CORD(X_CORD),
    .Y_CORD(Y_CORD)
) Inst_PE_ConfigMem (
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

// Instantiate BEL compare
compare #() Inst_compare (
    .A(A),
    .B(B),
    .Y(Y),
    .conf(ConfigBits[4:3])
);

// Instantiate BEL const_unit
const_unit #() Inst_const_unit (
    .const_out(const_out),
    .ConfigBits(ConfigBits[12:5])
);

// Instantiate BEL RES_reg_unit
reg_unit #() Inst_RES_reg_unit (
    .RES_en(RES_RES_en),
    .RES_reg_in(RES_RES_reg_in),
    .RES_rst(RES_RES_rst),
    .RES_reg_out(RES_RES_reg_out),
    .RES_clk(UserCLK),
    .tide_en(ConfigBits[13]),
    .tide_rst(ConfigBits[14])
);

// Instantiate BEL N_reg_unit
reg_unit #() Inst_N_reg_unit (
    .N_en(N_N_en),
    .N_reg_in(N_N_reg_in),
    .N_rst(N_N_rst),
    .N_reg_out(N_N_reg_out),
    .N_clk(UserCLK),
    .tide_en(ConfigBits[15]),
    .tide_rst(ConfigBits[16])
);

// Instantiate BEL E_reg_unit
reg_unit #() Inst_E_reg_unit (
    .E_en(E_E_en),
    .E_reg_in(E_E_reg_in),
    .E_rst(E_E_rst),
    .E_reg_out(E_E_reg_out),
    .E_clk(UserCLK),
    .tide_en(ConfigBits[17]),
    .tide_rst(ConfigBits[18])
);

// Instantiate BEL S_reg_unit
reg_unit #() Inst_S_reg_unit (
    .S_en(S_S_en),
    .S_reg_in(S_S_reg_in),
    .S_rst(S_S_rst),
    .S_reg_out(S_S_reg_out),
    .S_clk(UserCLK),
    .tide_en(ConfigBits[19]),
    .tide_rst(ConfigBits[20])
);

// Instantiate BEL W_reg_unit
reg_unit #() Inst_W_reg_unit (
    .W_en(W_W_en),
    .W_reg_in(W_W_reg_in),
    .W_rst(W_W_rst),
    .W_reg_out(W_W_reg_out),
    .W_clk(UserCLK),
    .tide_en(ConfigBits[21]),
    .tide_rst(ConfigBits[22])
);

// Init Switch Matrix
PE_switch_matrix #() Inst_PE_switch_matrix (
    .out0(out0),
    .out1(out1),
    .out2(out2),
    .out3(out3),
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3),
    .A(A),
    .B(B),
    .RES_RES_reg_in(RES_RES_reg_in),
    .N_N_reg_in(N_N_reg_in),
    .E_E_reg_in(E_E_reg_in),
    .S_S_reg_in(S_S_reg_in),
    .W_W_reg_in(W_W_reg_in),
    .data_out(data_out),
    .RES_RES_reg_out(RES_RES_reg_out),
    .in2(in2),
    .in3(in3),
    .in0(in0),
    .in1(in1),
    .N_N_reg_out(N_N_reg_out),
    .E_E_reg_out(E_E_reg_out),
    .S_S_reg_out(S_S_reg_out),
    .W_W_reg_out(W_W_reg_out),
    .const_out(const_out),
    .Y(Y),
    .ConfigBits(ConfigBits[50:23]),
    .ConfigBits_N(ConfigBits_N[50:23])
);

endmodule

