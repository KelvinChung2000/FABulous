module \$neg (A,  Y);

    parameter A_SIGNED = 0;
    parameter A_WIDTH = 0;
    parameter Y_WIDTH = 0;
    // add missing parameters used by the instantiated \$add
    parameter B_SIGNED = 0;
    parameter B_WIDTH = Y_WIDTH;

    input [A_WIDTH-1:0] A;
    output [Y_WIDTH-1:0] Y;

    generate begin
        \$add #(
            .A_SIGNED(A_SIGNED),
            .B_SIGNED(B_SIGNED),
            .A_WIDTH(A_WIDTH),
            .B_WIDTH(B_WIDTH),
            .Y_WIDTH(Y_WIDTH)
        ) le_gate (
            .A(~A),
            // construct a constant with Y_WIDTH-1 zeros and a trailing 1
            .B({ {(Y_WIDTH-1){1'b0}}, 1'b1 }),
            .Y(Y)
        );

    end endgenerate
endmodule
