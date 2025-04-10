/* verilator lint_off MULTITOP */
/// =================== Unsigned, Fixed Point =========================
module std_fp_add #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out
);
  assign out = left + right;
endmodule

module std_fp_sub #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out
);
  assign out = left - right;
endmodule

module std_fp_mult_pipe #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16,
    parameter SIGNED = 0
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    input  logic             go,
    input  logic             clk,
    input  logic             reset,
    output logic [WIDTH-1:0] out,
    output logic             done
);
  logic [WIDTH-1:0]          rtmp;
  logic [WIDTH-1:0]          ltmp;
  logic [(WIDTH << 1) - 1:0] out_tmp;
  // Buffer used to walk through the 3 cycles of the pipeline.
  logic done_buf[1:0];

  assign done = done_buf[1];

  assign out = out_tmp[(WIDTH << 1) - INT_WIDTH - 1 : WIDTH - INT_WIDTH];

  // If the done buffer is completely empty and go is high then execution
  // just started.
  logic start;
  assign start = go;

  // Start sending the done signal.
  always_ff @(posedge clk) begin
    if (start)
      done_buf[0] <= 1;
    else
      done_buf[0] <= 0;
  end

  // Push the done signal through the pipeline.
  always_ff @(posedge clk) begin
    if (go) begin
      done_buf[1] <= done_buf[0];
    end else begin
      done_buf[1] <= 0;
    end
  end

  // Register the inputs
  always_ff @(posedge clk) begin
    if (reset) begin
      rtmp <= 0;
      ltmp <= 0;
    end else if (go) begin
      if (SIGNED) begin
        rtmp <= $signed(right);
        ltmp <= $signed(left);
      end else begin
        rtmp <= right;
        ltmp <= left;
      end
    end else begin
      rtmp <= 0;
      ltmp <= 0;
    end

  end

  // Compute the output and save it into out_tmp
  always_ff @(posedge clk) begin
    if (reset) begin
      out_tmp <= 0;
    end else if (go) begin
      if (SIGNED) begin
        // In the first cycle, this performs an invalid computation because
        // ltmp and rtmp only get their actual values in cycle 1
        out_tmp <= $signed(
          { {WIDTH{ltmp[WIDTH-1]}}, ltmp} *
          { {WIDTH{rtmp[WIDTH-1]}}, rtmp}
        );
      end else begin
        out_tmp <= ltmp * rtmp;
      end
    end else begin
      out_tmp <= out_tmp;
    end
  end
endmodule

/* verilator lint_off WIDTH */
module std_fp_div_pipe #(
  parameter WIDTH = 32,
  parameter INT_WIDTH = 16,
  parameter FRAC_WIDTH = 16
) (
    input  logic             go,
    input  logic             clk,
    input  logic             reset,
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out_remainder,
    output logic [WIDTH-1:0] out_quotient,
    output logic             done
);
    localparam ITERATIONS = WIDTH + FRAC_WIDTH;

    logic [WIDTH-1:0] quotient, quotient_next;
    logic [WIDTH:0] acc, acc_next;
    logic [$clog2(ITERATIONS)-1:0] idx;
    logic start, running, finished, dividend_is_zero;

    assign start = go && !running;
    assign dividend_is_zero = start && left == 0;
    assign finished = idx == ITERATIONS - 1 && running;

    always_ff @(posedge clk) begin
      if (reset || finished || dividend_is_zero)
        running <= 0;
      else if (start)
        running <= 1;
      else
        running <= running;
    end

    always @* begin
      if (acc >= {1'b0, right}) begin
        acc_next = acc - right;
        {acc_next, quotient_next} = {acc_next[WIDTH-1:0], quotient, 1'b1};
      end else begin
        {acc_next, quotient_next} = {acc, quotient} << 1;
      end
    end

    // `done` signaling
    always_ff @(posedge clk) begin
      if (dividend_is_zero || finished)
        done <= 1;
      else
        done <= 0;
    end

    always_ff @(posedge clk) begin
      if (running)
        idx <= idx + 1;
      else
        idx <= 0;
    end

    always_ff @(posedge clk) begin
      if (reset) begin
        out_quotient <= 0;
        out_remainder <= 0;
      end else if (start) begin
        out_quotient <= 0;
        out_remainder <= left;
      end else if (go == 0) begin
        out_quotient <= out_quotient;
        out_remainder <= out_remainder;
      end else if (dividend_is_zero) begin
        out_quotient <= 0;
        out_remainder <= 0;
      end else if (finished) begin
        out_quotient <= quotient_next;
        out_remainder <= out_remainder;
      end else begin
        out_quotient <= out_quotient;
        if (right <= out_remainder)
          out_remainder <= out_remainder - right;
        else
          out_remainder <= out_remainder;
      end
    end

    always_ff @(posedge clk) begin
      if (reset) begin
        acc <= 0;
        quotient <= 0;
      end else if (start) begin
        {acc, quotient} <= {{WIDTH{1'b0}}, left, 1'b0};
      end else begin
        acc <= acc_next;
        quotient <= quotient_next;
      end
    end
endmodule

module std_fp_gt #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic             out
);
  assign out = left > right;
endmodule

/// =================== Signed, Fixed Point =========================
module std_fp_sadd #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = $signed(left + right);
endmodule

module std_fp_ssub #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);

  assign out = $signed(left - right);
endmodule

module std_fp_smult_pipe #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  [WIDTH-1:0]              left,
    input  [WIDTH-1:0]              right,
    input  logic                    reset,
    input  logic                    go,
    input  logic                    clk,
    output logic [WIDTH-1:0]        out,
    output logic                    done
);
  std_fp_mult_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(INT_WIDTH),
    .FRAC_WIDTH(FRAC_WIDTH),
    .SIGNED(1)
  ) comp (
    .clk(clk),
    .done(done),
    .reset(reset),
    .go(go),
    .left(left),
    .right(right),
    .out(out)
  );
endmodule

module std_fp_sdiv_pipe #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input                     clk,
    input                     go,
    input                     reset,
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out_quotient,
    output signed [WIDTH-1:0] out_remainder,
    output logic              done
);

  logic signed [WIDTH-1:0] left_abs, right_abs, comp_out_q, comp_out_r, right_save, out_rem_intermediate;

  // Registers to figure out how to transform outputs.
  logic different_signs, left_sign, right_sign;

  // Latch the value of control registers so that their available after
  // go signal becomes low.
  always_ff @(posedge clk) begin
    if (go) begin
      right_save <= right_abs;
      left_sign <= left[WIDTH-1];
      right_sign <= right[WIDTH-1];
    end else begin
      left_sign <= left_sign;
      right_save <= right_save;
      right_sign <= right_sign;
    end
  end

  assign right_abs = right[WIDTH-1] ? -right : right;
  assign left_abs = left[WIDTH-1] ? -left : left;

  assign different_signs = left_sign ^ right_sign;
  assign out_quotient = different_signs ? -comp_out_q : comp_out_q;

  // Remainder is computed as:
  //  t0 = |left| % |right|
  //  t1 = if left * right < 0 and t0 != 0 then |right| - t0 else t0
  //  rem = if right < 0 then -t1 else t1
  assign out_rem_intermediate = different_signs & |comp_out_r ? $signed(right_save - comp_out_r) : comp_out_r;
  assign out_remainder = right_sign ? -out_rem_intermediate : out_rem_intermediate;

  std_fp_div_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(INT_WIDTH),
    .FRAC_WIDTH(FRAC_WIDTH)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left_abs),
    .right(right_abs),
    .out_quotient(comp_out_q),
    .out_remainder(comp_out_r)
  );
endmodule

module std_fp_sgt #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic signed [WIDTH-1:0] left,
    input  logic signed [WIDTH-1:0] right,
    output logic signed             out
);
  assign out = $signed(left > right);
endmodule

module std_fp_slt #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
   input logic signed [WIDTH-1:0] left,
   input logic signed [WIDTH-1:0] right,
   output logic signed            out
);
  assign out = $signed(left < right);
endmodule

