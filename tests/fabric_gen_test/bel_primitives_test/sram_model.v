// Behavioral simulation model for sram_1rw1r_32_256_8_sky130
// This replaces the blackbox for cocotb simulation.
module sram_1rw1r_32_256_8_sky130(
    clk0,csb0,web0,wmask0,addr0,din0,dout0,
    clk1,csb1,addr1,dout1
  );

  parameter NUM_WMASKS = 4 ;
  parameter DATA_WIDTH = 32 ;
  parameter ADDR_WIDTH = 8 ;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  parameter DELAY = 3 ;

  input  clk0;
  input  csb0; // active low chip select
  input  web0; // active low write control
  input [NUM_WMASKS-1:0] wmask0;
  input [ADDR_WIDTH-1:0] addr0;
  input [DATA_WIDTH-1:0] din0;
  output reg [DATA_WIDTH-1:0] dout0;

  input  clk1;
  input  csb1; // active low chip select
  input [ADDR_WIDTH-1:0] addr1;
  output reg [DATA_WIDTH-1:0] dout1;

  reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

  // Port 0: Read/Write
  always @ (posedge clk0) begin
    if (!csb0) begin
      if (!web0) begin // write
        if (wmask0[0]) mem[addr0][7:0]   <= din0[7:0];
        if (wmask0[1]) mem[addr0][15:8]  <= din0[15:8];
        if (wmask0[2]) mem[addr0][23:16] <= din0[23:16];
        if (wmask0[3]) mem[addr0][31:24] <= din0[31:24];
      end
      dout0 <= mem[addr0];
    end
  end

  // Port 1: Read-only
  always @ (posedge clk1) begin
    if (!csb1) begin
      dout1 <= mem[addr1];
    end
  end
endmodule
