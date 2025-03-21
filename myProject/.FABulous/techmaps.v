(* techmap_celltype = "ALU_ALU_func_0" *)
module map_ALU_ALU_func_0 #(
    parameter _TECHMAP_CONSTVAL_data_in1_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in2_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in3_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_out_ = 32'bx
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire[31:0] data_in3,
    output reg[31:0] data_out
);

generate
    ALU #(
        .ALU_func(1'd0)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule
(* techmap_celltype = "ALU_ALU_func_1" *)
module map_ALU_ALU_func_1 #(
    parameter _TECHMAP_CONSTVAL_data_in1_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in2_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in3_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_out_ = 32'bx
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire[31:0] data_in3,
    output reg[31:0] data_out
);

generate
    ALU #(
        .ALU_func(1'd1)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule
(* techmap_celltype = "ALU_ALU_func_2" *)
module map_ALU_ALU_func_2 #(
    parameter _TECHMAP_CONSTVAL_data_in1_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in2_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in3_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_out_ = 32'bx
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire[31:0] data_in3,
    output reg[31:0] data_out
);

generate
    ALU #(
        .ALU_func(2'd2)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule
(* techmap_celltype = "ALU_ALU_func_3" *)
module map_ALU_ALU_func_3 #(
    parameter _TECHMAP_CONSTVAL_data_in1_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in2_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in3_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_out_ = 32'bx
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire[31:0] data_in3,
    output reg[31:0] data_out
);

generate
    ALU #(
        .ALU_func(2'd3)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule
(* techmap_celltype = "ALU_ALU_func_4" *)
module map_ALU_ALU_func_4 #(
    parameter _TECHMAP_CONSTVAL_data_in1_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in2_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in3_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_out_ = 32'bx
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire[31:0] data_in3,
    output reg[31:0] data_out
);

generate
    ALU #(
        .ALU_func(3'd4)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule
(* techmap_celltype = "ALU_ALU_func_5" *)
module map_ALU_ALU_func_5 #(
    parameter _TECHMAP_CONSTVAL_data_in1_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in2_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in3_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_out_ = 32'bx
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire[31:0] data_in3,
    output reg[31:0] data_out
);

generate
    ALU #(
        .ALU_func(3'd5)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule

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

