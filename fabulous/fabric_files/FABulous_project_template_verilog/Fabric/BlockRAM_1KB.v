module BlockRAM_1KB (clk, rd_en, rd_addr, rd_data, wr_en, wr_addr, wr_data, C0, C1, C2, C3, C4, C5);

    input clk;

    input rd_en;
    input [10:0] rd_addr;
    output [31:0] rd_data;

    input wr_en;
    input [10:0] wr_addr;
    input [31:0] wr_data;

    input C0; // C0,C1 select write port width: {C0,C1} = 0:32b, 1:16b, 2:8b, 3:4b
    input C1;
    input C2; // C2,C3 select read port width: {C2,C3} = 0:32b, 1:16b, 2:8b, 3:4b
    input C3;
    input C4; // C4 selects alwaysWriteEnable (overrides wr_en)
    input C5; // C5 selects optional output register

    wire [1:0] wr_port_configuration;
    wire [1:0] rd_port_configuration;
    wire alwaysWriteEnable;
    wire optional_register_enabled_configuration;
    assign wr_port_configuration = {C0, C1};
    assign rd_port_configuration = {C2, C3};
    assign alwaysWriteEnable = C4;
    assign optional_register_enabled_configuration = C5;

    // Write enable: alwaysWriteEnable overrides wr_en
    wire mem_wr_en;
    assign mem_wr_en = alwaysWriteEnable | wr_en;

    // Write address top bits select sub-word position in narrow modes
    wire [2:0] wr_addr_topbits;
    assign wr_addr_topbits = wr_addr[10:8];

    reg [3:0] mem_wr_mask;
    reg [31:0] muxedDataIn;

    always @ (*) begin
        mem_wr_mask = 4'b0000;
        muxedDataIn = 32'd0;
        if (wr_port_configuration == 0) begin // 32-bit
            mem_wr_mask = 4'b1111;
            muxedDataIn = wr_data;
        end else if (wr_port_configuration == 1) begin // 16-bit
            if (wr_addr_topbits[0] == 0) begin
                mem_wr_mask = 4'b0011;
                muxedDataIn[15:0] = wr_data[15:0];
            end else begin
                mem_wr_mask = 4'b1100;
                muxedDataIn[31:16] = wr_data[15:0];
            end
        end else if (wr_port_configuration == 2) begin // 8-bit
            if (wr_addr_topbits[1:0] == 0) begin
                mem_wr_mask = 4'b0001;
                muxedDataIn[7:0] = wr_data[7:0];
            end else if (wr_addr_topbits[1:0] == 1) begin
                mem_wr_mask = 4'b0010;
                muxedDataIn[15:8] = wr_data[7:0];
            end else if (wr_addr_topbits[1:0] == 2) begin
                mem_wr_mask = 4'b0100;
                muxedDataIn[23:16] = wr_data[7:0];
            end else begin
                mem_wr_mask = 4'b1000;
                muxedDataIn[31:24] = wr_data[7:0];
            end
        end else begin // 4-bit (wr_port_configuration == 3)
            // addr[10:9] selects byte, addr[8] selects nibble within byte
            // NOTE: writes a full byte; adjacent nibble in same byte is zeroed
            case (wr_addr_topbits)
                3'd0: begin mem_wr_mask = 4'b0001; muxedDataIn[3:0]   = wr_data[3:0]; end
                3'd1: begin mem_wr_mask = 4'b0001; muxedDataIn[7:4]   = wr_data[3:0]; end
                3'd2: begin mem_wr_mask = 4'b0010; muxedDataIn[11:8]  = wr_data[3:0]; end
                3'd3: begin mem_wr_mask = 4'b0010; muxedDataIn[15:12] = wr_data[3:0]; end
                3'd4: begin mem_wr_mask = 4'b0100; muxedDataIn[19:16] = wr_data[3:0]; end
                3'd5: begin mem_wr_mask = 4'b0100; muxedDataIn[23:20] = wr_data[3:0]; end
                3'd6: begin mem_wr_mask = 4'b1000; muxedDataIn[27:24] = wr_data[3:0]; end
                3'd7: begin mem_wr_mask = 4'b1000; muxedDataIn[31:28] = wr_data[3:0]; end
                default: begin mem_wr_mask = 4'b0000; muxedDataIn = 32'd0; end
            endcase
        end
    end

    wire [31:0] mem_dout;
    BlockRAM_1KB_macro_wrapper memory_cell (
        .clk(clk),
        .wr_en(mem_wr_en),
        .wr_cs(mem_wr_en),
        .wr_wmask(mem_wr_mask),
        .wr_addr(wr_addr[7:0]),
        .wr_din(muxedDataIn),
        .rd_cs(rd_en),
        .rd_addr(rd_addr[7:0]),
        .rd_dout(mem_dout)
    );

    // Read address top bits registered to match SRAM 1-cycle read latency
    reg [2:0] rd_dout_sel;
    always @ (posedge clk) begin
        rd_dout_sel <= rd_addr[10:8];
    end

    // Read output mux
    reg [31:0] rd_dout_muxed;
    always @ (*) begin
        rd_dout_muxed = 32'd0;
        if (rd_port_configuration == 0) begin // 32-bit
            rd_dout_muxed = mem_dout;
        end else if (rd_port_configuration == 1) begin // 16-bit
            if (rd_dout_sel[0] == 0) begin
                rd_dout_muxed[15:0] = mem_dout[15:0];
            end else begin
                rd_dout_muxed[15:0] = mem_dout[31:16];
            end
        end else if (rd_port_configuration == 2) begin // 8-bit
            if (rd_dout_sel[1:0] == 0) begin
                rd_dout_muxed[7:0] = mem_dout[7:0];
            end else if (rd_dout_sel[1:0] == 1) begin
                rd_dout_muxed[7:0] = mem_dout[15:8];
            end else if (rd_dout_sel[1:0] == 2) begin
                rd_dout_muxed[7:0] = mem_dout[23:16];
            end else begin
                rd_dout_muxed[7:0] = mem_dout[31:24];
            end
        end else begin // 4-bit (rd_port_configuration == 3)
            case (rd_dout_sel)
                3'd0: rd_dout_muxed[3:0] = mem_dout[3:0];
                3'd1: rd_dout_muxed[3:0] = mem_dout[7:4];
                3'd2: rd_dout_muxed[3:0] = mem_dout[11:8];
                3'd3: rd_dout_muxed[3:0] = mem_dout[15:12];
                3'd4: rd_dout_muxed[3:0] = mem_dout[19:16];
                3'd5: rd_dout_muxed[3:0] = mem_dout[23:20];
                3'd6: rd_dout_muxed[3:0] = mem_dout[27:24];
                3'd7: rd_dout_muxed[3:0] = mem_dout[31:28];
                default: rd_dout_muxed = 32'd0;
            endcase
        end
    end

    // Optional output register
    reg [31:0] rd_dout_additional_register;
    always @ (posedge clk) begin
        rd_dout_additional_register <= rd_dout_muxed;
    end

    reg [31:0] final_dout;
    assign rd_data = final_dout;
    always @ (*) begin
        if (optional_register_enabled_configuration) begin
            final_dout = rd_dout_additional_register;
        end else begin
            final_dout = rd_dout_muxed;
        end
    end
