module delay_1 #(parameter WIDTH = 64) (
    input wire clock,
    input wire reset,
    input wire en,
    input wire en2,
    input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output reg [WIDTH-1:0] data_out2
);

    reg [WIDTH-1:0] data_reg;

    always @(posedge clock)
        begin
        if (reset) begin
            data_reg <= {WIDTH{1'b0}};
            data_out <= {WIDTH{1'b0}};
        end
        else if (en) begin
            data_reg <= data_in;
            data_out <= data_reg;
        end
        end
    assign data_out2 = data_reg;

endmodule
