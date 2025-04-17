(* techmap_celltype = "reg_unit_tide_en_0_tide_rst_0" *)
module map_reg_unit_tide_en_0_tide_rst_0 #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)
(
    input wire clk,
    input wire en,
    input wire[31:0] reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg[31:0] reg_out
);

generate
    reg_unit #(
        .tide_en(1'd0),
        .tide_rst(1'd0)
    ) _TECHMAP_REPLACE_ (
        .clk(clk),
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_tide_en_0_tide_rst_1" *)
module map_reg_unit_tide_en_0_tide_rst_1 #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)
(
    input wire clk,
    input wire en,
    input wire[31:0] reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg[31:0] reg_out
);

generate
    reg_unit #(
        .tide_en(1'd0),
        .tide_rst(1'd1)
    ) _TECHMAP_REPLACE_ (
        .clk(clk),
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_tide_en_1_tide_rst_0" *)
module map_reg_unit_tide_en_1_tide_rst_0 #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)
(
    input wire clk,
    input wire en,
    input wire[31:0] reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg[31:0] reg_out
);

generate
    reg_unit #(
        .tide_en(1'd1),
        .tide_rst(1'd0)
    ) _TECHMAP_REPLACE_ (
        .clk(clk),
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_tide_en_1_tide_rst_1" *)
module map_reg_unit_tide_en_1_tide_rst_1 #(
    parameter _TECHMAP_CONSTVAL_reg_in_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_reg_out_ = 32'bx
)
(
    input wire clk,
    input wire en,
    input wire[31:0] reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg[31:0] reg_out
);

generate
    reg_unit #(
        .tide_en(1'd1),
        .tide_rst(1'd1)
    ) _TECHMAP_REPLACE_ (
        .clk(clk),
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

