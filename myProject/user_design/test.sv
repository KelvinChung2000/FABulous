module std_add #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out
);
  assign out = left + right;
endmodule


module std_reg #(
    parameter WIDTH = 32
) (
    (* write_together=1, data=1 *) input wire logic [WIDTH-1:0] in,
    (* write_together=1, interval=1, go=1 *) input wire logic write_en,
    (* clk=1 *) input wire logic clk,
    (* reset=1 *) input wire logic reset,
    (* stable=1, data=1 *) output wire logic [WIDTH-1:0] out,
    (* done=1 *) output wire logic done
);
  always_ff @(posedge clk) begin
    if (reset) begin
      out  <= 0;
      done <= 0;
    end else if (write_en) begin
      out  <= in;
      done <= 1'd1;
    end else done <= 1'd0;
  end
endmodule


module test(
    input logic clk,
    input logic reset,
    input logic [31:0] A,
    input logic [31:0] B,
    output logic [31:0] Y
);

logic [31:0] C_out;
logic [31:0] reg_out;

std_add #(
    .WIDTH(32)
) adder1 (
    .left(A),
    .right(B),
    .out(C_out)
);

std_reg #(
    .WIDTH(32)
) regs (
    .in(C_out),
    .write_en(1),
    .clk(clk),
    .reset(reset),
    .out(reg_out),
    .done()
);

std_add #(
    .WIDTH(32)
) adder2 (
    .left (reg_out),
    .right('d7),
    .out  (Y)
);

endmodule
