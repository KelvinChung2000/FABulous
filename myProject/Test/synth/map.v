(* techmap_celltype = "$alu" *)
module _90_alu (A, B, CI, BI, X, Y, CO);
  parameter A_SIGNED = 0;
  parameter B_SIGNED = 0;
  parameter A_WIDTH = 1;
  parameter B_WIDTH = 1;
  parameter Y_WIDTH = 1;

  (* force_downto *)
  input [A_WIDTH-1:0] A;
  (* force_downto *)
  input [B_WIDTH-1:0] B;
  (* force_downto *)
  output [Y_WIDTH-1:0] X, Y;

  input CI, BI;
  (* force_downto *)
  output [Y_WIDTH-1:0] CO;

  (* force_downto *)
  wire [Y_WIDTH-1:0] AA = A_buf;
  (* force_downto *)
  wire [Y_WIDTH-1:0] BB = BI ? ~B_buf : B_buf;

  (* force_downto *)
  wire [Y_WIDTH-1:0] A_buf, B_buf;
  \$pos #(.A_SIGNED(A_SIGNED), .A_WIDTH(A_WIDTH), .Y_WIDTH(Y_WIDTH)) A_conv (.A(A), .Y(A_buf));
  \$pos #(.A_SIGNED(B_SIGNED), .A_WIDTH(B_WIDTH), .Y_WIDTH(Y_WIDTH)) B_conv (.A(B), .Y(B_buf));

  \$lcu #(.WIDTH(Y_WIDTH)) lcu (.P(X), .G(AA & BB), .CI(CI), .CO(CO));

  assign X = AA ^ BB;
  assign Y = X ^ {CO, CI};
endmodule


(* techmap_wrap = "alumacc" *)
(* techmap_celltype = "$lt $le $ge $gt $add $sub $neg $mul $and $or $xor" *)
module _90_alumac
endmodule
