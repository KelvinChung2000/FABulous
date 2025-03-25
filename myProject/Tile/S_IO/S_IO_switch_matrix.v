module S_IO_switch_matrix #(
    parameter NoConfigBits = 0
)
(
    output reg[31:0] out0,
    output reg[31:0] S_from_fabric,
    input wire[31:0] S_to_fabric,
    input wire[31:0] in0
);

localparam GND = 32'd0;
localparam VCC = 32'd1;

// switch matrix multiplexer out0 MUX-1
assign out0 = S_to_fabric;
// switch matrix multiplexer S_from_fabric MUX-1
assign S_from_fabric = in0;
endmodule

