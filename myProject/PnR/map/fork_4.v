module fork_4 #(
    parameter WIDTH = 32
) (
    input wire [WIDTH-1:0] in,

    output reg [WIDTH-1:0] out1,
    output reg [WIDTH-1:0] out2,
    output reg [WIDTH-1:0] out3,
    output reg [WIDTH-1:0] out4
);

assign out1 = in;
assign out2 = in;
assign out3 = in;
assign out4 = in;

endmodule
