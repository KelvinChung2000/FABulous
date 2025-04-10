module generic_fsm #(
    parameter STATE_WIDTH = 4  // Width of state register
) (
    input wire clk,             // Clock signal
    input wire rst_n,           // Active low reset
    input wire trigger,         // Example input to cause state transitions
    input wire [7:0] data_in,   // Example data input
    output reg [7:0] data_out,  // Example data output
    output reg done             // Example completion signal
);

    // State definitions as numeric values
    localparam [STATE_WIDTH-1:0]
        IDLE          = 'd0,
        INIT          = 'd1,
        PROCESS_DATA  = 'd2,
        COMPUTE       = 'd3,
        WAIT_READY    = 'd4,
        FINALIZE      = 'd5,
        COMPLETE      = 'd6;

    // State registers
    reg [STATE_WIDTH-1:0] currentState;
    reg [STATE_WIDTH-1:0] nextState;

    // Counter for iterations if needed
    reg [7:0] iterationCount;

    // State register update logic
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            currentState <= IDLE;
            iterationCount <= 8'd0;
        end else begin
            currentState <= nextState;

            // Update iteration counter if needed
            if (currentState == PROCESS_DATA && nextState == PROCESS_DATA && iterationCount < 8'd10)
                iterationCount <= iterationCount + 8'd1;
            else if (nextState == IDLE)
                iterationCount <= 8'd0;
        end
    end

    // Next state logic - uses addition for some transitions
    always @(*) begin
        // Default: stay in current state
        nextState = currentState;

        case (currentState)
            IDLE: begin
                if (trigger)
                    nextState = currentState + 'd1;  // Move to INIT by adding 1
            end

            INIT: begin
                nextState = currentState + 'd1;  // Always move to PROCESS_DATA
            end

            PROCESS_DATA: begin
                if (iterationCount >= 8'd10)
                    nextState = currentState + 'd1;  // Move to COMPUTE after 10 iterations
            end

            COMPUTE: begin
                if (data_in > 8'd100)
                    nextState = currentState + 'd1;  // Move to WAIT_READY
                else
                    nextState = FINALIZE;  // Skip to FINALIZE for small values
            end

            WAIT_READY: begin
                if (trigger)
                    nextState = currentState + 'd1;  // Move to FINALIZE when triggered
            end

            FINALIZE: begin
                nextState = currentState + 'd1;  // Always move to COMPLETE
            end

            COMPLETE: begin
                nextState = IDLE;  // Return to IDLE
            end

            default: nextState = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default outputs
        data_out = 8'd0;
        done = 1'b0;

        case (currentState)
            IDLE: begin
                // No outputs in IDLE
            end

            INIT: begin
                data_out = 8'd1;  // Initialize output
            end

            PROCESS_DATA: begin
                data_out = data_in + iterationCount;  // Process based on iteration
            end

            COMPUTE: begin
                data_out = data_in << 1;  // Double the input
            end

            WAIT_READY: begin
                data_out = data_in;  // Pass through
            end

            FINALIZE: begin
                data_out = data_in + 8'd5;  // Finalize calculation
            end

            COMPLETE: begin
                data_out = data_in;
                done = 1'b1;  // Signal completion
            end

            default: begin
                data_out = 8'd0;
                done = 1'b0;
            end
        endcase
    end

endmodule
