(* techmap_celltype = "ConstOp UnaryOp BinaryOp TernaryOp" *)
module PE_map(A, B, C, Y);
    parameter WIDTH = 0;
    parameter _TECHMAP_CELLTYPE_ = "";
    parameter _TECHMAP_FAIL_ = 0;
    parameter OP = 0;
    parameter CONST = 0;

    input [WIDTH-1:0] A;
    input [WIDTH-1:0] B;
    input [WIDTH-1:0] C;
    output [WIDTH-1:0] Y;

    generate
        localparam OP_TYPE =
            _TECHMAP_CELLTYPE_ == "ConstOp" ? 0 :
            _TECHMAP_CELLTYPE_ == "UnaryOp" ? 1 :
            _TECHMAP_CELLTYPE_ == "BinaryOp" ? 2 :
            _TECHMAP_CELLTYPE_ == "TernaryOp" ? 3 : -1;

        if (OP_TYPE == 0)
            ALU #(.WIDTH(WIDTH), .CONST(CONST)) _TECHMAP_REPLACE_ (.data_out(Y));
        else if (OP_TYPE == 1)
            ALU #(
                .WIDTH(WIDTH),
                .OP(OP)
            ) _TECHMAP_REPLACE_ (
                .data_in1(A),
                .data_out(Y)
            );
        else if (OP_TYPE == 2)
            ALU #(
                .WIDTH(WIDTH),
                .OP(OP)
            ) _TECHMAP_REPLACE_ (
                .data_in1(A),
                .data_in2(B),
                .data_out(Y)
            );
        else if (OP_TYPE == 3)
            ALU #(
                .WIDTH(WIDTH),
                .OP(OP)
            ) _TECHMAP_REPLACE_ (
                .data_in1(A),
                .data_in2(B),
                .data_in3(C),
                .data_out(Y)
            );
        else
            wire  _TECHMAP_FAIL_ = 1;
    endgenerate

endmodule


// module CMP_map(A, B, Y);
//     parameter A_SIGNED = 0;
//     parameter B_SIGNED = 0;
//     parameter A_WIDTH = 0;
//     parameter B_WIDTH = 0;
//     parameter Y_WIDTH = 0;

//     input [A_WIDTH-1:0] A;
//     input [B_WIDTH-1:0] B;
//     output [Y_WIDTH-1:0] Y;

//     generate
//         localparam operation =
//             _TECHMAP_CELLTYPE_ == "$eq" ? 0 :
//             _TECHMAP_CELLTYPE_ == "$ne" ? 1 :
//             _TECHMAP_CELLTYPE_ == "$lt" ? 2 :
//             _TECHMAP_CELLTYPE_ == "$le" ? 3 :
//             _TECHMAP_CELLTYPE_ == "$gt" ? 4 :
//             _TECHMAP_CELLTYPE_ == "$ge" ? 5 :
//             -1;

//         CMP #(.OPERATION(operation)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));
//     endgenerate
// endmodule