endmodule


module BlockRAM_1KB_macro_wrapper (clk, wr_en, wr_cs, wr_wmask, wr_addr, wr_din, rd_cs, rd_addr, rd_dout);

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 8;
    parameter NUM_WMASKS = 4;

    input clk;

    // Port 0: Read/Write (active-high interface)
    input wr_en;
    input wr_cs;
    input [NUM_WMASKS-1:0] wr_wmask;
    input [ADDR_WIDTH-1:0] wr_addr;
    input [DATA_WIDTH-1:0] wr_din;

    // Port 1: Read-only (active-high interface)
    input rd_cs;
    input [ADDR_WIDTH-1:0] rd_addr;
    output [DATA_WIDTH-1:0] rd_dout;

    sram_1rw1r_32_256_8_sky130 memory_cell (
        .clk0(clk),
        .csb0(~wr_cs),
        .web0(~wr_en),
        .wmask0(wr_wmask),
        .addr0(wr_addr),
        .din0(wr_din),
        .dout0(),
        .clk1(clk),
        .csb1(~rd_cs),
        .addr1(rd_addr),
        .dout1(rd_dout)
    );
endmodule


(* blackbox *)
module sram_1rw1r_32_256_8_sky130(
    clk0,csb0,web0,wmask0,addr0,din0,dout0,
    clk1,csb1,addr1,dout1
  );

  parameter NUM_WMASKS = 4 ;
  parameter DATA_WIDTH = 32 ;
  parameter ADDR_WIDTH = 8 ;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  parameter DELAY = 3 ;

  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [NUM_WMASKS-1:0]   wmask0; // write mask
  input [ADDR_WIDTH-1:0]  addr0;
  input [DATA_WIDTH-1:0]  din0;
  output [DATA_WIDTH-1:0] dout0;
  input  clk1; // clock
  input   csb1; // active low chip select
  input [ADDR_WIDTH-1:0]  addr1;
  output [DATA_WIDTH-1:0] dout1;
endmodule
