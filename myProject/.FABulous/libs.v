(* blackbox *)
module IO #(

)(
    input [31:0] from_fabric,
    input [31:0] in,
    output [31:0] to_fabric,
    output [31:0] out
);

endmodule


(* blackbox *)
module ALU #(
    parameter ALU_func = 0
)(
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
);

endmodule


(* blackbox *)
module reg_unit #(

)(
    input en,
    input [31:0] reg_in,
    input rst,
    output [31:0] reg_out,
    input clk
);

endmodule


(* blackbox *)
module const_unit #(
    parameter ConfigBits = 0
)(
    output [31:0] const_out
);

endmodule


