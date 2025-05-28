module test (
    input wire [31:0] A,
    input wire  A2,
    input wire [31:0] B,
    output wire [31:0] Y,
    output wire [31:0] Y3,
    output wire Y2,
    input wire C
);

// ALU alu1(
//     .data_in1(A),
//     .data_in2(B),
//     .data_in3(),
//     .data_out(Y)
// );

reg_unit_WIDTH_1 reg1(
    .reg_in(A2),
    .reg_out(Y2),
    .en(C),
    .rst()
);

reg_unit reg2(
    .reg_in(A),
    .reg_out(Y3),
    .en(C),
    .rst()
);

endmodule
