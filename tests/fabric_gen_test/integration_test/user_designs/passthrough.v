`default_nettype none

module passthrough (
    input  wire [3:0] a,
    output wire [3:0] b
);

    assign b = a;

endmodule

`default_nettype wire
