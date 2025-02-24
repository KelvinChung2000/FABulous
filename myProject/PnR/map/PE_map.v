(* techmap_celltype = "std_add" *)
module ALU_map #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] left,
    input [WIDTH-1:0] right,
    output [WIDTH-1:0] out

);
    generate
        ADD #(
            .WIDTH(WIDTH),
        ) _TECHMAP_REPLACE_ (
            .en(1'b1),
            .data_in1(left),
            .data_in2(right),
            .data_out(out)
        );

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
