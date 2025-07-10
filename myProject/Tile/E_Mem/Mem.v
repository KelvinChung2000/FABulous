(* MEM *)
module Mem #(
    parameter WIDTH = 32,
    parameter SIZE = 16,
    parameter IDX_SIZE = 16
) (
    input wire [WIDTH-1:0] addr0,
    input wire [WIDTH-1:0] write_data,
    input wire write_en,
    
    (* FABulous, USER_CLK*)
    input wire clk,
    
    input wire reset,
    output reg [WIDTH-1:0] read_data,

    (* FABulous, CONFIG_BIT, FEATURE="AR;SR"*)
    input wire config_bits
);

  logic [WIDTH-1:0] mem[SIZE-1:0];
  logic [WIDTH-1:0] read_data_comb;
  logic [WIDTH-1:0] read_data_sync;

  assign read_data_comb = mem[addr0[IDX_SIZE-1:0]]; 

  always_ff @(posedge clk) begin
    if (write_en)
      mem[addr0[IDX_SIZE-1:0]] <= write_data;

    read_data_sync <= mem[addr0[IDX_SIZE-1:0]];
  end

  assign read_data = config_bits ? read_data_sync : read_data_comb;

endmodule
