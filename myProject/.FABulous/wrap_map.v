(* techmap_celltype = "$add" *)
module add_wrap (
    A,
    B,
    Y
);

  parameter A_SIGNED = 0;
  parameter B_SIGNED = 0;
  parameter A_WIDTH = 1;
  parameter B_WIDTH = 1;
  parameter Y_WIDTH = 1;

  input [A_WIDTH-1:0] A;
  input [B_WIDTH-1:0] B;
  output [Y_WIDTH-1:0] Y;

  wire [31:0] A_32 = A;
  wire [31:0] B_32 = B;
  wire [31:0] Y_32;
  assign Y = Y_32;

//   wire [1023:0] _TECHMAP_DO_ = "proc; clean";


  \$__add_wrapper #(
      .A_SIGNED(A_SIGNED),
      .B_SIGNED(B_SIGNED),
      .A_WIDTH (A_WIDTH),
      .B_WIDTH (B_WIDTH),
      .Y_WIDTH (Y_WIDTH)
  ) _TECHMAP_REPLACE_ (
      .A(A_32),
      .B(B_32),
      .Y(Y_32)
  );

endmodule
