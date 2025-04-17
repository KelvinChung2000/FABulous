(* ARITH, CELL *)
module const_unit #(
    parameter NoConfigBits = 3,
    parameter WIDTH = 32
) (
    (* FABulous, BUS, DATA *) output wire [WIDTH-1:0] const_out,
    (* FABulous, CONFIG_BIT, INIT, FEATURE="const_value" *) input [7:0] ConfigBits
);

assign const_out = {{(WIDTH-8){ConfigBits[7]}}, ConfigBits[7:0]};

endmodule
