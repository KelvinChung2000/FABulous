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

(* blackbox *)
module const_unit #(
    parameter ConfigBits = 0
)
(
    output reg[31:0] const_out
);

endmodule

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
module IO #(
)
(
    input wire[31:0] from_fabric,
    input wire[31:0] in,
    output reg[31:0] to_fabric,
    output reg[31:0] out
);

endmodule

