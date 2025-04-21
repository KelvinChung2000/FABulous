(* blackbox *)
module Mem #(
    parameter config_bits = 0
)
(
    input wire[31:0] addr0,
    input wire reset,
    input wire[31:0] write_data,
    input wire write_en,
    output reg[31:0] read_data,
    input wire clk
);

endmodule