/// =================== Unsigned, Bitnum =========================
module std_mult_pipe #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    input  logic             reset,
    input  logic             go,
    input  logic             clk,
    output logic [WIDTH-1:0] out,
    output logic             done
);
  std_fp_mult_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(WIDTH),
    .FRAC_WIDTH(0),
    .SIGNED(0)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left),
    .right(right),
    .out(out)
  );
endmodule

module std_div_pipe #(
    parameter WIDTH = 32
) (
    input                    reset,
    input                    clk,
    input                    go,
    input        [WIDTH-1:0] left,
    input        [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out_remainder,
    output logic [WIDTH-1:0] out_quotient,
    output logic             done
);

  logic [WIDTH-1:0] dividend;
  logic [(WIDTH-1)*2:0] divisor;
  logic [WIDTH-1:0] quotient;
  logic [WIDTH-1:0] quotient_msk;
  logic start, running, finished, dividend_is_zero;

  assign start = go && !running;
  assign finished = quotient_msk == 0 && running;
  assign dividend_is_zero = start && left == 0;

  always_ff @(posedge clk) begin
    // Early return if the divisor is zero.
    if (finished || dividend_is_zero)
      done <= 1;
    else
      done <= 0;
  end

  always_ff @(posedge clk) begin
    if (reset || finished || dividend_is_zero)
      running <= 0;
    else if (start)
      running <= 1;
    else
      running <= running;
  end

  // Outputs
  always_ff @(posedge clk) begin
    if (dividend_is_zero || start) begin
      out_quotient <= 0;
      out_remainder <= 0;
    end else if (finished) begin
      out_quotient <= quotient;
      out_remainder <= dividend;
    end else begin
      // Otherwise, explicitly latch the values.
      out_quotient <= out_quotient;
      out_remainder <= out_remainder;
    end
  end

  // Calculate the quotient mask.
  always_ff @(posedge clk) begin
    if (start)
      quotient_msk <= 1 << WIDTH - 1;
    else if (running)
      quotient_msk <= quotient_msk >> 1;
    else
      quotient_msk <= quotient_msk;
  end

  // Calculate the quotient.
  always_ff @(posedge clk) begin
    if (start)
      quotient <= 0;
    else if (divisor <= dividend)
      quotient <= quotient | quotient_msk;
    else
      quotient <= quotient;
  end

  // Calculate the dividend.
  always_ff @(posedge clk) begin
    if (start)
      dividend <= left;
    else if (divisor <= dividend)
      dividend <= dividend - divisor;
    else
      dividend <= dividend;
  end

  always_ff @(posedge clk) begin
    if (start) begin
      divisor <= right << WIDTH - 1;
    end else if (finished) begin
      divisor <= 0;
    end else begin
      divisor <= divisor >> 1;
    end
  end

  // Simulation self test against unsynthesizable implementation.
  `ifdef VERILATOR
    logic [WIDTH-1:0] l, r;
    always_ff @(posedge clk) begin
      if (go) begin
        l <= left;
        r <= right;
      end else begin
        l <= l;
        r <= r;
      end
    end

    always @(posedge clk) begin
      if (done && $unsigned(out_remainder) != $unsigned(l % r))
        $error(
          "\nstd_div_pipe (Remainder): Computed and golden outputs do not match!\n",
          "left: %0d", $unsigned(l),
          "  right: %0d\n", $unsigned(r),
          "expected: %0d", $unsigned(l % r),
          "  computed: %0d", $unsigned(out_remainder)
        );

      if (done && $unsigned(out_quotient) != $unsigned(l / r))
        $error(
          "\nstd_div_pipe (Quotient): Computed and golden outputs do not match!\n",
          "left: %0d", $unsigned(l),
          "  right: %0d\n", $unsigned(r),
          "expected: %0d", $unsigned(l / r),
          "  computed: %0d", $unsigned(out_quotient)
        );
    end
  `endif
endmodule

/// =================== Signed, Bitnum =========================
module std_sadd #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = $signed(left + right);
endmodule

module std_ssub #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = $signed(left - right);
endmodule

module std_smult_pipe #(
    parameter WIDTH = 32
) (
    input  logic                    reset,
    input  logic                    go,
    input  logic                    clk,
    input  signed       [WIDTH-1:0] left,
    input  signed       [WIDTH-1:0] right,
    output logic signed [WIDTH-1:0] out,
    output logic                    done
);
  std_fp_mult_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(WIDTH),
    .FRAC_WIDTH(0),
    .SIGNED(1)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left),
    .right(right),
    .out(out)
  );
endmodule

/* verilator lint_off WIDTH */
module std_sdiv_pipe #(
    parameter WIDTH = 32
) (
    input                           reset,
    input                           clk,
    input                           go,
    input  logic signed [WIDTH-1:0] left,
    input  logic signed [WIDTH-1:0] right,
    output logic signed [WIDTH-1:0] out_quotient,
    output logic signed [WIDTH-1:0] out_remainder,
    output logic                    done
);

  logic signed [WIDTH-1:0] left_abs, right_abs, comp_out_q, comp_out_r, right_save, out_rem_intermediate;

  // Registers to figure out how to transform outputs.
  logic different_signs, left_sign, right_sign;

  // Latch the value of control registers so that their available after
  // go signal becomes low.
  always_ff @(posedge clk) begin
    if (go) begin
      right_save <= right_abs;
      left_sign <= left[WIDTH-1];
      right_sign <= right[WIDTH-1];
    end else begin
      left_sign <= left_sign;
      right_save <= right_save;
      right_sign <= right_sign;
    end
  end

  assign right_abs = right[WIDTH-1] ? -right : right;
  assign left_abs = left[WIDTH-1] ? -left : left;

  assign different_signs = left_sign ^ right_sign;
  assign out_quotient = different_signs ? -comp_out_q : comp_out_q;

  // Remainder is computed as:
  //  t0 = |left| % |right|
  //  t1 = if left * right < 0 and t0 != 0 then |right| - t0 else t0
  //  rem = if right < 0 then -t1 else t1
  assign out_rem_intermediate = different_signs & |comp_out_r ? $signed(right_save - comp_out_r) : comp_out_r;
  assign out_remainder = right_sign ? -out_rem_intermediate : out_rem_intermediate;

  std_div_pipe #(
    .WIDTH(WIDTH)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left_abs),
    .right(right_abs),
    .out_quotient(comp_out_q),
    .out_remainder(comp_out_r)
  );

  // Simulation self test against unsynthesizable implementation.
  `ifdef VERILATOR
    logic signed [WIDTH-1:0] l, r;
    always_ff @(posedge clk) begin
      if (go) begin
        l <= left;
        r <= right;
      end else begin
        l <= l;
        r <= r;
      end
    end

    always @(posedge clk) begin
      if (done && out_quotient != $signed(l / r))
        $error(
          "\nstd_sdiv_pipe (Quotient): Computed and golden outputs do not match!\n",
          "left: %0d", l,
          "  right: %0d\n", r,
          "expected: %0d", $signed(l / r),
          "  computed: %0d", $signed(out_quotient),
        );
      if (done && out_remainder != $signed(((l % r) + r) % r))
        $error(
          "\nstd_sdiv_pipe (Remainder): Computed and golden outputs do not match!\n",
          "left: %0d", l,
          "  right: %0d\n", r,
          "expected: %0d", $signed(((l % r) + r) % r),
          "  computed: %0d", $signed(out_remainder),
        );
    end
  `endif
endmodule

module std_sgt #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left > right);
endmodule

module std_slt #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left < right);
endmodule

module std_seq #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left == right);
endmodule

module std_sneq #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left != right);
endmodule

module std_sge #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left >= right);
endmodule

module std_sle #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left <= right);
endmodule

module std_slsh #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = left <<< right;
endmodule

module std_srsh #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = left >>> right;
endmodule

