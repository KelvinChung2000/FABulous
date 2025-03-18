(* techmap_celltype = "ALU_ALU_func_0" *)
module map_ALU_ALU_func_0 #(
    parameter _TECHMAP_CONSTVAL_data_in1_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in2_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_in3_ = 32'bx,
    parameter _TECHMAP_CONSTVAL_data_out_ = 32'bx
)(
    input [2:0] ALU_func,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
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
)(
    input [2:0] ALU_func,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
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
)(
    input [2:0] ALU_func,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
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
)(
    input [2:0] ALU_func,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
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
)(
    input [2:0] ALU_func,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
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
)(
    input [2:0] ALU_func,
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [31:0] data_in3,
    output [31:0] data_out
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
