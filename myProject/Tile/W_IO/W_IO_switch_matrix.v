module W_IO_switch_matrix #(
    parameter NoConfigBits = 2
)(
    output [31:0] out1,
    output [31:0] W_from_fabric,
    input [31:0] W_to_fabric,
    input [31:0] in1,
    input [NoConfigBits - 1:0] ConfigBits,
    input [NoConfigBits - 1:0] ConfigBits_N
);

localparam reg GND = 32'd0;
localparam reg VCC = 32'd1;

// switch matrix multiplexer out1 MUX-1
assign out1 = W_to_fabric;
// switch matrix multiplexer from_fabric MUX-1
assign W_from_fabric = in1;
endmodule
