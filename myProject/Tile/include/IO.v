(* CELL, IO *)
module IO #(
    parameter WIDTH = 32
) (
    (* FABulous, DATA *) input [WIDTH-1:0] from_fabric,
    (* FABulous, DATA *) output [WIDTH-1:0] to_fabric,
    (* FABulous, EXTERNAL *) input [WIDTH-1:0] in,
    (* FABulous, EXTERNAL *) output [WIDTH-1:0] out
);

    assign out = from_fabric;
    assign to_fabric = in;

endmodule
