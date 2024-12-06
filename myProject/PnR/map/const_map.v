(* techmap_celltype = "ConstOp" *)
module const_map (
    Y
);
  parameter WIDTH = 0;
  parameter CONST = 0;
  parameter _TECHMAP_CELLTYPE_ = "";
  parameter _TECHMAP_FAIL_ = 0;

  output [WIDTH-1:0] Y;

  generate
    const_unit #() _TECHMAP_REPLACE_ (.const_out(Y));
  endgenerate

endmodule
