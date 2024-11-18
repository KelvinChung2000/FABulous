module buffer(
    input wire rst,
    input wire en,
    input wire [7:0] data_in,
    output wire [7:0] data_out,
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);

    reg [7:0] data_out;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            data_out <= 8'b0;
        end
        else if(en) begin
            data_out <= data_in;
        end
    end

endmodule
