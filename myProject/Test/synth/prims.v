module add(input [7:0] srcA, input [7:0] srcB, output [7:0] out);
  assign out = srcA + srcB;
endmodule

module INBUF (
    input PAD,
    output O,
  );
  assign O = PAD;
endmodule

module OUTBUF (
    output PAD,
    input I,
  );
  assign PAD = I;
endmodule
