(* techmap_celltype = "$__cell_Mem_config_bits_1" *)
module map_Mem #(
)
(
    input wire[3:0] PORT_RW0_ADDR,
    input wire[31:0] PORT_RW0_WR_DATA,
    output reg[31:0] PORT_RW0_RD_DATA,
    input wire PORT_RW0_WR_EN
);

Mem #(
    .config_bits(1'd1)
) _TECHMAP_REPLACE_ (

);

endmodule

(* techmap_celltype = "$__cell_Mem_config_bits_0" *)
module map_Mem #(
)
(
    input wire[3:0] PORT_RW0_ADDR,
    input wire[31:0] PORT_RW0_WR_DATA,
    output reg[31:0] PORT_RW0_RD_DATA,
    input wire PORT_RW0_WR_EN
);

Mem #(
    .config_bits(1'd0)
) _TECHMAP_REPLACE_ (

);

endmodule

