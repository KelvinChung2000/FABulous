

module test();
  logic sel;
  logic [31:0] A;
  logic [31:0] B;
  logic [31:0] C;
  assign C = sel? A : B;
endmodule
