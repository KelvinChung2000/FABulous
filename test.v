module ne(
    input wire [8:0] A,
    input wire [8:0] B,
    output wire Y
);

assign Y = A != B;

endmodule