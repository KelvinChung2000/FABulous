module gemm(
  input [31:0] alpha,
  input  alpha_valid,
  input [31:0] beta,
  input  beta_valid,
  input [31:0] A_loadData,
  input [31:0] B_loadData,
  input [31:0] C_loadData,
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
  output  A_loadEn,
  output [9:0] A_loadAddr,
  output  A_storeEn,
  output [9:0] A_storeAddr,
  output [31:0] A_storeData,
  output  B_loadEn,
  output [9:0] B_loadAddr,
  output  B_storeEn,
  output [9:0] B_storeAddr,
  output [31:0] B_storeData,
  output  C_loadEn,
  output [9:0] C_loadAddr,
  output  C_storeEn,
  output [9:0] C_storeAddr,
  output [31:0] C_storeData
);
  wire  fork0_outs_0_valid;
  wire  fork0_outs_0_ready;
  wire  fork0_outs_1_valid;
  wire  fork0_outs_1_ready;
  wire  fork0_outs_2_valid;
  wire  fork0_outs_2_ready;
  wire [31:0] mem_controller2_ldData_0;
  wire  mem_controller2_ldData_0_valid;
  wire  mem_controller2_ldData_0_ready;
  wire  mem_controller2_memEnd_valid;
  wire  mem_controller2_memEnd_ready;
  wire  mem_controller2_loadEn;
  wire [9:0] mem_controller2_loadAddr;
  wire  mem_controller2_storeEn;
  wire [9:0] mem_controller2_storeAddr;
  wire [31:0] mem_controller2_storeData;
  wire [31:0] mem_controller3_ldData_0;
  wire  mem_controller3_ldData_0_valid;
  wire  mem_controller3_ldData_0_ready;
  wire  mem_controller3_memEnd_valid;
  wire  mem_controller3_memEnd_ready;
  wire  mem_controller3_loadEn;
  wire [9:0] mem_controller3_loadAddr;
  wire  mem_controller3_storeEn;
  wire [9:0] mem_controller3_storeAddr;
  wire [31:0] mem_controller3_storeData;
  wire [31:0] mem_controller4_ldData_0;
  wire  mem_controller4_ldData_0_valid;
  wire  mem_controller4_ldData_0_ready;
  wire  mem_controller4_memEnd_valid;
  wire  mem_controller4_memEnd_ready;
  wire  mem_controller4_loadEn;
  wire [9:0] mem_controller4_loadAddr;
  wire  mem_controller4_storeEn;
  wire [9:0] mem_controller4_storeAddr;
  wire [31:0] mem_controller4_storeData;
  wire [0:0] constant1_outs;
  wire  constant1_outs_valid;
  wire  constant1_outs_ready;
  wire [5:0] extsi13_outs;
  wire  extsi13_outs_valid;
  wire  extsi13_outs_ready;
  wire [5:0] mux13_outs;
  wire  mux13_outs_valid;
  wire  mux13_outs_ready;
  wire [31:0] mux1_outs;
  wire  mux1_outs_valid;
  wire  mux1_outs_ready;
  wire [31:0] mux2_outs;
  wire  mux2_outs_valid;
  wire  mux2_outs_ready;
  wire  control_merge0_outs_valid;
  wire  control_merge0_outs_ready;
  wire [0:0] control_merge0_index;
  wire  control_merge0_index_valid;
  wire  control_merge0_index_ready;
  wire [0:0] fork1_outs_0;
  wire  fork1_outs_0_valid;
  wire  fork1_outs_0_ready;
  wire [0:0] fork1_outs_1;
  wire  fork1_outs_1_valid;
  wire  fork1_outs_1_ready;
  wire [0:0] fork1_outs_2;
  wire  fork1_outs_2_valid;
  wire  fork1_outs_2_ready;
  wire  buffer6_outs_valid;
  wire  buffer6_outs_ready;
  wire  buffer7_outs_valid;
  wire  buffer7_outs_ready;
  wire  fork2_outs_0_valid;
  wire  fork2_outs_0_ready;
  wire  fork2_outs_1_valid;
  wire  fork2_outs_1_ready;
  wire [0:0] constant3_outs;
  wire  constant3_outs_valid;
  wire  constant3_outs_ready;
  wire [5:0] extsi14_outs;
  wire  extsi14_outs_valid;
  wire  extsi14_outs_ready;
  wire [31:0] buffer2_outs;
  wire  buffer2_outs_valid;
  wire  buffer2_outs_ready;
  wire [31:0] buffer3_outs;
  wire  buffer3_outs_valid;
  wire  buffer3_outs_ready;
  wire [31:0] buffer4_outs;
  wire  buffer4_outs_valid;
  wire  buffer4_outs_ready;
  wire [31:0] buffer5_outs;
  wire  buffer5_outs_valid;
  wire  buffer5_outs_ready;
  wire [5:0] buffer0_outs;
  wire  buffer0_outs_valid;
  wire  buffer0_outs_ready;
  wire [5:0] buffer1_outs;
  wire  buffer1_outs_valid;
  wire  buffer1_outs_ready;
  wire [5:0] mux14_outs;
  wire  mux14_outs_valid;
  wire  mux14_outs_ready;
  wire [5:0] buffer8_outs;
  wire  buffer8_outs_valid;
  wire  buffer8_outs_ready;
  wire [5:0] buffer9_outs;
  wire  buffer9_outs_valid;
  wire  buffer9_outs_ready;
  wire [5:0] fork3_outs_0;
  wire  fork3_outs_0_valid;
  wire  fork3_outs_0_ready;
  wire [5:0] fork3_outs_1;
  wire  fork3_outs_1_valid;
  wire  fork3_outs_1_ready;
  wire [9:0] extsi15_outs;
  wire  extsi15_outs_valid;
  wire  extsi15_outs_ready;
  wire [31:0] mux4_outs;
  wire  mux4_outs_valid;
  wire  mux4_outs_ready;
  wire [31:0] mux5_outs;
  wire  mux5_outs_valid;
  wire  mux5_outs_ready;
  wire [31:0] buffer12_outs;
  wire  buffer12_outs_valid;
  wire  buffer12_outs_ready;
  wire [31:0] buffer13_outs;
  wire  buffer13_outs_valid;
  wire  buffer13_outs_ready;
  wire [31:0] fork4_outs_0;
  wire  fork4_outs_0_valid;
  wire  fork4_outs_0_ready;
  wire [31:0] fork4_outs_1;
  wire  fork4_outs_1_valid;
  wire  fork4_outs_1_ready;
  wire [5:0] mux15_outs;
  wire  mux15_outs_valid;
  wire  mux15_outs_ready;
  wire [5:0] buffer14_outs;
  wire  buffer14_outs_valid;
  wire  buffer14_outs_ready;
  wire [5:0] buffer15_outs;
  wire  buffer15_outs_valid;
  wire  buffer15_outs_ready;
  wire [5:0] fork5_outs_0;
  wire  fork5_outs_0_valid;
  wire  fork5_outs_0_ready;
  wire [5:0] fork5_outs_1;
  wire  fork5_outs_1_valid;
  wire  fork5_outs_1_ready;
  wire [11:0] extsi16_outs;
  wire  extsi16_outs_valid;
  wire  extsi16_outs_ready;
  wire  control_merge1_outs_valid;
  wire  control_merge1_outs_ready;
  wire [0:0] control_merge1_index;
  wire  control_merge1_index_valid;
  wire  control_merge1_index_ready;
  wire [0:0] fork6_outs_0;
  wire  fork6_outs_0_valid;
  wire  fork6_outs_0_ready;
  wire [0:0] fork6_outs_1;
  wire  fork6_outs_1_valid;
  wire  fork6_outs_1_ready;
  wire [0:0] fork6_outs_2;
  wire  fork6_outs_2_valid;
  wire  fork6_outs_2_ready;
  wire [0:0] fork6_outs_3;
  wire  fork6_outs_3_valid;
  wire  fork6_outs_3_ready;
  wire  buffer16_outs_valid;
  wire  buffer16_outs_ready;
  wire  buffer17_outs_valid;
  wire  buffer17_outs_ready;
  wire  fork7_outs_0_valid;
  wire  fork7_outs_0_ready;
  wire  fork7_outs_1_valid;
  wire  fork7_outs_1_ready;
  wire  source0_outs_valid;
  wire  source0_outs_ready;
  wire [5:0] constant15_outs;
  wire  constant15_outs_valid;
  wire  constant15_outs_ready;
  wire [11:0] extsi17_outs;
  wire  extsi17_outs_valid;
  wire  extsi17_outs_ready;
  wire [0:0] constant16_outs;
  wire  constant16_outs_valid;
  wire  constant16_outs_ready;
  wire [11:0] muli7_result;
  wire  muli7_result_valid;
  wire  muli7_result_ready;
  wire [9:0] trunci0_outs;
  wire  trunci0_outs_valid;
  wire  trunci0_outs_ready;
  wire [9:0] addi8_result;
  wire  addi8_result_valid;
  wire  addi8_result_ready;
  wire [9:0] load0_addrOut;
  wire  load0_addrOut_valid;
  wire  load0_addrOut_ready;
  wire [31:0] load0_dataOut;
  wire  load0_dataOut_valid;
  wire  load0_dataOut_ready;
  wire [31:0] muli0_result;
  wire  muli0_result_valid;
  wire  muli0_result_ready;
  wire [5:0] extsi18_outs;
  wire  extsi18_outs_valid;
  wire  extsi18_outs_ready;
  wire [31:0] buffer10_outs;
  wire  buffer10_outs_valid;
  wire  buffer10_outs_ready;
  wire [31:0] buffer11_outs;
  wire  buffer11_outs_valid;
  wire  buffer11_outs_ready;
  wire [5:0] mux16_outs;
  wire  mux16_outs_valid;
  wire  mux16_outs_ready;
  wire [5:0] buffer18_outs;
  wire  buffer18_outs_valid;
  wire  buffer18_outs_ready;
  wire [5:0] buffer19_outs;
  wire  buffer19_outs_valid;
  wire  buffer19_outs_ready;
  wire [5:0] fork8_outs_0;
  wire  fork8_outs_0_valid;
  wire  fork8_outs_0_ready;
  wire [5:0] fork8_outs_1;
  wire  fork8_outs_1_valid;
  wire  fork8_outs_1_ready;
  wire [5:0] fork8_outs_2;
  wire  fork8_outs_2_valid;
  wire  fork8_outs_2_ready;
  wire [9:0] extsi19_outs;
  wire  extsi19_outs_valid;
  wire  extsi19_outs_ready;
  wire [6:0] extsi20_outs;
  wire  extsi20_outs_valid;
  wire  extsi20_outs_ready;
  wire [11:0] extsi21_outs;
  wire  extsi21_outs_valid;
  wire  extsi21_outs_ready;
  wire [31:0] mux8_outs;
  wire  mux8_outs_valid;
  wire  mux8_outs_ready;
  wire [31:0] mux9_outs;
  wire  mux9_outs_valid;
  wire  mux9_outs_ready;
  wire [31:0] buffer22_outs;
  wire  buffer22_outs_valid;
  wire  buffer22_outs_ready;
  wire [31:0] buffer23_outs;
  wire  buffer23_outs_valid;
  wire  buffer23_outs_ready;
  wire [31:0] fork9_outs_0;
  wire  fork9_outs_0_valid;
  wire  fork9_outs_0_ready;
  wire [31:0] fork9_outs_1;
  wire  fork9_outs_1_valid;
  wire  fork9_outs_1_ready;
  wire [31:0] mux10_outs;
  wire  mux10_outs_valid;
  wire  mux10_outs_ready;
  wire [5:0] mux17_outs;
  wire  mux17_outs_valid;
  wire  mux17_outs_ready;
  wire [5:0] buffer26_outs;
  wire  buffer26_outs_valid;
  wire  buffer26_outs_ready;
  wire [5:0] buffer27_outs;
  wire  buffer27_outs_valid;
  wire  buffer27_outs_ready;
  wire [5:0] fork10_outs_0;
  wire  fork10_outs_0_valid;
  wire  fork10_outs_0_ready;
  wire [5:0] fork10_outs_1;
  wire  fork10_outs_1_valid;
  wire  fork10_outs_1_ready;
  wire [11:0] extsi22_outs;
  wire  extsi22_outs_valid;
  wire  extsi22_outs_ready;
  wire [5:0] mux18_outs;
  wire  mux18_outs_valid;
  wire  mux18_outs_ready;
  wire [5:0] buffer28_outs;
  wire  buffer28_outs_valid;
  wire  buffer28_outs_ready;
  wire [5:0] buffer29_outs;
  wire  buffer29_outs_valid;
  wire  buffer29_outs_ready;
  wire [5:0] fork11_outs_0;
  wire  fork11_outs_0_valid;
  wire  fork11_outs_0_ready;
  wire [5:0] fork11_outs_1;
  wire  fork11_outs_1_valid;
  wire  fork11_outs_1_ready;
  wire [9:0] extsi23_outs;
  wire  extsi23_outs_valid;
  wire  extsi23_outs_ready;
  wire  control_merge2_outs_valid;
  wire  control_merge2_outs_ready;
  wire [0:0] control_merge2_index;
  wire  control_merge2_index_valid;
  wire  control_merge2_index_ready;
  wire [0:0] fork12_outs_0;
  wire  fork12_outs_0_valid;
  wire  fork12_outs_0_ready;
  wire [0:0] fork12_outs_1;
  wire  fork12_outs_1_valid;
  wire  fork12_outs_1_ready;
  wire [0:0] fork12_outs_2;
  wire  fork12_outs_2_valid;
  wire  fork12_outs_2_ready;
  wire [0:0] fork12_outs_3;
  wire  fork12_outs_3_valid;
  wire  fork12_outs_3_ready;
  wire [0:0] fork12_outs_4;
  wire  fork12_outs_4_valid;
  wire  fork12_outs_4_ready;
  wire [0:0] fork12_outs_5;
  wire  fork12_outs_5_valid;
  wire  fork12_outs_5_ready;
  wire  source1_outs_valid;
  wire  source1_outs_ready;
  wire [5:0] constant17_outs;
  wire  constant17_outs_valid;
  wire  constant17_outs_ready;
  wire [5:0] fork13_outs_0;
  wire  fork13_outs_0_valid;
  wire  fork13_outs_0_ready;
  wire [5:0] fork13_outs_1;
  wire  fork13_outs_1_valid;
  wire  fork13_outs_1_ready;
  wire [11:0] extsi24_outs;
  wire  extsi24_outs_valid;
  wire  extsi24_outs_ready;
  wire [11:0] extsi25_outs;
  wire  extsi25_outs_valid;
  wire  extsi25_outs_ready;
  wire  source2_outs_valid;
  wire  source2_outs_ready;
  wire [5:0] constant18_outs;
  wire  constant18_outs_valid;
  wire  constant18_outs_ready;
  wire [6:0] extsi26_outs;
  wire  extsi26_outs_valid;
  wire  extsi26_outs_ready;
  wire  source3_outs_valid;
  wire  source3_outs_ready;
  wire [1:0] constant19_outs;
  wire  constant19_outs_valid;
  wire  constant19_outs_ready;
  wire [6:0] extsi27_outs;
  wire  extsi27_outs_valid;
  wire  extsi27_outs_ready;
  wire [11:0] muli8_result;
  wire  muli8_result_valid;
  wire  muli8_result_ready;
  wire [9:0] trunci1_outs;
  wire  trunci1_outs_valid;
  wire  trunci1_outs_ready;
  wire [9:0] addi9_result;
  wire  addi9_result_valid;
  wire  addi9_result_ready;
  wire [9:0] load1_addrOut;
  wire  load1_addrOut_valid;
  wire  load1_addrOut_ready;
  wire [31:0] load1_dataOut;
  wire  load1_dataOut_valid;
  wire  load1_dataOut_ready;
  wire [31:0] muli1_result;
  wire  muli1_result_valid;
  wire  muli1_result_ready;
  wire [11:0] muli9_result;
  wire  muli9_result_valid;
  wire  muli9_result_ready;
  wire [9:0] trunci2_outs;
  wire  trunci2_outs_valid;
  wire  trunci2_outs_ready;
  wire [9:0] addi10_result;
  wire  addi10_result_valid;
  wire  addi10_result_ready;
  wire [9:0] load2_addrOut;
  wire  load2_addrOut_valid;
  wire  load2_addrOut_ready;
  wire [31:0] load2_dataOut;
  wire  load2_dataOut_valid;
  wire  load2_dataOut_ready;
  wire [31:0] muli2_result;
  wire  muli2_result_valid;
  wire  muli2_result_ready;
  wire [31:0] buffer20_outs;
  wire  buffer20_outs_valid;
  wire  buffer20_outs_ready;
  wire [31:0] buffer21_outs;
  wire  buffer21_outs_valid;
  wire  buffer21_outs_ready;
  wire [31:0] addi0_result;
  wire  addi0_result_valid;
  wire  addi0_result_ready;
  wire [6:0] addi11_result;
  wire  addi11_result_valid;
  wire  addi11_result_ready;
  wire [6:0] fork14_outs_0;
  wire  fork14_outs_0_valid;
  wire  fork14_outs_0_ready;
  wire [6:0] fork14_outs_1;
  wire  fork14_outs_1_valid;
  wire  fork14_outs_1_ready;
  wire [5:0] trunci3_outs;
  wire  trunci3_outs_valid;
  wire  trunci3_outs_ready;
  wire [0:0] cmpi3_result;
  wire  cmpi3_result_valid;
  wire  cmpi3_result_ready;
  wire [0:0] fork15_outs_0;
  wire  fork15_outs_0_valid;
  wire  fork15_outs_0_ready;
  wire [0:0] fork15_outs_1;
  wire  fork15_outs_1_valid;
  wire  fork15_outs_1_ready;
  wire [0:0] fork15_outs_2;
  wire  fork15_outs_2_valid;
  wire  fork15_outs_2_ready;
  wire [0:0] fork15_outs_3;
  wire  fork15_outs_3_valid;
  wire  fork15_outs_3_ready;
  wire [0:0] fork15_outs_4;
  wire  fork15_outs_4_valid;
  wire  fork15_outs_4_ready;
  wire [0:0] fork15_outs_5;
  wire  fork15_outs_5_valid;
  wire  fork15_outs_5_ready;
  wire [0:0] fork15_outs_6;
  wire  fork15_outs_6_valid;
  wire  fork15_outs_6_ready;
  wire [5:0] cond_br0_trueOut;
  wire  cond_br0_trueOut_valid;
  wire  cond_br0_trueOut_ready;
  wire [5:0] cond_br0_falseOut;
  wire  cond_br0_falseOut_valid;
  wire  cond_br0_falseOut_ready;
  wire [31:0] cond_br4_trueOut;
  wire  cond_br4_trueOut_valid;
  wire  cond_br4_trueOut_ready;
  wire [31:0] cond_br4_falseOut;
  wire  cond_br4_falseOut_valid;
  wire  cond_br4_falseOut_ready;
  wire [31:0] cond_br5_trueOut;
  wire  cond_br5_trueOut_valid;
  wire  cond_br5_trueOut_ready;
  wire [31:0] cond_br5_falseOut;
  wire  cond_br5_falseOut_valid;
  wire  cond_br5_falseOut_ready;
  wire [31:0] buffer24_outs;
  wire  buffer24_outs_valid;
  wire  buffer24_outs_ready;
  wire [31:0] buffer25_outs;
  wire  buffer25_outs_valid;
  wire  buffer25_outs_ready;
  wire [31:0] cond_br6_trueOut;
  wire  cond_br6_trueOut_valid;
  wire  cond_br6_trueOut_ready;
  wire [31:0] cond_br6_falseOut;
  wire  cond_br6_falseOut_valid;
  wire  cond_br6_falseOut_ready;
  wire [5:0] cond_br1_trueOut;
  wire  cond_br1_trueOut_valid;
  wire  cond_br1_trueOut_ready;
  wire [5:0] cond_br1_falseOut;
  wire  cond_br1_falseOut_valid;
  wire  cond_br1_falseOut_ready;
  wire [5:0] cond_br2_trueOut;
  wire  cond_br2_trueOut_valid;
  wire  cond_br2_trueOut_ready;
  wire [5:0] cond_br2_falseOut;
  wire  cond_br2_falseOut_valid;
  wire  cond_br2_falseOut_ready;
  wire  buffer30_outs_valid;
  wire  buffer30_outs_ready;
  wire  buffer31_outs_valid;
  wire  buffer31_outs_ready;
  wire  cond_br9_trueOut_valid;
  wire  cond_br9_trueOut_ready;
  wire  cond_br9_falseOut_valid;
  wire  cond_br9_falseOut_ready;
  wire [5:0] buffer36_outs;
  wire  buffer36_outs_valid;
  wire  buffer36_outs_ready;
  wire [5:0] buffer37_outs;
  wire  buffer37_outs_valid;
  wire  buffer37_outs_ready;
  wire [5:0] fork16_outs_0;
  wire  fork16_outs_0_valid;
  wire  fork16_outs_0_ready;
  wire [5:0] fork16_outs_1;
  wire  fork16_outs_1_valid;
  wire  fork16_outs_1_ready;
  wire [11:0] extsi28_outs;
  wire  extsi28_outs_valid;
  wire  extsi28_outs_ready;
  wire [5:0] buffer38_outs;
  wire  buffer38_outs_valid;
  wire  buffer38_outs_ready;
  wire [5:0] buffer39_outs;
  wire  buffer39_outs_valid;
  wire  buffer39_outs_ready;
  wire [5:0] fork17_outs_0;
  wire  fork17_outs_0_valid;
  wire  fork17_outs_0_ready;
  wire [5:0] fork17_outs_1;
  wire  fork17_outs_1_valid;
  wire  fork17_outs_1_ready;
  wire [9:0] extsi29_outs;
  wire  extsi29_outs_valid;
  wire  extsi29_outs_ready;
  wire [6:0] extsi30_outs;
  wire  extsi30_outs_valid;
  wire  extsi30_outs_ready;
  wire  buffer42_outs_valid;
  wire  buffer42_outs_ready;
  wire  buffer43_outs_valid;
  wire  buffer43_outs_ready;
  wire  fork18_outs_0_valid;
  wire  fork18_outs_0_ready;
  wire  fork18_outs_1_valid;
  wire  fork18_outs_1_ready;
  wire [1:0] constant20_outs;
  wire  constant20_outs_valid;
  wire  constant20_outs_ready;
  wire [31:0] extsi7_outs;
  wire  extsi7_outs_valid;
  wire  extsi7_outs_ready;
  wire  source4_outs_valid;
  wire  source4_outs_ready;
  wire [5:0] constant21_outs;
  wire  constant21_outs_valid;
  wire  constant21_outs_ready;
  wire [11:0] extsi31_outs;
  wire  extsi31_outs_valid;
  wire  extsi31_outs_ready;
  wire  source5_outs_valid;
  wire  source5_outs_ready;
  wire [5:0] constant22_outs;
  wire  constant22_outs_valid;
  wire  constant22_outs_ready;
  wire [6:0] extsi32_outs;
  wire  extsi32_outs_valid;
  wire  extsi32_outs_ready;
  wire  source6_outs_valid;
  wire  source6_outs_ready;
  wire [1:0] constant23_outs;
  wire  constant23_outs_valid;
  wire  constant23_outs_ready;
  wire [6:0] extsi33_outs;
  wire  extsi33_outs_valid;
  wire  extsi33_outs_ready;
  wire [11:0] muli10_result;
  wire  muli10_result_valid;
  wire  muli10_result_ready;
  wire [9:0] trunci4_outs;
  wire  trunci4_outs_valid;
  wire  trunci4_outs_ready;
  wire [9:0] addi12_result;
  wire  addi12_result_valid;
  wire  addi12_result_ready;
  wire [31:0] buffer40_outs;
  wire  buffer40_outs_valid;
  wire  buffer40_outs_ready;
  wire [31:0] buffer41_outs;
  wire  buffer41_outs_valid;
  wire  buffer41_outs_ready;
  wire [9:0] store0_addrOut;
  wire  store0_addrOut_valid;
  wire  store0_addrOut_ready;
  wire [31:0] store0_dataToMem;
  wire  store0_dataToMem_valid;
  wire  store0_dataToMem_ready;
  wire [6:0] addi13_result;
  wire  addi13_result_valid;
  wire  addi13_result_ready;
  wire [6:0] fork19_outs_0;
  wire  fork19_outs_0_valid;
  wire  fork19_outs_0_ready;
  wire [6:0] fork19_outs_1;
  wire  fork19_outs_1_valid;
  wire  fork19_outs_1_ready;
  wire [5:0] trunci5_outs;
  wire  trunci5_outs_valid;
  wire  trunci5_outs_ready;
  wire [0:0] cmpi4_result;
  wire  cmpi4_result_valid;
  wire  cmpi4_result_ready;
  wire [0:0] fork20_outs_0;
  wire  fork20_outs_0_valid;
  wire  fork20_outs_0_ready;
  wire [0:0] fork20_outs_1;
  wire  fork20_outs_1_valid;
  wire  fork20_outs_1_ready;
  wire [0:0] fork20_outs_2;
  wire  fork20_outs_2_valid;
  wire  fork20_outs_2_ready;
  wire [0:0] fork20_outs_3;
  wire  fork20_outs_3_valid;
  wire  fork20_outs_3_ready;
  wire [0:0] fork20_outs_4;
  wire  fork20_outs_4_valid;
  wire  fork20_outs_4_ready;
  wire [5:0] cond_br19_trueOut;
  wire  cond_br19_trueOut_valid;
  wire  cond_br19_trueOut_ready;
  wire [5:0] cond_br19_falseOut;
  wire  cond_br19_falseOut_valid;
  wire  cond_br19_falseOut_ready;
  wire [31:0] buffer32_outs;
  wire  buffer32_outs_valid;
  wire  buffer32_outs_ready;
  wire [31:0] buffer33_outs;
  wire  buffer33_outs_valid;
  wire  buffer33_outs_ready;
  wire [31:0] cond_br11_trueOut;
  wire  cond_br11_trueOut_valid;
  wire  cond_br11_trueOut_ready;
  wire [31:0] cond_br11_falseOut;
  wire  cond_br11_falseOut_valid;
  wire  cond_br11_falseOut_ready;
  wire [31:0] buffer34_outs;
  wire  buffer34_outs_valid;
  wire  buffer34_outs_ready;
  wire [31:0] buffer35_outs;
  wire  buffer35_outs_valid;
  wire  buffer35_outs_ready;
  wire [31:0] cond_br12_trueOut;
  wire  cond_br12_trueOut_valid;
  wire  cond_br12_trueOut_ready;
  wire [31:0] cond_br12_falseOut;
  wire  cond_br12_falseOut_valid;
  wire  cond_br12_falseOut_ready;
  wire [5:0] cond_br20_trueOut;
  wire  cond_br20_trueOut_valid;
  wire  cond_br20_trueOut_ready;
  wire [5:0] cond_br20_falseOut;
  wire  cond_br20_falseOut_valid;
  wire  cond_br20_falseOut_ready;
  wire  cond_br14_trueOut_valid;
  wire  cond_br14_trueOut_ready;
  wire  cond_br14_falseOut_valid;
  wire  cond_br14_falseOut_ready;
  wire [5:0] buffer48_outs;
  wire  buffer48_outs_valid;
  wire  buffer48_outs_ready;
  wire [5:0] buffer49_outs;
  wire  buffer49_outs_valid;
  wire  buffer49_outs_ready;
  wire [6:0] extsi34_outs;
  wire  extsi34_outs_valid;
  wire  extsi34_outs_ready;
  wire  source7_outs_valid;
  wire  source7_outs_ready;
  wire [5:0] constant24_outs;
  wire  constant24_outs_valid;
  wire  constant24_outs_ready;
  wire [6:0] extsi35_outs;
  wire  extsi35_outs_valid;
  wire  extsi35_outs_ready;
  wire  source8_outs_valid;
  wire  source8_outs_ready;
  wire [1:0] constant25_outs;
  wire  constant25_outs_valid;
  wire  constant25_outs_ready;
  wire [6:0] extsi36_outs;
  wire  extsi36_outs_valid;
  wire  extsi36_outs_ready;
  wire [6:0] addi14_result;
  wire  addi14_result_valid;
  wire  addi14_result_ready;
  wire [6:0] fork21_outs_0;
  wire  fork21_outs_0_valid;
  wire  fork21_outs_0_ready;
  wire [6:0] fork21_outs_1;
  wire  fork21_outs_1_valid;
  wire  fork21_outs_1_ready;
  wire [5:0] trunci6_outs;
  wire  trunci6_outs_valid;
  wire  trunci6_outs_ready;
  wire [0:0] cmpi5_result;
  wire  cmpi5_result_valid;
  wire  cmpi5_result_ready;
  wire [0:0] fork22_outs_0;
  wire  fork22_outs_0_valid;
  wire  fork22_outs_0_ready;
  wire [0:0] fork22_outs_1;
  wire  fork22_outs_1_valid;
  wire  fork22_outs_1_ready;
  wire [0:0] fork22_outs_2;
  wire  fork22_outs_2_valid;
  wire  fork22_outs_2_ready;
  wire [0:0] fork22_outs_3;
  wire  fork22_outs_3_valid;
  wire  fork22_outs_3_ready;
  wire [5:0] cond_br21_trueOut;
  wire  cond_br21_trueOut_valid;
  wire  cond_br21_trueOut_ready;
  wire [5:0] cond_br21_falseOut;
  wire  cond_br21_falseOut_valid;
  wire  cond_br21_falseOut_ready;
  wire [31:0] buffer44_outs;
  wire  buffer44_outs_valid;
  wire  buffer44_outs_ready;
  wire [31:0] buffer45_outs;
  wire  buffer45_outs_valid;
  wire  buffer45_outs_ready;
  wire [31:0] cond_br16_trueOut;
  wire  cond_br16_trueOut_valid;
  wire  cond_br16_trueOut_ready;
  wire [31:0] cond_br16_falseOut;
  wire  cond_br16_falseOut_valid;
  wire  cond_br16_falseOut_ready;
  wire [31:0] buffer46_outs;
  wire  buffer46_outs_valid;
  wire  buffer46_outs_ready;
  wire [31:0] buffer47_outs;
  wire  buffer47_outs_valid;
  wire  buffer47_outs_ready;
  wire [31:0] cond_br17_trueOut;
  wire  cond_br17_trueOut_valid;
  wire  cond_br17_trueOut_ready;
  wire [31:0] cond_br17_falseOut;
  wire  cond_br17_falseOut_valid;
  wire  cond_br17_falseOut_ready;
  wire  buffer50_outs_valid;
  wire  buffer50_outs_ready;
  wire  buffer51_outs_valid;
  wire  buffer51_outs_ready;
  wire  cond_br18_trueOut_valid;
  wire  cond_br18_trueOut_ready;
  wire  cond_br18_falseOut_valid;
  wire  cond_br18_falseOut_ready;
  wire  buffer52_outs_valid;
  wire  buffer52_outs_ready;
  wire  buffer53_outs_valid;
  wire  buffer53_outs_ready;
  wire  fork23_outs_0_valid;
  wire  fork23_outs_0_ready;
  wire  fork23_outs_1_valid;
  wire  fork23_outs_1_ready;
  wire  fork23_outs_2_valid;
  wire  fork23_outs_2_ready;

  assign A_end_valid = mem_controller4_memEnd_valid;
  assign mem_controller4_memEnd_ready = A_end_ready;
  assign B_end_valid = mem_controller3_memEnd_valid;
  assign mem_controller3_memEnd_ready = B_end_ready;
  assign C_end_valid = mem_controller2_memEnd_valid;
  assign mem_controller2_memEnd_ready = C_end_ready;
  assign end_valid = fork0_outs_1_valid;
  assign fork0_outs_1_ready = end_ready;
  assign A_loadEn = mem_controller4_loadEn;
  assign A_loadAddr = mem_controller4_loadAddr;
  assign A_storeEn = mem_controller4_storeEn;
  assign A_storeAddr = mem_controller4_storeAddr;
  assign A_storeData = mem_controller4_storeData;
  assign B_loadEn = mem_controller3_loadEn;
  assign B_loadAddr = mem_controller3_loadAddr;
  assign B_storeEn = mem_controller3_storeEn;
  assign B_storeAddr = mem_controller3_storeAddr;
  assign B_storeData = mem_controller3_storeData;
  assign C_loadEn = mem_controller2_loadEn;
  assign C_loadAddr = mem_controller2_loadAddr;
  assign C_storeEn = mem_controller2_storeEn;
  assign C_storeAddr = mem_controller2_storeAddr;
  assign C_storeData = mem_controller2_storeData;

  fork_dataless #(.SIZE(3)) fork0(
    .clk (clk),
    .ins_ready (start_ready),
    .ins_valid (start_valid),
    .outs_ready ({fork0_outs_2_ready, fork0_outs_1_ready, fork0_outs_0_ready}),
    .outs_valid ({fork0_outs_2_valid, fork0_outs_1_valid, fork0_outs_0_valid}),
    .rst (rst)
  );

  mem_controller #(.NUM_CONTROLS(1), .NUM_LOADS(1), .NUM_STORES(1), .DATA_TYPE(32), .ADDR_TYPE(10)) mem_controller2(
    .clk (clk),
    .ctrl ({extsi7_outs}),
    .ctrlEnd_ready (fork23_outs_2_ready),
    .ctrlEnd_valid (fork23_outs_2_valid),
    .ctrl_ready ({extsi7_outs_ready}),
    .ctrl_valid ({extsi7_outs_valid}),
    .ldAddr ({load0_addrOut}),
    .ldAddr_ready ({load0_addrOut_ready}),
    .ldAddr_valid ({load0_addrOut_valid}),
    .ldData ({mem_controller2_ldData_0}),
    .ldData_ready ({mem_controller2_ldData_0_ready}),
    .ldData_valid ({mem_controller2_ldData_0_valid}),
    .loadAddr (mem_controller2_loadAddr),
    .loadData (C_loadData),
    .loadEn (mem_controller2_loadEn),
    .memEnd_ready (mem_controller2_memEnd_ready),
    .memEnd_valid (mem_controller2_memEnd_valid),
    .memStart_ready (C_start_ready),
    .memStart_valid (C_start_valid),
    .rst (rst),
    .stAddr ({store0_addrOut}),
    .stAddr_ready ({store0_addrOut_ready}),
    .stAddr_valid ({store0_addrOut_valid}),
    .stData ({store0_dataToMem}),
    .stData_ready ({store0_dataToMem_ready}),
    .stData_valid ({store0_dataToMem_valid}),
    .storeAddr (mem_controller2_storeAddr),
    .storeData (mem_controller2_storeData),
    .storeEn (mem_controller2_storeEn)
  );

  mem_controller_storeless #(.NUM_LOADS(1), .DATA_TYPE(32), .ADDR_TYPE(10)) mem_controller3(
    .clk (clk),
    .ctrlEnd_ready (fork23_outs_1_ready),
    .ctrlEnd_valid (fork23_outs_1_valid),
    .ldAddr ({load2_addrOut}),
    .ldAddr_ready ({load2_addrOut_ready}),
    .ldAddr_valid ({load2_addrOut_valid}),
    .ldData ({mem_controller3_ldData_0}),
    .ldData_ready ({mem_controller3_ldData_0_ready}),
    .ldData_valid ({mem_controller3_ldData_0_valid}),
    .loadAddr (mem_controller3_loadAddr),
    .loadData (B_loadData),
    .loadEn (mem_controller3_loadEn),
    .memEnd_ready (mem_controller3_memEnd_ready),
    .memEnd_valid (mem_controller3_memEnd_valid),
    .memStart_ready (B_start_ready),
    .memStart_valid (B_start_valid),
    .rst (rst),
    .storeAddr (mem_controller3_storeAddr),
    .storeData (mem_controller3_storeData),
    .storeEn (mem_controller3_storeEn)
  );

  mem_controller_storeless #(.NUM_LOADS(1), .DATA_TYPE(32), .ADDR_TYPE(10)) mem_controller4(
    .clk (clk),
    .ctrlEnd_ready (fork23_outs_0_ready),
    .ctrlEnd_valid (fork23_outs_0_valid),
    .ldAddr ({load1_addrOut}),
    .ldAddr_ready ({load1_addrOut_ready}),
    .ldAddr_valid ({load1_addrOut_valid}),
    .ldData ({mem_controller4_ldData_0}),
    .ldData_ready ({mem_controller4_ldData_0_ready}),
    .ldData_valid ({mem_controller4_ldData_0_valid}),
    .loadAddr (mem_controller4_loadAddr),
    .loadData (A_loadData),
    .loadEn (mem_controller4_loadEn),
    .memEnd_ready (mem_controller4_memEnd_ready),
    .memEnd_valid (mem_controller4_memEnd_valid),
    .memStart_ready (A_start_ready),
    .memStart_valid (A_start_valid),
    .rst (rst),
    .storeAddr (mem_controller4_storeAddr),
    .storeData (mem_controller4_storeData),
    .storeEn (mem_controller4_storeEn)
  );

  handshake_constant_0 #(.DATA_WIDTH(1)) constant1(
    .clk (clk),
    .ctrl_ready (fork0_outs_0_ready),
    .ctrl_valid (fork0_outs_0_valid),
    .outs (constant1_outs),
    .outs_ready (constant1_outs_ready),
    .outs_valid (constant1_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(1), .OUTPUT_TYPE(6)) extsi13(
    .clk (clk),
    .ins (constant1_outs),
    .ins_ready (constant1_outs_ready),
    .ins_valid (constant1_outs_valid),
    .outs (extsi13_outs),
    .outs_ready (extsi13_outs_ready),
    .outs_valid (extsi13_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(6), .SELECT_TYPE(1)) mux13(
    .clk (clk),
    .index (fork1_outs_0),
    .index_ready (fork1_outs_0_ready),
    .index_valid (fork1_outs_0_valid),
    .ins ({cond_br21_trueOut, extsi13_outs}),
    .ins_ready ({cond_br21_trueOut_ready, extsi13_outs_ready}),
    .ins_valid ({cond_br21_trueOut_valid, extsi13_outs_valid}),
    .outs (mux13_outs),
    .outs_ready (mux13_outs_ready),
    .outs_valid (mux13_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(32), .SELECT_TYPE(1)) mux1(
    .clk (clk),
    .index (fork1_outs_1),
    .index_ready (fork1_outs_1_ready),
    .index_valid (fork1_outs_1_valid),
    .ins ({cond_br16_trueOut, alpha}),
    .ins_ready ({cond_br16_trueOut_ready, alpha_ready}),
    .ins_valid ({cond_br16_trueOut_valid, alpha_valid}),
    .outs (mux1_outs),
    .outs_ready (mux1_outs_ready),
    .outs_valid (mux1_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(32), .SELECT_TYPE(1)) mux2(
    .clk (clk),
    .index (fork1_outs_2),
    .index_ready (fork1_outs_2_ready),
    .index_valid (fork1_outs_2_valid),
    .ins ({cond_br17_trueOut, beta}),
    .ins_ready ({cond_br17_trueOut_ready, beta_ready}),
    .ins_valid ({cond_br17_trueOut_valid, beta_valid}),
    .outs (mux2_outs),
    .outs_ready (mux2_outs_ready),
    .outs_valid (mux2_outs_valid),
    .rst (rst)
  );

  control_merge_dataless #(.SIZE(2), .INDEX_TYPE(1)) control_merge0(
    .clk (clk),
    .index (control_merge0_index),
    .index_ready (control_merge0_index_ready),
    .index_valid (control_merge0_index_valid),
    .ins_ready ({cond_br18_trueOut_ready, fork0_outs_2_ready}),
    .ins_valid ({cond_br18_trueOut_valid, fork0_outs_2_valid}),
    .outs_ready (control_merge0_outs_ready),
    .outs_valid (control_merge0_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(3), .DATA_TYPE(1)) fork1(
    .clk (clk),
    .ins (control_merge0_index),
    .ins_ready (control_merge0_index_ready),
    .ins_valid (control_merge0_index_valid),
    .outs ({fork1_outs_2, fork1_outs_1, fork1_outs_0}),
    .outs_ready ({fork1_outs_2_ready, fork1_outs_1_ready, fork1_outs_0_ready}),
    .outs_valid ({fork1_outs_2_valid, fork1_outs_1_valid, fork1_outs_0_valid}),
    .rst (rst)
  );

  oehb_dataless buffer6(
    .clk (clk),
    .ins_ready (control_merge0_outs_ready),
    .ins_valid (control_merge0_outs_valid),
    .outs_ready (buffer6_outs_ready),
    .outs_valid (buffer6_outs_valid),
    .rst (rst)
  );

  tehb_dataless buffer7(
    .clk (clk),
    .ins_ready (buffer6_outs_ready),
    .ins_valid (buffer6_outs_valid),
    .outs_ready (buffer7_outs_ready),
    .outs_valid (buffer7_outs_valid),
    .rst (rst)
  );

  fork_dataless #(.SIZE(2)) fork2(
    .clk (clk),
    .ins_ready (buffer7_outs_ready),
    .ins_valid (buffer7_outs_valid),
    .outs_ready ({fork2_outs_1_ready, fork2_outs_0_ready}),
    .outs_valid ({fork2_outs_1_valid, fork2_outs_0_valid}),
    .rst (rst)
  );

  handshake_constant_0 #(.DATA_WIDTH(1)) constant3(
    .clk (clk),
    .ctrl_ready (fork2_outs_0_ready),
    .ctrl_valid (fork2_outs_0_valid),
    .outs (constant3_outs),
    .outs_ready (constant3_outs_ready),
    .outs_valid (constant3_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(1), .OUTPUT_TYPE(6)) extsi14(
    .clk (clk),
    .ins (constant3_outs),
    .ins_ready (constant3_outs_ready),
    .ins_valid (constant3_outs_valid),
    .outs (extsi14_outs),
    .outs_ready (extsi14_outs_ready),
    .outs_valid (extsi14_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer2(
    .clk (clk),
    .ins (mux1_outs),
    .ins_ready (mux1_outs_ready),
    .ins_valid (mux1_outs_valid),
    .outs (buffer2_outs),
    .outs_ready (buffer2_outs_ready),
    .outs_valid (buffer2_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer3(
    .clk (clk),
    .ins (buffer2_outs),
    .ins_ready (buffer2_outs_ready),
    .ins_valid (buffer2_outs_valid),
    .outs (buffer3_outs),
    .outs_ready (buffer3_outs_ready),
    .outs_valid (buffer3_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer4(
    .clk (clk),
    .ins (mux2_outs),
    .ins_ready (mux2_outs_ready),
    .ins_valid (mux2_outs_valid),
    .outs (buffer4_outs),
    .outs_ready (buffer4_outs_ready),
    .outs_valid (buffer4_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer5(
    .clk (clk),
    .ins (buffer4_outs),
    .ins_ready (buffer4_outs_ready),
    .ins_valid (buffer4_outs_valid),
    .outs (buffer5_outs),
    .outs_ready (buffer5_outs_ready),
    .outs_valid (buffer5_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(6)) buffer0(
    .clk (clk),
    .ins (mux13_outs),
    .ins_ready (mux13_outs_ready),
    .ins_valid (mux13_outs_valid),
    .outs (buffer0_outs),
    .outs_ready (buffer0_outs_ready),
    .outs_valid (buffer0_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer1(
    .clk (clk),
    .ins (buffer0_outs),
    .ins_ready (buffer0_outs_ready),
    .ins_valid (buffer0_outs_valid),
    .outs (buffer1_outs),
    .outs_ready (buffer1_outs_ready),
    .outs_valid (buffer1_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(6), .SELECT_TYPE(1)) mux14(
    .clk (clk),
    .index (fork6_outs_1),
    .index_ready (fork6_outs_1_ready),
    .index_valid (fork6_outs_1_valid),
    .ins ({cond_br19_trueOut, extsi14_outs}),
    .ins_ready ({cond_br19_trueOut_ready, extsi14_outs_ready}),
    .ins_valid ({cond_br19_trueOut_valid, extsi14_outs_valid}),
    .outs (mux14_outs),
    .outs_ready (mux14_outs_ready),
    .outs_valid (mux14_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(6)) buffer8(
    .clk (clk),
    .ins (mux14_outs),
    .ins_ready (mux14_outs_ready),
    .ins_valid (mux14_outs_valid),
    .outs (buffer8_outs),
    .outs_ready (buffer8_outs_ready),
    .outs_valid (buffer8_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer9(
    .clk (clk),
    .ins (buffer8_outs),
    .ins_ready (buffer8_outs_ready),
    .ins_valid (buffer8_outs_valid),
    .outs (buffer9_outs),
    .outs_ready (buffer9_outs_ready),
    .outs_valid (buffer9_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(6)) fork3(
    .clk (clk),
    .ins (buffer9_outs),
    .ins_ready (buffer9_outs_ready),
    .ins_valid (buffer9_outs_valid),
    .outs ({fork3_outs_1, fork3_outs_0}),
    .outs_ready ({fork3_outs_1_ready, fork3_outs_0_ready}),
    .outs_valid ({fork3_outs_1_valid, fork3_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(10)) extsi15(
    .clk (clk),
    .ins (fork3_outs_0),
    .ins_ready (fork3_outs_0_ready),
    .ins_valid (fork3_outs_0_valid),
    .outs (extsi15_outs),
    .outs_ready (extsi15_outs_ready),
    .outs_valid (extsi15_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(32), .SELECT_TYPE(1)) mux4(
    .clk (clk),
    .index (fork6_outs_2),
    .index_ready (fork6_outs_2_ready),
    .index_valid (fork6_outs_2_valid),
    .ins ({cond_br11_trueOut, buffer3_outs}),
    .ins_ready ({cond_br11_trueOut_ready, buffer3_outs_ready}),
    .ins_valid ({cond_br11_trueOut_valid, buffer3_outs_valid}),
    .outs (mux4_outs),
    .outs_ready (mux4_outs_ready),
    .outs_valid (mux4_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(32), .SELECT_TYPE(1)) mux5(
    .clk (clk),
    .index (fork6_outs_3),
    .index_ready (fork6_outs_3_ready),
    .index_valid (fork6_outs_3_valid),
    .ins ({cond_br12_trueOut, buffer5_outs}),
    .ins_ready ({cond_br12_trueOut_ready, buffer5_outs_ready}),
    .ins_valid ({cond_br12_trueOut_valid, buffer5_outs_valid}),
    .outs (mux5_outs),
    .outs_ready (mux5_outs_ready),
    .outs_valid (mux5_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer12(
    .clk (clk),
    .ins (mux5_outs),
    .ins_ready (mux5_outs_ready),
    .ins_valid (mux5_outs_valid),
    .outs (buffer12_outs),
    .outs_ready (buffer12_outs_ready),
    .outs_valid (buffer12_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer13(
    .clk (clk),
    .ins (buffer12_outs),
    .ins_ready (buffer12_outs_ready),
    .ins_valid (buffer12_outs_valid),
    .outs (buffer13_outs),
    .outs_ready (buffer13_outs_ready),
    .outs_valid (buffer13_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(32)) fork4(
    .clk (clk),
    .ins (buffer13_outs),
    .ins_ready (buffer13_outs_ready),
    .ins_valid (buffer13_outs_valid),
    .outs ({fork4_outs_1, fork4_outs_0}),
    .outs_ready ({fork4_outs_1_ready, fork4_outs_0_ready}),
    .outs_valid ({fork4_outs_1_valid, fork4_outs_0_valid}),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(6), .SELECT_TYPE(1)) mux15(
    .clk (clk),
    .index (fork6_outs_0),
    .index_ready (fork6_outs_0_ready),
    .index_valid (fork6_outs_0_valid),
    .ins ({cond_br20_trueOut, buffer1_outs}),
    .ins_ready ({cond_br20_trueOut_ready, buffer1_outs_ready}),
    .ins_valid ({cond_br20_trueOut_valid, buffer1_outs_valid}),
    .outs (mux15_outs),
    .outs_ready (mux15_outs_ready),
    .outs_valid (mux15_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(6)) buffer14(
    .clk (clk),
    .ins (mux15_outs),
    .ins_ready (mux15_outs_ready),
    .ins_valid (mux15_outs_valid),
    .outs (buffer14_outs),
    .outs_ready (buffer14_outs_ready),
    .outs_valid (buffer14_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer15(
    .clk (clk),
    .ins (buffer14_outs),
    .ins_ready (buffer14_outs_ready),
    .ins_valid (buffer14_outs_valid),
    .outs (buffer15_outs),
    .outs_ready (buffer15_outs_ready),
    .outs_valid (buffer15_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(6)) fork5(
    .clk (clk),
    .ins (buffer15_outs),
    .ins_ready (buffer15_outs_ready),
    .ins_valid (buffer15_outs_valid),
    .outs ({fork5_outs_1, fork5_outs_0}),
    .outs_ready ({fork5_outs_1_ready, fork5_outs_0_ready}),
    .outs_valid ({fork5_outs_1_valid, fork5_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi16(
    .clk (clk),
    .ins (fork5_outs_1),
    .ins_ready (fork5_outs_1_ready),
    .ins_valid (fork5_outs_1_valid),
    .outs (extsi16_outs),
    .outs_ready (extsi16_outs_ready),
    .outs_valid (extsi16_outs_valid),
    .rst (rst)
  );

  control_merge_dataless #(.SIZE(2), .INDEX_TYPE(1)) control_merge1(
    .clk (clk),
    .index (control_merge1_index),
    .index_ready (control_merge1_index_ready),
    .index_valid (control_merge1_index_valid),
    .ins_ready ({cond_br14_trueOut_ready, fork2_outs_1_ready}),
    .ins_valid ({cond_br14_trueOut_valid, fork2_outs_1_valid}),
    .outs_ready (control_merge1_outs_ready),
    .outs_valid (control_merge1_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(4), .DATA_TYPE(1)) fork6(
    .clk (clk),
    .ins (control_merge1_index),
    .ins_ready (control_merge1_index_ready),
    .ins_valid (control_merge1_index_valid),
    .outs ({fork6_outs_3, fork6_outs_2, fork6_outs_1, fork6_outs_0}),
    .outs_ready ({fork6_outs_3_ready, fork6_outs_2_ready, fork6_outs_1_ready, fork6_outs_0_ready}),
    .outs_valid ({fork6_outs_3_valid, fork6_outs_2_valid, fork6_outs_1_valid, fork6_outs_0_valid}),
    .rst (rst)
  );

  oehb_dataless buffer16(
    .clk (clk),
    .ins_ready (control_merge1_outs_ready),
    .ins_valid (control_merge1_outs_valid),
    .outs_ready (buffer16_outs_ready),
    .outs_valid (buffer16_outs_valid),
    .rst (rst)
  );

  tehb_dataless buffer17(
    .clk (clk),
    .ins_ready (buffer16_outs_ready),
    .ins_valid (buffer16_outs_valid),
    .outs_ready (buffer17_outs_ready),
    .outs_valid (buffer17_outs_valid),
    .rst (rst)
  );

  fork_dataless #(.SIZE(2)) fork7(
    .clk (clk),
    .ins_ready (buffer17_outs_ready),
    .ins_valid (buffer17_outs_valid),
    .outs_ready ({fork7_outs_1_ready, fork7_outs_0_ready}),
    .outs_valid ({fork7_outs_1_valid, fork7_outs_0_valid}),
    .rst (rst)
  );

  source source0(
    .clk (clk),
    .outs_ready (source0_outs_ready),
    .outs_valid (source0_outs_valid),
    .rst (rst)
  );

  handshake_constant_1 #(.DATA_WIDTH(6)) constant15(
    .clk (clk),
    .ctrl_ready (source0_outs_ready),
    .ctrl_valid (source0_outs_valid),
    .outs (constant15_outs),
    .outs_ready (constant15_outs_ready),
    .outs_valid (constant15_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi17(
    .clk (clk),
    .ins (constant15_outs),
    .ins_ready (constant15_outs_ready),
    .ins_valid (constant15_outs_valid),
    .outs (extsi17_outs),
    .outs_ready (extsi17_outs_ready),
    .outs_valid (extsi17_outs_valid),
    .rst (rst)
  );

  handshake_constant_0 #(.DATA_WIDTH(1)) constant16(
    .clk (clk),
    .ctrl_ready (fork7_outs_0_ready),
    .ctrl_valid (fork7_outs_0_valid),
    .outs (constant16_outs),
    .outs_ready (constant16_outs_ready),
    .outs_valid (constant16_outs_valid),
    .rst (rst)
  );

  muli #(.DATA_TYPE(12)) muli7(
    .clk (clk),
    .lhs (extsi16_outs),
    .lhs_ready (extsi16_outs_ready),
    .lhs_valid (extsi16_outs_valid),
    .result (muli7_result),
    .result_ready (muli7_result_ready),
    .result_valid (muli7_result_valid),
    .rhs (extsi17_outs),
    .rhs_ready (extsi17_outs_ready),
    .rhs_valid (extsi17_outs_valid),
    .rst (rst)
  );

  trunci #(.INPUT_TYPE(12), .OUTPUT_TYPE(10)) trunci0(
    .clk (clk),
    .ins (muli7_result),
    .ins_ready (muli7_result_ready),
    .ins_valid (muli7_result_valid),
    .outs (trunci0_outs),
    .outs_ready (trunci0_outs_ready),
    .outs_valid (trunci0_outs_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(10)) addi8(
    .clk (clk),
    .lhs (extsi15_outs),
    .lhs_ready (extsi15_outs_ready),
    .lhs_valid (extsi15_outs_valid),
    .result (addi8_result),
    .result_ready (addi8_result_ready),
    .result_valid (addi8_result_valid),
    .rhs (trunci0_outs),
    .rhs_ready (trunci0_outs_ready),
    .rhs_valid (trunci0_outs_valid),
    .rst (rst)
  );

  load #(.DATA_TYPE(32), .ADDR_TYPE(10)) load0(
    .addrIn (addi8_result),
    .addrIn_ready (addi8_result_ready),
    .addrIn_valid (addi8_result_valid),
    .addrOut (load0_addrOut),
    .addrOut_ready (load0_addrOut_ready),
    .addrOut_valid (load0_addrOut_valid),
    .clk (clk),
    .dataFromMem (mem_controller2_ldData_0),
    .dataFromMem_ready (mem_controller2_ldData_0_ready),
    .dataFromMem_valid (mem_controller2_ldData_0_valid),
    .dataOut (load0_dataOut),
    .dataOut_ready (load0_dataOut_ready),
    .dataOut_valid (load0_dataOut_valid),
    .rst (rst)
  );

  muli #(.DATA_TYPE(32)) muli0(
    .clk (clk),
    .lhs (load0_dataOut),
    .lhs_ready (load0_dataOut_ready),
    .lhs_valid (load0_dataOut_valid),
    .result (muli0_result),
    .result_ready (muli0_result_ready),
    .result_valid (muli0_result_valid),
    .rhs (fork4_outs_1),
    .rhs_ready (fork4_outs_1_ready),
    .rhs_valid (fork4_outs_1_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(1), .OUTPUT_TYPE(6)) extsi18(
    .clk (clk),
    .ins (constant16_outs),
    .ins_ready (constant16_outs_ready),
    .ins_valid (constant16_outs_valid),
    .outs (extsi18_outs),
    .outs_ready (extsi18_outs_ready),
    .outs_valid (extsi18_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer10(
    .clk (clk),
    .ins (mux4_outs),
    .ins_ready (mux4_outs_ready),
    .ins_valid (mux4_outs_valid),
    .outs (buffer10_outs),
    .outs_ready (buffer10_outs_ready),
    .outs_valid (buffer10_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer11(
    .clk (clk),
    .ins (buffer10_outs),
    .ins_ready (buffer10_outs_ready),
    .ins_valid (buffer10_outs_valid),
    .outs (buffer11_outs),
    .outs_ready (buffer11_outs_ready),
    .outs_valid (buffer11_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(6), .SELECT_TYPE(1)) mux16(
    .clk (clk),
    .index (fork12_outs_2),
    .index_ready (fork12_outs_2_ready),
    .index_valid (fork12_outs_2_valid),
    .ins ({cond_br0_trueOut, extsi18_outs}),
    .ins_ready ({cond_br0_trueOut_ready, extsi18_outs_ready}),
    .ins_valid ({cond_br0_trueOut_valid, extsi18_outs_valid}),
    .outs (mux16_outs),
    .outs_ready (mux16_outs_ready),
    .outs_valid (mux16_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(6)) buffer18(
    .clk (clk),
    .ins (mux16_outs),
    .ins_ready (mux16_outs_ready),
    .ins_valid (mux16_outs_valid),
    .outs (buffer18_outs),
    .outs_ready (buffer18_outs_ready),
    .outs_valid (buffer18_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer19(
    .clk (clk),
    .ins (buffer18_outs),
    .ins_ready (buffer18_outs_ready),
    .ins_valid (buffer18_outs_valid),
    .outs (buffer19_outs),
    .outs_ready (buffer19_outs_ready),
    .outs_valid (buffer19_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(3), .DATA_TYPE(6)) fork8(
    .clk (clk),
    .ins (buffer19_outs),
    .ins_ready (buffer19_outs_ready),
    .ins_valid (buffer19_outs_valid),
    .outs ({fork8_outs_2, fork8_outs_1, fork8_outs_0}),
    .outs_ready ({fork8_outs_2_ready, fork8_outs_1_ready, fork8_outs_0_ready}),
    .outs_valid ({fork8_outs_2_valid, fork8_outs_1_valid, fork8_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(10)) extsi19(
    .clk (clk),
    .ins (fork8_outs_0),
    .ins_ready (fork8_outs_0_ready),
    .ins_valid (fork8_outs_0_valid),
    .outs (extsi19_outs),
    .outs_ready (extsi19_outs_ready),
    .outs_valid (extsi19_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(7)) extsi20(
    .clk (clk),
    .ins (fork8_outs_1),
    .ins_ready (fork8_outs_1_ready),
    .ins_valid (fork8_outs_1_valid),
    .outs (extsi20_outs),
    .outs_ready (extsi20_outs_ready),
    .outs_valid (extsi20_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi21(
    .clk (clk),
    .ins (fork8_outs_2),
    .ins_ready (fork8_outs_2_ready),
    .ins_valid (fork8_outs_2_valid),
    .outs (extsi21_outs),
    .outs_ready (extsi21_outs_ready),
    .outs_valid (extsi21_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(32), .SELECT_TYPE(1)) mux8(
    .clk (clk),
    .index (fork12_outs_3),
    .index_ready (fork12_outs_3_ready),
    .index_valid (fork12_outs_3_valid),
    .ins ({cond_br4_trueOut, muli0_result}),
    .ins_ready ({cond_br4_trueOut_ready, muli0_result_ready}),
    .ins_valid ({cond_br4_trueOut_valid, muli0_result_valid}),
    .outs (mux8_outs),
    .outs_ready (mux8_outs_ready),
    .outs_valid (mux8_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(32), .SELECT_TYPE(1)) mux9(
    .clk (clk),
    .index (fork12_outs_4),
    .index_ready (fork12_outs_4_ready),
    .index_valid (fork12_outs_4_valid),
    .ins ({cond_br5_trueOut, buffer11_outs}),
    .ins_ready ({cond_br5_trueOut_ready, buffer11_outs_ready}),
    .ins_valid ({cond_br5_trueOut_valid, buffer11_outs_valid}),
    .outs (mux9_outs),
    .outs_ready (mux9_outs_ready),
    .outs_valid (mux9_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer22(
    .clk (clk),
    .ins (mux9_outs),
    .ins_ready (mux9_outs_ready),
    .ins_valid (mux9_outs_valid),
    .outs (buffer22_outs),
    .outs_ready (buffer22_outs_ready),
    .outs_valid (buffer22_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer23(
    .clk (clk),
    .ins (buffer22_outs),
    .ins_ready (buffer22_outs_ready),
    .ins_valid (buffer22_outs_valid),
    .outs (buffer23_outs),
    .outs_ready (buffer23_outs_ready),
    .outs_valid (buffer23_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(32)) fork9(
    .clk (clk),
    .ins (buffer23_outs),
    .ins_ready (buffer23_outs_ready),
    .ins_valid (buffer23_outs_valid),
    .outs ({fork9_outs_1, fork9_outs_0}),
    .outs_ready ({fork9_outs_1_ready, fork9_outs_0_ready}),
    .outs_valid ({fork9_outs_1_valid, fork9_outs_0_valid}),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(32), .SELECT_TYPE(1)) mux10(
    .clk (clk),
    .index (fork12_outs_5),
    .index_ready (fork12_outs_5_ready),
    .index_valid (fork12_outs_5_valid),
    .ins ({cond_br6_trueOut, fork4_outs_0}),
    .ins_ready ({cond_br6_trueOut_ready, fork4_outs_0_ready}),
    .ins_valid ({cond_br6_trueOut_valid, fork4_outs_0_valid}),
    .outs (mux10_outs),
    .outs_ready (mux10_outs_ready),
    .outs_valid (mux10_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(6), .SELECT_TYPE(1)) mux17(
    .clk (clk),
    .index (fork12_outs_0),
    .index_ready (fork12_outs_0_ready),
    .index_valid (fork12_outs_0_valid),
    .ins ({cond_br1_trueOut, fork5_outs_0}),
    .ins_ready ({cond_br1_trueOut_ready, fork5_outs_0_ready}),
    .ins_valid ({cond_br1_trueOut_valid, fork5_outs_0_valid}),
    .outs (mux17_outs),
    .outs_ready (mux17_outs_ready),
    .outs_valid (mux17_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(6)) buffer26(
    .clk (clk),
    .ins (mux17_outs),
    .ins_ready (mux17_outs_ready),
    .ins_valid (mux17_outs_valid),
    .outs (buffer26_outs),
    .outs_ready (buffer26_outs_ready),
    .outs_valid (buffer26_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer27(
    .clk (clk),
    .ins (buffer26_outs),
    .ins_ready (buffer26_outs_ready),
    .ins_valid (buffer26_outs_valid),
    .outs (buffer27_outs),
    .outs_ready (buffer27_outs_ready),
    .outs_valid (buffer27_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(6)) fork10(
    .clk (clk),
    .ins (buffer27_outs),
    .ins_ready (buffer27_outs_ready),
    .ins_valid (buffer27_outs_valid),
    .outs ({fork10_outs_1, fork10_outs_0}),
    .outs_ready ({fork10_outs_1_ready, fork10_outs_0_ready}),
    .outs_valid ({fork10_outs_1_valid, fork10_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi22(
    .clk (clk),
    .ins (fork10_outs_1),
    .ins_ready (fork10_outs_1_ready),
    .ins_valid (fork10_outs_1_valid),
    .outs (extsi22_outs),
    .outs_ready (extsi22_outs_ready),
    .outs_valid (extsi22_outs_valid),
    .rst (rst)
  );

  mux #(.SIZE(2), .DATA_TYPE(6), .SELECT_TYPE(1)) mux18(
    .clk (clk),
    .index (fork12_outs_1),
    .index_ready (fork12_outs_1_ready),
    .index_valid (fork12_outs_1_valid),
    .ins ({cond_br2_trueOut, fork3_outs_1}),
    .ins_ready ({cond_br2_trueOut_ready, fork3_outs_1_ready}),
    .ins_valid ({cond_br2_trueOut_valid, fork3_outs_1_valid}),
    .outs (mux18_outs),
    .outs_ready (mux18_outs_ready),
    .outs_valid (mux18_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(6)) buffer28(
    .clk (clk),
    .ins (mux18_outs),
    .ins_ready (mux18_outs_ready),
    .ins_valid (mux18_outs_valid),
    .outs (buffer28_outs),
    .outs_ready (buffer28_outs_ready),
    .outs_valid (buffer28_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer29(
    .clk (clk),
    .ins (buffer28_outs),
    .ins_ready (buffer28_outs_ready),
    .ins_valid (buffer28_outs_valid),
    .outs (buffer29_outs),
    .outs_ready (buffer29_outs_ready),
    .outs_valid (buffer29_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(6)) fork11(
    .clk (clk),
    .ins (buffer29_outs),
    .ins_ready (buffer29_outs_ready),
    .ins_valid (buffer29_outs_valid),
    .outs ({fork11_outs_1, fork11_outs_0}),
    .outs_ready ({fork11_outs_1_ready, fork11_outs_0_ready}),
    .outs_valid ({fork11_outs_1_valid, fork11_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(10)) extsi23(
    .clk (clk),
    .ins (fork11_outs_0),
    .ins_ready (fork11_outs_0_ready),
    .ins_valid (fork11_outs_0_valid),
    .outs (extsi23_outs),
    .outs_ready (extsi23_outs_ready),
    .outs_valid (extsi23_outs_valid),
    .rst (rst)
  );

  control_merge_dataless #(.SIZE(2), .INDEX_TYPE(1)) control_merge2(
    .clk (clk),
    .index (control_merge2_index),
    .index_ready (control_merge2_index_ready),
    .index_valid (control_merge2_index_valid),
    .ins_ready ({cond_br9_trueOut_ready, fork7_outs_1_ready}),
    .ins_valid ({cond_br9_trueOut_valid, fork7_outs_1_valid}),
    .outs_ready (control_merge2_outs_ready),
    .outs_valid (control_merge2_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(6), .DATA_TYPE(1)) fork12(
    .clk (clk),
    .ins (control_merge2_index),
    .ins_ready (control_merge2_index_ready),
    .ins_valid (control_merge2_index_valid),
    .outs ({fork12_outs_5, fork12_outs_4, fork12_outs_3, fork12_outs_2, fork12_outs_1, fork12_outs_0}),
    .outs_ready ({fork12_outs_5_ready, fork12_outs_4_ready, fork12_outs_3_ready, fork12_outs_2_ready, fork12_outs_1_ready, fork12_outs_0_ready}),
    .outs_valid ({fork12_outs_5_valid, fork12_outs_4_valid, fork12_outs_3_valid, fork12_outs_2_valid, fork12_outs_1_valid, fork12_outs_0_valid}),
    .rst (rst)
  );

  source source1(
    .clk (clk),
    .outs_ready (source1_outs_ready),
    .outs_valid (source1_outs_valid),
    .rst (rst)
  );

  handshake_constant_1 #(.DATA_WIDTH(6)) constant17(
    .clk (clk),
    .ctrl_ready (source1_outs_ready),
    .ctrl_valid (source1_outs_valid),
    .outs (constant17_outs),
    .outs_ready (constant17_outs_ready),
    .outs_valid (constant17_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(6)) fork13(
    .clk (clk),
    .ins (constant17_outs),
    .ins_ready (constant17_outs_ready),
    .ins_valid (constant17_outs_valid),
    .outs ({fork13_outs_1, fork13_outs_0}),
    .outs_ready ({fork13_outs_1_ready, fork13_outs_0_ready}),
    .outs_valid ({fork13_outs_1_valid, fork13_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi24(
    .clk (clk),
    .ins (fork13_outs_0),
    .ins_ready (fork13_outs_0_ready),
    .ins_valid (fork13_outs_0_valid),
    .outs (extsi24_outs),
    .outs_ready (extsi24_outs_ready),
    .outs_valid (extsi24_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi25(
    .clk (clk),
    .ins (fork13_outs_1),
    .ins_ready (fork13_outs_1_ready),
    .ins_valid (fork13_outs_1_valid),
    .outs (extsi25_outs),
    .outs_ready (extsi25_outs_ready),
    .outs_valid (extsi25_outs_valid),
    .rst (rst)
  );

  source source2(
    .clk (clk),
    .outs_ready (source2_outs_ready),
    .outs_valid (source2_outs_valid),
    .rst (rst)
  );

  handshake_constant_2 #(.DATA_WIDTH(6)) constant18(
    .clk (clk),
    .ctrl_ready (source2_outs_ready),
    .ctrl_valid (source2_outs_valid),
    .outs (constant18_outs),
    .outs_ready (constant18_outs_ready),
    .outs_valid (constant18_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(7)) extsi26(
    .clk (clk),
    .ins (constant18_outs),
    .ins_ready (constant18_outs_ready),
    .ins_valid (constant18_outs_valid),
    .outs (extsi26_outs),
    .outs_ready (extsi26_outs_ready),
    .outs_valid (extsi26_outs_valid),
    .rst (rst)
  );

  source source3(
    .clk (clk),
    .outs_ready (source3_outs_ready),
    .outs_valid (source3_outs_valid),
    .rst (rst)
  );

  handshake_constant_3 #(.DATA_WIDTH(2)) constant19(
    .clk (clk),
    .ctrl_ready (source3_outs_ready),
    .ctrl_valid (source3_outs_valid),
    .outs (constant19_outs),
    .outs_ready (constant19_outs_ready),
    .outs_valid (constant19_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(2), .OUTPUT_TYPE(7)) extsi27(
    .clk (clk),
    .ins (constant19_outs),
    .ins_ready (constant19_outs_ready),
    .ins_valid (constant19_outs_valid),
    .outs (extsi27_outs),
    .outs_ready (extsi27_outs_ready),
    .outs_valid (extsi27_outs_valid),
    .rst (rst)
  );

  muli #(.DATA_TYPE(12)) muli8(
    .clk (clk),
    .lhs (extsi22_outs),
    .lhs_ready (extsi22_outs_ready),
    .lhs_valid (extsi22_outs_valid),
    .result (muli8_result),
    .result_ready (muli8_result_ready),
    .result_valid (muli8_result_valid),
    .rhs (extsi24_outs),
    .rhs_ready (extsi24_outs_ready),
    .rhs_valid (extsi24_outs_valid),
    .rst (rst)
  );

  trunci #(.INPUT_TYPE(12), .OUTPUT_TYPE(10)) trunci1(
    .clk (clk),
    .ins (muli8_result),
    .ins_ready (muli8_result_ready),
    .ins_valid (muli8_result_valid),
    .outs (trunci1_outs),
    .outs_ready (trunci1_outs_ready),
    .outs_valid (trunci1_outs_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(10)) addi9(
    .clk (clk),
    .lhs (extsi19_outs),
    .lhs_ready (extsi19_outs_ready),
    .lhs_valid (extsi19_outs_valid),
    .result (addi9_result),
    .result_ready (addi9_result_ready),
    .result_valid (addi9_result_valid),
    .rhs (trunci1_outs),
    .rhs_ready (trunci1_outs_ready),
    .rhs_valid (trunci1_outs_valid),
    .rst (rst)
  );

  load #(.DATA_TYPE(32), .ADDR_TYPE(10)) load1(
    .addrIn (addi9_result),
    .addrIn_ready (addi9_result_ready),
    .addrIn_valid (addi9_result_valid),
    .addrOut (load1_addrOut),
    .addrOut_ready (load1_addrOut_ready),
    .addrOut_valid (load1_addrOut_valid),
    .clk (clk),
    .dataFromMem (mem_controller4_ldData_0),
    .dataFromMem_ready (mem_controller4_ldData_0_ready),
    .dataFromMem_valid (mem_controller4_ldData_0_valid),
    .dataOut (load1_dataOut),
    .dataOut_ready (load1_dataOut_ready),
    .dataOut_valid (load1_dataOut_valid),
    .rst (rst)
  );

  muli #(.DATA_TYPE(32)) muli1(
    .clk (clk),
    .lhs (fork9_outs_1),
    .lhs_ready (fork9_outs_1_ready),
    .lhs_valid (fork9_outs_1_valid),
    .result (muli1_result),
    .result_ready (muli1_result_ready),
    .result_valid (muli1_result_valid),
    .rhs (load1_dataOut),
    .rhs_ready (load1_dataOut_ready),
    .rhs_valid (load1_dataOut_valid),
    .rst (rst)
  );

  muli #(.DATA_TYPE(12)) muli9(
    .clk (clk),
    .lhs (extsi21_outs),
    .lhs_ready (extsi21_outs_ready),
    .lhs_valid (extsi21_outs_valid),
    .result (muli9_result),
    .result_ready (muli9_result_ready),
    .result_valid (muli9_result_valid),
    .rhs (extsi25_outs),
    .rhs_ready (extsi25_outs_ready),
    .rhs_valid (extsi25_outs_valid),
    .rst (rst)
  );

  trunci #(.INPUT_TYPE(12), .OUTPUT_TYPE(10)) trunci2(
    .clk (clk),
    .ins (muli9_result),
    .ins_ready (muli9_result_ready),
    .ins_valid (muli9_result_valid),
    .outs (trunci2_outs),
    .outs_ready (trunci2_outs_ready),
    .outs_valid (trunci2_outs_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(10)) addi10(
    .clk (clk),
    .lhs (extsi23_outs),
    .lhs_ready (extsi23_outs_ready),
    .lhs_valid (extsi23_outs_valid),
    .result (addi10_result),
    .result_ready (addi10_result_ready),
    .result_valid (addi10_result_valid),
    .rhs (trunci2_outs),
    .rhs_ready (trunci2_outs_ready),
    .rhs_valid (trunci2_outs_valid),
    .rst (rst)
  );

  load #(.DATA_TYPE(32), .ADDR_TYPE(10)) load2(
    .addrIn (addi10_result),
    .addrIn_ready (addi10_result_ready),
    .addrIn_valid (addi10_result_valid),
    .addrOut (load2_addrOut),
    .addrOut_ready (load2_addrOut_ready),
    .addrOut_valid (load2_addrOut_valid),
    .clk (clk),
    .dataFromMem (mem_controller3_ldData_0),
    .dataFromMem_ready (mem_controller3_ldData_0_ready),
    .dataFromMem_valid (mem_controller3_ldData_0_valid),
    .dataOut (load2_dataOut),
    .dataOut_ready (load2_dataOut_ready),
    .dataOut_valid (load2_dataOut_valid),
    .rst (rst)
  );

  muli #(.DATA_TYPE(32)) muli2(
    .clk (clk),
    .lhs (muli1_result),
    .lhs_ready (muli1_result_ready),
    .lhs_valid (muli1_result_valid),
    .result (muli2_result),
    .result_ready (muli2_result_ready),
    .result_valid (muli2_result_valid),
    .rhs (load2_dataOut),
    .rhs_ready (load2_dataOut_ready),
    .rhs_valid (load2_dataOut_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer20(
    .clk (clk),
    .ins (mux8_outs),
    .ins_ready (mux8_outs_ready),
    .ins_valid (mux8_outs_valid),
    .outs (buffer20_outs),
    .outs_ready (buffer20_outs_ready),
    .outs_valid (buffer20_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer21(
    .clk (clk),
    .ins (buffer20_outs),
    .ins_ready (buffer20_outs_ready),
    .ins_valid (buffer20_outs_valid),
    .outs (buffer21_outs),
    .outs_ready (buffer21_outs_ready),
    .outs_valid (buffer21_outs_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(32)) addi0(
    .clk (clk),
    .lhs (buffer21_outs),
    .lhs_ready (buffer21_outs_ready),
    .lhs_valid (buffer21_outs_valid),
    .result (addi0_result),
    .result_ready (addi0_result_ready),
    .result_valid (addi0_result_valid),
    .rhs (muli2_result),
    .rhs_ready (muli2_result_ready),
    .rhs_valid (muli2_result_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(7)) addi11(
    .clk (clk),
    .lhs (extsi20_outs),
    .lhs_ready (extsi20_outs_ready),
    .lhs_valid (extsi20_outs_valid),
    .result (addi11_result),
    .result_ready (addi11_result_ready),
    .result_valid (addi11_result_valid),
    .rhs (extsi27_outs),
    .rhs_ready (extsi27_outs_ready),
    .rhs_valid (extsi27_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(7)) fork14(
    .clk (clk),
    .ins (addi11_result),
    .ins_ready (addi11_result_ready),
    .ins_valid (addi11_result_valid),
    .outs ({fork14_outs_1, fork14_outs_0}),
    .outs_ready ({fork14_outs_1_ready, fork14_outs_0_ready}),
    .outs_valid ({fork14_outs_1_valid, fork14_outs_0_valid}),
    .rst (rst)
  );

  trunci #(.INPUT_TYPE(7), .OUTPUT_TYPE(6)) trunci3(
    .clk (clk),
    .ins (fork14_outs_0),
    .ins_ready (fork14_outs_0_ready),
    .ins_valid (fork14_outs_0_valid),
    .outs (trunci3_outs),
    .outs_ready (trunci3_outs_ready),
    .outs_valid (trunci3_outs_valid),
    .rst (rst)
  );

  handshake_cmpi_0 #(.DATA_TYPE(7)) cmpi3(
    .clk (clk),
    .lhs (fork14_outs_1),
    .lhs_ready (fork14_outs_1_ready),
    .lhs_valid (fork14_outs_1_valid),
    .result (cmpi3_result),
    .result_ready (cmpi3_result_ready),
    .result_valid (cmpi3_result_valid),
    .rhs (extsi26_outs),
    .rhs_ready (extsi26_outs_ready),
    .rhs_valid (extsi26_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(7), .DATA_TYPE(1)) fork15(
    .clk (clk),
    .ins (cmpi3_result),
    .ins_ready (cmpi3_result_ready),
    .ins_valid (cmpi3_result_valid),
    .outs ({fork15_outs_6, fork15_outs_5, fork15_outs_4, fork15_outs_3, fork15_outs_2, fork15_outs_1, fork15_outs_0}),
    .outs_ready ({fork15_outs_6_ready, fork15_outs_5_ready, fork15_outs_4_ready, fork15_outs_3_ready, fork15_outs_2_ready, fork15_outs_1_ready, fork15_outs_0_ready}),
    .outs_valid ({fork15_outs_6_valid, fork15_outs_5_valid, fork15_outs_4_valid, fork15_outs_3_valid, fork15_outs_2_valid, fork15_outs_1_valid, fork15_outs_0_valid}),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(6)) cond_br0(
    .clk (clk),
    .condition (fork15_outs_0),
    .condition_ready (fork15_outs_0_ready),
    .condition_valid (fork15_outs_0_valid),
    .data (trunci3_outs),
    .data_ready (trunci3_outs_ready),
    .data_valid (trunci3_outs_valid),
    .falseOut (cond_br0_falseOut),
    .falseOut_ready (cond_br0_falseOut_ready),
    .falseOut_valid (cond_br0_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br0_trueOut),
    .trueOut_ready (cond_br0_trueOut_ready),
    .trueOut_valid (cond_br0_trueOut_valid)
  );

  sink #(.DATA_TYPE(6)) sink0(
    .clk (clk),
    .ins (cond_br0_falseOut),
    .ins_ready (cond_br0_falseOut_ready),
    .ins_valid (cond_br0_falseOut_valid),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(32)) cond_br4(
    .clk (clk),
    .condition (fork15_outs_3),
    .condition_ready (fork15_outs_3_ready),
    .condition_valid (fork15_outs_3_valid),
    .data (addi0_result),
    .data_ready (addi0_result_ready),
    .data_valid (addi0_result_valid),
    .falseOut (cond_br4_falseOut),
    .falseOut_ready (cond_br4_falseOut_ready),
    .falseOut_valid (cond_br4_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br4_trueOut),
    .trueOut_ready (cond_br4_trueOut_ready),
    .trueOut_valid (cond_br4_trueOut_valid)
  );

  cond_br #(.DATA_TYPE(32)) cond_br5(
    .clk (clk),
    .condition (fork15_outs_4),
    .condition_ready (fork15_outs_4_ready),
    .condition_valid (fork15_outs_4_valid),
    .data (fork9_outs_0),
    .data_ready (fork9_outs_0_ready),
    .data_valid (fork9_outs_0_valid),
    .falseOut (cond_br5_falseOut),
    .falseOut_ready (cond_br5_falseOut_ready),
    .falseOut_valid (cond_br5_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br5_trueOut),
    .trueOut_ready (cond_br5_trueOut_ready),
    .trueOut_valid (cond_br5_trueOut_valid)
  );

  oehb #(.DATA_TYPE(32)) buffer24(
    .clk (clk),
    .ins (mux10_outs),
    .ins_ready (mux10_outs_ready),
    .ins_valid (mux10_outs_valid),
    .outs (buffer24_outs),
    .outs_ready (buffer24_outs_ready),
    .outs_valid (buffer24_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer25(
    .clk (clk),
    .ins (buffer24_outs),
    .ins_ready (buffer24_outs_ready),
    .ins_valid (buffer24_outs_valid),
    .outs (buffer25_outs),
    .outs_ready (buffer25_outs_ready),
    .outs_valid (buffer25_outs_valid),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(32)) cond_br6(
    .clk (clk),
    .condition (fork15_outs_5),
    .condition_ready (fork15_outs_5_ready),
    .condition_valid (fork15_outs_5_valid),
    .data (buffer25_outs),
    .data_ready (buffer25_outs_ready),
    .data_valid (buffer25_outs_valid),
    .falseOut (cond_br6_falseOut),
    .falseOut_ready (cond_br6_falseOut_ready),
    .falseOut_valid (cond_br6_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br6_trueOut),
    .trueOut_ready (cond_br6_trueOut_ready),
    .trueOut_valid (cond_br6_trueOut_valid)
  );

  cond_br #(.DATA_TYPE(6)) cond_br1(
    .clk (clk),
    .condition (fork15_outs_1),
    .condition_ready (fork15_outs_1_ready),
    .condition_valid (fork15_outs_1_valid),
    .data (fork10_outs_0),
    .data_ready (fork10_outs_0_ready),
    .data_valid (fork10_outs_0_valid),
    .falseOut (cond_br1_falseOut),
    .falseOut_ready (cond_br1_falseOut_ready),
    .falseOut_valid (cond_br1_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br1_trueOut),
    .trueOut_ready (cond_br1_trueOut_ready),
    .trueOut_valid (cond_br1_trueOut_valid)
  );

  cond_br #(.DATA_TYPE(6)) cond_br2(
    .clk (clk),
    .condition (fork15_outs_2),
    .condition_ready (fork15_outs_2_ready),
    .condition_valid (fork15_outs_2_valid),
    .data (fork11_outs_1),
    .data_ready (fork11_outs_1_ready),
    .data_valid (fork11_outs_1_valid),
    .falseOut (cond_br2_falseOut),
    .falseOut_ready (cond_br2_falseOut_ready),
    .falseOut_valid (cond_br2_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br2_trueOut),
    .trueOut_ready (cond_br2_trueOut_ready),
    .trueOut_valid (cond_br2_trueOut_valid)
  );

  oehb_dataless buffer30(
    .clk (clk),
    .ins_ready (control_merge2_outs_ready),
    .ins_valid (control_merge2_outs_valid),
    .outs_ready (buffer30_outs_ready),
    .outs_valid (buffer30_outs_valid),
    .rst (rst)
  );

  tehb_dataless buffer31(
    .clk (clk),
    .ins_ready (buffer30_outs_ready),
    .ins_valid (buffer30_outs_valid),
    .outs_ready (buffer31_outs_ready),
    .outs_valid (buffer31_outs_valid),
    .rst (rst)
  );

  cond_br_dataless cond_br9(
    .clk (clk),
    .condition (fork15_outs_6),
    .condition_ready (fork15_outs_6_ready),
    .condition_valid (fork15_outs_6_valid),
    .data_ready (buffer31_outs_ready),
    .data_valid (buffer31_outs_valid),
    .falseOut_ready (cond_br9_falseOut_ready),
    .falseOut_valid (cond_br9_falseOut_valid),
    .rst (rst),
    .trueOut_ready (cond_br9_trueOut_ready),
    .trueOut_valid (cond_br9_trueOut_valid)
  );

  oehb #(.DATA_TYPE(6)) buffer36(
    .clk (clk),
    .ins (cond_br1_falseOut),
    .ins_ready (cond_br1_falseOut_ready),
    .ins_valid (cond_br1_falseOut_valid),
    .outs (buffer36_outs),
    .outs_ready (buffer36_outs_ready),
    .outs_valid (buffer36_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer37(
    .clk (clk),
    .ins (buffer36_outs),
    .ins_ready (buffer36_outs_ready),
    .ins_valid (buffer36_outs_valid),
    .outs (buffer37_outs),
    .outs_ready (buffer37_outs_ready),
    .outs_valid (buffer37_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(6)) fork16(
    .clk (clk),
    .ins (buffer37_outs),
    .ins_ready (buffer37_outs_ready),
    .ins_valid (buffer37_outs_valid),
    .outs ({fork16_outs_1, fork16_outs_0}),
    .outs_ready ({fork16_outs_1_ready, fork16_outs_0_ready}),
    .outs_valid ({fork16_outs_1_valid, fork16_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi28(
    .clk (clk),
    .ins (fork16_outs_1),
    .ins_ready (fork16_outs_1_ready),
    .ins_valid (fork16_outs_1_valid),
    .outs (extsi28_outs),
    .outs_ready (extsi28_outs_ready),
    .outs_valid (extsi28_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(6)) buffer38(
    .clk (clk),
    .ins (cond_br2_falseOut),
    .ins_ready (cond_br2_falseOut_ready),
    .ins_valid (cond_br2_falseOut_valid),
    .outs (buffer38_outs),
    .outs_ready (buffer38_outs_ready),
    .outs_valid (buffer38_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer39(
    .clk (clk),
    .ins (buffer38_outs),
    .ins_ready (buffer38_outs_ready),
    .ins_valid (buffer38_outs_valid),
    .outs (buffer39_outs),
    .outs_ready (buffer39_outs_ready),
    .outs_valid (buffer39_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(6)) fork17(
    .clk (clk),
    .ins (buffer39_outs),
    .ins_ready (buffer39_outs_ready),
    .ins_valid (buffer39_outs_valid),
    .outs ({fork17_outs_1, fork17_outs_0}),
    .outs_ready ({fork17_outs_1_ready, fork17_outs_0_ready}),
    .outs_valid ({fork17_outs_1_valid, fork17_outs_0_valid}),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(10)) extsi29(
    .clk (clk),
    .ins (fork17_outs_0),
    .ins_ready (fork17_outs_0_ready),
    .ins_valid (fork17_outs_0_valid),
    .outs (extsi29_outs),
    .outs_ready (extsi29_outs_ready),
    .outs_valid (extsi29_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(7)) extsi30(
    .clk (clk),
    .ins (fork17_outs_1),
    .ins_ready (fork17_outs_1_ready),
    .ins_valid (fork17_outs_1_valid),
    .outs (extsi30_outs),
    .outs_ready (extsi30_outs_ready),
    .outs_valid (extsi30_outs_valid),
    .rst (rst)
  );

  oehb_dataless buffer42(
    .clk (clk),
    .ins_ready (cond_br9_falseOut_ready),
    .ins_valid (cond_br9_falseOut_valid),
    .outs_ready (buffer42_outs_ready),
    .outs_valid (buffer42_outs_valid),
    .rst (rst)
  );

  tehb_dataless buffer43(
    .clk (clk),
    .ins_ready (buffer42_outs_ready),
    .ins_valid (buffer42_outs_valid),
    .outs_ready (buffer43_outs_ready),
    .outs_valid (buffer43_outs_valid),
    .rst (rst)
  );

  fork_dataless #(.SIZE(2)) fork18(
    .clk (clk),
    .ins_ready (buffer43_outs_ready),
    .ins_valid (buffer43_outs_valid),
    .outs_ready ({fork18_outs_1_ready, fork18_outs_0_ready}),
    .outs_valid ({fork18_outs_1_valid, fork18_outs_0_valid}),
    .rst (rst)
  );

  handshake_constant_3 #(.DATA_WIDTH(2)) constant20(
    .clk (clk),
    .ctrl_ready (fork18_outs_0_ready),
    .ctrl_valid (fork18_outs_0_valid),
    .outs (constant20_outs),
    .outs_ready (constant20_outs_ready),
    .outs_valid (constant20_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(2), .OUTPUT_TYPE(32)) extsi7(
    .clk (clk),
    .ins (constant20_outs),
    .ins_ready (constant20_outs_ready),
    .ins_valid (constant20_outs_valid),
    .outs (extsi7_outs),
    .outs_ready (extsi7_outs_ready),
    .outs_valid (extsi7_outs_valid),
    .rst (rst)
  );

  source source4(
    .clk (clk),
    .outs_ready (source4_outs_ready),
    .outs_valid (source4_outs_valid),
    .rst (rst)
  );

  handshake_constant_1 #(.DATA_WIDTH(6)) constant21(
    .clk (clk),
    .ctrl_ready (source4_outs_ready),
    .ctrl_valid (source4_outs_valid),
    .outs (constant21_outs),
    .outs_ready (constant21_outs_ready),
    .outs_valid (constant21_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(12)) extsi31(
    .clk (clk),
    .ins (constant21_outs),
    .ins_ready (constant21_outs_ready),
    .ins_valid (constant21_outs_valid),
    .outs (extsi31_outs),
    .outs_ready (extsi31_outs_ready),
    .outs_valid (extsi31_outs_valid),
    .rst (rst)
  );

  source source5(
    .clk (clk),
    .outs_ready (source5_outs_ready),
    .outs_valid (source5_outs_valid),
    .rst (rst)
  );

  handshake_constant_2 #(.DATA_WIDTH(6)) constant22(
    .clk (clk),
    .ctrl_ready (source5_outs_ready),
    .ctrl_valid (source5_outs_valid),
    .outs (constant22_outs),
    .outs_ready (constant22_outs_ready),
    .outs_valid (constant22_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(7)) extsi32(
    .clk (clk),
    .ins (constant22_outs),
    .ins_ready (constant22_outs_ready),
    .ins_valid (constant22_outs_valid),
    .outs (extsi32_outs),
    .outs_ready (extsi32_outs_ready),
    .outs_valid (extsi32_outs_valid),
    .rst (rst)
  );

  source source6(
    .clk (clk),
    .outs_ready (source6_outs_ready),
    .outs_valid (source6_outs_valid),
    .rst (rst)
  );

  handshake_constant_3 #(.DATA_WIDTH(2)) constant23(
    .clk (clk),
    .ctrl_ready (source6_outs_ready),
    .ctrl_valid (source6_outs_valid),
    .outs (constant23_outs),
    .outs_ready (constant23_outs_ready),
    .outs_valid (constant23_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(2), .OUTPUT_TYPE(7)) extsi33(
    .clk (clk),
    .ins (constant23_outs),
    .ins_ready (constant23_outs_ready),
    .ins_valid (constant23_outs_valid),
    .outs (extsi33_outs),
    .outs_ready (extsi33_outs_ready),
    .outs_valid (extsi33_outs_valid),
    .rst (rst)
  );

  muli #(.DATA_TYPE(12)) muli10(
    .clk (clk),
    .lhs (extsi28_outs),
    .lhs_ready (extsi28_outs_ready),
    .lhs_valid (extsi28_outs_valid),
    .result (muli10_result),
    .result_ready (muli10_result_ready),
    .result_valid (muli10_result_valid),
    .rhs (extsi31_outs),
    .rhs_ready (extsi31_outs_ready),
    .rhs_valid (extsi31_outs_valid),
    .rst (rst)
  );

  trunci #(.INPUT_TYPE(12), .OUTPUT_TYPE(10)) trunci4(
    .clk (clk),
    .ins (muli10_result),
    .ins_ready (muli10_result_ready),
    .ins_valid (muli10_result_valid),
    .outs (trunci4_outs),
    .outs_ready (trunci4_outs_ready),
    .outs_valid (trunci4_outs_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(10)) addi12(
    .clk (clk),
    .lhs (extsi29_outs),
    .lhs_ready (extsi29_outs_ready),
    .lhs_valid (extsi29_outs_valid),
    .result (addi12_result),
    .result_ready (addi12_result_ready),
    .result_valid (addi12_result_valid),
    .rhs (trunci4_outs),
    .rhs_ready (trunci4_outs_ready),
    .rhs_valid (trunci4_outs_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer40(
    .clk (clk),
    .ins (cond_br4_falseOut),
    .ins_ready (cond_br4_falseOut_ready),
    .ins_valid (cond_br4_falseOut_valid),
    .outs (buffer40_outs),
    .outs_ready (buffer40_outs_ready),
    .outs_valid (buffer40_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer41(
    .clk (clk),
    .ins (buffer40_outs),
    .ins_ready (buffer40_outs_ready),
    .ins_valid (buffer40_outs_valid),
    .outs (buffer41_outs),
    .outs_ready (buffer41_outs_ready),
    .outs_valid (buffer41_outs_valid),
    .rst (rst)
  );

  store #(.DATA_TYPE(32), .ADDR_TYPE(10)) store0(
    .addrIn (addi12_result),
    .addrIn_ready (addi12_result_ready),
    .addrIn_valid (addi12_result_valid),
    .addrOut (store0_addrOut),
    .addrOut_ready (store0_addrOut_ready),
    .addrOut_valid (store0_addrOut_valid),
    .clk (clk),
    .dataIn (buffer41_outs),
    .dataIn_ready (buffer41_outs_ready),
    .dataIn_valid (buffer41_outs_valid),
    .dataToMem (store0_dataToMem),
    .dataToMem_ready (store0_dataToMem_ready),
    .dataToMem_valid (store0_dataToMem_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(7)) addi13(
    .clk (clk),
    .lhs (extsi30_outs),
    .lhs_ready (extsi30_outs_ready),
    .lhs_valid (extsi30_outs_valid),
    .result (addi13_result),
    .result_ready (addi13_result_ready),
    .result_valid (addi13_result_valid),
    .rhs (extsi33_outs),
    .rhs_ready (extsi33_outs_ready),
    .rhs_valid (extsi33_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(7)) fork19(
    .clk (clk),
    .ins (addi13_result),
    .ins_ready (addi13_result_ready),
    .ins_valid (addi13_result_valid),
    .outs ({fork19_outs_1, fork19_outs_0}),
    .outs_ready ({fork19_outs_1_ready, fork19_outs_0_ready}),
    .outs_valid ({fork19_outs_1_valid, fork19_outs_0_valid}),
    .rst (rst)
  );

  trunci #(.INPUT_TYPE(7), .OUTPUT_TYPE(6)) trunci5(
    .clk (clk),
    .ins (fork19_outs_0),
    .ins_ready (fork19_outs_0_ready),
    .ins_valid (fork19_outs_0_valid),
    .outs (trunci5_outs),
    .outs_ready (trunci5_outs_ready),
    .outs_valid (trunci5_outs_valid),
    .rst (rst)
  );

  handshake_cmpi_0 #(.DATA_TYPE(7)) cmpi4(
    .clk (clk),
    .lhs (fork19_outs_1),
    .lhs_ready (fork19_outs_1_ready),
    .lhs_valid (fork19_outs_1_valid),
    .result (cmpi4_result),
    .result_ready (cmpi4_result_ready),
    .result_valid (cmpi4_result_valid),
    .rhs (extsi32_outs),
    .rhs_ready (extsi32_outs_ready),
    .rhs_valid (extsi32_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(5), .DATA_TYPE(1)) fork20(
    .clk (clk),
    .ins (cmpi4_result),
    .ins_ready (cmpi4_result_ready),
    .ins_valid (cmpi4_result_valid),
    .outs ({fork20_outs_4, fork20_outs_3, fork20_outs_2, fork20_outs_1, fork20_outs_0}),
    .outs_ready ({fork20_outs_4_ready, fork20_outs_3_ready, fork20_outs_2_ready, fork20_outs_1_ready, fork20_outs_0_ready}),
    .outs_valid ({fork20_outs_4_valid, fork20_outs_3_valid, fork20_outs_2_valid, fork20_outs_1_valid, fork20_outs_0_valid}),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(6)) cond_br19(
    .clk (clk),
    .condition (fork20_outs_0),
    .condition_ready (fork20_outs_0_ready),
    .condition_valid (fork20_outs_0_valid),
    .data (trunci5_outs),
    .data_ready (trunci5_outs_ready),
    .data_valid (trunci5_outs_valid),
    .falseOut (cond_br19_falseOut),
    .falseOut_ready (cond_br19_falseOut_ready),
    .falseOut_valid (cond_br19_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br19_trueOut),
    .trueOut_ready (cond_br19_trueOut_ready),
    .trueOut_valid (cond_br19_trueOut_valid)
  );

  sink #(.DATA_TYPE(6)) sink2(
    .clk (clk),
    .ins (cond_br19_falseOut),
    .ins_ready (cond_br19_falseOut_ready),
    .ins_valid (cond_br19_falseOut_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer32(
    .clk (clk),
    .ins (cond_br5_falseOut),
    .ins_ready (cond_br5_falseOut_ready),
    .ins_valid (cond_br5_falseOut_valid),
    .outs (buffer32_outs),
    .outs_ready (buffer32_outs_ready),
    .outs_valid (buffer32_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer33(
    .clk (clk),
    .ins (buffer32_outs),
    .ins_ready (buffer32_outs_ready),
    .ins_valid (buffer32_outs_valid),
    .outs (buffer33_outs),
    .outs_ready (buffer33_outs_ready),
    .outs_valid (buffer33_outs_valid),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(32)) cond_br11(
    .clk (clk),
    .condition (fork20_outs_2),
    .condition_ready (fork20_outs_2_ready),
    .condition_valid (fork20_outs_2_valid),
    .data (buffer33_outs),
    .data_ready (buffer33_outs_ready),
    .data_valid (buffer33_outs_valid),
    .falseOut (cond_br11_falseOut),
    .falseOut_ready (cond_br11_falseOut_ready),
    .falseOut_valid (cond_br11_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br11_trueOut),
    .trueOut_ready (cond_br11_trueOut_ready),
    .trueOut_valid (cond_br11_trueOut_valid)
  );

  oehb #(.DATA_TYPE(32)) buffer34(
    .clk (clk),
    .ins (cond_br6_falseOut),
    .ins_ready (cond_br6_falseOut_ready),
    .ins_valid (cond_br6_falseOut_valid),
    .outs (buffer34_outs),
    .outs_ready (buffer34_outs_ready),
    .outs_valid (buffer34_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer35(
    .clk (clk),
    .ins (buffer34_outs),
    .ins_ready (buffer34_outs_ready),
    .ins_valid (buffer34_outs_valid),
    .outs (buffer35_outs),
    .outs_ready (buffer35_outs_ready),
    .outs_valid (buffer35_outs_valid),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(32)) cond_br12(
    .clk (clk),
    .condition (fork20_outs_3),
    .condition_ready (fork20_outs_3_ready),
    .condition_valid (fork20_outs_3_valid),
    .data (buffer35_outs),
    .data_ready (buffer35_outs_ready),
    .data_valid (buffer35_outs_valid),
    .falseOut (cond_br12_falseOut),
    .falseOut_ready (cond_br12_falseOut_ready),
    .falseOut_valid (cond_br12_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br12_trueOut),
    .trueOut_ready (cond_br12_trueOut_ready),
    .trueOut_valid (cond_br12_trueOut_valid)
  );

  cond_br #(.DATA_TYPE(6)) cond_br20(
    .clk (clk),
    .condition (fork20_outs_1),
    .condition_ready (fork20_outs_1_ready),
    .condition_valid (fork20_outs_1_valid),
    .data (fork16_outs_0),
    .data_ready (fork16_outs_0_ready),
    .data_valid (fork16_outs_0_valid),
    .falseOut (cond_br20_falseOut),
    .falseOut_ready (cond_br20_falseOut_ready),
    .falseOut_valid (cond_br20_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br20_trueOut),
    .trueOut_ready (cond_br20_trueOut_ready),
    .trueOut_valid (cond_br20_trueOut_valid)
  );

  cond_br_dataless cond_br14(
    .clk (clk),
    .condition (fork20_outs_4),
    .condition_ready (fork20_outs_4_ready),
    .condition_valid (fork20_outs_4_valid),
    .data_ready (fork18_outs_1_ready),
    .data_valid (fork18_outs_1_valid),
    .falseOut_ready (cond_br14_falseOut_ready),
    .falseOut_valid (cond_br14_falseOut_valid),
    .rst (rst),
    .trueOut_ready (cond_br14_trueOut_ready),
    .trueOut_valid (cond_br14_trueOut_valid)
  );

  oehb #(.DATA_TYPE(6)) buffer48(
    .clk (clk),
    .ins (cond_br20_falseOut),
    .ins_ready (cond_br20_falseOut_ready),
    .ins_valid (cond_br20_falseOut_valid),
    .outs (buffer48_outs),
    .outs_ready (buffer48_outs_ready),
    .outs_valid (buffer48_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(6)) buffer49(
    .clk (clk),
    .ins (buffer48_outs),
    .ins_ready (buffer48_outs_ready),
    .ins_valid (buffer48_outs_valid),
    .outs (buffer49_outs),
    .outs_ready (buffer49_outs_ready),
    .outs_valid (buffer49_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(7)) extsi34(
    .clk (clk),
    .ins (buffer49_outs),
    .ins_ready (buffer49_outs_ready),
    .ins_valid (buffer49_outs_valid),
    .outs (extsi34_outs),
    .outs_ready (extsi34_outs_ready),
    .outs_valid (extsi34_outs_valid),
    .rst (rst)
  );

  source source7(
    .clk (clk),
    .outs_ready (source7_outs_ready),
    .outs_valid (source7_outs_valid),
    .rst (rst)
  );

  handshake_constant_2 #(.DATA_WIDTH(6)) constant24(
    .clk (clk),
    .ctrl_ready (source7_outs_ready),
    .ctrl_valid (source7_outs_valid),
    .outs (constant24_outs),
    .outs_ready (constant24_outs_ready),
    .outs_valid (constant24_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(6), .OUTPUT_TYPE(7)) extsi35(
    .clk (clk),
    .ins (constant24_outs),
    .ins_ready (constant24_outs_ready),
    .ins_valid (constant24_outs_valid),
    .outs (extsi35_outs),
    .outs_ready (extsi35_outs_ready),
    .outs_valid (extsi35_outs_valid),
    .rst (rst)
  );

  source source8(
    .clk (clk),
    .outs_ready (source8_outs_ready),
    .outs_valid (source8_outs_valid),
    .rst (rst)
  );

  handshake_constant_3 #(.DATA_WIDTH(2)) constant25(
    .clk (clk),
    .ctrl_ready (source8_outs_ready),
    .ctrl_valid (source8_outs_valid),
    .outs (constant25_outs),
    .outs_ready (constant25_outs_ready),
    .outs_valid (constant25_outs_valid),
    .rst (rst)
  );

  extsi #(.INPUT_TYPE(2), .OUTPUT_TYPE(7)) extsi36(
    .clk (clk),
    .ins (constant25_outs),
    .ins_ready (constant25_outs_ready),
    .ins_valid (constant25_outs_valid),
    .outs (extsi36_outs),
    .outs_ready (extsi36_outs_ready),
    .outs_valid (extsi36_outs_valid),
    .rst (rst)
  );

  addi #(.DATA_TYPE(7)) addi14(
    .clk (clk),
    .lhs (extsi34_outs),
    .lhs_ready (extsi34_outs_ready),
    .lhs_valid (extsi34_outs_valid),
    .result (addi14_result),
    .result_ready (addi14_result_ready),
    .result_valid (addi14_result_valid),
    .rhs (extsi36_outs),
    .rhs_ready (extsi36_outs_ready),
    .rhs_valid (extsi36_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(2), .DATA_TYPE(7)) fork21(
    .clk (clk),
    .ins (addi14_result),
    .ins_ready (addi14_result_ready),
    .ins_valid (addi14_result_valid),
    .outs ({fork21_outs_1, fork21_outs_0}),
    .outs_ready ({fork21_outs_1_ready, fork21_outs_0_ready}),
    .outs_valid ({fork21_outs_1_valid, fork21_outs_0_valid}),
    .rst (rst)
  );

  trunci #(.INPUT_TYPE(7), .OUTPUT_TYPE(6)) trunci6(
    .clk (clk),
    .ins (fork21_outs_0),
    .ins_ready (fork21_outs_0_ready),
    .ins_valid (fork21_outs_0_valid),
    .outs (trunci6_outs),
    .outs_ready (trunci6_outs_ready),
    .outs_valid (trunci6_outs_valid),
    .rst (rst)
  );

  handshake_cmpi_0 #(.DATA_TYPE(7)) cmpi5(
    .clk (clk),
    .lhs (fork21_outs_1),
    .lhs_ready (fork21_outs_1_ready),
    .lhs_valid (fork21_outs_1_valid),
    .result (cmpi5_result),
    .result_ready (cmpi5_result_ready),
    .result_valid (cmpi5_result_valid),
    .rhs (extsi35_outs),
    .rhs_ready (extsi35_outs_ready),
    .rhs_valid (extsi35_outs_valid),
    .rst (rst)
  );

  fork_type #(.SIZE(4), .DATA_TYPE(1)) fork22(
    .clk (clk),
    .ins (cmpi5_result),
    .ins_ready (cmpi5_result_ready),
    .ins_valid (cmpi5_result_valid),
    .outs ({fork22_outs_3, fork22_outs_2, fork22_outs_1, fork22_outs_0}),
    .outs_ready ({fork22_outs_3_ready, fork22_outs_2_ready, fork22_outs_1_ready, fork22_outs_0_ready}),
    .outs_valid ({fork22_outs_3_valid, fork22_outs_2_valid, fork22_outs_1_valid, fork22_outs_0_valid}),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(6)) cond_br21(
    .clk (clk),
    .condition (fork22_outs_0),
    .condition_ready (fork22_outs_0_ready),
    .condition_valid (fork22_outs_0_valid),
    .data (trunci6_outs),
    .data_ready (trunci6_outs_ready),
    .data_valid (trunci6_outs_valid),
    .falseOut (cond_br21_falseOut),
    .falseOut_ready (cond_br21_falseOut_ready),
    .falseOut_valid (cond_br21_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br21_trueOut),
    .trueOut_ready (cond_br21_trueOut_ready),
    .trueOut_valid (cond_br21_trueOut_valid)
  );

  sink #(.DATA_TYPE(6)) sink4(
    .clk (clk),
    .ins (cond_br21_falseOut),
    .ins_ready (cond_br21_falseOut_ready),
    .ins_valid (cond_br21_falseOut_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer44(
    .clk (clk),
    .ins (cond_br11_falseOut),
    .ins_ready (cond_br11_falseOut_ready),
    .ins_valid (cond_br11_falseOut_valid),
    .outs (buffer44_outs),
    .outs_ready (buffer44_outs_ready),
    .outs_valid (buffer44_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer45(
    .clk (clk),
    .ins (buffer44_outs),
    .ins_ready (buffer44_outs_ready),
    .ins_valid (buffer44_outs_valid),
    .outs (buffer45_outs),
    .outs_ready (buffer45_outs_ready),
    .outs_valid (buffer45_outs_valid),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(32)) cond_br16(
    .clk (clk),
    .condition (fork22_outs_1),
    .condition_ready (fork22_outs_1_ready),
    .condition_valid (fork22_outs_1_valid),
    .data (buffer45_outs),
    .data_ready (buffer45_outs_ready),
    .data_valid (buffer45_outs_valid),
    .falseOut (cond_br16_falseOut),
    .falseOut_ready (cond_br16_falseOut_ready),
    .falseOut_valid (cond_br16_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br16_trueOut),
    .trueOut_ready (cond_br16_trueOut_ready),
    .trueOut_valid (cond_br16_trueOut_valid)
  );

  sink #(.DATA_TYPE(32)) sink5(
    .clk (clk),
    .ins (cond_br16_falseOut),
    .ins_ready (cond_br16_falseOut_ready),
    .ins_valid (cond_br16_falseOut_valid),
    .rst (rst)
  );

  oehb #(.DATA_TYPE(32)) buffer46(
    .clk (clk),
    .ins (cond_br12_falseOut),
    .ins_ready (cond_br12_falseOut_ready),
    .ins_valid (cond_br12_falseOut_valid),
    .outs (buffer46_outs),
    .outs_ready (buffer46_outs_ready),
    .outs_valid (buffer46_outs_valid),
    .rst (rst)
  );

  tehb #(.DATA_TYPE(32)) buffer47(
    .clk (clk),
    .ins (buffer46_outs),
    .ins_ready (buffer46_outs_ready),
    .ins_valid (buffer46_outs_valid),
    .outs (buffer47_outs),
    .outs_ready (buffer47_outs_ready),
    .outs_valid (buffer47_outs_valid),
    .rst (rst)
  );

  cond_br #(.DATA_TYPE(32)) cond_br17(
    .clk (clk),
    .condition (fork22_outs_2),
    .condition_ready (fork22_outs_2_ready),
    .condition_valid (fork22_outs_2_valid),
    .data (buffer47_outs),
    .data_ready (buffer47_outs_ready),
    .data_valid (buffer47_outs_valid),
    .falseOut (cond_br17_falseOut),
    .falseOut_ready (cond_br17_falseOut_ready),
    .falseOut_valid (cond_br17_falseOut_valid),
    .rst (rst),
    .trueOut (cond_br17_trueOut),
    .trueOut_ready (cond_br17_trueOut_ready),
    .trueOut_valid (cond_br17_trueOut_valid)
  );

  sink #(.DATA_TYPE(32)) sink6(
    .clk (clk),
    .ins (cond_br17_falseOut),
    .ins_ready (cond_br17_falseOut_ready),
    .ins_valid (cond_br17_falseOut_valid),
    .rst (rst)
  );

  oehb_dataless buffer50(
    .clk (clk),
    .ins_ready (cond_br14_falseOut_ready),
    .ins_valid (cond_br14_falseOut_valid),
    .outs_ready (buffer50_outs_ready),
    .outs_valid (buffer50_outs_valid),
    .rst (rst)
  );

  tehb_dataless buffer51(
    .clk (clk),
    .ins_ready (buffer50_outs_ready),
    .ins_valid (buffer50_outs_valid),
    .outs_ready (buffer51_outs_ready),
    .outs_valid (buffer51_outs_valid),
    .rst (rst)
  );

  cond_br_dataless cond_br18(
    .clk (clk),
    .condition (fork22_outs_3),
    .condition_ready (fork22_outs_3_ready),
    .condition_valid (fork22_outs_3_valid),
    .data_ready (buffer51_outs_ready),
    .data_valid (buffer51_outs_valid),
    .falseOut_ready (cond_br18_falseOut_ready),
    .falseOut_valid (cond_br18_falseOut_valid),
    .rst (rst),
    .trueOut_ready (cond_br18_trueOut_ready),
    .trueOut_valid (cond_br18_trueOut_valid)
  );

  oehb_dataless buffer52(
    .clk (clk),
    .ins_ready (cond_br18_falseOut_ready),
    .ins_valid (cond_br18_falseOut_valid),
    .outs_ready (buffer52_outs_ready),
    .outs_valid (buffer52_outs_valid),
    .rst (rst)
  );

  tehb_dataless buffer53(
    .clk (clk),
    .ins_ready (buffer52_outs_ready),
    .ins_valid (buffer52_outs_valid),
    .outs_ready (buffer53_outs_ready),
    .outs_valid (buffer53_outs_valid),
    .rst (rst)
  );

  fork_dataless #(.SIZE(3)) fork23(
    .clk (clk),
    .ins_ready (buffer53_outs_ready),
    .ins_valid (buffer53_outs_valid),
    .outs_ready ({fork23_outs_2_ready, fork23_outs_1_ready, fork23_outs_0_ready}),
    .outs_valid ({fork23_outs_2_valid, fork23_outs_1_valid, fork23_outs_0_valid}),
    .rst (rst)
  );

endmodule
