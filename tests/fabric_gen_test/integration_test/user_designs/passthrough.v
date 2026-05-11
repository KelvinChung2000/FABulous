// Adapted from mole99/tt-fabulous-ihp-26a/user_designs/designs/tiny/passthrough/
// for the FABulous demo fabric (W_IO column, 4-bit width to fit overlapping
// signal placements in the shared constraints.pcf).

`default_nettype none

module passthrough (
    input  wire [3:0] a,
    output wire [3:0] b
);

    assign b = a;

endmodule

`default_nettype wire
