(* ARITH *)
module compare #(
    parameter NoConfigBits = 2,
    parameter WIDTH = 32
) (
    // (* FABulous, USER_CLK *) input wire clk,
    // (* FABulous, CONTROL *)input wire en,
    (* FABulous *) input wire [WIDTH-1:0] A,
    (* FABulous *) input wire [WIDTH-1:0] B,
    (* FABulous, BUS *) output reg Y,
    (* FABulous, CONFIG_BIT, FEATURE="LT;LTE;EQ;NE;"*)
    input [1:0] conf
);
  // Define operation codes
  localparam LT  = 2'b00;
  localparam LTE = 2'b01;
  localparam EQ  = 2'b10;
  localparam NE  = 2'b11;

  always @(*) begin
    case (conf)
        LT:   Y = (A < B);
        LTE:  Y = (A <= B);
        EQ:   Y = (A == B);
        NE:   Y = (A != B);
        default: Y = {WIDTH{1'b0}};
    endcase
  end

endmodule
