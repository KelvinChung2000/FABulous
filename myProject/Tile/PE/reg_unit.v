module reg_unit #(
    parameter NoConfigBits = 3,
    parameter WIDTH = 32
) (
    (* FABulous, CONTROL *)input wire rst,
    (* FABulous, CONTROL *)input wire en,
    (* FABulous, USER_CLK *) input wire clk,
    (* FABulous, BUS, DATA *) input  wire [WIDTH-1:0] reg_in,
    (* FABulous, BUS, DATA *) output wire [WIDTH-1:0] reg_out
);

always @(posedge clk) begin
    if (rst) begin
        reg_out <= 0;
    end
    else if (en) begin
        reg_out <= reg_in;
    end
end

endmodule
