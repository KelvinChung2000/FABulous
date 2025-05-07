module reduce_or(
    input wire [8:0] A,
    output wire Y
);

assign Y = |A;

endmodule