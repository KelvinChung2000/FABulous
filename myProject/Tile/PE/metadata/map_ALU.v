(* techmap_celltype = "ALU_ALU_func_0" *)
module map_ALU_ALU_func_0 #(
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

(* techmap_celltype = "ALU_ALU_func_3" *)
module map_ALU_ALU_func_3 #(
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

(* techmap_celltype = "ALU_ALU_func_6" *)
module map_ALU_ALU_func_6 #(
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
        .ALU_func(3'd6)
    ) _TECHMAP_REPLACE_ (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_out(data_out)
    );

endgenerate

endmodule

