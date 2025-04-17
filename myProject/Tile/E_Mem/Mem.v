(* CELL *)
module Mem #(
    parameter WIDTH = 32,
    parameter SIZE = 16,
    parameter IDX_SIZE = 4
) (
    input wire [WIDTH-1:0] addr0,
    input wire [WIDTH-1:0] write_data,
    input wire write_en,
    
    (* FABulous, USER_CLK*)
    input wire clk,
    
    input wire reset,
    output reg [WIDTH-1:0] read_data,
);

  logic [WIDTH-1:0] mem[SIZE-1:0];
  assign read_data = mem[addr0[IDX_SIZE-1:0]]; 

  always_ff @(posedge clk) begin
    if (write_en)
      mem[addr0[IDX_SIZE-1:0]] <= write_data;
  end

endmodule
