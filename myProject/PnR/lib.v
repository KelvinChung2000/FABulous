(* blackbox, keep *)
module ConstOp #(
    parameter WIDTH = 32,
    parameter CONST = 0
  )(
    output [WIDTH-1:0] Y
  );
endmodule

(* blackbox, keep *)
module UnaryOp #(
    parameter WIDTH = 32,
    parameter OP = 0
  )(
    input [WIDTH-1:0] A,
    output [WIDTH-1:0] Y
  );
endmodule

(* blackbox, keep *)
module BinaryOp #(
    parameter WIDTH = 32,
    parameter OP = 0
  )(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    output [WIDTH-1:0] Y
  );
endmodule

(* blackbox, keep *)
module TernaryOp #(
    parameter WIDTH = 32,
    parameter OP = 0
  )(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [WIDTH-1:0] C,
    output [WIDTH-1:0] Y
  );
endmodule

(* blackbox, keep *)
module InputOp #(
    parameter WIDTH = 32
  )(
    output [WIDTH-1:0] Y
  );
endmodule

(* blackbox, keep *)
module OutputOp #(
    parameter WIDTH = 32
  )(
    input [WIDTH-1:0] A
  );
endmodule

