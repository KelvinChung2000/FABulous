module MUX64(A, B, S, Y);
    input wire[63:0] A;
    input wire[63:0] B;
    input wire S;
    output reg[63:0] Y;

    assign Y = S ? A : B;

endmodule