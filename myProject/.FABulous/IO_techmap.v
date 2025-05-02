module \$__external_in #(
    parameter WIDTH = 32,
)
(
    input wire[WIDTH-1:0] I,
    output wire[WIDTH-1:0] O
);

wire [31:0] I_32;
wire [31:0] O_32;
assign I_32 = I;
assign O = O_32;

IO #(.WIDTH(32)) _TECHMAP_REPLACE_ (
    .from_fabric(),
    .to_fabric(O_32),
    .in(I_32),
    .out()
);

endmodule

module \$__external_out #(
    parameter WIDTH = 32,
)
(
    input wire[WIDTH-1:0] I,
    output wire[WIDTH-1:0] O
);
wire [31:0] I_32;
wire [31:0] O_32;
assign I_32 = I;
assign O = O_32;

IO #(.WIDTH(32)) _TECHMAP_REPLACE_ (
    .from_fabric(I_32),
    .to_fabric(),
    .in(),
    .out(O_32)
);

endmodule