// Signed extension
module std_signext #(
  parameter IN_WIDTH  = 32,
  parameter OUT_WIDTH = 32
) (
  input wire logic [IN_WIDTH-1:0]  in,
  output logic     [OUT_WIDTH-1:0] out
);
  localparam EXTEND = OUT_WIDTH - IN_WIDTH;
  assign out = { {EXTEND {in[IN_WIDTH-1]}}, in};

  `ifdef VERILATOR
    always_comb begin
      if (IN_WIDTH > OUT_WIDTH)
        $error(
          "std_signext: Output width less than input width\n",
          "IN_WIDTH: %0d", IN_WIDTH,
          "OUT_WIDTH: %0d", OUT_WIDTH
        );
    end
  `endif
endmodule

module std_const_mult #(
    parameter WIDTH = 32,
    parameter VALUE = 1
) (
    input  signed [WIDTH-1:0] in,
    output signed [WIDTH-1:0] out
);
  assign out = in * VALUE;
endmodule

module comb_mem_d1 #(
    parameter WIDTH = 32,
    parameter SIZE = 16,
    parameter IDX_SIZE = 4
) (
   input wire                logic [IDX_SIZE-1:0] addr0,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   input wire                logic reset,
   (* keep = 1*)output logic [ WIDTH-1:0] read_data,
   output logic              done
);

  logic [WIDTH-1:0] mem[SIZE-1:0];

  /* verilator lint_off WIDTH */
  assign read_data = mem[addr0];

  always_ff @(posedge clk) begin
    if (reset)
      done <= '0;
    else if (write_en)
      done <= '1;
    else
      done <= '0;
  end

  always_ff @(posedge clk) begin
    if (!reset && write_en)
      mem[addr0] <= write_data;
  end

  // Check for out of bounds access
  `ifdef VERILATOR
    always_comb begin
      if (addr0 >= SIZE)
        $error(
          "comb_mem_d1: Out of bounds access\n",
          "addr0: %0d\n", addr0,
          "SIZE: %0d", SIZE
        );
    end
  `endif
endmodule

module comb_mem_d2 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4
) (
   input wire                logic [D0_IDX_SIZE-1:0] addr0,
   input wire                logic [D1_IDX_SIZE-1:0] addr1,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   input wire                logic reset,
   output logic [ WIDTH-1:0] read_data,
   output logic              done
);

  /* verilator lint_off WIDTH */
  logic [WIDTH-1:0] mem[D0_SIZE-1:0][D1_SIZE-1:0];

  assign read_data = mem[addr0][addr1];

  always_ff @(posedge clk) begin
    if (reset)
      done <= '0;
    else if (write_en)
      done <= '1;
    else
      done <= '0;
  end

  always_ff @(posedge clk) begin
    if (!reset && write_en)
      mem[addr0][addr1] <= write_data;
  end

  // Check for out of bounds access
  `ifdef VERILATOR
    always_comb begin
      if (addr0 >= D0_SIZE)
        $error(
          "comb_mem_d2: Out of bounds access\n",
          "addr0: %0d\n", addr0,
          "D0_SIZE: %0d", D0_SIZE
        );
      if (addr1 >= D1_SIZE)
        $error(
          "comb_mem_d2: Out of bounds access\n",
          "addr1: %0d\n", addr1,
          "D1_SIZE: %0d", D1_SIZE
        );
    end
  `endif
endmodule

module comb_mem_d3 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D2_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4,
    parameter D2_IDX_SIZE = 4
) (
   input wire                logic [D0_IDX_SIZE-1:0] addr0,
   input wire                logic [D1_IDX_SIZE-1:0] addr1,
   input wire                logic [D2_IDX_SIZE-1:0] addr2,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   input wire                logic reset,
   output logic [ WIDTH-1:0] read_data,
   output logic              done
);

  /* verilator lint_off WIDTH */
  logic [WIDTH-1:0] mem[D0_SIZE-1:0][D1_SIZE-1:0][D2_SIZE-1:0];

  assign read_data = mem[addr0][addr1][addr2];

  always_ff @(posedge clk) begin
    if (reset)
      done <= '0;
    else if (write_en)
      done <= '1;
    else
      done <= '0;
  end

  always_ff @(posedge clk) begin
    if (!reset && write_en)
      mem[addr0][addr1][addr2] <= write_data;
  end

  // Check for out of bounds access
  `ifdef VERILATOR
    always_comb begin
      if (addr0 >= D0_SIZE)
        $error(
          "comb_mem_d3: Out of bounds access\n",
          "addr0: %0d\n", addr0,
          "D0_SIZE: %0d", D0_SIZE
        );
      if (addr1 >= D1_SIZE)
        $error(
          "comb_mem_d3: Out of bounds access\n",
          "addr1: %0d\n", addr1,
          "D1_SIZE: %0d", D1_SIZE
        );
      if (addr2 >= D2_SIZE)
        $error(
          "comb_mem_d3: Out of bounds access\n",
          "addr2: %0d\n", addr2,
          "D2_SIZE: %0d", D2_SIZE
        );
    end
  `endif
endmodule

module comb_mem_d4 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D2_SIZE = 16,
    parameter D3_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4,
    parameter D2_IDX_SIZE = 4,
    parameter D3_IDX_SIZE = 4
) (
   input wire                logic [D0_IDX_SIZE-1:0] addr0,
   input wire                logic [D1_IDX_SIZE-1:0] addr1,
   input wire                logic [D2_IDX_SIZE-1:0] addr2,
   input wire                logic [D3_IDX_SIZE-1:0] addr3,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   input wire                logic reset,
   output logic [ WIDTH-1:0] read_data,
   output logic              done
);

  /* verilator lint_off WIDTH */
  logic [WIDTH-1:0] mem[D0_SIZE-1:0][D1_SIZE-1:0][D2_SIZE-1:0][D3_SIZE-1:0];

  assign read_data = mem[addr0][addr1][addr2][addr3];

  always_ff @(posedge clk) begin
    if (reset)
      done <= '0;
    else if (write_en)
      done <= '1;
    else
      done <= '0;
  end

  always_ff @(posedge clk) begin
    if (!reset && write_en)
      mem[addr0][addr1][addr2][addr3] <= write_data;
  end

  // Check for out of bounds access
  `ifdef VERILATOR
    always_comb begin
      if (addr0 >= D0_SIZE)
        $error(
          "comb_mem_d4: Out of bounds access\n",
          "addr0: %0d\n", addr0,
          "D0_SIZE: %0d", D0_SIZE
        );
      if (addr1 >= D1_SIZE)
        $error(
          "comb_mem_d4: Out of bounds access\n",
          "addr1: %0d\n", addr1,
          "D1_SIZE: %0d", D1_SIZE
        );
      if (addr2 >= D2_SIZE)
        $error(
          "comb_mem_d4: Out of bounds access\n",
          "addr2: %0d\n", addr2,
          "D2_SIZE: %0d", D2_SIZE
        );
      if (addr3 >= D3_SIZE)
        $error(
          "comb_mem_d4: Out of bounds access\n",
          "addr3: %0d\n", addr3,
          "D3_SIZE: %0d", D3_SIZE
        );
    end
  `endif
endmodule

/**
 * Core primitives for Calyx.
 * Implements core primitives used by the compiler.
 *
 * Conventions:
 * - All parameter names must be SNAKE_CASE and all caps.
 * - Port names must be snake_case, no caps.
 */

module std_slice #(
    parameter IN_WIDTH  = 32,
    parameter OUT_WIDTH = 32
) (
   input wire                   logic [ IN_WIDTH-1:0] in,
   output logic [OUT_WIDTH-1:0] out
);
  assign out = in[OUT_WIDTH-1:0];

  `ifdef VERILATOR
    always_comb begin
      if (IN_WIDTH < OUT_WIDTH)
        $error(
          "std_slice: Input width less than output width\n",
          "IN_WIDTH: %0d", IN_WIDTH,
          "OUT_WIDTH: %0d", OUT_WIDTH
        );
    end
  `endif
endmodule

