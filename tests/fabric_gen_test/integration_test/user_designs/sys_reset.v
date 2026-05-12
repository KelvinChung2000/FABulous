`default_nettype none

module sys_reset (
    input  wire       rst,
    input  wire [3:0] a,
    output wire [3:0] b
);

    wire clk;
    (* keep *) Global_Clock clk_i (.CLK(clk));

    reg [3:0] data;

    always @(posedge clk) begin
        if (rst) begin
            data <= 4'h7;
        end else begin
            data <= a;
        end
    end

    assign b = data;

endmodule

`default_nettype wire
