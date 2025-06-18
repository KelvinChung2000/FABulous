module pre_gen_graph_loop #(parameter WIDTH=32);

localparam add_op = 0;
localparam br_op = 1;
localparam const_op = 2;
localparam icmp_op = 3;
localparam input_op = 4;
localparam load_op = 5;
localparam mul_op = 6;
localparam output_op = 7;
localparam phi_op = 8;

wire[WIDTH-1:0] const0;
wire[WIDTH-1:0] i0_phi;
wire[WIDTH-1:0] const1;
wire[WIDTH-1:0] i1_phi;
wire[WIDTH-1:0] const2;
wire[WIDTH-1:0] i3_data_size1;
wire[WIDTH-1:0] i3_mul1;
wire[WIDTH-1:0] i3_add1;
wire[WIDTH-1:0] i4_load;
wire[WIDTH-1:0] const3;
wire[WIDTH-1:0] i5_data_size1;
wire[WIDTH-1:0] i5_mul1;
wire[WIDTH-1:0] i5_add1;
wire[WIDTH-1:0] i6_load;
wire[WIDTH-1:0] i7_mul;
wire[WIDTH-1:0] i8_add;
wire[WIDTH-1:0] i9_add;
wire[WIDTH-1:0] input0;
wire[WIDTH-1:0] i10_icmp;
wire[WIDTH-1:0] bb0;
wire[WIDTH-1:0] bb1;
wire[WIDTH-1:0] i11_br;
wire[WIDTH-1:0] i8_output;

// Output: i11_br -> out_i11_br
assign output_out_i11_br = i11_br;
// Output: i8_output -> out_i8_output
assign output_out_i8_output = i8_output;

const_unit #(.ConfigBits(1)) inst_const0(.const_out(const0));
ALU #(.ALU_func(phi_op)) inst_i0_phi(.data_in1(const0), .data_in2(i9_add), .data_in3(1'b0), .data_out(i0_phi));
const_unit #(.ConfigBits(0)) inst_const1(.const_out(const1));
ALU #(.ALU_func(phi_op)) inst_i1_phi(.data_in1(const1), .data_in2(i8_add), .data_in3(1'b0), .data_out(i1_phi));
const_unit #(.ConfigBits(4)) inst_const2(.const_out(const2));
const_unit #(.ConfigBits(4)) inst_i3_data_size1(.const_out(i3_data_size1));
ALU #(.ALU_func(mul_op)) inst_i3_mul1(.data_in1(i0_phi), .data_in2(i3_data_size1), .data_in3(1'b0), .data_out(i3_mul1));
ALU #(.ALU_func(add_op)) inst_i3_add1(.data_in1(const2), .data_in2(i3_mul1), .data_in3(1'b0), .data_out(i3_add1));
ALU #(.ALU_func(load_op)) inst_i4_load(.data_in1(i3_add1), .data_in2(32'b0), .data_in3(1'b0), .data_out(i4_load));
const_unit #(.ConfigBits(36)) inst_const3(.const_out(const3));
const_unit #(.ConfigBits(4)) inst_i5_data_size1(.const_out(i5_data_size1));
ALU #(.ALU_func(mul_op)) inst_i5_mul1(.data_in1(i0_phi), .data_in2(i5_data_size1), .data_in3(1'b0), .data_out(i5_mul1));
ALU #(.ALU_func(add_op)) inst_i5_add1(.data_in1(const3), .data_in2(i5_mul1), .data_in3(1'b0), .data_out(i5_add1));
ALU #(.ALU_func(load_op)) inst_i6_load(.data_in1(i5_add1), .data_in2(32'b0), .data_in3(1'b0), .data_out(i6_load));
ALU #(.ALU_func(mul_op)) inst_i7_mul(.data_in1(i4_load), .data_in2(i6_load), .data_in3(1'b0), .data_out(i7_mul));
ALU #(.ALU_func(add_op)) inst_i8_add(.data_in1(i1_phi), .data_in2(i7_mul), .data_in3(1'b0), .data_out(i8_add));
ALU #(.ALU_func(add_op)) inst_i9_add(.data_in1(const0), .data_in2(i0_phi), .data_in3(1'b0), .data_out(i9_add));
const_unit #(.ConfigBits(0)) inst_input0(.const_out(input0));
compare #(.conf(0)) inst_i10_icmp(.A(i9_add), .B(input0), .Y(i10_icmp));
const_unit #(.ConfigBits(0)) inst_bb0(.const_out(bb0));
const_unit #(.ConfigBits(0)) inst_bb1(.const_out(bb1));
ALU #(.ALU_func(br_op)) inst_i11_br(.data_in1(i10_icmp), .data_in2(bb0), .data_in3(bb1), .data_out(i11_br));
ALU #(.ALU_func(output_op)) inst_i8_output(.data_in1(i8_add), .data_in2(32'b0), .data_in3(1'b0), .data_out(i8_output));

endmodule
