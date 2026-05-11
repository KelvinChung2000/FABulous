// Adapted from mole99/tt-fabulous-ihp-26a for the FABulous demo fabric.

`default_nettype none

module multiplication (
    input  wire [2:0] mult_a,
    input  wire [2:0] mult_b,
    output wire [5:0] product
);

    assign product = mult_a * mult_b;

endmodule

`default_nettype wire
