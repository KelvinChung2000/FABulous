(* CELL *)
module IO #(
    parameter WIDTH = 32
) (
    (* FABulous, BUS, DATA *) input [WIDTH-1:0] from_fabric,
    (* FABulous, BUS, DATA *) output [WIDTH-1:0] to_fabric,
    (* FABulous, BUS, EXTERNAL *) input [WIDTH-1:0] in,
    (* FABulous, BUS, EXTERNAL *) output [WIDTH-1:0] out
);

    assign out = from_fabric;
    assign to_fabric = in;

endmodule
