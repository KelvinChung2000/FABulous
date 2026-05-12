`default_nettype none

module addition (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [4:0] c
);

    assign c = a + b;

endmodule

`default_nettype wire
