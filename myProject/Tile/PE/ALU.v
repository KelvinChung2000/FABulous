module ALU #(parameter NoConfigBits = 3) (
    input wire rst,
    input wire en,
    (* FABulous, USER_CLK *)input wire clk,
    (* FABulous, BUS *)input wire [7:0] data_in1,
    (* FABulous, BUS *)input wire [7:0] data_in2,
    (* FABulous, BUS *)output wire [7:0] data_out,
    (* FABulous, CONFIG_BIT, ALU *) input [NoConfigBits:0] ConfigBits
);
    
endmodule
