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

module CLK_DRV #() (
    output  CLK_O
);

endmodule

module GND_DRV #() (
    output O
);

endmodule

module VCC_DRV #() (
    output O
);

endmodule