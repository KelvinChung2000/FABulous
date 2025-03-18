module PE_switch_matrix #(
    parameter NoConfigBits = 65
)(
    output [31:0] out0,
    output [31:0] out1,
    output [31:0] out2,
    output [31:0] out3,
    output [31:0] data_in1,
    output [31:0] data_in2,
    output [31:0] data_in3,
    output [31:0] RES_reg_in,
    output [31:0] N_reg_in,
    output [31:0] E_reg_in,
    output [31:0] S_reg_in,
    output [31:0] W_reg_in,
    input [31:0] data_out,
    input [31:0] RES_reg_out,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] N_reg_out,
    input [31:0] E_reg_out,
    input [31:0] S_reg_out,
    input [31:0] W_reg_out,
    input [31:0] const_out,
    input [NoConfigBits - 1:0] ConfigBits,
    input [NoConfigBits - 1:0] ConfigBits_N
);

localparam reg GND = 32'd0;
localparam reg VCC = 32'd1;

// switch matrix multiplexer out0 MUX-3
cus_mux41_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux41_buf_pack_out0 (
    .A0(in2),
    .A1(RES_reg_out),
    .A2(data_out),
    .A3(GND),
    .S0(ConfigBits[0]),
    .S0N(ConfigBits_N[0]),
    .S1(ConfigBits[1]),
    .S1N(ConfigBits_N[1]),
    .X(out0)
);

// switch matrix multiplexer out1 MUX-3
cus_mux41_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux41_buf_pack_out1 (
    .A0(in3),
    .A1(RES_reg_out),
    .A2(data_out),
    .A3(GND),
    .S0(ConfigBits[2]),
    .S0N(ConfigBits_N[2]),
    .S1(ConfigBits[3]),
    .S1N(ConfigBits_N[3]),
    .X(out1)
);

// switch matrix multiplexer out2 MUX-3
cus_mux41_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux41_buf_pack_out2 (
    .A0(in0),
    .A1(RES_reg_out),
    .A2(data_out),
    .A3(GND),
    .S0(ConfigBits[4]),
    .S0N(ConfigBits_N[4]),
    .S1(ConfigBits[5]),
    .S1N(ConfigBits_N[5]),
    .X(out2)
);

// switch matrix multiplexer out3 MUX-3
cus_mux41_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux41_buf_pack_out3 (
    .A0(in1),
    .A1(RES_reg_out),
    .A2(data_out),
    .A3(GND),
    .S0(ConfigBits[6]),
    .S0N(ConfigBits_N[6]),
    .S1(ConfigBits[7]),
    .S1N(ConfigBits_N[7]),
    .X(out3)
);

// switch matrix multiplexer data_in1 MUX-9
cus_mux161_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux161_buf_pack_data_in1 (
    .A0(W_reg_out),
    .A1(S_reg_out),
    .A2(E_reg_out),
    .A3(N_reg_out),
    .A4(RES_reg_out),
    .A5(in3),
    .A6(in2),
    .A7(in1),
    .A8(in0),
    .A9(GND),
    .A10(GND),
    .A11(GND),
    .A12(GND),
    .A13(GND),
    .A14(GND),
    .A15(GND),
    .S0(ConfigBits[8]),
    .S0N(ConfigBits_N[8]),
    .S1(ConfigBits[9]),
    .S1N(ConfigBits_N[9]),
    .S2(ConfigBits[10]),
    .S2N(ConfigBits_N[10]),
    .S3(ConfigBits[11]),
    .S3N(ConfigBits_N[11]),
    .X(data_in1)
);

// switch matrix multiplexer data_in2 MUX-10
cus_mux161_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux161_buf_pack_data_in2 (
    .A0(W_reg_out),
    .A1(S_reg_out),
    .A2(E_reg_out),
    .A3(N_reg_out),
    .A4(RES_reg_out),
    .A5(const_out),
    .A6(in3),
    .A7(in2),
    .A8(in1),
    .A9(in0),
    .A10(GND),
    .A11(GND),
    .A12(GND),
    .A13(GND),
    .A14(GND),
    .A15(GND),
    .S0(ConfigBits[12]),
    .S0N(ConfigBits_N[12]),
    .S1(ConfigBits[13]),
    .S1N(ConfigBits_N[13]),
    .S2(ConfigBits[14]),
    .S2N(ConfigBits_N[14]),
    .S3(ConfigBits[15]),
    .S3N(ConfigBits_N[15]),
    .X(data_in2)
);

// switch matrix multiplexer data_in3 MUX-5
cus_mux81_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux81_buf_pack_data_in3 (
    .A0(const_out),
    .A1(in3),
    .A2(in2),
    .A3(in1),
    .A4(in0),
    .A5(GND),
    .A6(GND),
    .A7(GND),
    .S0(ConfigBits[16]),
    .S0N(ConfigBits_N[16]),
    .S1(ConfigBits[17]),
    .S1N(ConfigBits_N[17]),
    .S2(ConfigBits[18]),
    .S2N(ConfigBits_N[18]),
    .X(data_in3)
);

// switch matrix multiplexer reg_in MUX-1
assign RES_reg_in = data_out;
// switch matrix multiplexer reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_reg_in (
    .A0(N_reg_out),
    .A1(in0),
    .S(ConfigBits[19]),
    .X(N_reg_in)
);

// switch matrix multiplexer reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_reg_in (
    .A0(E_reg_out),
    .A1(in1),
    .S(ConfigBits[20]),
    .X(E_reg_in)
);

// switch matrix multiplexer reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_reg_in (
    .A0(S_reg_out),
    .A1(in2),
    .S(ConfigBits[21]),
    .X(S_reg_in)
);

// switch matrix multiplexer reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_reg_in (
    .A0(W_reg_out),
    .A1(in3),
    .S(ConfigBits[22]),
    .X(W_reg_in)
);

endmodule
