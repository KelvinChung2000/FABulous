module reg_unit #(
    parameter NoConfigBits = 2,
    parameter WIDTH = 32
) (
    input wire rst,
    input wire en,
    (* FABulous, USER_CLK *) input wire clk,
    (* FABulous, BUS, DATA *) input  wire [WIDTH-1:0] reg_in,
    (* FABulous, BUS, DATA *) output reg [WIDTH-1:0] reg_out,
    (* FABulous, CONFIG_BIT, FEATURE="tide_en" *) input wire tide_en,
    (* FABulous, CONFIG_BIT, FEATURE="tide_rst" *) input wire tide_rst
);

always @(posedge clk) begin
    if (rst & tide_rst) begin
        reg_out <= 32'b0;
    end
    else if (en | tide_en) begin
        reg_out <= reg_in;
    end
end

endmodule
