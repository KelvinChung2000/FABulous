module ALU #(
    parameter NoConfigBits = 3,
    parameter WIDTH = 32
) (
    // (* FABulous, USER_CLK *) input wire clk,
    // (* FABulous, CONTROL *)input wire en,
    (* FABulous, BUS, DATA *) input wire [WIDTH-1:0] data_in1,
    (* FABulous, BUS, DATA *) input wire [WIDTH-1:0] data_in2,
    (* FABulous, BUS, DATA *) input wire [WIDTH-1:0] data_in3,
    (* FABulous, BUS, DATA *) output reg [WIDTH-1:0] data_out,
    (* FABulous, CONFIG_BIT, FEATURE="ADD;SUB;AND;OR;XOR;MUL",
    FEATURE_MAP="std_add(left=>data_in1, right=>data_in2, out=>data_out);"*)
    input [2:0] ALU_func
);
  // Define operation codes
  localparam ADD = 3'b000;
  localparam SUB = 3'b001;
  localparam AND = 3'b010;
  localparam OR = 3'b011;
  localparam XOR = 3'b100;
  localparam MUL = 3'b101;

  // wire [WIDTH - 1:0] data2;

  // assign data2 = const_en ? {{WIDTH-1{constant[7]}}, constant} : data_in2;

  always @(*) begin
    case (ALU_func)
      ADD: data_out = data_in1 + data_in2;
      SUB: data_out = data_in1 - data_in2;
      AND: data_out = data_in1 & data_in2;
      OR: data_out = data_in1 | data_in2;
      XOR: data_out = data_in1 ^ data_in2;
      MUL: data_out = data_in1 * data_in2;
      default: data_out = {WIDTH{1'b0}};
    endcase
    // if (en) begin
    // end
    // else begin
    //   data_out = 8'b0;
    // end
  end

endmodule
