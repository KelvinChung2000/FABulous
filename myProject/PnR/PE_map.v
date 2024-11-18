(* techmap_celltype = "$add $sub $mul $div $mod $and $or $xor" *)
module ALU_map(A, B, Y); 
    parameter A_SIGNED = 0;
    parameter B_SIGNED = 0;
    parameter A_WIDTH = 0;
    parameter B_WIDTH = 0;
    parameter Y_WIDTH = 0;
    parameter _TECHMAP_CELLTYPE_ = "";


    input [A_WIDTH-1:0] A;
    input [B_WIDTH-1:0] B;
    output [Y_WIDTH-1:0] Y;

    generate
        localparam operation =
            _TECHMAP_CELLTYPE_ == "$add" ? 0 :
            _TECHMAP_CELLTYPE_ == "$sub" ? 1 :
            _TECHMAP_CELLTYPE_ == "$mul" ? 2 :
            _TECHMAP_CELLTYPE_ == "$div" ? 3 :
            _TECHMAP_CELLTYPE_ == "$mod" ? 4 :
            _TECHMAP_CELLTYPE_ == "$and" ? 5 :
            _TECHMAP_CELLTYPE_ == "$or"  ? 6 :
            _TECHMAP_CELLTYPE_ == "$xor" ? 7 : -1;

        ALU #(.OPERATION(operation)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));
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
