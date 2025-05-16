module test(
    input wire [3:0]A,
    input wire [3:0]B,
    output wire Y0,
    output wire Y1,
    output wire Y2
);

assign Y0 = (!A);
assign Y1 = (A && B);
assign Y2 = (A || B);

endmodule