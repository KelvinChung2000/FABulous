(* ARITH *)
module ALU #(
    parameter NoConfigBits = 3,
    parameter WIDTH = 32
) (
    // (* FABulous, USER_CLK *) input wire clk,
    // (* FABulous, CONTROL *)input wire en,
    (* FABulous, BUS *) input wire [WIDTH-1:0] data_in1,
    (* FABulous, BUS *) input wire [WIDTH-1:0] data_in2,
    (* FABulous, BUS *) input wire data_in3,
    (* FABulous, BUS *) output reg [WIDTH-1:0] data_out,
    (* FABulous, CONFIG_BIT, FEATURE="ADD;SUB;AND;OR;XOR;MUL;MUL_ADD"*)
    input [2:0] ALU_func
);
  // Define operation codes
  localparam ADD = 3'b000;
  localparam SUB = 3'b001;
  localparam REDUCE_AND = 3'b010;
  localparam REDUCE_OR = 3'b011;
  localparam XOR = 3'b100;
  localparam MUL = 3'b101;
  localparam SEL = 3'b110;
  localparam NOT = 3'b111;

  // wire [WIDTH - 1:0] data2;

  // assign data2 = const_en ? {{WIDTH-1{constant[7]}}, constant} : data_in2;

  always @(*) begin
    case (ALU_func)
      ADD: data_out = data_in1 + data_in2;
      SUB: data_out = data_in1 - data_in2;
      XOR: data_out = data_in1 ^ data_in2;
      MUL: data_out = data_in1 * data_in2;
      // REDUCE_OR: data_out[0] = |data_in1;
      // REDUCE_AND: data_out[0] = &data_in1;
      NOT: data_out = ~data_in1;
      SEL: data_out = data_in3 ? data_in1 : data_in2;
      default: data_out = {WIDTH{1'b0}};
    endcase
  end

endmodule
