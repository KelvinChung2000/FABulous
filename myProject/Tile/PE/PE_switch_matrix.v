module PE_switch_matrix #(
    parameter NoConfigBits = 28
)
(
    output reg[31:0] out0,
    output reg[31:0] out1,
    output reg[31:0] out2,
    output reg[31:0] out3,
    output reg[31:0] data_in1,
    output reg[31:0] data_in2,
    output reg[31:0] data_in3,
    output reg[31:0] A,
    output reg[31:0] B,
    output reg[31:0] RES_RES_reg_in,
    output reg[31:0] N_N_reg_in,
    output reg[31:0] E_E_reg_in,
    output reg[31:0] S_S_reg_in,
    output reg[31:0] W_W_reg_in,
    input wire[31:0] data_out,
    input wire[31:0] RES_RES_reg_out,
    input wire[31:0] in2,
    input wire[31:0] in3,
    input wire[31:0] in0,
    input wire[31:0] in1,
    input wire[31:0] N_N_reg_out,
    input wire[31:0] E_E_reg_out,
    input wire[31:0] S_S_reg_out,
    input wire[31:0] W_W_reg_out,
    input wire[31:0] const_out,
    input wire[31:0] Y,
    input wire[NoConfigBits - 1:0] ConfigBits,
    input wire[NoConfigBits - 1:0] ConfigBits_N
);

localparam GND = 32'd0;
localparam VCC = 32'd1;

// switch matrix multiplexer out0 MUX-3
cus_mux41_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux41_buf_pack_out0 (
    .A0(in2),
    .A1(RES_RES_reg_out),
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
    .A1(RES_RES_reg_out),
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
    .A1(RES_RES_reg_out),
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
    .A1(RES_RES_reg_out),
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
    .A0(W_W_reg_out),
    .A1(S_S_reg_out),
    .A2(E_E_reg_out),
    .A3(N_N_reg_out),
    .A4(RES_RES_reg_out),
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
    .A0(W_W_reg_out),
    .A1(S_S_reg_out),
    .A2(E_E_reg_out),
    .A3(N_N_reg_out),
    .A4(RES_RES_reg_out),
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

// switch matrix multiplexer data_in3 MUX-6
cus_mux81_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux81_buf_pack_data_in3 (
    .A0(Y),
    .A1(const_out),
    .A2(in3),
    .A3(in2),
    .A4(in1),
    .A5(in0),
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

// switch matrix multiplexer A MUX-4
cus_mux41_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux41_buf_pack_A (
    .A0(in3),
    .A1(in2),
    .A2(in1),
    .A3(in0),
    .S0(ConfigBits[19]),
    .S0N(ConfigBits_N[19]),
    .S1(ConfigBits[20]),
    .S1N(ConfigBits_N[20]),
    .X(A)
);

// switch matrix multiplexer B MUX-5
cus_mux81_buf_pack #(
    .WIDTH(6'd32)
) inst_cus_mux81_buf_pack_B (
    .A0(const_out),
    .A1(in3),
    .A2(in2),
    .A3(in1),
    .A4(in0),
    .A5(GND),
    .A6(GND),
    .A7(GND),
    .S0(ConfigBits[21]),
    .S0N(ConfigBits_N[21]),
    .S1(ConfigBits[22]),
    .S1N(ConfigBits_N[22]),
    .S2(ConfigBits[23]),
    .S2N(ConfigBits_N[23]),
    .X(B)
);

// switch matrix multiplexer RES_reg_in MUX-1
assign RES_RES_reg_in = data_out;
// switch matrix multiplexer N_reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_N_reg_in (
    .A0(N_N_reg_out),
    .A1(in0),
    .S(ConfigBits[24]),
    .X(N_N_reg_in)
);

// switch matrix multiplexer E_reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_E_reg_in (
    .A0(E_E_reg_out),
    .A1(in1),
    .S(ConfigBits[25]),
    .X(E_E_reg_in)
);

// switch matrix multiplexer S_reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_S_reg_in (
    .A0(S_S_reg_out),
    .A1(in2),
    .S(ConfigBits[26]),
    .X(S_S_reg_in)
);

// switch matrix multiplexer W_reg_in MUX-2
cus_mux21_pack #(
    .WIDTH(6'd32)
) inst_cus_mux21_pack_W_reg_in (
    .A0(W_W_reg_out),
    .A1(in3),
    .S(ConfigBits[27]),
    .X(W_W_reg_in)
);

endmodule

