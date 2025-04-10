(* techmap_celltype = "Mem_read_allow_1_write_allow_0" *)
module map_Mem_read_allow_1_write_allow_0 #(
)
(
    input wire[31:0] addr0,
    input wire clk,
    input wire read_allow,
    input wire reset,
    input wire write_allow,
    input wire[31:0] write_data,
    input wire write_en,
    output reg[31:0] read_data
);

generate
    Mem #(
        .read_allow(1'd1),
        .write_allow(1'd0)
    ) _TECHMAP_REPLACE_ (
        .addr0(addr0),
        .clk(clk),
        .read_data(read_data),
        .reset(reset),
        .write_data(write_data),
        .write_en(write_en)
    );

endgenerate

endmodule

(* techmap_celltype = "Mem_read_allow_1_write_allow_1" *)
module map_Mem_read_allow_1_write_allow_1 #(
)
(
    input wire[31:0] addr0,
    input wire clk,
    input wire read_allow,
    input wire reset,
    input wire write_allow,
    input wire[31:0] write_data,
    input wire write_en,
    output reg[31:0] read_data
);

generate
    Mem #(
        .read_allow(1'd1),
        .write_allow(1'd1)
    ) _TECHMAP_REPLACE_ (
        .addr0(addr0),
        .clk(clk),
        .read_data(read_data),
        .reset(reset),
        .write_data(write_data),
        .write_en(write_en)
    );

endgenerate

endmodule

