module nomem2 #(parameter WIDTH=32);

localparam add_op = 0;
localparam const_op = 1;
localparam icmp_op = 2;
localparam io_width_1_op = 3;
localparam mul_op = 4;

wire global_en;
wire global_rst;

wire[WIDTH-1:0] const1;
wire[WIDTH-1:0] i3_mul;
wire[WIDTH-1:0] const2;
wire[WIDTH-1:0] i4_add;
wire[WIDTH-1:0] i5_add;
wire[WIDTH-1:0] const3;
wire[WIDTH-1:0] i6_add;
wire[WIDTH-1:0] input0;
wire i7_icmp;
wire[WIDTH-1:0] const1_alu;
wire[WIDTH-1:0] i3_mul_alu;
wire[WIDTH-1:0] const2_alu;
wire[WIDTH-1:0] i4_add_alu;
wire[WIDTH-1:0] i5_add_alu;
wire[WIDTH-1:0] const3_alu;
wire[WIDTH-1:0] i6_add_alu;
wire[WIDTH-1:0] i5_output_alu;
wire[WIDTH-1:0] i8_br;
wire[WIDTH-1:0] i5_output;


IO_WIDTH_1 inst_global_en(.from_fabric(), .in(), .to_fabric(global_en), .out());
IO_WIDTH_1 inst_global_rst(.from_fabric(), .in(), .to_fabric(global_rst), .out());

const_unit #(.ConfigBits(3)) inst_const1(.const_out(const1));
ALU #(.ALU_func(mul_op)) inst_i3_mul(.data_in1(const1), .data_in2(i6_add), .data_in3(), .data_out(i3_mul_alu));
reg_unit #(.tide_en(0), .tide_rst(0)) inst_i3_mul_reg(.reg_in(i3_mul_alu), .reg_out(i3_mul), .en(global_en), .rst(global_rst));
const_unit #(.ConfigBits(5)) inst_const2(.const_out(const2));
ALU #(.ALU_func(add_op)) inst_i4_add(.data_in1(i3_mul), .data_in2(const2), .data_in3(), .data_out(i4_add_alu));
reg_unit #(.tide_en(0), .tide_rst(0)) inst_i4_add_reg(.reg_in(i4_add_alu), .reg_out(i4_add), .en(global_en), .rst(global_rst));
ALU #(.ALU_func(add_op)) inst_i5_add(.data_in1(i4_add), .data_in2(i5_add), .data_in3(), .data_out(i5_add_alu));
reg_unit #(.tide_en(0), .tide_rst(0)) inst_i5_add_reg(.reg_in(i5_add_alu), .reg_out(i5_add), .en(global_en), .rst(global_rst));
const_unit #(.ConfigBits(1)) inst_const3(.const_out(const3));
ALU #(.ALU_func(add_op)) inst_i6_add(.data_in1(const3), .data_in2(i6_add), .data_in3(), .data_out(i6_add_alu));
reg_unit #(.tide_en(0), .tide_rst(0)) inst_i6_add_reg(.reg_in(i6_add_alu), .reg_out(i6_add), .en(global_en), .rst(global_rst));
(* keep *) IO inst_input0(.from_fabric(), .in(), .to_fabric(input0), .out());
compare #(.conf(0)) inst_i7_icmp(.A(i6_add), .B(input0), .Y(i7_icmp));
(* keep *) IO_WIDTH_1 inst_i8_br(.from_fabric(i7_icmp), .in(), .to_fabric(), .out());
(* keep *) IO inst_i5_output(.from_fabric(i5_add), .in(), .to_fabric(), .out());

endmodule
