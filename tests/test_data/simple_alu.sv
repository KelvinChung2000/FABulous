// Simple ALU in SystemVerilog
module simple_alu #(
    parameter WIDTH = 8
) (
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    input logic [1:0] op,
    output logic [WIDTH-1:0] result,
    output logic zero_flag
);

    typedef enum logic [1:0] {
        ADD = 2'b00,
        SUB = 2'b01,
        AND = 2'b10,
        OR  = 2'b11
    } alu_op_t;

    always_comb begin
        case (alu_op_t'(op))
            ADD: result = a + b;
            SUB: result = a - b;
            AND: result = a & b;
            OR:  result = a | b;
        endcase
    end
    
    assign zero_flag = (result == '0);

endmodule
