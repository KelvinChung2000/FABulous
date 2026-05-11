// Adapted from mole99/tt-fabulous-ihp-26a for the FABulous demo fabric.
//
// Upstream uses a `GBUF` global clock buffer driven from a regular IO pin;
// the FABulous demo fabric has no `GBUF` and cannot route a multi-fanout
// clock from an IO bel through the regular routing. Use the demo's
// `Global_Clock` primitive instead, which nextpnr-fabulous places at
// X0Y0/CLK and routes via dedicated clock wires. From the cocotb side the
// same wire is the eFPGA top-level `UserCLK` input, so the testbench drives
// `dut.UserCLK` to step the design.

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
