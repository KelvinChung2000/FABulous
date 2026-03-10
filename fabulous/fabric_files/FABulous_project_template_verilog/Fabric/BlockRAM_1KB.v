// Wrapper contract for the sky130 1rw1r macro:
// - Supported port widths are 32-bit, 16-bit and 8-bit only.
//   Configuration value 2'b11 is reserved and intentionally unsupported.
// - Addresses are contiguous within the selected access width.
//   Valid ranges are 0..255 for 32-bit mode, 0..511 for 16-bit mode,
//   and 0..1023 for 8-bit mode.
// - `rd_data` is only defined for completed reads issued with `rd_en=1`.
//   When `rd_en=0`, the SRAM read port is deselected and the wrapper may
//   continue presenting stale data from an earlier read. Downstream logic
//   must treat `rd_data` as invalid unless a read was requested.
// - Simultaneous write on port 0 and read on port 1 to the same address is
//   a macro-level collision. The sky130 SRAM does not guarantee old-data
//   or new-data behaviour for that case, so surrounding logic must avoid
//   same-address read/write cycles.
// - `C4` forces continuous writes and is intended only for specialised
//   fabric use cases. It increases SRAM switching activity and should not
//   be enabled in normal low-power operation.
// - `C5` is a runtime configuration input, not a synthesis-time parameter.
//   Keeping both the direct and registered read paths is therefore
//   intentional.

module BlockRAM_1KB (
    input               clk,
    input               rd_en,
    input      [9:0]    rd_addr,
    output     [31:0]   rd_data,
    input               wr_en,
    input      [9:0]    wr_addr,
    input      [31:0]   wr_data,
    input               C0,
    input               C1,
    input               C2,
    input               C3,
    input               C4,
    input               C5
);

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

    reg [7:0] mem_wr_addr;
    reg [3:0] mem_wr_mask;
    reg [31:0] muxedDataIn;

    always @(*) begin
        mem_wr_addr = 8'd0;
        mem_wr_mask = 4'd0;
        muxedDataIn = 32'd0;

        case (wr_port_configuration)
            2'b00: begin // 32-bit
                mem_wr_addr = wr_addr[7:0];
                mem_wr_mask = 4'b1111;
                muxedDataIn = wr_data;
            end
            2'b01: begin // 16-bit
                mem_wr_addr = wr_addr[8:1];
                if (wr_addr[0]) begin
                    mem_wr_mask = 4'b1100;
                    muxedDataIn[31:16] = wr_data[15:0];
                end else begin
                    mem_wr_mask = 4'b0011;
                    muxedDataIn[15:0] = wr_data[15:0];
                end
            end
            2'b10: begin // 8-bit
                mem_wr_addr = wr_addr[9:2];
                case (wr_addr[1:0])
                    2'b00: begin
                        mem_wr_mask = 4'b0001;
                        muxedDataIn[7:0] = wr_data[7:0];
                    end
                    2'b01: begin
                        mem_wr_mask = 4'b0010;
                        muxedDataIn[15:8] = wr_data[7:0];
                    end
                    2'b10: begin
                        mem_wr_mask = 4'b0100;
                        muxedDataIn[23:16] = wr_data[7:0];
                    end
                    2'b11: begin
                        mem_wr_mask = 4'b1000;
                        muxedDataIn[31:24] = wr_data[7:0];
                    end
                    default: begin
                    end
                endcase
            end
            default: begin
            end
        endcase
    end

    reg [7:0] mem_rd_addr;
    reg [1:0] rd_dout_sel;
    reg [1:0] rd_dout_sel_next;
    reg [1:0] rd_port_configuration_q;

    always @(*) begin
        mem_rd_addr = 8'd0;
        rd_dout_sel_next = 2'b00;

        case (rd_port_configuration)
            2'b00: begin // 32-bit
                mem_rd_addr = rd_addr[7:0];
                rd_dout_sel_next = 2'b00;
            end
            2'b01: begin // 16-bit
                mem_rd_addr = rd_addr[8:1];
                rd_dout_sel_next = {1'b0, rd_addr[0]};
            end
            2'b10: begin // 8-bit
                mem_rd_addr = rd_addr[9:2];
                rd_dout_sel_next = rd_addr[1:0];
            end
            default: begin
            end
        endcase
    end

    wire [31:0] mem_dout;
    BlockRAM_1KB_macro_wrapper memory_cell (
        .clk(clk),
        .wr_en(mem_wr_en),
        .wr_cs(mem_wr_en),
        .wr_wmask(mem_wr_mask),
        .wr_addr(mem_wr_addr),
        .wr_din(muxedDataIn),
        .rd_cs(rd_en),
        .rd_addr(mem_rd_addr),
        .rd_dout(mem_dout)
    );

    // Read lane select and width configuration are registered with the request
    // so the returned word is decoded with the same access mode that launched
    // the SRAM read.
    always @ (posedge clk) begin
        if (rd_en) begin
            rd_port_configuration_q <= rd_port_configuration;
            rd_dout_sel <= rd_dout_sel_next;
        end
    end

    // Read output mux
    reg [31:0] rd_dout_muxed;
    always @(*) begin
        rd_dout_muxed = 32'd0;
        case (rd_port_configuration_q)
            2'b00: begin // 32-bit
                rd_dout_muxed = mem_dout;
            end
            2'b01: begin // 16-bit
                rd_dout_muxed[15:0] = rd_dout_sel[0] ? mem_dout[31:16] : mem_dout[15:0];
            end
            2'b10: begin // 8-bit
                case (rd_dout_sel)
                    2'b00: begin
                        rd_dout_muxed[7:0] = mem_dout[7:0];
                    end
                    2'b01: begin
                        rd_dout_muxed[7:0] = mem_dout[15:8];
                    end
                    2'b10: begin
                        rd_dout_muxed[7:0] = mem_dout[23:16];
                    end
                    2'b11: begin
                        rd_dout_muxed[7:0] = mem_dout[31:24];
                    end
                    default: begin
                    end
                endcase
            end
            default: begin
            end
        endcase
    end

    // Optional output register
    reg [31:0] rd_dout_additional_register;
    always @ (posedge clk) begin
        rd_dout_additional_register <= rd_dout_muxed;
    end

    assign rd_data = optional_register_enabled_configuration ? rd_dout_additional_register : rd_dout_muxed;

endmodule


module BlockRAM_1KB_macro_wrapper #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8,
    parameter NUM_WMASKS = 4
) (
    input                         clk,
    input                         wr_en,
    input                         wr_cs,
    input      [NUM_WMASKS-1:0]   wr_wmask,
    input      [ADDR_WIDTH-1:0]   wr_addr,
    input      [DATA_WIDTH-1:0]   wr_din,
    input                         rd_cs,
    input      [ADDR_WIDTH-1:0]   rd_addr,
    output     [DATA_WIDTH-1:0]   rd_dout
);

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
module sram_1rw1r_32_256_8_sky130 #(
    parameter NUM_WMASKS = 4,
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8,
    parameter RAM_DEPTH = 1 << ADDR_WIDTH,
    parameter DELAY = 3
) (
    input                         clk0,
    input                         csb0,
    input                         web0,
    input      [NUM_WMASKS-1:0]   wmask0,
    input      [ADDR_WIDTH-1:0]   addr0,
    input      [DATA_WIDTH-1:0]   din0,
    output     [DATA_WIDTH-1:0]   dout0,
    input                         clk1,
    input                         csb1,
    input      [ADDR_WIDTH-1:0]   addr1,
    output     [DATA_WIDTH-1:0]   dout1
);
endmodule
