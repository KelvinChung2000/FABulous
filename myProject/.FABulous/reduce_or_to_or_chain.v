module \$reduce_or
#(
    parameter A_SIGNED = 0,
    parameter A_WIDTH = 1,
    parameter Y_WIDTH = 1,
)
(
    input wire [A_WIDTH-1:0] A,
    output wire[Y_WIDTH-1:0] Y
);
    // Generate a chain of OR gates for reduction
    generate
        if (A_WIDTH == 1) begin
            // For single bit input, directly connect to output
            assign Y = A;
        end else begin
            // Declare wires for the OR chain
            wire [A_WIDTH-1:0] chain;
            
            // First element in chain is just the first input bit
            assign chain[0] = A[0];
            
            // Create a chain of OR gates
            genvar i;
            for (i = 1; i < A_WIDTH; i = i + 1) begin: or_chain
                \$or #(
                    .A_SIGNED(A_SIGNED),
                    .B_SIGNED(A_SIGNED),
                    .A_WIDTH(1),
                    .B_WIDTH(1), 
                    .Y_WIDTH(1)
                ) or_gate (
                    .A(chain[i-1]),   // Previous result in the chain
                    .B(A[i]),         // Current input bit
                    .Y(chain[i])      // Current result
                );
            end
            
            // Connect the final output to the last element in the chain
            assign Y = chain[A_WIDTH-1];
        end
    endgenerate
endmodule