module INBUF #(parameter WIDTH = 8) (
    input [WIDTH-1:0] PAD,
    output [WIDTH-1:0] O
);
    assign O = PAD;
endmodule

module OUTBUF #(parameter WIDTH = 8) (
    output [WIDTH-1:0] PAD,
    input [WIDTH-1:0] I
);
    assign PAD = I;
endmodule
