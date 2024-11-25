module ALU #(
    parameter NoConfigBits = 3
) (
    input wire rst,
    input wire en,
    (* FABulous, USER_CLK *) input wire clk,
    (* FABulous, BUS *) input wire [7:0] data_in1,
    (* FABulous, BUS *) input wire [7:0] data_in2,
    (* FABulous, BUS *) input wire [7:0] data_in3,
    (* FABulous, BUS *) output reg [7:0] data_out,
    (* FABulous, CONFIG_BIT, FEATURE="ALU", ENUMERATE *) input [NoConfigBits:0] ConfigBits
);
  // Define operation codes
  localparam ADD = 3'b000;
  localparam SUB = 3'b001;
  localparam AND = 3'b010;
  localparam OR = 3'b011;
  localparam XOR = 3'b100;
  localparam MUL = 3'b101;

  always @(*) begin
    if (rst) begin
      data_out = 8'b0;
    end else if (en) begin
      case (ConfigBits)
        ADD: data_out = data_in1 + data_in2;
        SUB: data_out = data_in1 - data_in2;
        AND: data_out = data_in1 & data_in2;
        OR: data_out = data_in1 | data_in2;
        XOR: data_out = data_in1 ^ data_in2;
        MUL: data_out = data_in1 * data_in2;
        default: data_out = 8'b0;
      endcase
    end
  end


endmodule

module IO #(
) (
    (* FABulous, BUS *) input from_fabric,
    (* FABulous, BUS *) output to_fabric,
    (* FABulous, BUS, EXTERNAL *) input in,
    (* FABulous, BUS, EXTERNAL *) output out,
    (* FABulous, CONFIG_BIT, FEATURE="IO", ONE_HOT *) input ConfigBits
);
endmodule

