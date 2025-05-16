module \$ne (A, B, Y);

    parameter A_SIGNED = 0;
    parameter B_SIGNED = 0;
    parameter A_WIDTH = 0;
    parameter B_WIDTH = 0;
    parameter Y_WIDTH = 0;

    input [A_WIDTH-1:0] A;
    input [B_WIDTH-1:0] B;  
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
        if (A_WIDTH == 1 && B_WIDTH == 0) begin
            assign Y = A;
        end
        else if (A_WIDTH == 0 && B_WIDTH == 1) begin
            assign Y = B;
        end
        else if (A_WIDTH == 1 && B_WIDTH == 1) begin
            \$xor #(
                    .A_SIGNED(A_SIGNED),
                    .B_SIGNED(B_SIGNED),
                    .A_WIDTH(1),
                    .B_WIDTH(1), 
                    .Y_WIDTH(1)
                ) xor_gate (
                    .A(A),   // Previous result in the chain
                    .B(B),   // Current input bit
                    .Y(Y)    // Current result
                );
        end
        else if (A_WIDTH > 1 && B_WIDTH > 1 && A_WIDTH == B_WIDTH) begin
            localparam next_stage_sz = (A_WIDTH+1) / 2;
            assign Y = (A[next_stage_sz-1:0] != B[next_stage_sz-1:0]) | (A[A_WIDTH-1:next_stage_sz] != B[B_WIDTH-1:next_stage_sz]);
        end
        else begin
            wire _TECHMAP_FAIL_ = 1'b1;
        end

    end endgenerate
endmodule