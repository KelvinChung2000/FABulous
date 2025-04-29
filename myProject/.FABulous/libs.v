(* blackbox *)
module ALU #(
    parameter ALU_func = 0
)
(
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire[31:0] data_in3,
    output reg[31:0] data_out
);

endmodule


(* blackbox *)
module reg_unit #(
    parameter tide_en = 0,
    parameter tide_rst = 0
)
(
    input wire RES_en,
    input wire[31:0] RES_reg_in,
    input wire RES_rst,
    output reg[31:0] RES_reg_out,
    input wire RES_clk
);

endmodule


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


(* blackbox *)
module const_unit #(
    parameter ConfigBits = 0
)
(
    output reg[31:0] const_out
);

endmodule


(* blackbox *)
module IO #(
)
(
    input wire[31:0] N_from_fabric,
    input wire[31:0] N_in,
    output reg[31:0] N_to_fabric,
    output reg[31:0] N_out
);

endmodule


(* blackbox *)
module compare #(
    parameter conf = 0
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    output reg[31:0] Y
);

endmodule


