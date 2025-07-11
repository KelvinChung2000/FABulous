module \$__external_in #(
    parameter WIDTH = 32
)
(
    input wire[WIDTH-1:0] I,
    output wire[WIDTH-1:0] O
);

wire [WIDTH-1:0] I_WIDTH;
wire [WIDTH-1:0] O_WIDTH;
assign I_WIDTH = I;
assign O = O_WIDTH;

if (WIDTH <= 1)
    IO_WIDTH_1 #(.WIDTH(WIDTH)) _TECHMAP_REPLACE_ (
        .from_fabric(),
        .to_fabric(O_WIDTH),
        .in(I_WIDTH),
        .out()
    );
else if (WIDTH <= 32)
    IO #(.WIDTH(WIDTH)) _TECHMAP_REPLACE_ (
        .from_fabric(),
        .to_fabric(O_WIDTH),
        .in(I_WIDTH),
        .out()
    );
else
    wire _TECHMAP_FAIL_ = 1;

endmodule

module \$__external_out #(
    parameter WIDTH = 32
)
(
    input wire[WIDTH-1:0] I,
    output wire[WIDTH-1:0] O
);
wire [WIDTH-1:0] I_WIDTH;
wire [WIDTH-1:0] O_WIDTH;
assign I_WIDTH = I;
assign O = O_WIDTH;

if (WIDTH <= 1)
    IO_WIDTH_1 #(.WIDTH(WIDTH)) _TECHMAP_REPLACE_ (
        .from_fabric(I_WIDTH),
        .to_fabric(),
        .in(),
        .out(O_WIDTH)
    );
else if (WIDTH <= 32)
    IO #(.WIDTH(WIDTH)) _TECHMAP_REPLACE_ (
        .from_fabric(I_WIDTH),
        .to_fabric(),
        .in(),
        .out(O_WIDTH)
    );
else
    wire _TECHMAP_FAIL_ = 1;

endmodule
