(* techmap_celltype = "reg_unit_en_1_rst_0" *)
module map_reg_unit_en_1_rst_0 #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)(
    input clk,
    input en,
    input [31:0] reg_in,
    input rst,
    output [31:0] reg_out
);

generate
    reg_unit #() _TECHMAP_REPLACE_ (
        .en(1),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(0)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_en_1_rst_z" *)
module map_reg_unit_en_1_rst_z #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)(
    input clk,
    input en,
    input [31:0] reg_in,
    input rst,
    output [31:0] reg_out
);

generate
    reg_unit #() _TECHMAP_REPLACE_ (
        .en(1),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_en_z_rst_0" *)
module map_reg_unit_en_z_rst_0 #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)(
    input clk,
    input en,
    input [31:0] reg_in,
    input rst,
    output [31:0] reg_out
);

generate
    reg_unit #() _TECHMAP_REPLACE_ (
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(0)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_en_z_rst_z" *)
module map_reg_unit_en_z_rst_z #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)(
    input clk,
    input en,
    input [31:0] reg_in,
    input rst,
    output [31:0] reg_out
);

generate
    reg_unit #() _TECHMAP_REPLACE_ (
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

