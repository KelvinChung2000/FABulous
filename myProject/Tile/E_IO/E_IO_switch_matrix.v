module E_IO_switch_matrix #(
    parameter NoConfigBits = 2
)(
    output [31:0] out3,
    output [31:0] E_from_fabric,
    input [31:0] E_to_fabric,
    input [31:0] in3,
    input [NoConfigBits - 1:0] ConfigBits,
    input [NoConfigBits - 1:0] ConfigBits_N
);

localparam reg GND = 32'd0;
localparam reg VCC = 32'd1;

// switch matrix multiplexer out3 MUX-1
assign out3 = E_to_fabric;
// switch matrix multiplexer from_fabric MUX-1
assign E_from_fabric = in3;
endmodule
