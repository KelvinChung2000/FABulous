module #(WIDTH=32) test;

wire[WIDTH-1:0] i_e_061_reg2mem30;
wire[WIDTH-1:0] i_cnt_160_reg2mem28;
wire[WIDTH-1:0] i_arrayidx18;
wire[WIDTH-1:0] i_edges;
wire[WIDTH-1:0] i_level;
wire[WIDTH-1:0] i_cmp21_const;
wire[WIDTH-1:0] i_0;
wire[WIDTH-1:0] i_inc;
wire[WIDTH-1:0] i_inc_const;
wire[WIDTH-1:0] i_inc27;
wire[WIDTH-1:0] i_inc27_const;
wire[WIDTH-1:0] i_4;
wire[WIDTH-1:0] i_arrayidx19_0;
ConstOp #(.CONST(0), .WIDTH(WIDTH)) inst_i_e_061_reg2mem30(.Y(i_e_061_reg2mem30));
ConstOp #(.CONST(0), .WIDTH(WIDTH)) inst_i_cnt_160_reg2mem28(.Y(i_cnt_160_reg2mem28));
BinaryOp #(.OP(gepLoad), .WIDTH(WIDTH)) inst_i_arrayidx18(.A(i_edges), .B(i_e_061_reg2mem30), .Y(i_arrayidx18));
InputOp #(.WIDTH(WIDTH)) i_edges(.Y(i_edges));
InputOp #(.WIDTH(WIDTH)) i_level(.Y(i_level));
BinaryOp #(.OP(cmp), .WIDTH(WIDTH)) inst_i_cmp21(.A(i_arrayidx19_0), .B(i_cmp21_const), .Y(i_cmp21));
ConstOp #(.CONST(127), .WIDTH(WIDTH)) inst_i_cmp21_const(.Y(i_cmp21_const));
InputOp #(.WIDTH(WIDTH)) i_0(.Y(i_0));
BinaryOp #(.OP(add), .WIDTH(WIDTH)) inst_i_inc(.A(i_cnt_160_reg2mem28), .B(i_inc_const), .Y(i_inc));
ConstOp #(.CONST(1), .WIDTH(WIDTH)) inst_i_inc_const(.Y(i_inc_const));
UnaryOp #(.OP(reg), .WIDTH(WIDTH)) inst_i_cnt_2_reg2mem26(.A(i_inc), .Y(i_cnt_2_reg2mem26);
BinaryOp #(.OP(add), .WIDTH(WIDTH)) inst_i_inc27(.A(i_e_061_reg2mem30), .B(i_inc27_const), .Y(i_inc27));
ConstOp #(.CONST(1), .WIDTH(WIDTH)) inst_i_inc27_const(.Y(i_inc27_const));
BinaryOp #(.OP(cmp), .WIDTH(WIDTH)) inst_i_exitcond_not(.A(i_inc27), .B(i_4), .Y(i_exitcond_not));
InputOp #(.WIDTH(WIDTH)) i_4(.Y(i_4));
BinaryOp #(.OP(gepLoad), .WIDTH(WIDTH)) inst_i_arrayidx19_0(.A(i_level), .B(i_arrayidx18), .Y(i_arrayidx19_0));
TernaryOp #(.OP(gepStore), .WIDTH(WIDTH)) inst_i_arrayidx19_1(.A(i_arrayidx18), .B(i_level), .C(i_0), .Y(i_arrayidx19_1));

endmodule