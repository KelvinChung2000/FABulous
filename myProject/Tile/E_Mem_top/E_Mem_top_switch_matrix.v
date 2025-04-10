module E_Mem_top_switch_matrix #(
    parameter NoConfigBits = 0
)
(
    output reg[31:0] out3,
    output reg[31:0] addr_o,
    input wire[31:0] in3
);

localparam GND = 32'd0;
localparam VCC = 32'd1;

// switch matrix multiplexer out3 MUX-1
assign out3 = in3;
// switch matrix multiplexer addr_o MUX-1
assign addr_o = in3;
endmodule

