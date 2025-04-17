module \$fsm #(
    parameter NAME = "",

    parameter CLK_POLARITY = 1'b1,
    parameter ARST_POLARITY = 1'b1,

    parameter CTRL_IN_WIDTH = 1,
    parameter CTRL_OUT_WIDTH = 1,

    parameter STATE_BITS = 1,
    parameter STATE_NUM = 1,
    parameter STATE_NUM_LOG2 = 1,
    parameter STATE_RST = 0,
    parameter STATE_TABLE = 1'b0,

    parameter TRANS_NUM = 1,
    parameter TRANS_TABLE = 4'b0x0x
)
(
    input CLK, 
    input ARST,
    input [CTRL_IN_WIDTH-1:0] CTRL_IN,
    output reg [CTRL_OUT_WIDTH-1:0] CTRL_OUT
);

wire [STATE_BITS-1:0] current_state;


function getMemInit();
    // Parse transition table
    integer i, j;
    integer entry_width;
    integer state_in_pos, ctrl_in_pos, state_out_pos, ctrl_out_pos;
    integer patternCount;
    reg [CTRL_IN_WIDTH-1:0] ctrl_in_pattern;
    
    // For memory initialization
    reg [(1 << (STATE_BITS + CTRL_IN_WIDTH)) * (STATE_BITS + CTRL_OUT_WIDTH) - 1:0] memInit;
    integer memAddr;
    integer memBitPos;
    integer totalPatterns;
    
    // Current transition values
    reg [STATE_BITS-1:0] current_state_in;
    reg [STATE_BITS-1:0] current_state_out;
    reg [CTRL_OUT_WIDTH-1:0] current_ctrl_out;
    
    entry_width = (STATE_BITS + CTRL_IN_WIDTH + STATE_BITS + CTRL_OUT_WIDTH);
    totalPatterns = TRANS_NUM * (1 << CTRL_IN_WIDTH); // Calculate total patterns directly
    
    // Initialize memory with default values (reset state with zero outputs)
    for (memAddr = 0; memAddr < (1 << (STATE_BITS + CTRL_IN_WIDTH)); memAddr = memAddr + 1) begin
        memBitPos = memAddr * (STATE_BITS + CTRL_OUT_WIDTH);
        memInit[memBitPos +: STATE_BITS] = STATE_RST;
        memInit[memBitPos + STATE_BITS +: CTRL_OUT_WIDTH] = {CTRL_OUT_WIDTH{1'b0}};
    end
    
    // Process transitions and fill memory with all possible combinations
    patternCount = 0;
    
    for (i = 0; i < TRANS_NUM; i = i + 1) begin
        // Calculate positions in the transition table for this entry
        state_in_pos = i * entry_width;
        ctrl_in_pos = state_in_pos + STATE_BITS;
        state_out_pos = ctrl_in_pos + CTRL_IN_WIDTH;
        ctrl_out_pos = state_out_pos + STATE_BITS;
        
        // Extract values directly from TRANS_TABLE
        current_state_in = TRANS_TABLE[state_in_pos +: STATE_BITS];
        current_state_out = TRANS_TABLE[state_out_pos +: STATE_BITS];
        current_ctrl_out = TRANS_TABLE[ctrl_out_pos +: CTRL_OUT_WIDTH];
        
        // Generate all possible combinations for control inputs
        for (j = 0; j < (1 << CTRL_IN_WIDTH); j = j + 1) begin
            // Set each bit based on the value of j
            ctrl_in_pattern = j[CTRL_IN_WIDTH-1:0];
            
            // Calculate memory address for this pattern
            memAddr = {current_state_in, ctrl_in_pattern};
            memBitPos = memAddr * (STATE_BITS + CTRL_OUT_WIDTH);
            
            // Set the corresponding memory values
            memInit[memBitPos +: STATE_BITS] = current_state_out;
            memInit[memBitPos + STATE_BITS +: CTRL_OUT_WIDTH] = current_ctrl_out;
        end
    end
    getMemInit = memInit;
endfunction


\$mem_v2 #(
    .MEMID(NAME),
    .SIZE(STATE_NUM),
    .OFFSET(0),
    .ABITS(STATE_BITS + CTRL_IN_WIDTH),
    .WIDTH(STATE_BITS + CTRL_OUT_WIDTH),
    .INIT(getMemInit()),

    .RD_PORTS(1),
    .RD_CLK_ENABLE(1'b1),
    .RD_CLK_POLARITY(CLK_POLARITY),
    .RD_TRANSPARENCY_MASK(1'b0),
    .RD_COLLISION_X_MASK(1'b0),
    .RD_WIDE_CONTINUATION(1'b0),
    .RD_CE_OVER_SRST(1'b0),
    .RD_ARST_VALUE(STATE_RST[STATE_BITS + CTRL_OUT_WIDTH-1:0]),
    .RD_SRST_VALUE(STATE_RST[STATE_BITS + CTRL_OUT_WIDTH-1:0]),
    .RD_INIT_VALUE(STATE_RST[STATE_BITS + CTRL_OUT_WIDTH-1:0]),

    .WR_PORTS(0),
    .WR_CLK_ENABLE(1'b0),
    .WR_CLK_POLARITY(CLK_POLARITY),
    .WR_PRIORITY_MASK(1'b0),
    .WR_WIDE_CONTINUATION(1'b0)
) _TECHMAP_REPLACE_ (
    .RD_CLK(CLK), 
    .RD_EN(1'b1), 
    .RD_ARST(ARST), 
    .RD_SRST(1'b0), 
    .RD_ADDR({current_state, CTRL_IN}),
    .RD_DATA({current_state, CTRL_OUT}),

    .WR_CLK(), 
    .WR_EN(), 
    .WR_ADDR(), 
    .WR_DATA()
);

endmodule