module IO #(
) (
    (* FABulous, BUS *) input from_fabric,
    (* FABulous, BUS *) output to_fabric,
    (* FABulous, BUS, EXTERNAL *) input in,
    (* FABulous, BUS, EXTERNAL *) output out,
    (* FABulous, CONFIG_BIT, FEATURE="IO", ONE_HOT *) input ConfigBits
);
endmodule
