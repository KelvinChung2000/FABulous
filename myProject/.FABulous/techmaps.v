module $__Mem #(
    parameter INIT = "0",
    parameter OPTION_config_bits = "1",
    parameter OPTION_config_bits_ADDRESS_BITS = "16",
    parameter OPTION_config_bits_DATA_WIDTH = "32",
    parameter OPTION_config_bits = "0",
    parameter OPTION_config_bits_ADDRESS_BITS = "16",
    parameter OPTION_config_bits_DATA_WIDTH = "32",
    parameter PORT_RW0_WIDTH = "32",
    parameter PORT_RW0_RD_USED = "1",
    parameter PORT_RW0_WR_USED = "1",
    parameter PORT_RW0_WIDTH = "32",
    parameter PORT_RW0_RD_USED = "1",
    parameter PORT_RW0_WR_USED = "1"
)
(
    input wire[15:0] PORT_RW0_ADDR,
    input wire PORT_RW0_CLK,
    input wire[31:0] PORT_RW0_WR_DATA,
    input wire PORT_RW0_WR_EN,
    input wire PORT_RW0_CLK_EN,
    output reg[31:0] PORT_RW0_RD_DATA
);

Mem #(
    .config_bits(1'd1),
    .config_bits(1'd0)
) _TECHMAP_REPLACE_ (
    .write_data(PORT_RW0_WR_DATA),
    .write_en(PORT_RW0_WR_EN),
    .read_data(PORT_RW0_RD_DATA),
    .addr0(PORT_RW0_ADDR)
);

endmodule


(* techmap_celltype = "ALU_ALU_func_0" *)
module map_ALU_ALU_func_0 #(
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire data_in3,
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
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire data_in3,
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

(* techmap_celltype = "ALU_ALU_func_4" *)
module map_ALU_ALU_func_4 #(
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire data_in3,
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
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire data_in3,
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

(* techmap_celltype = "ALU_ALU_func_6" *)
module map_ALU_ALU_func_6 #(
)
(
    input wire[2:0] ALU_func,
    input wire[31:0] data_in1,
    input wire[31:0] data_in2,
    input wire data_in3,
    output reg[31:0] data_out
);

generate
    ALU #(
        .ALU_func(3'd6)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule


(* techmap_celltype = "compare_conf_0" *)
module map_compare_conf_0 #(
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[1:0] conf,
    output reg Y
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
    output reg Y
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
    output reg Y
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

(* techmap_celltype = "compare_conf_3" *)
module map_compare_conf_3 #(
)
(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[1:0] conf,
    output reg Y
);

generate
    compare #(
        .conf(2'd3)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule


(* techmap_celltype = "logic_op_conf_0" *)
module map_logic_op_conf_0 #(
)
(
    input wire A,
    input wire B,
    input wire[1:0] conf,
    output reg Y
);

generate
    logic_op #(
        .conf(1'd0)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule

(* techmap_celltype = "logic_op_conf_1" *)
module map_logic_op_conf_1 #(
)
(
    input wire A,
    input wire B,
    input wire[1:0] conf,
    output reg Y
);

generate
    logic_op #(
        .conf(1'd1)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule

(* techmap_celltype = "logic_op_conf_2" *)
module map_logic_op_conf_2 #(
)
(
    input wire A,
    input wire B,
    input wire[1:0] conf,
    output reg Y
);

generate
    logic_op #(
        .conf(2'd2)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule

(* techmap_celltype = "logic_op_conf_3" *)
module map_logic_op_conf_3 #(
)
(
    input wire A,
    input wire B,
    input wire[1:0] conf,
    output reg Y
);

generate
    logic_op #(
        .conf(2'd3)
    ) _TECHMAP_REPLACE_ (
        .A(A),
        .B(B),
        .Y(Y)
    );

endgenerate

endmodule


(* techmap_celltype = "reg_unit_tide_en_0_tide_rst_0" *)
module map_reg_unit_tide_en_0_tide_rst_0 #(
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
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_tide_en_0_tide_rst_1" *)
module map_reg_unit_tide_en_0_tide_rst_1 #(
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
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_tide_en_1_tide_rst_0" *)
module map_reg_unit_tide_en_1_tide_rst_0 #(
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
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_tide_en_1_tide_rst_1" *)
module map_reg_unit_tide_en_1_tide_rst_1 #(
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
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule


(* techmap_celltype = "reg_unit_WIDTH_1_tide_en_0_tide_rst_0" *)
module map_reg_unit_WIDTH_1_tide_en_0_tide_rst_0 #(
)
(
    input wire clk,
    input wire en,
    input wire reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg reg_out
);

generate
    reg_unit_WIDTH_1 #(
        .tide_en(1'd0),
        .tide_rst(1'd0)
    ) _TECHMAP_REPLACE_ (
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_WIDTH_1_tide_en_0_tide_rst_1" *)
module map_reg_unit_WIDTH_1_tide_en_0_tide_rst_1 #(
)
(
    input wire clk,
    input wire en,
    input wire reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg reg_out
);

generate
    reg_unit_WIDTH_1 #(
        .tide_en(1'd0),
        .tide_rst(1'd1)
    ) _TECHMAP_REPLACE_ (
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_WIDTH_1_tide_en_1_tide_rst_0" *)
module map_reg_unit_WIDTH_1_tide_en_1_tide_rst_0 #(
)
(
    input wire clk,
    input wire en,
    input wire reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg reg_out
);

generate
    reg_unit_WIDTH_1 #(
        .tide_en(1'd1),
        .tide_rst(1'd0)
    ) _TECHMAP_REPLACE_ (
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule

(* techmap_celltype = "reg_unit_WIDTH_1_tide_en_1_tide_rst_1" *)
module map_reg_unit_WIDTH_1_tide_en_1_tide_rst_1 #(
)
(
    input wire clk,
    input wire en,
    input wire reg_in,
    input wire rst,
    input wire tide_en,
    input wire tide_rst,
    output reg reg_out
);

generate
    reg_unit_WIDTH_1 #(
        .tide_en(1'd1),
        .tide_rst(1'd1)
    ) _TECHMAP_REPLACE_ (
        .en(en),
        .reg_in(reg_in),
        .reg_out(reg_out),
        .rst(rst)
    );

endgenerate

endmodule


