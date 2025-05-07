(* ARITH *)
module logic_op #(
    parameter NoConfigBits = 2,
    parameter WIDTH = 1
) (
    // (* FABulous, USER_CLK *) input wire clk,
    // (* FABulous, CONTROL *)input wire en,
    (* FABulous *) input wire [WIDTH-1:0] A,
    (* FABulous *) input wire [WIDTH-1:0] B,
    (* FABulous, BUS *) output reg Y,
    (* FABulous, CONFIG_BIT, FEATURE="AND;OR;NOT"*)
    input [1:0] conf
);
  // Define operation codes
  localparam AND = 2'b00;
  localparam OR  = 2'b01;
  localparam NOT = 2'b10;

  always @(*) begin
    case (conf)
        AND:  Y = A & B;
        OR:   Y = A | B;
        NOT:  Y = ~A;
        default: Y = {WIDTH{1'b0}};
    endcase
  end

endmodule
