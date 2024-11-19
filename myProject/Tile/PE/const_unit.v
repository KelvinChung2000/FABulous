module const_unit #(
    parameter NoConfigBits = 3
) (
    input wire rst,
    input wire en,
    (* FABulous, USER_CLK *) input wire clk,
    (* FABulous, BUS *) output wire [7:0] const_out,
    (* FABulous, CONFIG_BIT, CONST *) input [NoConfigBits:0] ConfigBits
);

endmodule
