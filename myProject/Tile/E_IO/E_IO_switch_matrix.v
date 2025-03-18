module E_IO_switch_matrix #(
    parameter NoConfigBits = 0
)
(
    output [31:0] out3,
    output [31:0] E_from_fabric,
    input [31:0] E_to_fabric,
    input [31:0] in3
);

localparam GND = 32'd0;
localparam VCC = 32'd1;

// switch matrix multiplexer out3 MUX-1
assign out3 = E_to_fabric;
// switch matrix multiplexer E_from_fabric MUX-1
assign E_from_fabric = in3;
endmodule
