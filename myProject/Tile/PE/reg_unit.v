module reg_unit #(
    parameter NoConfigBits = 3,
    parameter WIDTH = 32
) (
    input wire rst,
    input wire en,
    (* FABulous, USER_CLK *) input wire clk,
    (* FABulous, BUS *) input  wire [WIDTH-1:0] reg_in,
    (* FABulous, BUS *) output wire [WIDTH-1:0] reg_out,
    (* FABulous, CONFIG_BIT, INIT *) input [NoConfigBits:0] ConfigBits
);

endmodule
