// Adapted from mole99/tt-fabulous-ihp-26a for the FABulous demo fabric.

`default_nettype none

module addition (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [4:0] c
);

    assign c = a + b;

endmodule

`default_nettype wire
