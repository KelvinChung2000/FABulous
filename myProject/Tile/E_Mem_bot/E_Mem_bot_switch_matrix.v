module E_Mem_bot_switch_matrix #(
    parameter NoConfigBits = 0
)
(
    output reg[31:0] out3,
    output reg[31:0] addr0,
    output reg[31:0] write_data,
    input wire[31:0] read_data,
    input wire[31:0] addr_i,
    input wire[31:0] in3
);

localparam GND = 32'd0;
localparam VCC = 32'd1;

// switch matrix multiplexer out3 MUX-1
assign out3 = read_data;
// switch matrix multiplexer addr0 MUX-1
assign addr0 = addr_i;
// switch matrix multiplexer write_data MUX-1
assign write_data = in3;
endmodule

