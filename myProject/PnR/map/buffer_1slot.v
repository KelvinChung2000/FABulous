module buffer #(
    parameter WIDTH = 1
) (
    input wire clock,
    input wire reset,

    input wire in_valid,
    input wire [WIDTH-1:0] in_data,
    output wire in_ready,

    output wire out_valid,
    output wire [WIDTH-1:0] out_data,
    input wire out_ready
);

  wire [WIDTH - 1: 0] data;
  wire valid;
  wire ready;

  oehb #(
      .DATA_TYPE(WIDTH)
  ) oehb_inst (
      .clk(clock),
      .rst(reset),
      .ins(in_data),
      .ins_valid(in_valid),
      .ins_ready(in_ready),
      .outs(data),
      .outs_valid(valid),
      .outs_ready(ready)
  );

  tehb #(
      .DATA_TYPE(WIDTH)
  ) tehb_inst (
      .clk(clock),
      .rst(reset),
      .ins(data),
      .ins_valid(valid),
      .ins_ready(ready),
      .outs(out_data),
      .outs_valid(out_valid),
      .outs_ready(out_ready)
  );


endmodule


module oehb #(
    parameter DATA_TYPE = 32
) (
    input clk,
    input rst,
    // Input channel
    input [DATA_TYPE - 1 : 0] ins,
    input ins_valid,
    output ins_ready,
    // Output channel
    output [DATA_TYPE - 1 : 0] outs,
    output outs_valid,
    input outs_ready
);
  wire regEn, inputReady;
  reg [DATA_TYPE - 1 : 0] dataReg = 0;

  // Instance of oehb_dataless to manage handshaking
  oehb_dataless control (
      .clk       (clk),
      .rst       (rst),
      .ins_valid (ins_valid),
      .ins_ready (inputReady),
      .outs_valid(outs_valid),
      .outs_ready(outs_ready)
  );

  always @(posedge clk) begin
    if (rst) begin
      dataReg <= {DATA_TYPE{1'b0}};
    end else if (regEn) begin
      dataReg <= ins;
    end
  end

  assign ins_ready = inputReady;
  assign regEn = inputReady & ins_valid;
  assign outs = dataReg;

endmodule

module tehb #(
    parameter DATA_TYPE = 32  // Default set to 32 bits
) (
    input clk,
    input rst,
    // Input Channel
    input [DATA_TYPE - 1 : 0] ins,
    input ins_valid,
    output ins_ready,
    // Output Channel
    output [DATA_TYPE - 1 : 0] outs,
    output outs_valid,
    input outs_ready
);
  // Signal Definition
  wire regEnable, regNotFull;
  reg [DATA_TYPE - 1 : 0] dataReg = 0;

  // Instantiate control logic part
  tehb_dataless control (
      .clk       (clk),
      .rst       (rst),
      .ins_valid (ins_valid),
      .ins_ready (regNotFull),
      .outs_valid(outs_valid),
      .outs_ready(outs_ready)
  );

  assign regEnable = regNotFull & ins_valid & ~outs_ready;

  always @(posedge clk) begin
    if (rst) begin
      dataReg <= 0;
    end else if (regEnable) begin
      dataReg <= ins;
    end
  end

  // Output Assignment
  assign outs = regNotFull ? ins : dataReg;

  assign ins_ready = regNotFull;

endmodule

module tehb_dataless (
    input  clk,
    input  rst,
    // Input Channel
    input  ins_valid,
    output ins_ready,
    // Output Channel
    output outs_valid,
    input  outs_ready
);
  reg fullReg = 0;

  always @(posedge clk) begin
    if (rst) begin
      fullReg <= 0;
    end else begin
      fullReg <= (ins_valid | fullReg) & ~outs_ready;
    end
  end

  assign ins_ready  = ~fullReg;
  assign outs_valid = ins_valid | fullReg;

endmodule

module oehb_dataless (
    input  clk,
    input  rst,
    // Input channel
    input  ins_valid,
    output ins_ready,
    // Output channel
    output outs_valid,
    input  outs_ready
);
  // Define internal signals
  reg outputValid = 0;

  always @(posedge clk) begin
    if (rst) begin
      outputValid <= 0;
    end else begin
      outputValid <= ins_valid | (~outs_ready & outputValid);
    end
  end

  assign ins_ready  = ~outputValid | outs_ready;
  assign outs_valid = outputValid;

endmodule
