module E_IO_switch_matrix #(
    parameter NoConfigBits = 4
)(
    output [31:0] out1,
    output [31:0] out3,
    output E_from_fabric,
    input [31:0] in3,
    input [31:0] in1,
    input [NoConfigBits - 1:0] ConfigBits,
    input [NoConfigBits - 1:0] ConfigBits_N
);

localparam reg GND0 = 0;
localparam reg GND = 0;
localparam reg VCC0 = 1;
localparam reg VCC = 1;
localparam reg VDD0 = 1;
localparam reg VDD = 1;

// switch matrix multiplexer out1 MUX-1
assign out1 = in3;

// switch matrix multiplexer out3 MUX-1
assign out3 = in1;

// switch matrix multiplexer from_fabric MUX-0
// WARNING unused multiplexer MUX-BelPort(input E_from_fabric[0:0])

endmodule
