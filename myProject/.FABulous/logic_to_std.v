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

module \$logic_not #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 32,
    parameter Y_WIDTH = 1
) (
    input wire[A_WIDTH-1:0] A,
    output wire[Y_WIDTH-1:0] Y
);
    \$not #(
        .A_WIDTH(A_WIDTH),
        .Y_WIDTH(Y_WIDTH),
        .A_SIGNED(A_SIGNED)
    ) 
    _TECHMAP_REPLACE_ (
        .A(A),
        .Y(Y)
    );
endmodule

module \$logic_and #(
    parameter A_SIGNED = 0,
    parameter B_SIGNED = 0,
    parameter A_WIDTH = 32,
    parameter B_WIDTH = 32,
    parameter Y_WIDTH = 1
) (
    input wire[A_WIDTH-1:0] A,
    input wire[A_WIDTH-1:0] B,
    output wire[Y_WIDTH-1:0] Y
);
    \$and #(
        .A_SIGNED(A_SIGNED),
        .A_WIDTH(A_WIDTH),
        .B_SIGNED(B_SIGNED),
        .B_WIDTH(B_WIDTH),
        .Y_WIDTH(Y_WIDTH)
    ) 
    _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );
endmodule

module \$logic_or #(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 32,
    parameter B_SIGNED = 0,
    parameter B_WIDTH = 32,
    parameter Y_WIDTH = 1
) (
    input wire[A_WIDTH-1:0] A,
    input wire[A_WIDTH-1:0] B,
    output wire[Y_WIDTH-1:0] Y
);
    \$or #(
        .A_SIGNED(A_SIGNED),
        .A_WIDTH(A_WIDTH),
        .B_SIGNED(B_SIGNED),
        .B_WIDTH(B_WIDTH),
        .Y_WIDTH(Y_WIDTH)
        ) 
    _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );
endmodule