// Adapted from mole99/tt-fabulous-ihp-26a for the FABulous demo fabric.
//
// Upstream uses a fabric-specific `SYS_RESET` primitive that ships with
// mole99's tile library; the FABulous demo does not have it. We replace it
// with an ordinary reset input pin driven by the testbench. The clock is
// generated via the demo's `Global_Clock` primitive so it lands on the
// global clock network (driven by the eFPGA's top-level `UserCLK` input).

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