module std_pad #(
    parameter IN_WIDTH  = 32,
    parameter OUT_WIDTH = 32
) (
   input wire logic [IN_WIDTH-1:0]  in,
   output logic     [OUT_WIDTH-1:0] out
);
  localparam EXTEND = OUT_WIDTH - IN_WIDTH;
  assign out = { {EXTEND {1'b0}}, in};

  `ifdef VERILATOR
    always_comb begin
      if (IN_WIDTH > OUT_WIDTH)
        $error(
          "std_pad: Output width less than input width\n",
          "IN_WIDTH: %0d", IN_WIDTH,
          "OUT_WIDTH: %0d", OUT_WIDTH
        );
    end
  `endif
endmodule

module std_cat #(
  parameter LEFT_WIDTH  = 32,
  parameter RIGHT_WIDTH = 32,
  parameter OUT_WIDTH = 64
) (
  input wire logic [LEFT_WIDTH-1:0] left,
  input wire logic [RIGHT_WIDTH-1:0] right,
  output logic [OUT_WIDTH-1:0] out
);
  assign out = {left, right};

  `ifdef VERILATOR
    always_comb begin
      if (LEFT_WIDTH + RIGHT_WIDTH != OUT_WIDTH)
        $error(
          "std_cat: Output width must equal sum of input widths\n",
          "LEFT_WIDTH: %0d", LEFT_WIDTH,
          "RIGHT_WIDTH: %0d", RIGHT_WIDTH,
          "OUT_WIDTH: %0d", OUT_WIDTH
        );
    end
  `endif
endmodule

module std_not #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] in,
   output logic [WIDTH-1:0] out
);
  assign out = ~in;
endmodule

module std_and #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  assign out = left & right;
endmodule

module std_or #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  assign out = left | right;
endmodule

module std_xor #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  assign out = left ^ right;
endmodule

module std_sub #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  assign out = left - right;
endmodule

module std_gt #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  assign out = left > right;
endmodule

module std_lt #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  assign out = left < right;
endmodule

module std_eq #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  assign out = left == right;
endmodule

module std_neq #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  assign out = left != right;
endmodule

module std_ge #(
    parameter WIDTH = 32
) (
    input wire   logic [WIDTH-1:0] left,
    input wire   logic [WIDTH-1:0] right,
    output logic out
);
  assign out = left >= right;
endmodule

module std_le #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  assign out = left <= right;
endmodule

module std_rsh #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  assign out = left >> right;
endmodule

/// this primitive is intended to be used
/// for lowering purposes (not in source programs)
module std_mux #(
    parameter WIDTH = 32
) (
   input wire               logic cond,
   input wire               logic [WIDTH-1:0] tru,
   input wire               logic [WIDTH-1:0] fal,
   output logic [WIDTH-1:0] out
);
  assign out = cond ? tru : fal;
endmodule

module std_bit_slice #(
    parameter IN_WIDTH = 32,
    parameter START_IDX = 0,
    parameter END_IDX = 31,
    parameter OUT_WIDTH = 32
)(
   input wire logic [IN_WIDTH-1:0] in,
   output logic [OUT_WIDTH-1:0] out
);
  assign out = in[END_IDX:START_IDX];

  `ifdef VERILATOR
    always_comb begin
      if (START_IDX < 0 || END_IDX > IN_WIDTH-1)
        $error(
          "std_bit_slice: Slice range out of bounds\n",
          "IN_WIDTH: %0d", IN_WIDTH,
          "START_IDX: %0d", START_IDX,
          "END_IDX: %0d", END_IDX,
        );
    end
  `endif

endmodule

module std_skid_buffer #(
    parameter WIDTH = 32
)(
    input wire logic [WIDTH-1:0] in,
    input wire logic i_valid,
    input wire logic i_ready,
    input wire logic clk,
    input wire logic reset,
    output logic [WIDTH-1:0] out,
    output logic o_valid,
    output logic o_ready
);
  logic [WIDTH-1:0] val;
  logic bypass_rg;
  always @(posedge clk) begin
    // Reset  
    if (reset) begin      
      // Internal Registers
      val <= '0;     
      bypass_rg <= 1'b1;
    end   
    // Out of reset
    else begin      
      // Bypass state      
      if (bypass_rg) begin         
        if (!i_ready && i_valid) begin
          val <= in;          // Data skid happened, store to buffer
          bypass_rg <= 1'b0;  // To skid mode  
        end 
      end 
      // Skid state
      else begin         
        if (i_ready) begin
          bypass_rg <= 1'b1;  // Back to bypass mode           
        end
      end
    end
  end

  assign o_ready = bypass_rg;
  assign out = bypass_rg ? in : val;
  assign o_valid = bypass_rg ? i_valid : 1'b1;
endmodule

module std_bypass_reg #(
    parameter WIDTH = 32
)(
    input wire logic [WIDTH-1:0] in,
    input wire logic write_en,
    input wire logic clk,
    input wire logic reset,
    output logic [WIDTH-1:0] out,
    output logic done
);
  logic [WIDTH-1:0] val;
  assign out = write_en ? in : val;

  always_ff @(posedge clk) begin
    if (reset) begin
      val <= 0;
      done <= 0;
    end else if (write_en) begin
      val <= in;
      done <= 1'd1;
    end else done <= 1'd0;
  end
endmodule

module undef #(
    parameter WIDTH = 32
) (
   output logic [WIDTH-1:0] out
);
assign out = 'x;
endmodule

module std_const #(
    parameter WIDTH = 32,
    parameter VALUE = 32
) (
   output logic [WIDTH-1:0] out
);
assign out = VALUE;
endmodule

module std_wire #(
    parameter WIDTH = 32
) (
   input wire logic [WIDTH-1:0] in,
   output logic [WIDTH-1:0] out
);
assign out = in;
endmodule

module std_add #(
    parameter WIDTH = 32
) (
   input wire logic [WIDTH-1:0] left,
   input wire logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
assign out = left + right;
endmodule

module std_lsh #(
    parameter WIDTH = 32
) (
   input wire logic [WIDTH-1:0] left,
   input wire logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
assign out = left << right;
endmodule

module std_reg #(
    parameter WIDTH = 32
) (
   input wire logic [WIDTH-1:0] in,
   input wire logic write_en,
   input wire logic clk,
   input wire logic reset,
   output logic [WIDTH-1:0] out,
   output logic done
);
initial out = 0;
  always_ff @(posedge clk) begin
    if (reset) begin
       out <= 0;
       done <= 0;
    end else if (write_en) begin
      out <= in;
      done <= 1'd1;
    end else done <= 1'd0;
  end
endmodule

module init_one_reg #(
    parameter WIDTH = 32
) (
   input wire logic [WIDTH-1:0] in,
   input wire logic write_en,
   input wire logic clk,
   input wire logic reset,
   output logic [WIDTH-1:0] out,
   output logic done
);
always_ff @(posedge clk) begin
    if (reset) begin
       out <= 1;
       done <= 0;
    end else if (write_en) begin
      out <= in;
      done <= 1'd1;
    end else done <= 1'd0;
  end
endmodule


