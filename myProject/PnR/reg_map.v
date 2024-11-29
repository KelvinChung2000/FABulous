(* techmap_celltype = "RegOp" *)
module const_map (
    Y
);
  parameter WIDTH = 0;
  parameter _TECHMAP_CELLTYPE_ = "";
  parameter _TECHMAP_FAIL_ = 0;

  output [WIDTH-1:0] Y;

  generate
    reg_unit #() _TECHMAP_REPLACE_ (.reg_out(Y));
  endgenerate

endmodule
