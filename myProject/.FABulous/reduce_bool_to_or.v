module \$reduce_bool #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 32,
    parameter Y_WIDTH = 1
) (
    input wire[A_WIDTH-1:0] A,
    output wire[Y_WIDTH-1:0] Y
);
    \$reduce_or #(
        .A_WIDTH(A_WIDTH),
        .Y_WIDTH(Y_WIDTH),
        .A_SIGNED(A_SIGNED)
    ) 
    _TECHMAP_REPLACE_ (
        .A(A),
        .Y(Y)
    );
endmodule