(* techmap_celltype = "InputOp OutputOp" *)
module IO_map (
    A, Y
);
    parameter WIDTH = 0;
    parameter _TECHMAP_CELLTYPE_ = "";
    parameter _TECHMAP_FAIL_ = 0;

    input [WIDTH-1:0] A;
    output [WIDTH-1:0] Y;

    generate
        localparam OP_TYPE =
                _TECHMAP_CELLTYPE_ == "InputOp" ? 0 :
                _TECHMAP_CELLTYPE_ == "OutputOp" ? 1 : -1;

        if (OP_TYPE == 0)
            IO #(
                .WIDTH(WIDTH)
            ) _TECHMAP_REPLACE_ (
                .to_fabric(Y)
            );
        else if (OP_TYPE == 1)
            IO #(
                .WIDTH(WIDTH)
            ) _TECHMAP_REPLACE_ (
                .from_fabric(A)
            );
        else
            wire _TECHMAP_FAIL_ = 1;
    endgenerate

endmodule
