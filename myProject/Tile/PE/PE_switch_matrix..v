module PE_switch_matrix #(
    parameter NoConfigBits = 47
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
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] RES_reg_out,
    input [31:0] N_reg_out,
    input [31:0] E_reg_out,
    input [31:0] S_reg_out,
    input [31:0] W_reg_out,
    input [31:0] const_out,
    input [NoConfigBits - 1:0] ConfigBits,
    input [NoConfigBits - 1:0] ConfigBits_N
);

localparam reg GND0 = 0;localparam reg GND = 0;localparam reg VCC0 = 1;localparam reg VCC = 1;localparam reg VDD0 = 1;localparam reg VDD = 1;// switch matrix multiplexer out0 MUX-1assign out0 = data_out;// switch matrix multiplexer out1 MUX-1assign out1 = data_out;// switch matrix multiplexer out2 MUX-1assign out2 = data_out;// switch matrix multiplexer out3 MUX-1assign out3 = data_out;// switch matrix multiplexer data_in1 MUX-9cus_mux161_buf_pack #(
    .WIDTH(32)
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
    .A9(GND0),
    .A10(GND0),
    .A11(GND0),
    .A12(GND0),
    .A13(GND0),
    .A14(GND0),
    .A15(GND0),
    .S0(ConfigBits[0]),
    .S0N(ConfigBits_N[0]),
    .S1(ConfigBits[1]),
    .S1N(ConfigBits_N[1]),
    .S2(ConfigBits[2]),
    .S2N(ConfigBits_N[2]),
    .S3(ConfigBits[3]),
    .S3N(ConfigBits_N[3]),
    .X(data_in1)
);
// switch matrix multiplexer data_in2 MUX-10cus_mux161_buf_pack #(
    .WIDTH(32)
) inst_cus_mux161_buf_pack_data_in2 (
    .A0(W_reg_in),
    .A1(S_reg_in),
    .A2(E_reg_in),
    .A3(N_reg_in),
    .A4(RES_reg_in),
    .A5(const_out),
    .A6(in3),
    .A7(in2),
    .A8(in1),
    .A9(in0),
    .A10(GND0),
    .A11(GND0),
    .A12(GND0),
    .A13(GND0),
    .A14(GND0),
    .A15(GND0),
    .S0(ConfigBits[4]),
    .S0N(ConfigBits_N[4]),
    .S1(ConfigBits[5]),
    .S1N(ConfigBits_N[5]),
    .S2(ConfigBits[6]),
    .S2N(ConfigBits_N[6]),
    .S3(ConfigBits[7]),
    .S3N(ConfigBits_N[7]),
    .X(data_in2)
);
// switch matrix multiplexer data_in3 MUX-0// WARNING unused multiplexer MUX-BelPort(input data_in3[31:0])// switch matrix multiplexer reg_in MUX-1assign RES_reg_in = data_out;// switch matrix multiplexer reg_in MUX-2cus_mux21_pack #(
    .WIDTH(32)
) inst_cus_mux21_pack_reg_in (
    .A0(N_reg_out),
    .A1(in0),
    .S(ConfigBits[8]),
    .X(N_reg_in)
);
// switch matrix multiplexer reg_in MUX-2cus_mux21_pack #(
    .WIDTH(32)
) inst_cus_mux21_pack_reg_in (
    .A0(E_reg_out),
    .A1(in1),
    .S(ConfigBits[9]),
    .X(E_reg_in)
);
// switch matrix multiplexer reg_in MUX-2cus_mux21_pack #(
    .WIDTH(32)
) inst_cus_mux21_pack_reg_in (
    .A0(S_reg_out),
    .A1(in2),
    .S(ConfigBits[10]),
    .X(S_reg_in)
);
// switch matrix multiplexer reg_in MUX-2cus_mux21_pack #(
    .WIDTH(32)
) inst_cus_mux21_pack_reg_in (
    .A0(W_reg_out),
    .A1(in3),
    .S(ConfigBits[11]),
    .X(W_reg_in)
);

endmodule
