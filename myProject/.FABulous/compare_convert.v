module \$gt (A, B, Y);

    parameter A_SIGNED = 0;
    parameter B_SIGNED = 0;
    parameter A_WIDTH = 0;
    parameter B_WIDTH = 0;
    parameter Y_WIDTH = 0;

    input [A_WIDTH-1:0] A;
    input [B_WIDTH-1:0] B;
    output [Y_WIDTH-1:0] Y;

    genvar i;
    generate begin

        \$le #(
            .A_SIGNED(A_SIGNED),
            .B_SIGNED(B_SIGNED),
            .A_WIDTH(A_WIDTH),
            .B_WIDTH(B_WIDTH),
            .Y_WIDTH(Y_WIDTH)
        ) le_gate (
            .A(B),
            .B(A),
            .Y(Y)
        );

    end endgenerate
endmodule

module \$ge (A, B, Y);

    parameter A_SIGNED = 0;
    parameter B_SIGNED = 0;
    parameter A_WIDTH = 0;
    parameter B_WIDTH = 0;
    parameter Y_WIDTH = 0;

    input [A_WIDTH-1:0] A;
    input [B_WIDTH-1:0] B;
    output [Y_WIDTH-1:0] Y;
;
    generate begin

        \$lt #(
            .A_SIGNED(A_SIGNED),
            .B_SIGNED(B_SIGNED),
            .A_WIDTH(A_WIDTH),
            .B_WIDTH(B_WIDTH),
            .Y_WIDTH(Y_WIDTH)
        ) le_gate (
            .A(B),
            .B(A),
            .Y(Y)
        );

    end endgenerate
endmodule

