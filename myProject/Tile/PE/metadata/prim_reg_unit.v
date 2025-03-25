(* blackbox *)
module reg_unit #(
    parameter tide_en = 0,
    parameter tide_rst = 0
)
(
    input wire en,
    input wire[31:0] reg_in,
    input wire rst,
    output reg[31:0] reg_out,
    input wire clk
);

endmodule

