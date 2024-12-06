module gemm_wrapper(
  input [31:0] alpha,
  input  alpha_valid,
  input [31:0] beta,
  input  beta_valid,
  input [31:0] A_din0,
  input [31:0] A_din1,
  input [31:0] B_din0,
  input [31:0] B_din1,
  input [31:0] C_din0,
  input [31:0] C_din1,
  input  A_start_valid,
  input  B_start_valid,
  input  C_start_valid,
  input  start_valid,
  input  clk,
  input  rst,
  input  A_end_ready,
  input  B_end_ready,
  input  C_end_ready,
  input  end_ready,
  output  alpha_ready,
  output  beta_ready,
  output  A_start_ready,
  output  B_start_ready,
  output  C_start_ready,
  output  start_ready,
  output  A_end_valid,
  output  B_end_valid,
  output  C_end_valid,
  output  end_valid,
  output  A_ce0,
  output  A_we0,
  output [9:0] A_address0,
  output [31:0] A_dout0,
  output  A_ce1,
  output  A_we1,
  output [9:0] A_address1,
  output [31:0] A_dout1,
  output  B_ce0,
  output  B_we0,
  output [9:0] B_address0,
  output [31:0] B_dout0,
  output  B_ce1,
  output  B_we1,
  output [9:0] B_address1,
  output [31:0] B_dout1,
  output  C_ce0,
  output  C_we0,
  output [9:0] C_address0,
  output [31:0] C_dout0,
  output  C_ce1,
  output  C_we1,
  output [9:0] C_address1,
  output [31:0] C_dout1
);
  wire  mem_to_bram_converter_B_ce0;
  wire  mem_to_bram_converter_B_we0;
  wire [9:0] mem_to_bram_converter_B_address0;
  wire [31:0] mem_to_bram_converter_B_dout0;
  wire  mem_to_bram_converter_B_ce1;
  wire  mem_to_bram_converter_B_we1;
  wire [9:0] mem_to_bram_converter_B_address1;
  wire [31:0] mem_to_bram_converter_B_dout1;
  wire [31:0] mem_to_bram_converter_B_loadData;
  wire  mem_to_bram_converter_C_ce0;
  wire  mem_to_bram_converter_C_we0;
  wire [9:0] mem_to_bram_converter_C_address0;
  wire [31:0] mem_to_bram_converter_C_dout0;
  wire  mem_to_bram_converter_C_ce1;
  wire  mem_to_bram_converter_C_we1;
  wire [9:0] mem_to_bram_converter_C_address1;
  wire [31:0] mem_to_bram_converter_C_dout1;
  wire [31:0] mem_to_bram_converter_C_loadData;
  wire  mem_to_bram_converter_A_ce0;
  wire  mem_to_bram_converter_A_we0;
  wire [9:0] mem_to_bram_converter_A_address0;
  wire [31:0] mem_to_bram_converter_A_dout0;
  wire  mem_to_bram_converter_A_ce1;
  wire  mem_to_bram_converter_A_we1;
  wire [9:0] mem_to_bram_converter_A_address1;
  wire [31:0] mem_to_bram_converter_A_dout1;
  wire [31:0] mem_to_bram_converter_A_loadData;
  wire  gemm_wrapped_A_end_valid;
  wire  gemm_wrapped_A_end_ready;
  wire  gemm_wrapped_B_end_valid;
  wire  gemm_wrapped_B_end_ready;
  wire  gemm_wrapped_C_end_valid;
  wire  gemm_wrapped_C_end_ready;
  wire  gemm_wrapped_end_valid;
  wire  gemm_wrapped_end_ready;
  wire  gemm_wrapped_A_loadEn;
  wire [9:0] gemm_wrapped_A_loadAddr;
  wire  gemm_wrapped_A_storeEn;
  wire [9:0] gemm_wrapped_A_storeAddr;
  wire [31:0] gemm_wrapped_A_storeData;
  wire  gemm_wrapped_B_loadEn;
  wire [9:0] gemm_wrapped_B_loadAddr;
  wire  gemm_wrapped_B_storeEn;
  wire [9:0] gemm_wrapped_B_storeAddr;
  wire [31:0] gemm_wrapped_B_storeData;
  wire  gemm_wrapped_C_loadEn;
  wire [9:0] gemm_wrapped_C_loadAddr;
  wire  gemm_wrapped_C_storeEn;
  wire [9:0] gemm_wrapped_C_storeAddr;
  wire [31:0] gemm_wrapped_C_storeData;

  assign A_end_valid = gemm_wrapped_A_end_valid;
  assign gemm_wrapped_A_end_ready = A_end_ready;
  assign B_end_valid = gemm_wrapped_B_end_valid;
  assign gemm_wrapped_B_end_ready = B_end_ready;
  assign C_end_valid = gemm_wrapped_C_end_valid;
  assign gemm_wrapped_C_end_ready = C_end_ready;
  assign end_valid = gemm_wrapped_end_valid;
  assign gemm_wrapped_end_ready = end_ready;
  assign A_ce0 = mem_to_bram_converter_A_ce0;
  assign A_we0 = mem_to_bram_converter_A_we0;
  assign A_address0 = mem_to_bram_converter_A_address0;
  assign A_dout0 = mem_to_bram_converter_A_dout0;
  assign A_ce1 = mem_to_bram_converter_A_ce1;
  assign A_we1 = mem_to_bram_converter_A_we1;
  assign A_address1 = mem_to_bram_converter_A_address1;
  assign A_dout1 = mem_to_bram_converter_A_dout1;
  assign B_ce0 = mem_to_bram_converter_B_ce0;
  assign B_we0 = mem_to_bram_converter_B_we0;
  assign B_address0 = mem_to_bram_converter_B_address0;
  assign B_dout0 = mem_to_bram_converter_B_dout0;
  assign B_ce1 = mem_to_bram_converter_B_ce1;
  assign B_we1 = mem_to_bram_converter_B_we1;
  assign B_address1 = mem_to_bram_converter_B_address1;
  assign B_dout1 = mem_to_bram_converter_B_dout1;
  assign C_ce0 = mem_to_bram_converter_C_ce0;
  assign C_we0 = mem_to_bram_converter_C_we0;
  assign C_address0 = mem_to_bram_converter_C_address0;
  assign C_dout0 = mem_to_bram_converter_C_dout0;
  assign C_ce1 = mem_to_bram_converter_C_ce1;
  assign C_we1 = mem_to_bram_converter_C_we1;
  assign C_address1 = mem_to_bram_converter_C_address1;
  assign C_dout1 = mem_to_bram_converter_C_dout1;

  mem_to_bram #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) mem_to_bram_converter_B(
    .address0 (mem_to_bram_converter_B_address0),
    .address1 (mem_to_bram_converter_B_address1),
    .ce0 (mem_to_bram_converter_B_ce0),
    .ce1 (mem_to_bram_converter_B_ce1),
    .din0 (B_din0),
    .din1 (B_din1),
    .dout0 (mem_to_bram_converter_B_dout0),
    .dout1 (mem_to_bram_converter_B_dout1),
    .loadAddr (gemm_wrapped_B_loadAddr),
    .loadData (mem_to_bram_converter_B_loadData),
    .loadEn (gemm_wrapped_B_loadEn),
    .storeAddr (gemm_wrapped_B_storeAddr),
    .storeData (gemm_wrapped_B_storeData),
    .storeEn (gemm_wrapped_B_storeEn),
    .we0 (mem_to_bram_converter_B_we0),
    .we1 (mem_to_bram_converter_B_we1)
  );

  mem_to_bram #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) mem_to_bram_converter_C(
    .address0 (mem_to_bram_converter_C_address0),
    .address1 (mem_to_bram_converter_C_address1),
    .ce0 (mem_to_bram_converter_C_ce0),
    .ce1 (mem_to_bram_converter_C_ce1),
    .din0 (C_din0),
    .din1 (C_din1),
    .dout0 (mem_to_bram_converter_C_dout0),
    .dout1 (mem_to_bram_converter_C_dout1),
    .loadAddr (gemm_wrapped_C_loadAddr),
    .loadData (mem_to_bram_converter_C_loadData),
    .loadEn (gemm_wrapped_C_loadEn),
    .storeAddr (gemm_wrapped_C_storeAddr),
    .storeData (gemm_wrapped_C_storeData),
    .storeEn (gemm_wrapped_C_storeEn),
    .we0 (mem_to_bram_converter_C_we0),
    .we1 (mem_to_bram_converter_C_we1)
  );

  mem_to_bram #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) mem_to_bram_converter_A(
    .address0 (mem_to_bram_converter_A_address0),
    .address1 (mem_to_bram_converter_A_address1),
    .ce0 (mem_to_bram_converter_A_ce0),
    .ce1 (mem_to_bram_converter_A_ce1),
    .din0 (A_din0),
    .din1 (A_din1),
    .dout0 (mem_to_bram_converter_A_dout0),
    .dout1 (mem_to_bram_converter_A_dout1),
    .loadAddr (gemm_wrapped_A_loadAddr),
    .loadData (mem_to_bram_converter_A_loadData),
    .loadEn (gemm_wrapped_A_loadEn),
    .storeAddr (gemm_wrapped_A_storeAddr),
    .storeData (gemm_wrapped_A_storeData),
    .storeEn (gemm_wrapped_A_storeEn),
    .we0 (mem_to_bram_converter_A_we0),
    .we1 (mem_to_bram_converter_A_we1)
  );

  gemm gemm_wrapped(
    .A_end_ready (gemm_wrapped_A_end_ready),
    .A_end_valid (gemm_wrapped_A_end_valid),
    .A_loadAddr (gemm_wrapped_A_loadAddr),
    .A_loadData (mem_to_bram_converter_A_loadData),
    .A_loadEn (gemm_wrapped_A_loadEn),
    .A_start_ready (A_start_ready),
    .A_start_valid (A_start_valid),
    .A_storeAddr (gemm_wrapped_A_storeAddr),
    .A_storeData (gemm_wrapped_A_storeData),
    .A_storeEn (gemm_wrapped_A_storeEn),
    .B_end_ready (gemm_wrapped_B_end_ready),
    .B_end_valid (gemm_wrapped_B_end_valid),
    .B_loadAddr (gemm_wrapped_B_loadAddr),
    .B_loadData (mem_to_bram_converter_B_loadData),
    .B_loadEn (gemm_wrapped_B_loadEn),
    .B_start_ready (B_start_ready),
    .B_start_valid (B_start_valid),
    .B_storeAddr (gemm_wrapped_B_storeAddr),
    .B_storeData (gemm_wrapped_B_storeData),
    .B_storeEn (gemm_wrapped_B_storeEn),
    .C_end_ready (gemm_wrapped_C_end_ready),
    .C_end_valid (gemm_wrapped_C_end_valid),
    .C_loadAddr (gemm_wrapped_C_loadAddr),
    .C_loadData (mem_to_bram_converter_C_loadData),
    .C_loadEn (gemm_wrapped_C_loadEn),
    .C_start_ready (C_start_ready),
    .C_start_valid (C_start_valid),
    .C_storeAddr (gemm_wrapped_C_storeAddr),
    .C_storeData (gemm_wrapped_C_storeData),
    .C_storeEn (gemm_wrapped_C_storeEn),
    .alpha (alpha),
    .alpha_ready (alpha_ready),
    .alpha_valid (alpha_valid),
    .beta (beta),
    .beta_ready (beta_ready),
    .beta_valid (beta_valid),
    .clk (clk),
    .end_ready (gemm_wrapped_end_ready),
    .end_valid (gemm_wrapped_end_valid),
    .rst (rst),
    .start_ready (start_ready),
    .start_valid (start_valid)
  );

endmodule
