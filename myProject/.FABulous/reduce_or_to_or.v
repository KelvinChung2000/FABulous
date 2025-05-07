module \$reduce_or (A, Y);

    parameter A_SIGNED = 0;
    parameter A_WIDTH = 0;
    parameter Y_WIDTH = 0;

    input [A_WIDTH-1:0] A;
    output [Y_WIDTH-1:0] Y;

    function integer min;
        input integer a, b;
        begin
            if (a < b)
                min = a;
            else
                min = b;
        end
    endfunction

    genvar i;
    generate begin
        if (A_WIDTH == 0) begin
            assign Y = 0;
        end
        if (A_WIDTH == 1) begin
            assign Y = A;
        end
        if (A_WIDTH == 2) begin
            \$or #(
                    .A_SIGNED(A_SIGNED),
                    .B_SIGNED(A_SIGNED),
                    .A_WIDTH(1),
                    .B_WIDTH(1), 
                    .Y_WIDTH(1)
                ) or_gate (
                    .A(A[0]),   // Previous result in the chain
                    .B(A[1]),         // Current input bit
                    .Y(ybuf)      // Current result
                );
            assign Y = ybuf;
        end
        if (A_WIDTH > 2) begin
            localparam next_stage_sz = (A_WIDTH+1) / 2;
            wire [next_stage_sz-1:0] next_stage;
            for (i = 0; i < next_stage_sz; i = i+1) begin
                localparam bits = min(A_WIDTH - 2*i, 2);
                assign next_stage[i] = |A[2*i +: bits];
            end
            assign Y = |next_stage;
        end
    end endgenerate
endmodule