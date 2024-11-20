module test #(parameter WIDTH=1);

localparam reg_op = 1;
localparam add_op = 0;
wire[WIDTH-1:0] a;
wire[WIDTH-1:0] inA;
wire[WIDTH-1:0] inB;
wire[WIDTH-1:0] inC;
wire[WIDTH-1:0] b;
OutputOp #(.WIDTH(WIDTH)) out_b(.A(b));
BinaryOp #(.OP(add_op), .WIDTH(WIDTH)) inst_a(.A(inA), .B(inB), .Y(a));
BinaryOp #(.OP(add_op), .WIDTH(WIDTH)) inst_b(.A(a), .B(inC), .Y(b));
InputOp #(.WIDTH(WIDTH)) inst_inA(.Y(inA));
InputOp #(.WIDTH(WIDTH)) inst_inB(.Y(inB));
InputOp #(.WIDTH(WIDTH)) inst_inC(.Y(inC));

endmodule
