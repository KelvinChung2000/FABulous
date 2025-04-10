(* techmap_celltype = "\$__mux_wrapper" *)
module unwrap_map #(
    parameter WIDTH = 0
) (
    input wire [63:0] A,
    input wire [63:0] B,
    input wire S,
    output wire [63:0] Y
);

  wire [WIDTH-1:0] A_orig;
  wire [WIDTH-1:0] B_orig;
  wire S_orig;
  wire [WIDTH-1:0] Y_orig;
  assign A_orig = A;
  assign B_orig = B;
  assign S_orig = S;
  assign Y = Y_orig;
  \$mux #(
      .WIDTH(WIDTH)
  ) _TECHMAP_REPLACE_ (
      .A(A_orig),
      .B(B_orig),
      .S(S_orig),
      .Y(Y_orig)
  );

endmodule
