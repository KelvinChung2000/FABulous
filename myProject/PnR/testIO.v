module test #(
    parameter WIDTH = 1
);

  localparam add_op = 0;
  localparam reg_op = 1;
  wire [WIDTH-1:0] a;
  wire [WIDTH-1:0] inA;
  wire [WIDTH-1:0] inB;
  (*BEL="X0Y1/0_W_IO"*) OutputOp #(.WIDTH(WIDTH)) out_b (.A(a));
  (*BEL="X1Y1/0_ALU"*)BinaryOp #(
      .OP(add_op),
      .WIDTH(WIDTH)
  ) inst_a (
      .A(inA),
      .B(),
      .Y(a)
  );
  (*BEL="X1Y0/0_S_IO"*) InputOp #(.WIDTH(WIDTH)) inst_inA (.Y(inA));
//   InputOp #(.WIDTH(WIDTH)) inst_inB (.Y(inB));

endmodule
