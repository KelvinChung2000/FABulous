`default_nettype none

module counter (
    input  wire       rst,
    input  wire       ena,
    output wire [7:0] d
);

    wire clk;
    (* keep *) Global_Clock clk_i (.CLK(clk));

    reg [7:0] ctr;

    always @(posedge clk) begin
        if (rst) begin
            ctr <= '0;
        end else if (ena) begin
            ctr <= ctr + 1'b1;
        end
    end

    assign d = ctr;

endmodule

`default_nettype wire
