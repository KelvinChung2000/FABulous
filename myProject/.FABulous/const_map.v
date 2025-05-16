module \$__const #(
    parameter WIDTH = 0,
    parameter VALUE = 0
)
(
    output wire [WIDTH-1:0] O
);

if (WIDTH == 32)
    const_unit #(
        .ConfigBits(VALUE),
        .WIDTH(WIDTH)
    ) _TECHMAP_REPLACE_ (
        .const_out(O)
    );
else if (WIDTH == 1 && VALUE == 0)
    GND_DRV #() 
    _TECHMAP_REPLACE_ (
        .O(O)
    );
else if (WIDTH == 1 && VALUE == 1)
    VCC_DRV #() 
    _TECHMAP_REPLACE_ (
        .O(O)
    );
else
    assign O = VALUE;

endmodule