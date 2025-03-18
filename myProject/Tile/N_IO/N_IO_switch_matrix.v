module N_IO_switch_matrix #(
    parameter NoConfigBits = 2
)(
    output [31:0] out2,
    output [31:0] N_from_fabric,
    input [31:0] N_to_fabric,
    input [31:0] in2,
    input [NoConfigBits - 1:0] ConfigBits,
    input [NoConfigBits - 1:0] ConfigBits_N
);

localparam reg GND = 32'd0;
localparam reg VCC = 32'd1;

// switch matrix multiplexer out2 MUX-1
assign out2 = N_to_fabric;
// switch matrix multiplexer from_fabric MUX-1
assign N_from_fabric = in2;
endmodule
