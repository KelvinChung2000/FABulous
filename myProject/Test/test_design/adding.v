
module top ( input wire clk, input wire [7:0] a, input wire [7:0] b, output reg [7:0] dst);
  assign dst = a + b;
endmodule
