(* ARITH *)
module compare #(
    parameter NoConfigBits = 2,
    parameter WIDTH = 32
) (
    // (* FABulous, USER_CLK *) input wire clk,
    // (* FABulous, CONTROL *)input wire en,
    (* FABulous, BUS *) input wire [WIDTH-1:0] A,
    (* FABulous, BUS *) input wire [WIDTH-1:0] B,
    (* FABulous, BUS *) output reg [WIDTH-1:0] Y,
    (* FABulous, CONFIG_BIT, FEATURE="LT;LTE;EQ;REDUCE_OR;REDUCE_AND;NE;"*)
    input [2:0] conf
);
  // Define operation codes
  localparam LT = 3'b000;
  localparam LTE = 3'b001;
  localparam EQ = 3'b010;
  localparam REDUCE_OR = 3'b011;
  localparam REDUCE_AND = 3'b100;
  localparam NE = 3'b101;
  localparam LOGIC_NOT = 3'b110;

  // wire [WIDTH - 1:0] data2;

  // assign data2 = const_en ? {{WIDTH-1{constant[7]}}, constant} : data_in2;

  always @(*) begin
    case (conf)
        LT: Y = (A < B);
        LTE: Y = (A <= B);
        EQ: Y =  (A == B);
        NE: Y = (A != B);
        REDUCE_OR: Y = |A;
        REDUCE_AND: Y = &A;
        LOGIC_NOT: Y = !A;
      default: Y = {WIDTH{1'b0}};
    endcase
  end

endmodule
