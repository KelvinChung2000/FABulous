module PE_switch_matrix #(
    parameter NoConfigBits = 73
)(
    output data_in1,
    input in0,
    input in1,
    input in2,
    input in3,
    input RES_reg_out,
    input N_reg_out,
    input E_reg_out,
    input S_reg_out,
    input W_reg_out,
    output data_in2,
    input in0,
    input in1,
    input in2,
    input in3,
    input const_out,
    input RES_reg_out,
    input N_reg_out,
    input E_reg_out,
    input S_reg_out,
    input W_reg_out,
    output RES_in,
    input data_out,
    output out0,
    input data_out,
    input in0,
    input in1,
    input in2,
    input in3,
    output out1,
    input data_out,
    input in0,
    input in1,
    input in2,
    input in3,
    output out2,
    input data_out,
    input in0,
    input in1,
    input in2,
    input in3,
    output out3,
    input data_out,
    input in0,
    input in1,
    input in2,
    input in3,
    output N_reg_in,
    input in0,
    input N_reg_out,
    output E_reg_in,
    input in1,
    input E_reg_out,
    output S_reg_in,
    input in2,
    input S_reg_out,
    output W_reg_in,
    input in3,
    input W_reg_out,
    input ConfigBits,
    input ConfigBits_N
);

localparam reg GND0 = 0;
localparam reg GND = 0;
localparam reg VCC0 = 1;
localparam reg VCC = 1;
localparam reg VDD0 = 1;
localparam reg VDD = 1;
// switch matrix multiplexer data_in1 MUX-9
assign data_in1_input = {W_reg_out, S_reg_out, E_reg_out, N_reg_out, RES_reg_out, in3, in2, in1, in0};
cus_mux161_buf #() inst_cus_mux161_buf_data_in1 (
    .A0(data_in1_input[0]),
    .A1(data_in1_input[1]),
    .A2(data_in1_input[2]),
    .A3(data_in1_input[3]),
    .A4(data_in1_input[4]),
    .A5(data_in1_input[5]),
    .A6(data_in1_input[6]),
    .A7(data_in1_input[7]),
    .A8(data_in1_input[8]),
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

// switch matrix multiplexer data_in2 MUX-10
assign data_in2_input = {W_reg_out, S_reg_out, E_reg_out, N_reg_out, RES_reg_out, const_out, in3, in2, in1, in0};
cus_mux161_buf #() inst_cus_mux161_buf_data_in2 (
    .A0(data_in2_input[0]),
    .A1(data_in2_input[1]),
    .A2(data_in2_input[2]),
    .A3(data_in2_input[3]),
    .A4(data_in2_input[4]),
    .A5(data_in2_input[5]),
    .A6(data_in2_input[6]),
    .A7(data_in2_input[7]),
    .A8(data_in2_input[8]),
    .A9(data_in2_input[9]),
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

// switch matrix multiplexer RES_in MUX-1
assign RES_in = data_out;
// switch matrix multiplexer out0 MUX-5
assign out0_input = {in3, in2, in1, in0, data_out};
cus_mux81_buf #() inst_cus_mux81_buf_out0 (
    .A0(out0_input[0]),
    .A1(out0_input[1]),
    .A2(out0_input[2]),
    .A3(out0_input[3]),
    .A4(out0_input[4]),
    .A5(GND0),
    .A6(GND0),
    .A7(GND0),
    .S0(ConfigBits[8]),
    .S0N(ConfigBits_N[8]),
    .S1(ConfigBits[9]),
    .S1N(ConfigBits_N[9]),
    .S2(ConfigBits[10]),
    .S2N(ConfigBits_N[10]),
    .X(out0)
);

// switch matrix multiplexer out1 MUX-5
assign out1_input = {in3, in2, in1, in0, data_out};
cus_mux81_buf #() inst_cus_mux81_buf_out1 (
    .A0(out1_input[0]),
    .A1(out1_input[1]),
    .A2(out1_input[2]),
    .A3(out1_input[3]),
    .A4(out1_input[4]),
    .A5(GND0),
    .A6(GND0),
    .A7(GND0),
    .S0(ConfigBits[11]),
    .S0N(ConfigBits_N[11]),
    .S1(ConfigBits[12]),
    .S1N(ConfigBits_N[12]),
    .S2(ConfigBits[13]),
    .S2N(ConfigBits_N[13]),
    .X(out1)
);

// switch matrix multiplexer out2 MUX-5
assign out2_input = {in3, in2, in1, in0, data_out};
cus_mux81_buf #() inst_cus_mux81_buf_out2 (
    .A0(out2_input[0]),
    .A1(out2_input[1]),
    .A2(out2_input[2]),
    .A3(out2_input[3]),
    .A4(out2_input[4]),
    .A5(GND0),
    .A6(GND0),
    .A7(GND0),
    .S0(ConfigBits[14]),
    .S0N(ConfigBits_N[14]),
    .S1(ConfigBits[15]),
    .S1N(ConfigBits_N[15]),
    .S2(ConfigBits[16]),
    .S2N(ConfigBits_N[16]),
    .X(out2)
);

// switch matrix multiplexer out3 MUX-5
assign out3_input = {in3, in2, in1, in0, data_out};
cus_mux81_buf #() inst_cus_mux81_buf_out3 (
    .A0(out3_input[0]),
    .A1(out3_input[1]),
    .A2(out3_input[2]),
    .A3(out3_input[3]),
    .A4(out3_input[4]),
    .A5(GND0),
    .A6(GND0),
    .A7(GND0),
    .S0(ConfigBits[17]),
    .S0N(ConfigBits_N[17]),
    .S1(ConfigBits[18]),
    .S1N(ConfigBits_N[18]),
    .S2(ConfigBits[19]),
    .S2N(ConfigBits_N[19]),
    .X(out3)
);

// switch matrix multiplexer N_reg_in MUX-2
assign N_reg_in_input = {N_reg_out, in0};
cus_mux21 #() inst_cus_mux21_N_reg_in (
    .A0(N_reg_in_input[0]),
    .A1(N_reg_in_input[1]),
    .S(ConfigBits[20]),
    .X(N_reg_in)
);

// switch matrix multiplexer E_reg_in MUX-2
assign E_reg_in_input = {E_reg_out, in1};
cus_mux21 #() inst_cus_mux21_E_reg_in (
    .A0(E_reg_in_input[0]),
    .A1(E_reg_in_input[1]),
    .S(ConfigBits[21]),
    .X(E_reg_in)
);

// switch matrix multiplexer S_reg_in MUX-2
assign S_reg_in_input = {S_reg_out, in2};
cus_mux21 #() inst_cus_mux21_S_reg_in (
    .A0(S_reg_in_input[0]),
    .A1(S_reg_in_input[1]),
    .S(ConfigBits[22]),
    .X(S_reg_in)
);

// switch matrix multiplexer W_reg_in MUX-2
assign W_reg_in_input = {W_reg_out, in3};
cus_mux21 #() inst_cus_mux21_W_reg_in (
    .A0(W_reg_in_input[0]),
    .A1(W_reg_in_input[1]),
    .S(ConfigBits[23]),
    .X(W_reg_in)
);

endmodule
