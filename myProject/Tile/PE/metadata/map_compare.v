(* techmap_celltype = "compare_conf_0" *)
module map_compare_conf_0 #(
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[1:0] conf,
    output reg[31:0] Y
);

generate
    compare #(
        .conf(1'd0)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule

(* techmap_celltype = "compare_conf_1" *)
module map_compare_conf_1 #(
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[1:0] conf,
    output reg[31:0] Y
);

generate
    compare #(
        .conf(1'd1)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule

(* techmap_celltype = "compare_conf_2" *)
module map_compare_conf_2 #(
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[1:0] conf,
    output reg[31:0] Y
);

generate
    compare #(
        .conf(2'd2)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule

