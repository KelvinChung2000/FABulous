(* ARITH *)
module compare #(
    parameter NoConfigBits = 2,
    parameter WIDTH = 32
) (
    // (* FABulous, USER_CLK *) input wire clk,
    // (* FABulous, CONTROL *)input wire en,
    (* FABulous, BUS *) input wire [WIDTH-1:0] A,
    (* FABulous, BUS *) input wire [WIDTH-1:0] B,
    (* FABulous, BUS *) output reg Y,
    (* FABulous, CONFIG_BIT, FEATURE="LT;LTE;EQ;REDUCE_OR;REDUCE_AND;NE;"*)
    input [2:0] conf
);
  // Define operation codes
  localparam LT = 3'b000;
  localparam LTE = 3'b001;
  localparam EQ = 3'b010;
  localparam OR = 3'b011;
  localparam AND = 3'b100;
  localparam NE = 3'b101;
  localparam NOT = 3'b110;

  always @(*) begin
    case (conf)
        LT:   Y = (A < B);
        LTE:  Y = (A <= B);
        EQ:   Y = (A == B);
        NE:   Y = (A != B);
        AND:  Y = A[0] & B[0];
        OR:   Y = A[0] | B[0];
        NOT:  Y = ~A[0];
        default: Y = {WIDTH{1'b0}};
    endcase
  end

endmodule