module fsm_pipelined_mac_def (
  input logic clk,
  input logic reset,
  output logic [0:0] fsm_data_valid_reg_write_en_in,
  output logic [0:0] fsm_data_valid_reg_in_in,
  output logic [31:0] fsm_add_right_in,
  output logic [31:0] fsm_add_left_in,
  output logic [31:0] fsm_mult_pipe_right_in,
  output logic [31:0] fsm_pipe2_in_in,
  output logic [0:0] fsm_cond_in_in,
  output logic [0:0] fsm_cond_wire0_in_in,
  output logic [0:0] fsm_mult_pipe_go_in,
  output logic [31:0] fsm_mult_pipe_left_in,
  output logic [0:0] fsm_pipe2_write_en_in,
  output logic [0:0] fsm_cond_write_en_in,
  output logic [0:0] fsm_pipe1_write_en_in,
  output logic [31:0] fsm_pipe1_in_in,
  output logic [0:0] fsm_out_valid_in_in,
  output logic [0:0] fsm_out_valid_write_en_in,
  output logic [0:0] fsm_stage2_valid_write_en_in,
  output logic [0:0] fsm_stage2_valid_in_in,
  output logic [0:0] fsm_done_in,
  input logic [0:0] data_valid,
  input logic [0:0] data_valid_reg_out,
  input logic [0:0] cond_out,
  input logic [31:0] b,
  input logic cond_wire0_out,
  input logic [31:0] c,
  input logic stage2_valid_out,
  input logic [31:0] pipe1_out,
  input logic [31:0] add_out,
  input logic [31:0] a,
  input logic [31:0] mult_pipe_out,
  input logic fsm_start_out
);

  localparam logic[2:0] S0 = 3'd0;
  localparam logic[2:0] S1 = 3'd1;
  localparam logic[2:0] S2 = 3'd2;
  localparam logic[2:0] S3 = 3'd3;
  localparam logic[2:0] S4 = 3'd4;
  localparam logic[2:0] S5 = 3'd5;
  localparam logic[2:0] S6 = 3'd6;
  localparam logic[2:0] S7 = 3'd7;

  logic [2:0] current_state;
  logic [2:0] next_state;

  always @(posedge clk) begin
    if (reset) begin
      current_state <= S0;
    end
    else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    case ( current_state )
        S0: begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 'b0;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 'b0;
          if (fsm_start_out) begin
            next_state = S1;
          end
          else begin
            next_state = S0;
          end
        end
        S1: begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 1'd1;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 'b0;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 'b0;
          next_state = S2;
        end
        S2: begin
          fsm_cond_write_en_in = 1'd1;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 1'd1;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 1'd1;
          fsm_stage2_valid_write_en_in = 'b0;
          next_state = S3;
        end
        S3: begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 1'd1;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 'b0;
          next_state = S4;
        end
        S4: begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 1'd1;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 'b0;
          next_state = S5;
        end
        S5: begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 'b0;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 1'd1;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 'b0;
          next_state = S6;
        end
        S6: begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 'b0;
          fsm_out_valid_write_en_in = 1'd1;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 1'd1;
          next_state = S7;
        end
        S7: begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 1'd1;
          fsm_mult_pipe_go_in = 'b0;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 'b0;
          next_state = S0;
        end
      default begin
          fsm_cond_write_en_in = 'b0;
          fsm_data_valid_reg_write_en_in = 'b0;
          fsm_done_in = 'b0;
          fsm_mult_pipe_go_in = 'b0;
          fsm_out_valid_write_en_in = 'b0;
          fsm_pipe1_write_en_in = 'b0;
          fsm_pipe2_write_en_in = 'b0;
          fsm_stage2_valid_write_en_in = 'b0;
          next_state = S0;
      end
    endcase
  end
assign fsm_data_valid_reg_in_in = data_valid;
assign fsm_pipe2_in_in = add_out;
assign fsm_mult_pipe_left_in = a;
assign fsm_add_left_in = pipe1_out;
assign fsm_mult_pipe_right_in = b;
assign fsm_cond_in_in = data_valid_reg_out;
assign fsm_add_right_in = c;
assign fsm_cond_wire0_in_in = 
       current_state == S2 ? data_valid_reg_out :
       current_state == S3 ? cond_out :
       current_state == S4 ? cond_out :
       current_state == S5 ? cond_out :
       1'dx;
assign fsm_pipe1_in_in = mult_pipe_out;
assign fsm_out_valid_in_in = 
       ((current_state == S6) & (stage2_valid_out)) ? 1'd1 :
       ((current_state == S6) & (~(stage2_valid_out))) ? 1'd0 :
       1'dx;
assign fsm_stage2_valid_in_in = 
       ((current_state == S6) & (data_valid_reg_out)) ? 1'd1 :
       ((current_state == S6) & (~(data_valid_reg_out))) ? 1'd0 :
       1'dx;
endmodule

module pipelined_mac(
  input logic data_valid,
  (* data=1 *) input logic [31:0] a,
  (* data=1 *) input logic [31:0] b,
  (* data=1 *) input logic [31:0] c,
  (* data=1 *) output logic [31:0] out,
  output logic output_valid,
  (* go=1 *) input logic go,
  (* clk=1 *) input logic clk,
  (* reset=1 *) input logic reset,
  (* done=1 *) output logic done
);
// COMPONENT START: pipelined_mac
logic mult_pipe_clk;
logic mult_pipe_reset;
logic mult_pipe_go;
logic [31:0] mult_pipe_left;
logic [31:0] mult_pipe_right;
logic [31:0] mult_pipe_out;
logic mult_pipe_done;
logic [31:0] add_left;
logic [31:0] add_right;
logic [31:0] add_out;
logic [31:0] pipe1_in;
logic pipe1_write_en;
logic pipe1_clk;
logic pipe1_reset;
logic [31:0] pipe1_out;
logic pipe1_done;
logic [31:0] pipe2_in;
logic pipe2_write_en;
logic pipe2_clk;
logic pipe2_reset;
logic [31:0] pipe2_out;
logic pipe2_done;
logic stage2_valid_in;
logic stage2_valid_write_en;
logic stage2_valid_clk;
logic stage2_valid_reset;
logic stage2_valid_out;
logic stage2_valid_done;
logic out_valid_in;
logic out_valid_write_en;
logic out_valid_clk;
logic out_valid_reset;
logic out_valid_out;
logic out_valid_done;
logic data_valid_reg_in;
logic data_valid_reg_write_en;
logic data_valid_reg_clk;
logic data_valid_reg_reset;
logic data_valid_reg_out;
logic data_valid_reg_done;
logic cond_in;
logic cond_write_en;
logic cond_clk;
logic cond_reset;
logic cond_out;
logic cond_done;
logic cond_wire0_in;
logic cond_wire0_out;
logic fsm_data_valid_reg_write_en_in;
logic fsm_data_valid_reg_write_en_out;
logic fsm_data_valid_reg_in_in;
logic fsm_data_valid_reg_in_out;
logic fsm_cond_in_in;
logic fsm_cond_in_out;
logic fsm_cond_wire0_in_in;
logic fsm_cond_wire0_in_out;
logic fsm_cond_write_en_in;
logic fsm_cond_write_en_out;
logic fsm_mult_pipe_go_in;
logic fsm_mult_pipe_go_out;
logic [31:0] fsm_mult_pipe_left_in;
logic [31:0] fsm_mult_pipe_left_out;
logic [31:0] fsm_mult_pipe_right_in;
logic [31:0] fsm_mult_pipe_right_out;
logic fsm_pipe2_write_en_in;
logic fsm_pipe2_write_en_out;
logic [31:0] fsm_pipe2_in_in;
logic [31:0] fsm_pipe2_in_out;
logic [31:0] fsm_add_left_in;
logic [31:0] fsm_add_left_out;
logic [31:0] fsm_add_right_in;
logic [31:0] fsm_add_right_out;
logic fsm_pipe1_write_en_in;
logic fsm_pipe1_write_en_out;
logic [31:0] fsm_pipe1_in_in;
logic [31:0] fsm_pipe1_in_out;
logic fsm_stage2_valid_write_en_in;
logic fsm_stage2_valid_write_en_out;
logic fsm_stage2_valid_in_in;
logic fsm_stage2_valid_in_out;
logic fsm_out_valid_write_en_in;
logic fsm_out_valid_write_en_out;
logic fsm_out_valid_in_in;
logic fsm_out_valid_in_out;
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
(* data=1 *)
std_mult_pipe # (
    .WIDTH(32)
) mult_pipe (
    .clk(mult_pipe_clk),
    .done(mult_pipe_done),
    .go(mult_pipe_go),
    .left(mult_pipe_left),
    .out(mult_pipe_out),
    .reset(mult_pipe_reset),
    .right(mult_pipe_right)
);

(* data=1 *)
std_add # (
    .WIDTH(32)
) add (
    .left(add_left),
    .out(add_out),
    .right(add_right)
);

