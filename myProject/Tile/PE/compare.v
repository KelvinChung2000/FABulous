module compare #(
    parameter NoConfigBits = 2,
    parameter WIDTH = 32
) (
    // (* FABulous, USER_CLK *) input wire clk,
    // (* FABulous, CONTROL *)input wire en,
    (* FABulous, BUS *) input wire [WIDTH-1:0] A,
    (* FABulous, BUS *) input wire [WIDTH-1:0] B,
    (* FABulous, BUS *) output reg [WIDTH-1:0] Y,
    (* FABulous, CONFIG_BIT, FEATURE="LT;LTE;EQ"*)
    input [1:0] conf
);
  // Define operation codes
  localparam LT = 2'b00;
  localparam LTE = 2'b01;
  localparam EQ = 2'b10;

  // wire [WIDTH - 1:0] data2;

  // assign data2 = const_en ? {{WIDTH-1{constant[7]}}, constant} : data_in2;

  always @(*) begin
    case (conf)
        LT: Y = (A < B);
        LTE: Y = (A <= B);
        EQ: Y =  (A == B);
      default: Y = {WIDTH{1'b0}};
    endcase
  end

endmodule
