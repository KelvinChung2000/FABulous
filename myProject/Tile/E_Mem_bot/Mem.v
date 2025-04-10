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
    
    (* FABulous, CONFIG_BIT, FEATURE="READ_ALLOW" *)
    input read_allow,
    (* FABulous, CONFIG_BIT, FEATURE="WRITE_ALLOW" *)
    input write_allow
);

  logic [WIDTH-1:0] mem[SIZE-1:0];

  /* verilator lint_off WIDTH */
  always_comb begin
    if (read_allow) begin
      read_data = mem[addr0[IDX_SIZE-1:0]];
    end else begin
      read_data = {{WIDTH{1'b0}}};
    end
  end

  always_ff @(posedge clk) begin
    if (write_en & write_allow) begin
      mem[addr0[IDX_SIZE-1:0]] <= write_data;
    end
  end

endmodule