(* data=1 *)
std_reg # (
    .WIDTH(32)
) pipe1 (
    .clk(pipe1_clk),
    .done(pipe1_done),
    .in(pipe1_in),
    .out(pipe1_out),
    .reset(pipe1_reset),
    .write_en(pipe1_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(32)
) pipe2 (
    .clk(pipe2_clk),
    .done(pipe2_done),
    .in(pipe2_in),
    .out(pipe2_out),
    .reset(pipe2_reset),
    .write_en(pipe2_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(1)
) stage2_valid (
    .clk(stage2_valid_clk),
    .done(stage2_valid_done),
    .in(stage2_valid_in),
    .out(stage2_valid_out),
    .reset(stage2_valid_reset),
    .write_en(stage2_valid_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(1)
) out_valid (
    .clk(out_valid_clk),
    .done(out_valid_done),
    .in(out_valid_in),
    .out(out_valid_out),
    .reset(out_valid_reset),
    .write_en(out_valid_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(1)
) data_valid_reg (
    .clk(data_valid_reg_clk),
    .done(data_valid_reg_done),
    .in(data_valid_reg_in),
    .out(data_valid_reg_out),
    .reset(data_valid_reg_reset),
    .write_en(data_valid_reg_write_en)
);

(* generated=1 *)
std_reg # (
    .WIDTH(1)
) cond (
    .clk(cond_clk),
    .done(cond_done),
    .in(cond_in),
    .out(cond_out),
    .reset(cond_reset),
    .write_en(cond_write_en)
);

assign cond_wire0_out = cond_wire0_in;
assign fsm_data_valid_reg_write_en_out = fsm_data_valid_reg_write_en_in;
assign fsm_data_valid_reg_in_out = fsm_data_valid_reg_in_in;
assign fsm_cond_in_out = fsm_cond_in_in;
assign fsm_cond_wire0_in_out = fsm_cond_wire0_in_in;
assign fsm_cond_write_en_out = fsm_cond_write_en_in;
assign fsm_mult_pipe_go_out = fsm_mult_pipe_go_in;
assign fsm_mult_pipe_left_out = fsm_mult_pipe_left_in;
assign fsm_mult_pipe_right_out = fsm_mult_pipe_right_in;
assign fsm_pipe2_write_en_out = fsm_pipe2_write_en_in;
assign fsm_pipe2_in_out = fsm_pipe2_in_in;
assign fsm_add_left_out = fsm_add_left_in;
assign fsm_add_right_out = fsm_add_right_in;
assign fsm_pipe1_write_en_out = fsm_pipe1_write_en_in;
assign fsm_pipe1_in_out = fsm_pipe1_in_in;
assign fsm_stage2_valid_write_en_out = fsm_stage2_valid_write_en_in;
assign fsm_stage2_valid_in_out = fsm_stage2_valid_in_in;
assign fsm_out_valid_write_en_out = fsm_out_valid_write_en_in;
assign fsm_out_valid_in_out = fsm_out_valid_in_in;
assign fsm_start_out = fsm_start_in;
assign fsm_done_out = fsm_done_in;
fsm_pipelined_mac_def fsm (
  .clk(clk),
  .reset(reset),
  .fsm_data_valid_reg_write_en_in(fsm_data_valid_reg_write_en_in),
  .fsm_data_valid_reg_in_in(fsm_data_valid_reg_in_in),
  .data_valid(data_valid),
  .fsm_cond_in_in(fsm_cond_in_in),
  .data_valid_reg_out(data_valid_reg_out),
  .fsm_cond_wire0_in_in(fsm_cond_wire0_in_in),
  .fsm_cond_write_en_in(fsm_cond_write_en_in),
  .fsm_mult_pipe_go_in(fsm_mult_pipe_go_in),
  .fsm_mult_pipe_left_in(fsm_mult_pipe_left_in),
  .a(a),
  .fsm_mult_pipe_right_in(fsm_mult_pipe_right_in),
  .b(b),
  .fsm_pipe2_write_en_in(fsm_pipe2_write_en_in),
  .fsm_pipe2_in_in(fsm_pipe2_in_in),
  .add_out(add_out),
  .fsm_add_left_in(fsm_add_left_in),
  .pipe1_out(pipe1_out),
  .fsm_add_right_in(fsm_add_right_in),
  .c(c),
  .cond_out(cond_out),
  .fsm_pipe1_write_en_in(fsm_pipe1_write_en_in),
  .fsm_pipe1_in_in(fsm_pipe1_in_in),
  .mult_pipe_out(mult_pipe_out),
  .fsm_stage2_valid_write_en_in(fsm_stage2_valid_write_en_in),
  .fsm_stage2_valid_in_in(fsm_stage2_valid_in_in),
  .fsm_out_valid_write_en_in(fsm_out_valid_write_en_in),
  .fsm_out_valid_in_in(fsm_out_valid_in_in),
  .fsm_done_in(fsm_done_in),
  .fsm_start_out(fsm_start_out)
);

assign done = fsm_done_out;
assign out = pipe2_out;
assign output_valid = out_valid_out;
assign cond_wire0_in = fsm_cond_wire0_in_out;
assign cond_write_en = fsm_cond_write_en_out;
assign cond_clk = clk;
assign cond_reset = reset;
assign cond_in = fsm_cond_in_out;
assign pipe2_write_en =
 stage2_valid_out ? fsm_pipe2_write_en_out : 1'd0;
assign pipe2_clk = clk;
assign pipe2_reset = reset;
assign pipe2_in = fsm_pipe2_in_out;
assign out_valid_write_en =
 ~stage2_valid_out | stage2_valid_out ? fsm_out_valid_write_en_out : 1'd0;
assign out_valid_clk = clk;
assign out_valid_reset = reset;
assign out_valid_in = fsm_out_valid_in_out;
assign mult_pipe_clk = clk;
assign mult_pipe_left = fsm_mult_pipe_left_out;
assign mult_pipe_go =
 cond_wire0_out ? fsm_mult_pipe_go_out : 1'd0;
assign mult_pipe_reset = reset;
assign mult_pipe_right = fsm_mult_pipe_right_out;
assign data_valid_reg_write_en = fsm_data_valid_reg_write_en_out;
assign data_valid_reg_clk = clk;
assign data_valid_reg_reset = reset;
assign data_valid_reg_in = fsm_data_valid_reg_in_out;
assign add_left = fsm_add_left_out;
assign add_right = fsm_add_right_out;
assign stage2_valid_write_en =
 ~data_valid_reg_out | data_valid_reg_out ? fsm_stage2_valid_write_en_out : 1'd0;
assign stage2_valid_clk = clk;
assign stage2_valid_reset = reset;
assign stage2_valid_in = fsm_stage2_valid_in_out;
assign pipe1_write_en =
 cond_wire0_out ? fsm_pipe1_write_en_out : 1'd0;
assign pipe1_clk = clk;
assign pipe1_reset = reset;
assign pipe1_in = fsm_pipe1_in_out;
assign fsm_start_in = go;
// COMPONENT END: pipelined_mac
endmodule

module fsm_main_def (
  input logic clk,
  input logic reset,
  output logic [31:0] fsm_read_a_in_in,
  output logic [0:0] fsm_read_b_write_en_in,
  output logic [0:0] fsm_read_a_write_en_in,
  output logic [31:0] fsm_read_b_in_in,
  output logic [3:0] fsm_b_addr0_in,
  output logic [3:0] fsm_a_addr0_in,
  output logic [31:0] fsm_mac_a_in,
  output logic [31:0] fsm_mac_b_in,
  output logic [0:0] fsm_mac_go_in,
  output logic [0:0] fsm_mac_data_valid_in,
  output logic [3:0] fsm_add0_right_in,
  output logic [3:0] fsm_idx0_in_in,
  output logic [3:0] fsm_add0_left_in,
  output logic [0:0] fsm_idx0_write_en_in,
  output logic [3:0] fsm_lt0_right_in,
  output logic [0:0] fsm_cond_wire_in_in,
  output logic [3:0] fsm_lt0_left_in,
  output logic [31:0] fsm_mac_c_in,
  output logic [31:0] fsm_out_write_data_in,
  output logic [0:0] fsm_out_addr0_in,
  output logic [0:0] fsm_out_write_en_in,
  output logic [0:0] fsm_done_in,
  input logic [3:0] idx0_out,
  input logic [31:0] a_read_data,
  input logic [31:0] b_read_data,
  input logic [31:0] read_a_out,
  input logic mac_done,
  input logic [31:0] read_b_out,
  input logic [3:0] add0_out,
  input logic idx0_done,
  input logic [0:0] lt0_out,
  input logic [31:0] mac_out,
  input logic out_done,
  input logic fsm_start_out,
  input logic cond_wire_out
);

  localparam logic[3:0] S0 = 4'd0;
  localparam logic[3:0] S1 = 4'd1;
  localparam logic[3:0] S2 = 4'd2;
  localparam logic[3:0] S3 = 4'd3;
  localparam logic[3:0] S4 = 4'd4;
  localparam logic[3:0] S5 = 4'd5;
  localparam logic[3:0] S6 = 4'd6;
  localparam logic[3:0] S7 = 4'd7;
  localparam logic[3:0] S8 = 4'd8;
  localparam logic[3:0] S9 = 4'd9;
  localparam logic[3:0] S10 = 4'd10;
  localparam logic[3:0] S11 = 4'd11;

  logic [3:0] current_state;
  logic [3:0] next_state;

  always @(posedge clk) begin
    if (reset) begin
      current_state <= S0;
    end
    else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    case ( current_state )
        S0: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (fsm_start_out) begin
            next_state = S1;
          end
          else begin
            next_state = S0;
          end
        end
        S1: begin
          fsm_a_addr0_in = idx0_out;
          fsm_b_addr0_in = idx0_out;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 1'd1;
          fsm_read_b_write_en_in = 1'd1;
          next_state = S2;
        end
        S2: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 1'd1;
          fsm_mac_go_in = 1'd1;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (mac_done) begin
            next_state = S3;
          end
          else begin
            next_state = S2;
          end
        end
        S3: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 1'd1;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (idx0_done) begin
            next_state = S4;
          end
          else begin
            next_state = S3;
          end
        end
        S4: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (cond_wire_out) begin
            next_state = S5;
          end
          else if (~(cond_wire_out)) begin
            next_state = S9;
          end
          else begin
            next_state = S4;
          end
        end
        S5: begin
          fsm_a_addr0_in = idx0_out;
          fsm_b_addr0_in = idx0_out;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 1'd1;
          fsm_read_b_write_en_in = 1'd1;
          next_state = S6;
        end
        S6: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 1'd1;
          fsm_mac_go_in = 1'd1;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (mac_done) begin
            next_state = S7;
          end
          else begin
            next_state = S6;
          end
        end
        S7: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 1'd1;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (idx0_done) begin
            next_state = S8;
          end
          else begin
            next_state = S7;
          end
        end
        S8: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (cond_wire_out) begin
            next_state = S5;
          end
          else if (~(cond_wire_out)) begin
            next_state = S9;
          end
          else begin
            next_state = S8;
          end
        end
        S9: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 1'd1;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (mac_done) begin
            next_state = S10;
          end
          else begin
            next_state = S9;
          end
        end
        S10: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 1'd0;
          fsm_out_write_en_in = 1'd1;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          if (out_done) begin
            next_state = S11;
          end
          else begin
            next_state = S10;
          end
        end
        S11: begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 1'd1;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          next_state = S0;
        end
      default begin
          fsm_a_addr0_in = 'b0;
          fsm_b_addr0_in = 'b0;
          fsm_done_in = 'b0;
          fsm_idx0_write_en_in = 'b0;
          fsm_mac_data_valid_in = 'b0;
          fsm_mac_go_in = 'b0;
          fsm_out_addr0_in = 'b0;
          fsm_out_write_en_in = 'b0;
          fsm_read_a_write_en_in = 'b0;
          fsm_read_b_write_en_in = 'b0;
          next_state = S0;
      end
    endcase
  end
assign fsm_read_a_in_in = a_read_data;
assign fsm_read_b_in_in = b_read_data;
assign fsm_mac_a_in = read_a_out;
assign fsm_mac_b_in = read_b_out;
assign fsm_add0_right_in = idx0_out;
assign fsm_idx0_in_in = add0_out;
assign fsm_add0_left_in = 4'd1;
assign fsm_cond_wire_in_in = lt0_out;
assign fsm_lt0_left_in = idx0_out;
assign fsm_lt0_right_in = 4'd10;
assign fsm_mac_c_in = mac_out;
assign fsm_out_write_data_in = mac_out;
endmodule

module main(
  (* go=1 *) input logic go,
  (* clk=1 *) input logic clk,
  (* reset=1 *) input logic reset,
  (* done=1 *) output logic done
);
// COMPONENT START: main
logic [3:0] a_addr0;
logic [31:0] a_write_data;
logic a_write_en;
logic a_clk;
logic a_reset;
logic [31:0] a_read_data;
logic a_done;
logic [3:0] b_addr0;
logic [31:0] b_write_data;
logic b_write_en;
logic b_clk;
logic b_reset;
logic [31:0] b_read_data;
logic b_done;
logic out_addr0;
logic [31:0] out_write_data;
logic out_write_en;
logic out_clk;
logic out_reset;
logic [31:0] out_read_data;
logic out_done;
logic [31:0] read_a_in;
logic read_a_write_en;
logic read_a_clk;
logic read_a_reset;
logic [31:0] read_a_out;
logic read_a_done;
logic [31:0] read_b_in;
logic read_b_write_en;
logic read_b_clk;
logic read_b_reset;
logic [31:0] read_b_out;
logic read_b_done;
logic [3:0] idx0_in;
logic idx0_write_en;
logic idx0_clk;
logic idx0_reset;
logic [3:0] idx0_out;
logic idx0_done;
logic [3:0] add0_left;
logic [3:0] add0_right;
logic [3:0] add0_out;
logic [3:0] lt0_left;
logic [3:0] lt0_right;
logic lt0_out;
logic mac_data_valid;
logic [31:0] mac_a;
logic [31:0] mac_b;
logic [31:0] mac_c;
logic [31:0] mac_out;
logic mac_output_valid;
logic mac_go;
logic mac_clk;
logic mac_reset;
logic mac_done;
logic cond_wire_in;
logic cond_wire_out;
logic [3:0] fsm_a_addr0_in;
logic [3:0] fsm_a_addr0_out;
logic fsm_read_a_write_en_in;
logic fsm_read_a_write_en_out;
logic [31:0] fsm_read_a_in_in;
logic [31:0] fsm_read_a_in_out;
logic [3:0] fsm_b_addr0_in;
logic [3:0] fsm_b_addr0_out;
logic fsm_read_b_write_en_in;
logic fsm_read_b_write_en_out;
logic [31:0] fsm_read_b_in_in;
logic [31:0] fsm_read_b_in_out;
logic fsm_mac_go_in;
logic fsm_mac_go_out;
logic fsm_mac_data_valid_in;
logic fsm_mac_data_valid_out;
logic [31:0] fsm_mac_a_in;
logic [31:0] fsm_mac_a_out;
logic [31:0] fsm_mac_b_in;
logic [31:0] fsm_mac_b_out;
logic fsm_idx0_write_en_in;
logic fsm_idx0_write_en_out;
logic [3:0] fsm_idx0_in_in;
logic [3:0] fsm_idx0_in_out;
logic [3:0] fsm_add0_left_in;
logic [3:0] fsm_add0_left_out;
logic [3:0] fsm_add0_right_in;
logic [3:0] fsm_add0_right_out;
logic [3:0] fsm_lt0_left_in;
logic [3:0] fsm_lt0_left_out;
logic [3:0] fsm_lt0_right_in;
logic [3:0] fsm_lt0_right_out;
logic fsm_cond_wire_in_in;
logic fsm_cond_wire_in_out;
logic [31:0] fsm_mac_c_in;
logic [31:0] fsm_mac_c_out;
logic fsm_out_addr0_in;
logic fsm_out_addr0_out;
logic fsm_out_write_en_in;
logic fsm_out_write_en_out;
logic [31:0] fsm_out_write_data_in;
logic [31:0] fsm_out_write_data_out;
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
(* external=1, data=1, keep=1 *)
comb_mem_d1 # (
    .IDX_SIZE(4),
    .SIZE(10),
    .WIDTH(32)
) a (
    .addr0(a_addr0),
    .clk(a_clk),
    .done(a_done),
    .read_data(a_read_data),
    .reset(a_reset),
    .write_data(a_write_data),
    .write_en(a_write_en)
);

(* external=1, data=1, keep=1 *)
comb_mem_d1 # (
    .IDX_SIZE(4),
    .SIZE(10),
    .WIDTH(32)
) b (
    .addr0(b_addr0),
    .clk(b_clk),
    .done(b_done),
    .read_data(b_read_data),
    .reset(b_reset),
    .write_data(b_write_data),
    .write_en(b_write_en)
);

(* external=1, data=1, keep=1 *)
comb_mem_d1 # (
    .IDX_SIZE(1),
    .SIZE(1),
    .WIDTH(32)
) out (
    .addr0(out_addr0),
    .clk(out_clk),
    .done(out_done),
    .read_data(out_read_data),
    .reset(out_reset),
    .write_data(out_write_data),
    .write_en(out_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(32)
) read_a (
    .clk(read_a_clk),
    .done(read_a_done),
    .in(read_a_in),
    .out(read_a_out),
    .reset(read_a_reset),
    .write_en(read_a_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(32)
) read_b (
    .clk(read_b_clk),
    .done(read_b_done),
    .in(read_b_in),
    .out(read_b_out),
    .reset(read_b_reset),
    .write_en(read_b_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(4)
) idx0 (
    .clk(idx0_clk),
    .done(idx0_done),
    .in(idx0_in),
    .out(idx0_out),
    .reset(idx0_reset),
    .write_en(idx0_write_en)
);

(* data=1 *)
std_add # (
    .WIDTH(4)
) add0 (
    .left(add0_left),
    .out(add0_out),
    .right(add0_right)
);

(* control=1 *)
std_lt # (
    .WIDTH(4)
) lt0 (
    .left(lt0_left),
    .out(lt0_out),
    .right(lt0_right)
);

(* data=1 *)
pipelined_mac mac (
    .a(mac_a),
    .b(mac_b),
    .c(mac_c),
    .clk(mac_clk),
    .data_valid(mac_data_valid),
    .done(mac_done),
    .go(mac_go),
    .out(mac_out),
    .output_valid(mac_output_valid),
    .reset(mac_reset)
);

assign cond_wire_out = cond_wire_in;
assign fsm_a_addr0_out = fsm_a_addr0_in;
assign fsm_read_a_write_en_out = fsm_read_a_write_en_in;
assign fsm_read_a_in_out = fsm_read_a_in_in;
assign fsm_b_addr0_out = fsm_b_addr0_in;
assign fsm_read_b_write_en_out = fsm_read_b_write_en_in;
assign fsm_read_b_in_out = fsm_read_b_in_in;
assign fsm_mac_go_out = fsm_mac_go_in;
assign fsm_mac_data_valid_out = fsm_mac_data_valid_in;
assign fsm_mac_a_out = fsm_mac_a_in;
assign fsm_mac_b_out = fsm_mac_b_in;
assign fsm_idx0_write_en_out = fsm_idx0_write_en_in;
assign fsm_idx0_in_out = fsm_idx0_in_in;
assign fsm_add0_left_out = fsm_add0_left_in;
assign fsm_add0_right_out = fsm_add0_right_in;
assign fsm_lt0_left_out = fsm_lt0_left_in;
assign fsm_lt0_right_out = fsm_lt0_right_in;
assign fsm_cond_wire_in_out = fsm_cond_wire_in_in;
assign fsm_mac_c_out = fsm_mac_c_in;
assign fsm_out_addr0_out = fsm_out_addr0_in;
assign fsm_out_write_en_out = fsm_out_write_en_in;
assign fsm_out_write_data_out = fsm_out_write_data_in;
assign fsm_start_out = fsm_start_in;
assign fsm_done_out = fsm_done_in;
fsm_main_def fsm (
  .clk(clk),
  .reset(reset),
  .fsm_a_addr0_in(fsm_a_addr0_in),
  .idx0_out(idx0_out),
  .fsm_read_a_write_en_in(fsm_read_a_write_en_in),
  .fsm_read_a_in_in(fsm_read_a_in_in),
  .a_read_data(a_read_data),
  .fsm_b_addr0_in(fsm_b_addr0_in),
  .fsm_read_b_write_en_in(fsm_read_b_write_en_in),
  .fsm_read_b_in_in(fsm_read_b_in_in),
  .b_read_data(b_read_data),
  .fsm_mac_go_in(fsm_mac_go_in),
  .fsm_mac_data_valid_in(fsm_mac_data_valid_in),
  .fsm_mac_a_in(fsm_mac_a_in),
  .read_a_out(read_a_out),
  .fsm_mac_b_in(fsm_mac_b_in),
  .read_b_out(read_b_out),
  .fsm_idx0_write_en_in(fsm_idx0_write_en_in),
  .fsm_idx0_in_in(fsm_idx0_in_in),
  .add0_out(add0_out),
  .fsm_add0_left_in(fsm_add0_left_in),
  .fsm_add0_right_in(fsm_add0_right_in),
  .fsm_lt0_left_in(fsm_lt0_left_in),
  .fsm_lt0_right_in(fsm_lt0_right_in),
  .fsm_cond_wire_in_in(fsm_cond_wire_in_in),
  .lt0_out(lt0_out),
  .fsm_mac_c_in(fsm_mac_c_in),
  .mac_out(mac_out),
  .fsm_out_addr0_in(fsm_out_addr0_in),
  .fsm_out_write_en_in(fsm_out_write_en_in),
  .fsm_out_write_data_in(fsm_out_write_data_in),
  .fsm_done_in(fsm_done_in),
  .fsm_start_out(fsm_start_out),
  .mac_done(mac_done),
  .idx0_done(idx0_done),
  .cond_wire_out(cond_wire_out),
  .out_done(out_done)
);

assign done = fsm_done_out;
assign add0_left = fsm_add0_left_out;
assign add0_right = fsm_add0_right_out;
assign b_write_en = 1'd0;
assign b_clk = clk;
assign b_addr0 = fsm_b_addr0_out;
assign b_reset = reset;
assign read_b_write_en = fsm_read_b_write_en_out;
assign read_b_clk = clk;
assign read_b_reset = reset;
assign read_b_in = fsm_read_b_in_out;
assign idx0_write_en =
 ~idx0_done ? fsm_idx0_write_en_out : 1'd0;
assign idx0_clk = clk;
assign idx0_reset = reset;
assign idx0_in = fsm_idx0_in_out;
assign a_write_en = 1'd0;
assign a_clk = clk;
assign a_addr0 = fsm_a_addr0_out;
assign a_reset = reset;
assign out_write_en =
 ~out_done ? fsm_out_write_en_out : 1'd0;
assign out_clk = clk;
assign out_addr0 =
 ~out_done ? fsm_out_addr0_out : 1'd0;
assign out_reset = reset;
assign out_write_data = fsm_out_write_data_out;
assign read_a_write_en = fsm_read_a_write_en_out;
assign read_a_clk = clk;
assign read_a_reset = reset;
assign read_a_in = fsm_read_a_in_out;
assign cond_wire_in = fsm_cond_wire_in_out;
assign mac_b = fsm_mac_b_out;
assign mac_data_valid =
 ~mac_done ? fsm_mac_data_valid_out : 1'd0;
assign mac_clk = clk;
assign mac_a = fsm_mac_a_out;
assign mac_go =
 ~mac_done ? fsm_mac_go_out : 1'd0;
assign mac_reset = reset;
assign mac_c = fsm_mac_c_out;
assign fsm_start_in = go;
assign lt0_left = fsm_lt0_left_out;
assign lt0_right = fsm_lt0_right_out;
// COMPONENT END: main
endmodule
