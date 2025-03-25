module W_IO_switch_matrix #(
    parameter NoConfigBits = 0
)
(
    output reg[31:0] out1,
    output reg[31:0] W_from_fabric,
    input wire[31:0] W_to_fabric,
    input wire[31:0] in1
);

localparam GND = 32'd0;
localparam VCC = 32'd1;

// switch matrix multiplexer out1 MUX-1
assign out1 = W_to_fabric;
// switch matrix multiplexer W_from_fabric MUX-1
assign W_from_fabric = in1;
endmodule

