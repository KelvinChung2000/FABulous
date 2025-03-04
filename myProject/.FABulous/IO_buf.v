module INBUF #() (
    input  PAD,
    output  O
);
    assign O = PAD;
endmodule

module OUTBUF #() (
    output  PAD,
    input I
);
    assign PAD = I;
endmodule
