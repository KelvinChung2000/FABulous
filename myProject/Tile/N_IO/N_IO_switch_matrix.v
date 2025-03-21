module N_IO_switch_matrix #(
    parameter NoConfigBits = 0
)
(
    output reg[31:0] out2,
    output reg[31:0] N_from_fabric,
    input wire[31:0] N_to_fabric,
    input wire[31:0] in2
);

localparam GND = 32'd0;
localparam VCC = 32'd1;

// switch matrix multiplexer out2 MUX-1
assign out2 = N_to_fabric;
// switch matrix multiplexer N_from_fabric MUX-1
assign N_from_fabric = in2;
endmodule
