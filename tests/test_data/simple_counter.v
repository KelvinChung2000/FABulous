// Simple 4-bit counter in Verilog
module simple_counter (
    input clk,
    input reset,
    input enable,
    output reg [3:0] count,
    output overflow
);

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            count <= count + 1;
        end
    end
    
    assign overflow = (count == 4'b1111) && enable;

endmodule
