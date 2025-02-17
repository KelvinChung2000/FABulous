module S_IO_switch_matrix #(
    parameter NoConfigBits = 4
)(
    output [31:0] out2,
    output [31:0] out0,
    output S_from_fabric,
    input [31:0] in0,
    input [31:0] in2,
    input [NoConfigBits - 1:0] ConfigBits,
    input [NoConfigBits - 1:0] ConfigBits_N
);

localparam reg GND0 = 0;localparam reg GND = 0;localparam reg VCC0 = 1;localparam reg VCC = 1;localparam reg VDD0 = 1;localparam reg VDD = 1;// switch matrix multiplexer out2 MUX-1assign out2 = in0;// switch matrix multiplexer out0 MUX-1assign out0 = in2;// switch matrix multiplexer from_fabric MUX-0// WARNING unused multiplexer MUX-BelPort(input S_from_fabric[0:0])
endmodule
