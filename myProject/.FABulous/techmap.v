(* techmap_celltype = "reg_unit_en_z_rst_0" *)
module map_reg_unit_en_z_rst_0 (
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
module map_reg_unit_en_z_rst_z (
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


(* techmap_celltype = "ALU_ALU_func_0" *)
module map_ALU_ALU_func_0 (
    input [2:0] ALU_func,
    input clk,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
);

generate
    ALU #(
        .ALU_func(0)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule

(* techmap_celltype = "ALU_ALU_func_1" *)
module map_ALU_ALU_func_1 (
    input [2:0] ALU_func,
    input clk,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
);

generate
    ALU #(
        .ALU_func(1)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule

(* techmap_celltype = "ALU_ALU_func_2" *)
module map_ALU_ALU_func_2 (
    input [2:0] ALU_func,
    input clk,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
);

generate
    ALU #(
        .ALU_func(2)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule

(* techmap_celltype = "ALU_ALU_func_3" *)
module map_ALU_ALU_func_3 (
    input [2:0] ALU_func,
    input clk,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
);

generate
    ALU #(
        .ALU_func(3)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule

(* techmap_celltype = "ALU_ALU_func_4" *)
module map_ALU_ALU_func_4 (
    input [2:0] ALU_func,
    input clk,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
);

generate
    ALU #(
        .ALU_func(4)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule

(* techmap_celltype = "ALU_ALU_func_5" *)
module map_ALU_ALU_func_5 (
    input [2:0] ALU_func,
    input clk,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
);

generate
    ALU #(
        .ALU_func(5)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule


