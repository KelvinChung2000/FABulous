(* techmap_celltype = "\$mux" *)
module wrap_map #(
    parameter WIDTH = 0
) (
    input wire [WIDTH-1:0] A,
    input wire [WIDTH-1:0] B,
    input wire S,
    output wire [WIDTH-1:0] Y
);

  wire [63:0] A_64;
  wire [63:0] B_64;
  wire S_1;
  wire [63:0] Y_64;
  assign A_64 = A;
  assign B_64 = B;
  assign S_1 = S;
  assign Y = Y_64;
  \$__mux_wrapper #(
      .WIDTH(WIDTH)
  ) _TECHMAP_REPLACE_ (
      .A(A_64),
      .B(B_64),
      .S(S_1),
      .Y(Y_64)
  );

endmodule

