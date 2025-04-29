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

/**
Implements a memory with sequential reads and writes.
- Both reads and writes take one cycle to perform.
- Attempting to read and write at the same time is an error.
- The out signal is registered to the last value requested by the read_en signal.
- The out signal is undefined once write_en is asserted.
*/
module seq_mem_d1 #(
    parameter WIDTH = 32,
    parameter SIZE = 16,
    parameter IDX_SIZE = 4
) (
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [IDX_SIZE-1:0] addr0,
   input wire logic content_en,
   output logic done,

   // Read signal
   output logic [ WIDTH-1:0] read_data,

   // Write signals
   input wire logic [ WIDTH-1:0] write_data,
   input wire logic write_en
);
  // Internal memory
  logic [WIDTH-1:0] mem[SIZE-1:0];

  // Register for the read output
  logic [WIDTH-1:0] read_out;
  assign read_data = read_out;

  // Read value from the memory
  always_ff @(posedge clk) begin
    if (reset) begin
      read_out <= '0;
    end else if (content_en && !write_en) begin
      /* verilator lint_off WIDTH */
      read_out <= mem[addr0];
    end else if (content_en && write_en) begin
      // Explicitly clobber the read output when a write is performed
      read_out <= 'x;
    end else begin
      read_out <= read_out;
    end
  end

  // Propagate the done signal
  always_ff @(posedge clk) begin
    if (reset) begin
      done <= '0;
    end else if (content_en) begin
      done <= '1;
    end else begin
      done <= '0;
    end
  end

  // Write value to the memory
  always_ff @(posedge clk) begin
    if (!reset && content_en && write_en)
      mem[addr0] <= write_data;
  end

  // Check for out of bounds access
  `ifdef VERILATOR
    always_comb begin
      if (content_en && !write_en)
        if (addr0 >= SIZE)
          $error(
            "comb_mem_d1: Out of bounds access\n",
            "addr0: %0d\n", addr0,
            "SIZE: %0d", SIZE
          );
    end
  `endif
endmodule

module seq_mem_d2 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4
) (
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [D0_IDX_SIZE-1:0] addr0,
   input wire logic [D1_IDX_SIZE-1:0] addr1,
   input wire logic content_en,
   output logic done,

   // Read signal
   output logic [WIDTH-1:0] read_data,

   // Write signals
   input wire logic write_en,
   input wire logic [ WIDTH-1:0] write_data
);
  wire [D0_IDX_SIZE+D1_IDX_SIZE-1:0] addr;
  assign addr = addr0 * D1_SIZE + addr1;

  seq_mem_d1 #(.WIDTH(WIDTH), .SIZE(D0_SIZE * D1_SIZE), .IDX_SIZE(D0_IDX_SIZE+D1_IDX_SIZE)) mem
     (.clk(clk), .reset(reset), .addr0(addr),
    .content_en(content_en), .read_data(read_data), .write_data(write_data), .write_en(write_en),
    .done(done));
endmodule

module seq_mem_d3 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D2_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4,
    parameter D2_IDX_SIZE = 4
) (
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [D0_IDX_SIZE-1:0] addr0,
   input wire logic [D1_IDX_SIZE-1:0] addr1,
   input wire logic [D2_IDX_SIZE-1:0] addr2,
   input wire logic content_en,
   output logic done,

   // Read signal
   output logic [WIDTH-1:0] read_data,

   // Write signals
   input wire logic write_en,
   input wire logic [ WIDTH-1:0] write_data
);
  wire [D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE-1:0] addr;
  assign addr = addr0 * (D1_SIZE * D2_SIZE) + addr1 * (D2_SIZE) + addr2;

  seq_mem_d1 #(.WIDTH(WIDTH), .SIZE(D0_SIZE * D1_SIZE * D2_SIZE), .IDX_SIZE(D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE)) mem
     (.clk(clk), .reset(reset), .addr0(addr),
    .content_en(content_en), .read_data(read_data), .write_data(write_data), .write_en(write_en),
    .done(done));
endmodule

module seq_mem_d4 #(
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
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [D0_IDX_SIZE-1:0] addr0,
   input wire logic [D1_IDX_SIZE-1:0] addr1,
   input wire logic [D2_IDX_SIZE-1:0] addr2,
   input wire logic [D3_IDX_SIZE-1:0] addr3,
   input wire logic content_en,
   output logic done,

   // Read signal
   output logic [WIDTH-1:0] read_data,

   // Write signals
   input wire logic write_en,
   input wire logic [ WIDTH-1:0] write_data
);
  wire [D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE+D3_IDX_SIZE-1:0] addr;
  assign addr = addr0 * (D1_SIZE * D2_SIZE * D3_SIZE) + addr1 * (D2_SIZE * D3_SIZE) + addr2 * (D3_SIZE) + addr3;

  seq_mem_d1 #(.WIDTH(WIDTH), .SIZE(D0_SIZE * D1_SIZE * D2_SIZE * D3_SIZE), .IDX_SIZE(D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE+D3_IDX_SIZE)) mem
     (.clk(clk), .reset(reset), .addr0(addr),
    .content_en(content_en), .read_data(read_data), .write_data(write_data), .write_en(write_en),
    .done(done));
endmodule

module undef #(
    parameter WIDTH = 32
) (
   output wire logic [WIDTH-1:0] out
);
assign out = 'x;
endmodule

module std_const #(
    parameter WIDTH = 32,
    parameter VALUE = 32
) (
   output wire logic [WIDTH-1:0] out
);
assign out = VALUE;
endmodule

module std_wire #(
    parameter WIDTH = 32
) (
   (* data=1 *) input wire logic [WIDTH-1:0] in,
   output wire logic [WIDTH-1:0] out
);
assign out = in;
endmodule

module std_add #(
    parameter WIDTH = 32
) (
   (* data=1 *) input wire logic [WIDTH-1:0] left,
   (* data=1 *) input wire logic [WIDTH-1:0] right,
   output wire logic [WIDTH-1:0] out
);
assign out = left + right;
endmodule

module std_lsh #(
    parameter WIDTH = 32
) (
   (* data=1 *) input wire logic [WIDTH-1:0] left,
   (* data=1 *) input wire logic [WIDTH-1:0] right,
   output wire logic [WIDTH-1:0] out
);
assign out = left << right;
endmodule

module std_reg #(
    parameter WIDTH = 32
) (
   (* write_together=1, data=1 *) input wire logic [WIDTH-1:0] in,
   (* write_together=1, interval=1, go=1 *) input wire logic write_en,
   (* clk=1 *) input wire logic clk,
   (* reset=1 *) input wire logic reset,
   (* stable=1, data=1 *) output wire logic [WIDTH-1:0] out,
   (* done=1 *) output wire logic done
);
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
   (* write_together=1, data=1 *) input wire logic [WIDTH-1:0] in,
   (* write_together=1, interval=1, go=1 *) input wire logic write_en,
   (* clk=1 *) input wire logic clk,
   (* reset=1 *) input wire logic reset,
   (* stable=1 *) output wire logic [WIDTH-1:0] out,
   (* done=1 *) output wire logic done
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

module main(
  input logic [31:0] in0,
  input logic [31:0] in1,
  (* clk=1 *) input logic clk,
  (* reset=1 *) input logic reset,
  (* go=1 *) input logic go,
  (* done=1 *) output logic done
);
// COMPONENT START: main
logic mem_3_clk;
logic mem_3_reset;
logic [9:0] mem_3_addr0;
logic mem_3_content_en;
logic mem_3_write_en;
logic [31:0] mem_3_write_data;
logic [31:0] mem_3_read_data;
logic mem_3_done;
logic mem_2_clk;
logic mem_2_reset;
logic [9:0] mem_2_addr0;
logic mem_2_content_en;
logic mem_2_write_en;
logic [31:0] mem_2_write_data;
logic [31:0] mem_2_read_data;
logic mem_2_done;
logic mem_1_clk;
logic mem_1_reset;
logic [9:0] mem_1_addr0;
logic mem_1_content_en;
logic mem_1_write_en;
logic [31:0] mem_1_write_data;
logic [31:0] mem_1_read_data;
logic mem_1_done;
logic mem_0_clk;
logic mem_0_reset;
logic [9:0] mem_0_addr0;
logic mem_0_content_en;
logic mem_0_write_en;
logic [31:0] mem_0_write_data;
logic [31:0] mem_0_read_data;
logic mem_0_done;
logic [31:0] gemm_instance_in0;
logic [31:0] gemm_instance_in1;
logic gemm_instance_clk;
logic gemm_instance_reset;
logic gemm_instance_go;
logic gemm_instance_done;
logic [31:0] gemm_instance_arg_mem_0_read_data;
logic gemm_instance_arg_mem_0_done;
logic [31:0] gemm_instance_arg_mem_1_write_data;
logic [31:0] gemm_instance_arg_mem_3_read_data;
logic [31:0] gemm_instance_arg_mem_2_read_data;
logic [9:0] gemm_instance_arg_mem_3_addr0;
logic [31:0] gemm_instance_arg_mem_3_write_data;
logic [31:0] gemm_instance_arg_mem_1_read_data;
logic gemm_instance_arg_mem_0_content_en;
logic [9:0] gemm_instance_arg_mem_0_addr0;
logic gemm_instance_arg_mem_3_content_en;
logic gemm_instance_arg_mem_3_done;
logic gemm_instance_arg_mem_0_write_en;
logic gemm_instance_arg_mem_3_write_en;
logic [9:0] gemm_instance_arg_mem_2_addr0;
logic gemm_instance_arg_mem_2_done;
logic gemm_instance_arg_mem_1_done;
logic gemm_instance_arg_mem_2_content_en;
logic [31:0] gemm_instance_arg_mem_0_write_data;
logic gemm_instance_arg_mem_1_write_en;
logic gemm_instance_arg_mem_2_write_en;
logic [31:0] gemm_instance_arg_mem_2_write_data;
logic [9:0] gemm_instance_arg_mem_1_addr0;
logic gemm_instance_arg_mem_1_content_en;
<<<<<<< Updated upstream
logic invoke0_go_in;
logic invoke0_go_out;
logic invoke0_done_in;
logic invoke0_done_out;
=======
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
>>>>>>> Stashed changes
(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(10),
    .SIZE(900),
    .WIDTH(32)
) mem_3 (
    .addr0(mem_3_addr0),
    .clk(mem_3_clk),
    .content_en(mem_3_content_en),
    .done(mem_3_done),
    .read_data(mem_3_read_data),
    .reset(mem_3_reset),
    .write_data(mem_3_write_data),
    .write_en(mem_3_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(10),
    .SIZE(900),
    .WIDTH(32)
) mem_2 (
    .addr0(mem_2_addr0),
    .clk(mem_2_clk),
    .content_en(mem_2_content_en),
    .done(mem_2_done),
    .read_data(mem_2_read_data),
    .reset(mem_2_reset),
    .write_data(mem_2_write_data),
    .write_en(mem_2_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(10),
    .SIZE(900),
    .WIDTH(32)
) mem_1 (
    .addr0(mem_1_addr0),
    .clk(mem_1_clk),
    .content_en(mem_1_content_en),
    .done(mem_1_done),
    .read_data(mem_1_read_data),
    .reset(mem_1_reset),
    .write_data(mem_1_write_data),
    .write_en(mem_1_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(10),
    .SIZE(900),
    .WIDTH(32)
) mem_0 (
    .addr0(mem_0_addr0),
    .clk(mem_0_clk),
    .content_en(mem_0_content_en),
    .done(mem_0_done),
    .read_data(mem_0_read_data),
    .reset(mem_0_reset),
    .write_data(mem_0_write_data),
    .write_en(mem_0_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
gemm gemm_instance (
    .arg_mem_0_addr0(gemm_instance_arg_mem_0_addr0),
    .arg_mem_0_content_en(gemm_instance_arg_mem_0_content_en),
    .arg_mem_0_done(gemm_instance_arg_mem_0_done),
    .arg_mem_0_read_data(gemm_instance_arg_mem_0_read_data),
    .arg_mem_0_write_data(gemm_instance_arg_mem_0_write_data),
    .arg_mem_0_write_en(gemm_instance_arg_mem_0_write_en),
    .arg_mem_1_addr0(gemm_instance_arg_mem_1_addr0),
    .arg_mem_1_content_en(gemm_instance_arg_mem_1_content_en),
    .arg_mem_1_done(gemm_instance_arg_mem_1_done),
    .arg_mem_1_read_data(gemm_instance_arg_mem_1_read_data),
    .arg_mem_1_write_data(gemm_instance_arg_mem_1_write_data),
    .arg_mem_1_write_en(gemm_instance_arg_mem_1_write_en),
    .arg_mem_2_addr0(gemm_instance_arg_mem_2_addr0),
    .arg_mem_2_content_en(gemm_instance_arg_mem_2_content_en),
    .arg_mem_2_done(gemm_instance_arg_mem_2_done),
    .arg_mem_2_read_data(gemm_instance_arg_mem_2_read_data),
    .arg_mem_2_write_data(gemm_instance_arg_mem_2_write_data),
    .arg_mem_2_write_en(gemm_instance_arg_mem_2_write_en),
    .arg_mem_3_addr0(gemm_instance_arg_mem_3_addr0),
    .arg_mem_3_content_en(gemm_instance_arg_mem_3_content_en),
    .arg_mem_3_done(gemm_instance_arg_mem_3_done),
    .arg_mem_3_read_data(gemm_instance_arg_mem_3_read_data),
    .arg_mem_3_write_data(gemm_instance_arg_mem_3_write_data),
    .arg_mem_3_write_en(gemm_instance_arg_mem_3_write_en),
    .clk(gemm_instance_clk),
    .done(gemm_instance_done),
    .go(gemm_instance_go),
    .in0(gemm_instance_in0),
    .in1(gemm_instance_in1),
    .reset(gemm_instance_reset)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* generated=1 *)
std_wire # (
    .WIDTH(1)
) invoke0_go (
    .in(invoke0_go_in),
    .out(invoke0_go_out)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* generated=1 *)
std_wire # (
    .WIDTH(1)
) invoke0_done (
    .in(invoke0_done_in),
    .out(invoke0_done_out)
);

<<<<<<< Updated upstream
assign done = invoke0_done_out;
=======
assign mem_3_write_data = gemm_instance_arg_mem_3_write_data;
assign mem_1_addr0 = gemm_instance_arg_mem_1_addr0;
assign mem_0_addr0 = gemm_instance_arg_mem_0_addr0;
assign mem_3_addr0 = gemm_instance_arg_mem_3_addr0;
assign done = fsm_done_out;
>>>>>>> Stashed changes
assign mem_2_write_en = 1'd0;
assign mem_2_clk = clk;
assign mem_2_content_en = 1'd0;
assign mem_2_reset = reset;
assign invoke0_go_in = go;
assign mem_1_write_en =
 invoke0_go_out ? gemm_instance_arg_mem_1_write_en : 1'd0;
assign mem_1_clk = clk;
assign mem_1_addr0 = gemm_instance_arg_mem_1_addr0;
assign mem_1_content_en =
 invoke0_go_out ? gemm_instance_arg_mem_1_content_en : 1'd0;
assign mem_1_reset = reset;
assign invoke0_done_in = gemm_instance_done;
assign mem_0_write_en =
 invoke0_go_out ? gemm_instance_arg_mem_0_write_en : 1'd0;
assign mem_0_clk = clk;
assign mem_0_addr0 = gemm_instance_arg_mem_0_addr0;
assign mem_0_content_en =
 invoke0_go_out ? gemm_instance_arg_mem_0_content_en : 1'd0;
assign mem_0_reset = reset;
assign mem_3_write_en =
 invoke0_go_out ? gemm_instance_arg_mem_3_write_en : 1'd0;
assign mem_3_clk = clk;
assign mem_3_addr0 = gemm_instance_arg_mem_3_addr0;
assign mem_3_content_en =
 invoke0_go_out ? gemm_instance_arg_mem_3_content_en : 1'd0;
assign mem_3_reset = reset;
assign mem_3_write_data = gemm_instance_arg_mem_3_write_data;
assign gemm_instance_arg_mem_0_read_data =
 invoke0_go_out ? mem_0_read_data : 32'd0;
assign gemm_instance_arg_mem_0_done =
 invoke0_go_out ? mem_0_done : 1'd0;
assign gemm_instance_arg_mem_3_read_data =
 invoke0_go_out ? mem_3_read_data : 32'd0;
assign gemm_instance_in1 =
 invoke0_go_out ? in1 : 32'd0;
assign gemm_instance_arg_mem_1_read_data =
 invoke0_go_out ? mem_1_read_data : 32'd0;
assign gemm_instance_clk = clk;
assign gemm_instance_arg_mem_3_done =
 invoke0_go_out ? mem_3_done : 1'd0;
assign gemm_instance_reset = reset;
assign gemm_instance_go = invoke0_go_out;
assign gemm_instance_arg_mem_1_done =
 invoke0_go_out ? mem_1_done : 1'd0;
assign gemm_instance_in0 =
 invoke0_go_out ? in0 : 32'd0;
// COMPONENT END: main
endmodule

module fsm_gemm_def (
  input logic clk,
  input logic reset,
  output logic adder0_left,
  output logic adder0_right,
  output logic adder1_left,
  output logic adder1_right,
  output logic adder_left,
  output logic adder_right,
  output logic arg_mem_0_content_en,
  output logic arg_mem_0_write_en,
  output logic arg_mem_1_content_en,
  output logic arg_mem_1_write_en,
  output logic arg_mem_3_content_en,
  output logic arg_mem_3_write_en,
  output logic cond_reg0_in,
  output logic cond_reg0_write_en,
  output logic cond_reg1_in,
  output logic cond_reg1_write_en,
  output logic cond_reg_in,
  output logic cond_reg_write_en,
  output logic for_0_induction_var_reg_write_en,
  output logic for_1_induction_var_reg_write_en,
  output logic for_2_induction_var_reg_write_en,
  output logic fsm_done_in,
  output logic idx0_in,
  output logic idx0_write_en,
  output logic idx1_in,
  output logic idx1_write_en,
  output logic idx_in,
  output logic idx_write_en,
  output logic load_0_reg_write_en,
  output logic lt0_left,
  output logic lt0_right,
  output logic lt1_left,
  output logic lt1_right,
  output logic lt_left,
  output logic lt_right,
  output logic muli_0_reg_write_en,
  output logic muli_1_reg_write_en,
  output logic muli_2_reg_write_en,
  output logic muli_3_reg_write_en,
  output logic std_mult_pipe_0_go,
  output logic std_mult_pipe_1_go,
  output logic std_mult_pipe_2_go,
  output logic std_mult_pipe_3_go,
  input logic idx0_out,
  input logic idx1_out,
  input logic idx_out,
  input logic lt0_out,
  input logic lt1_out,
  input logic lt_out,
  input logic adder0_out,
  input logic adder1_out,
  input logic adder_out,
  input logic fsm_start_out,
  input logic cond_reg1_done,
  input logic idx1_done,
  input logic cond_reg1_out,
  input logic cond_reg0_done,
  input logic idx0_done,
  input logic cond_reg0_out,
  input logic cond_reg_done,
  input logic idx_done,
  input logic cond_reg_out,
  output logic fsm_s0_out,
  output logic fsm_s1_out,
  output logic fsm_s2_out,
  output logic fsm_s3_out,
  output logic fsm_s4_out,
  output logic fsm_s5_out,
  output logic fsm_s6_out,
  output logic fsm_s7_out,
  output logic fsm_s8_out,
  output logic fsm_s9_out,
  output logic fsm_s10_out,
  output logic fsm_s11_out,
  output logic fsm_s12_out,
  output logic fsm_s13_out,
  output logic fsm_s14_out,
  output logic fsm_s15_out,
  output logic fsm_s16_out,
  output logic fsm_s17_out,
  output logic fsm_s18_out,
  output logic fsm_s19_out,
  output logic fsm_s20_out,
  output logic fsm_s21_out,
  output logic fsm_s22_out,
  output logic fsm_s23_out,
  output logic fsm_s24_out,
  output logic fsm_s25_out,
  output logic fsm_s26_out,
  output logic fsm_s27_out,
  output logic fsm_s28_out,
  output logic fsm_s29_out
);

  localparam logic[4:0] S0 = 5'd0;
  localparam logic[4:0] S1 = 5'd1;
  localparam logic[4:0] S2 = 5'd2;
  localparam logic[4:0] S3 = 5'd3;
  localparam logic[4:0] S4 = 5'd4;
  localparam logic[4:0] S5 = 5'd5;
  localparam logic[4:0] S6 = 5'd6;
  localparam logic[4:0] S7 = 5'd7;
  localparam logic[4:0] S8 = 5'd8;
  localparam logic[4:0] S9 = 5'd9;
  localparam logic[4:0] S10 = 5'd10;
  localparam logic[4:0] S11 = 5'd11;
  localparam logic[4:0] S12 = 5'd12;
  localparam logic[4:0] S13 = 5'd13;
  localparam logic[4:0] S14 = 5'd14;
  localparam logic[4:0] S15 = 5'd15;
  localparam logic[4:0] S16 = 5'd16;
  localparam logic[4:0] S17 = 5'd17;
  localparam logic[4:0] S18 = 5'd18;
  localparam logic[4:0] S19 = 5'd19;
  localparam logic[4:0] S20 = 5'd20;
  localparam logic[4:0] S21 = 5'd21;
  localparam logic[4:0] S22 = 5'd22;
  localparam logic[4:0] S23 = 5'd23;
  localparam logic[4:0] S24 = 5'd24;
  localparam logic[4:0] S25 = 5'd25;
  localparam logic[4:0] S26 = 5'd26;
  localparam logic[4:0] S27 = 5'd27;
  localparam logic[4:0] S28 = 5'd28;
  localparam logic[4:0] S29 = 5'd29;

  logic [4:0] current_state;
  logic [4:0] next_state;

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
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b1;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          if (fsm_start_out) begin
            next_state = S1;
          end
          else begin
            next_state = S0;
          end
        end
        S1: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 1'd1;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b1;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S2;
        end
        S2: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 1'd1;
          cond_reg1_write_en = 1'd1;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 5'd0;
          idx1_write_en = 1'd1;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b1;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          if (((cond_reg1_done) & (idx1_done)) & (cond_reg1_out)) begin
            next_state = S3;
          end
          else if (((cond_reg1_done) & (idx1_done)) & (~(cond_reg1_out))) begin
            next_state = S29;
          end
          else begin
            next_state = S2;
          end
        end
        S3: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 1'd1;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 1'd1;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b1;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S4;
        end
        S4: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 1'd1;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b1;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S5;
        end
        S5: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 1'd1;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b1;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S6;
        end
        S6: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 1'd1;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b1;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S7;
        end
        S7: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 1'd1;
          cond_reg0_write_en = 1'd1;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 5'd0;
          idx0_write_en = 1'd1;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b1;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          if (((cond_reg0_done) & (idx0_done)) & (cond_reg0_out)) begin
            next_state = S8;
          end
          else if (((cond_reg0_done) & (idx0_done)) & (~(cond_reg0_out))) begin
            next_state = S27;
          end
          else begin
            next_state = S7;
          end
        end
        S8: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 1'd1;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b1;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S9;
        end
        S9: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 1'd1;
          cond_reg_write_en = 1'd1;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 5'd0;
          idx_write_en = 1'd1;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b1;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          if (((cond_reg_done) & (idx_done)) & (cond_reg_out)) begin
            next_state = S10;
          end
          else if (((cond_reg_done) & (idx_done)) & (~(cond_reg_out))) begin
            next_state = S25;
          end
          else begin
            next_state = S9;
          end
        end
        S10: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 1'd1;
          arg_mem_0_write_en = 1'd0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b1;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S11;
        end
        S11: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 1'd1;
          std_mult_pipe_2_go = 1'd1;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b1;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S12;
        end
        S12: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 1'd1;
          std_mult_pipe_2_go = 1'd1;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b1;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S13;
        end
        S13: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 1'd1;
          std_mult_pipe_2_go = 1'd1;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b1;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S14;
        end
        S14: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 1'd1;
          muli_2_reg_write_en = 1'd1;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b1;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S15;
        end
        S15: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 1'd1;
          arg_mem_1_write_en = 1'd0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b1;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S16;
        end
        S16: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 1'd1;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b1;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S17;
        end
        S17: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 1'd1;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b1;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S18;
        end
        S18: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 1'd1;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b1;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S19;
        end
        S19: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 1'd1;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b1;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S20;
        end
        S20: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 1'd1;
          arg_mem_3_write_en = 1'd0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b1;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S21;
        end
        S21: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 1'd1;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b1;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S22;
        end
        S22: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 1'd1;
          arg_mem_3_write_en = 1'd1;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b1;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S23;
        end
        S23: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 1'd1;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b1;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S24;
        end
        S24: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = idx_out;
          adder_right = 5'd1;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = lt_out;
          cond_reg_write_en = 1'd1;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = adder_out;
          idx_write_en = 1'd1;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = adder_out;
          lt_right = 5'd20;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b1;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          if (((cond_reg_done) & (idx_done)) & (cond_reg_out)) begin
            next_state = S10;
          end
          else if (((cond_reg_done) & (idx_done)) & (~(cond_reg_out))) begin
            next_state = S25;
          end
          else begin
            next_state = S24;
          end
        end
        S25: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 1'd1;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b1;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S26;
        end
        S26: begin
          adder0_left = idx0_out;
          adder0_right = 5'd1;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = lt0_out;
          cond_reg0_write_en = 1'd1;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = adder0_out;
          idx0_write_en = 1'd1;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = adder0_out;
          lt0_right = 5'd20;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b1;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          if (((cond_reg0_done) & (idx0_done)) & (cond_reg0_out)) begin
            next_state = S8;
          end
          else if (((cond_reg0_done) & (idx0_done)) & (~(cond_reg0_out))) begin
            next_state = S27;
          end
          else begin
            next_state = S26;
          end
        end
        S27: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 1'd1;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b1;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b0;
          next_state = S28;
        end
        S28: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = idx1_out;
          adder1_right = 5'd1;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = lt1_out;
          cond_reg1_write_en = 1'd1;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = adder1_out;
          idx1_write_en = 1'd1;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = adder1_out;
          lt1_right = 5'd20;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b1;
          fsm_s29_out = 1'b0;
          if (((cond_reg1_done) & (idx1_done)) & (cond_reg1_out)) begin
            next_state = S3;
          end
          else if (((cond_reg1_done) & (idx1_done)) & (~(cond_reg1_out))) begin
            next_state = S29;
          end
          else begin
            next_state = S28;
          end
        end
        S29: begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 1'd1;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          fsm_s0_out = 1'b0;
          fsm_s1_out = 1'b0;
          fsm_s2_out = 1'b0;
          fsm_s3_out = 1'b0;
          fsm_s4_out = 1'b0;
          fsm_s5_out = 1'b0;
          fsm_s6_out = 1'b0;
          fsm_s7_out = 1'b0;
          fsm_s8_out = 1'b0;
          fsm_s9_out = 1'b0;
          fsm_s10_out = 1'b0;
          fsm_s11_out = 1'b0;
          fsm_s12_out = 1'b0;
          fsm_s13_out = 1'b0;
          fsm_s14_out = 1'b0;
          fsm_s15_out = 1'b0;
          fsm_s16_out = 1'b0;
          fsm_s17_out = 1'b0;
          fsm_s18_out = 1'b0;
          fsm_s19_out = 1'b0;
          fsm_s20_out = 1'b0;
          fsm_s21_out = 1'b0;
          fsm_s22_out = 1'b0;
          fsm_s23_out = 1'b0;
          fsm_s24_out = 1'b0;
          fsm_s25_out = 1'b0;
          fsm_s26_out = 1'b0;
          fsm_s27_out = 1'b0;
          fsm_s28_out = 1'b0;
          fsm_s29_out = 1'b1;
          next_state = S0;
        end
      default begin
          adder0_left = 'b0;
          adder0_right = 'b0;
          adder1_left = 'b0;
          adder1_right = 'b0;
          adder_left = 'b0;
          adder_right = 'b0;
          arg_mem_0_content_en = 'b0;
          arg_mem_0_write_en = 'b0;
          arg_mem_1_content_en = 'b0;
          arg_mem_1_write_en = 'b0;
          arg_mem_3_content_en = 'b0;
          arg_mem_3_write_en = 'b0;
          cond_reg0_in = 'b0;
          cond_reg0_write_en = 'b0;
          cond_reg1_in = 'b0;
          cond_reg1_write_en = 'b0;
          cond_reg_in = 'b0;
          cond_reg_write_en = 'b0;
          for_0_induction_var_reg_write_en = 'b0;
          for_1_induction_var_reg_write_en = 'b0;
          for_2_induction_var_reg_write_en = 'b0;
          fsm_done_in = 'b0;
          idx0_in = 'b0;
          idx0_write_en = 'b0;
          idx1_in = 'b0;
          idx1_write_en = 'b0;
          idx_in = 'b0;
          idx_write_en = 'b0;
          load_0_reg_write_en = 'b0;
          lt0_left = 'b0;
          lt0_right = 'b0;
          lt1_left = 'b0;
          lt1_right = 'b0;
          lt_left = 'b0;
          lt_right = 'b0;
          muli_0_reg_write_en = 'b0;
          muli_1_reg_write_en = 'b0;
          muli_2_reg_write_en = 'b0;
          muli_3_reg_write_en = 'b0;
          std_mult_pipe_0_go = 'b0;
          std_mult_pipe_1_go = 'b0;
          std_mult_pipe_2_go = 'b0;
          std_mult_pipe_3_go = 'b0;
          next_state = S0;
      end
    endcase
  end
endmodule

module gemm(
  input logic [31:0] in0,
  input logic [31:0] in1,
  (* clk=1 *) input logic clk,
  (* reset=1 *) input logic reset,
  (* go=1 *) input logic go,
  (* done=1 *) output logic done,
  (* data=1 *) output logic [9:0] arg_mem_3_addr0,
  output logic arg_mem_3_content_en,
  output logic arg_mem_3_write_en,
  (* data=1 *) output logic [31:0] arg_mem_3_write_data,
  input logic [31:0] arg_mem_3_read_data,
  input logic arg_mem_3_done,
  (* data=1 *) output logic [9:0] arg_mem_2_addr0,
  output logic arg_mem_2_content_en,
  output logic arg_mem_2_write_en,
  (* data=1 *) output logic [31:0] arg_mem_2_write_data,
  input logic [31:0] arg_mem_2_read_data,
  input logic arg_mem_2_done,
  (* data=1 *) output logic [9:0] arg_mem_1_addr0,
  output logic arg_mem_1_content_en,
  output logic arg_mem_1_write_en,
  (* data=1 *) output logic [31:0] arg_mem_1_write_data,
  input logic [31:0] arg_mem_1_read_data,
  input logic arg_mem_1_done,
  (* data=1 *) output logic [9:0] arg_mem_0_addr0,
  output logic arg_mem_0_content_en,
  output logic arg_mem_0_write_en,
  (* data=1 *) output logic [31:0] arg_mem_0_write_data,
  input logic [31:0] arg_mem_0_read_data,
  input logic arg_mem_0_done
);
// COMPONENT START: gemm
logic [31:0] std_slice_3_in;
logic [9:0] std_slice_3_out;
logic [31:0] std_slice_2_in;
logic [9:0] std_slice_2_out;
logic [31:0] std_slice_1_in;
logic [9:0] std_slice_1_out;
logic [31:0] std_slice_0_in;
logic [9:0] std_slice_0_out;
logic [31:0] std_add_6_left;
logic [31:0] std_add_6_right;
logic [31:0] std_add_6_out;
logic [31:0] std_add_5_left;
logic [31:0] std_add_5_right;
logic [31:0] std_add_5_out;
logic [31:0] std_add_4_left;
logic [31:0] std_add_4_right;
logic [31:0] std_add_4_out;
logic [31:0] std_add_3_left;
logic [31:0] std_add_3_right;
logic [31:0] std_add_3_out;
logic [31:0] load_0_reg_in;
logic load_0_reg_write_en;
logic load_0_reg_clk;
logic load_0_reg_reset;
logic [31:0] load_0_reg_out;
logic load_0_reg_done;
logic [31:0] muli_3_reg_in;
logic muli_3_reg_write_en;
logic muli_3_reg_clk;
logic muli_3_reg_reset;
logic [31:0] muli_3_reg_out;
logic muli_3_reg_done;
logic std_mult_pipe_3_clk;
logic std_mult_pipe_3_reset;
logic std_mult_pipe_3_go;
logic [31:0] std_mult_pipe_3_left;
logic [31:0] std_mult_pipe_3_right;
logic [31:0] std_mult_pipe_3_out;
logic std_mult_pipe_3_done;
logic [31:0] std_add_2_left;
logic [31:0] std_add_2_right;
logic [31:0] std_add_2_out;
logic [31:0] muli_2_reg_in;
logic muli_2_reg_write_en;
logic muli_2_reg_clk;
logic muli_2_reg_reset;
logic [31:0] muli_2_reg_out;
logic muli_2_reg_done;
logic std_mult_pipe_2_clk;
logic std_mult_pipe_2_reset;
logic std_mult_pipe_2_go;
logic [31:0] std_mult_pipe_2_left;
logic [31:0] std_mult_pipe_2_right;
logic [31:0] std_mult_pipe_2_out;
logic std_mult_pipe_2_done;
logic [31:0] muli_1_reg_in;
logic muli_1_reg_write_en;
logic muli_1_reg_clk;
logic muli_1_reg_reset;
logic [31:0] muli_1_reg_out;
logic muli_1_reg_done;
logic std_mult_pipe_1_clk;
logic std_mult_pipe_1_reset;
logic std_mult_pipe_1_go;
logic [31:0] std_mult_pipe_1_left;
logic [31:0] std_mult_pipe_1_right;
logic [31:0] std_mult_pipe_1_out;
logic std_mult_pipe_1_done;
logic [31:0] std_add_1_left;
logic [31:0] std_add_1_right;
logic [31:0] std_add_1_out;
logic [31:0] std_add_0_left;
logic [31:0] std_add_0_right;
logic [31:0] std_add_0_out;
logic [31:0] muli_0_reg_in;
logic muli_0_reg_write_en;
logic muli_0_reg_clk;
logic muli_0_reg_reset;
logic [31:0] muli_0_reg_out;
logic muli_0_reg_done;
logic std_mult_pipe_0_clk;
logic std_mult_pipe_0_reset;
logic std_mult_pipe_0_go;
logic [31:0] std_mult_pipe_0_left;
logic [31:0] std_mult_pipe_0_right;
logic [31:0] std_mult_pipe_0_out;
logic std_mult_pipe_0_done;
logic [31:0] for_2_induction_var_reg_in;
logic for_2_induction_var_reg_write_en;
logic for_2_induction_var_reg_clk;
logic for_2_induction_var_reg_reset;
logic [31:0] for_2_induction_var_reg_out;
logic for_2_induction_var_reg_done;
logic [31:0] for_1_induction_var_reg_in;
logic for_1_induction_var_reg_write_en;
logic for_1_induction_var_reg_clk;
logic for_1_induction_var_reg_reset;
logic [31:0] for_1_induction_var_reg_out;
logic for_1_induction_var_reg_done;
logic [31:0] for_0_induction_var_reg_in;
logic for_0_induction_var_reg_write_en;
logic for_0_induction_var_reg_clk;
logic for_0_induction_var_reg_reset;
logic [31:0] for_0_induction_var_reg_out;
logic for_0_induction_var_reg_done;
logic [4:0] idx_in;
logic idx_write_en;
logic idx_clk;
logic idx_reset;
logic [4:0] idx_out;
logic idx_done;
logic cond_reg_in;
logic cond_reg_write_en;
logic cond_reg_clk;
logic cond_reg_reset;
logic cond_reg_out;
logic cond_reg_done;
logic [4:0] adder_left;
logic [4:0] adder_right;
logic [4:0] adder_out;
logic [4:0] lt_left;
logic [4:0] lt_right;
logic lt_out;
logic [4:0] idx0_in;
logic idx0_write_en;
logic idx0_clk;
logic idx0_reset;
logic [4:0] idx0_out;
logic idx0_done;
logic cond_reg0_in;
logic cond_reg0_write_en;
logic cond_reg0_clk;
logic cond_reg0_reset;
logic cond_reg0_out;
logic cond_reg0_done;
logic [4:0] adder0_left;
logic [4:0] adder0_right;
logic [4:0] adder0_out;
logic [4:0] lt0_left;
logic [4:0] lt0_right;
logic lt0_out;
logic [4:0] idx1_in;
logic idx1_write_en;
logic idx1_clk;
logic idx1_reset;
logic [4:0] idx1_out;
logic idx1_done;
logic cond_reg1_in;
logic cond_reg1_write_en;
logic cond_reg1_clk;
logic cond_reg1_reset;
logic cond_reg1_out;
logic cond_reg1_done;
logic [4:0] adder1_left;
logic [4:0] adder1_right;
logic [4:0] adder1_out;
logic [4:0] lt1_left;
logic [4:0] lt1_right;
logic lt1_out;
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(10)
) std_slice_3 (
    .in(std_slice_3_in),
    .out(std_slice_3_out)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(10)
) std_slice_2 (
    .in(std_slice_2_in),
    .out(std_slice_2_out)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(10)
) std_slice_1 (
    .in(std_slice_1_in),
    .out(std_slice_1_out)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(10)
) std_slice_0 (
    .in(std_slice_0_in),
    .out(std_slice_0_out)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_6 (
    .left(std_add_6_left),
    .out(std_add_6_out),
    .right(std_add_6_right)
);
<<<<<<< Updated upstream

(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_5 (
    .left(std_add_5_left),
    .out(std_add_5_out),
    .right(std_add_5_right)
);

(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_4 (
    .left(std_add_4_left),
    .out(std_add_4_out),
    .right(std_add_4_right)
);

(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_3 (
    .left(std_add_3_left),
    .out(std_add_3_out),
    .right(std_add_3_right)
);

=======
>>>>>>> Stashed changes
(* data=1 *)
std_reg # (
    .WIDTH(32)
) load_0_reg (
    .clk(load_0_reg_clk),
    .done(load_0_reg_done),
    .in(load_0_reg_in),
    .out(load_0_reg_out),
    .reset(load_0_reg_reset),
    .write_en(load_0_reg_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_reg # (
    .WIDTH(32)
) muli_3_reg (
    .clk(muli_3_reg_clk),
    .done(muli_3_reg_done),
    .in(muli_3_reg_in),
    .out(muli_3_reg_out),
    .reset(muli_3_reg_reset),
    .write_en(muli_3_reg_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_mult_pipe # (
    .WIDTH(32)
) std_mult_pipe_3 (
    .clk(std_mult_pipe_3_clk),
    .done(std_mult_pipe_3_done),
    .go(std_mult_pipe_3_go),
    .left(std_mult_pipe_3_left),
    .out(std_mult_pipe_3_out),
    .reset(std_mult_pipe_3_reset),
    .right(std_mult_pipe_3_right)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_2 (
    .left(std_add_2_left),
    .out(std_add_2_out),
    .right(std_add_2_right)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_reg # (
    .WIDTH(32)
) muli_2_reg (
    .clk(muli_2_reg_clk),
    .done(muli_2_reg_done),
    .in(muli_2_reg_in),
    .out(muli_2_reg_out),
    .reset(muli_2_reg_reset),
    .write_en(muli_2_reg_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_mult_pipe # (
    .WIDTH(32)
) std_mult_pipe_2 (
    .clk(std_mult_pipe_2_clk),
    .done(std_mult_pipe_2_done),
    .go(std_mult_pipe_2_go),
    .left(std_mult_pipe_2_left),
    .out(std_mult_pipe_2_out),
    .reset(std_mult_pipe_2_reset),
    .right(std_mult_pipe_2_right)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_reg # (
    .WIDTH(32)
) muli_1_reg (
    .clk(muli_1_reg_clk),
    .done(muli_1_reg_done),
    .in(muli_1_reg_in),
    .out(muli_1_reg_out),
    .reset(muli_1_reg_reset),
    .write_en(muli_1_reg_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_mult_pipe # (
    .WIDTH(32)
) std_mult_pipe_1 (
    .clk(std_mult_pipe_1_clk),
    .done(std_mult_pipe_1_done),
    .go(std_mult_pipe_1_go),
    .left(std_mult_pipe_1_left),
    .out(std_mult_pipe_1_out),
    .reset(std_mult_pipe_1_reset),
    .right(std_mult_pipe_1_right)
);
<<<<<<< Updated upstream

=======
(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_4 (
    .left(std_add_4_left),
    .out(std_add_4_out),
    .right(std_add_4_right)
);
(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_3 (
    .left(std_add_3_left),
    .out(std_add_3_out),
    .right(std_add_3_right)
);
(* control=1 *)
std_slt # (
    .WIDTH(32)
) std_slt_2 (
    .left(std_slt_2_left),
    .out(std_slt_2_out),
    .right(std_slt_2_right)
);
(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_2 (
    .left(std_add_2_left),
    .out(std_add_2_out),
    .right(std_add_2_right)
);
>>>>>>> Stashed changes
(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_1 (
    .left(std_add_1_left),
    .out(std_add_1_out),
    .right(std_add_1_right)
);
<<<<<<< Updated upstream

(* data=1 *)
std_add # (
=======
(* control=1 *)
std_slt # (
>>>>>>> Stashed changes
    .WIDTH(32)
) std_add_0 (
    .left(std_add_0_left),
    .out(std_add_0_out),
    .right(std_add_0_right)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_reg # (
    .WIDTH(32)
) muli_0_reg (
    .clk(muli_0_reg_clk),
    .done(muli_0_reg_done),
    .in(muli_0_reg_in),
    .out(muli_0_reg_out),
    .reset(muli_0_reg_reset),
    .write_en(muli_0_reg_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_mult_pipe # (
    .WIDTH(32)
) std_mult_pipe_0 (
    .clk(std_mult_pipe_0_clk),
    .done(std_mult_pipe_0_done),
    .go(std_mult_pipe_0_go),
    .left(std_mult_pipe_0_left),
    .out(std_mult_pipe_0_out),
    .reset(std_mult_pipe_0_reset),
    .right(std_mult_pipe_0_right)
);
<<<<<<< Updated upstream

(* data=1 *)
std_reg # (
=======
(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_0 (
    .left(std_add_0_left),
    .out(std_add_0_out),
    .right(std_add_0_right)
);
(* control=1 *)
std_slt # (
>>>>>>> Stashed changes
    .WIDTH(32)
) for_2_induction_var_reg (
    .clk(for_2_induction_var_reg_clk),
    .done(for_2_induction_var_reg_done),
    .in(for_2_induction_var_reg_in),
    .out(for_2_induction_var_reg_out),
    .reset(for_2_induction_var_reg_reset),
    .write_en(for_2_induction_var_reg_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_reg # (
    .WIDTH(32)
) for_1_induction_var_reg (
    .clk(for_1_induction_var_reg_clk),
    .done(for_1_induction_var_reg_done),
    .in(for_1_induction_var_reg_in),
    .out(for_1_induction_var_reg_out),
    .reset(for_1_induction_var_reg_reset),
    .write_en(for_1_induction_var_reg_write_en)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* data=1 *)
std_reg # (
    .WIDTH(32)
) for_0_induction_var_reg (
    .clk(for_0_induction_var_reg_clk),
    .done(for_0_induction_var_reg_done),
    .in(for_0_induction_var_reg_in),
    .out(for_0_induction_var_reg_out),
    .reset(for_0_induction_var_reg_reset),
    .write_en(for_0_induction_var_reg_write_en)
);
<<<<<<< Updated upstream

(* generated=1 *)
=======
(* data=1 *)
>>>>>>> Stashed changes
std_reg # (
    .WIDTH(5)
) idx (
    .clk(idx_clk),
    .done(idx_done),
    .in(idx_in),
    .out(idx_out),
    .reset(idx_reset),
    .write_en(idx_write_en)
);
<<<<<<< Updated upstream

(* generated=1 *)
=======
(* data=1, generated=1 *)
>>>>>>> Stashed changes
std_reg # (
    .WIDTH(1)
) cond_reg (
    .clk(cond_reg_clk),
    .done(cond_reg_done),
    .in(cond_reg_in),
    .out(cond_reg_out),
    .reset(cond_reg_reset),
    .write_en(cond_reg_write_en)
);

(* generated=1 *)
std_add # (
    .WIDTH(5)
) adder (
    .left(adder_left),
    .out(adder_out),
    .right(adder_right)
);

(* generated=1 *)
std_lt # (
    .WIDTH(5)
) lt (
    .left(lt_left),
    .out(lt_out),
    .right(lt_right)
);

(* generated=1 *)
std_reg # (
    .WIDTH(5)
) idx0 (
    .clk(idx0_clk),
    .done(idx0_done),
    .in(idx0_in),
    .out(idx0_out),
    .reset(idx0_reset),
    .write_en(idx0_write_en)
);
<<<<<<< Updated upstream

(* generated=1 *)
=======
(* data=1, generated=1 *)
>>>>>>> Stashed changes
std_reg # (
    .WIDTH(1)
) cond_reg0 (
    .clk(cond_reg0_clk),
    .done(cond_reg0_done),
    .in(cond_reg0_in),
    .out(cond_reg0_out),
    .reset(cond_reg0_reset),
    .write_en(cond_reg0_write_en)
);
<<<<<<< Updated upstream

(* generated=1 *)
std_add # (
    .WIDTH(5)
) adder0 (
    .left(adder0_left),
    .out(adder0_out),
    .right(adder0_right)
);

(* generated=1 *)
std_lt # (
    .WIDTH(5)
) lt0 (
    .left(lt0_left),
    .out(lt0_out),
    .right(lt0_right)
);

(* generated=1 *)
std_reg # (
    .WIDTH(5)
) idx1 (
    .clk(idx1_clk),
    .done(idx1_done),
    .in(idx1_in),
    .out(idx1_out),
    .reset(idx1_reset),
    .write_en(idx1_write_en)
);

(* generated=1 *)
=======
(* data=1, generated=1 *)
>>>>>>> Stashed changes
std_reg # (
    .WIDTH(1)
) cond_reg1 (
    .clk(cond_reg1_clk),
    .done(cond_reg1_done),
    .in(cond_reg1_in),
    .out(cond_reg1_out),
    .reset(cond_reg1_reset),
    .write_en(cond_reg1_write_en)
);
<<<<<<< Updated upstream

(* generated=1 *)
std_add # (
    .WIDTH(5)
) adder1 (
    .left(adder1_left),
    .out(adder1_out),
    .right(adder1_right)
);

(* generated=1 *)
std_lt # (
    .WIDTH(5)
) lt1 (
    .left(lt1_left),
    .out(lt1_out),
    .right(lt1_right)
);

=======
>>>>>>> Stashed changes
(* generated=1 *)
std_wire # (
    .WIDTH(1)
) fsm_start (
    .in(fsm_start_in),
    .out(fsm_start_out)
);
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
(* generated=1 *)
std_wire # (
    .WIDTH(1)
) fsm_done (
    .in(fsm_done_in),
    .out(fsm_done_out)
);

logic fsm_s0_out;
logic fsm_s1_out;
logic fsm_s2_out;
logic fsm_s3_out;
logic fsm_s4_out;
logic fsm_s5_out;
logic fsm_s6_out;
logic fsm_s7_out;
logic fsm_s8_out;
logic fsm_s9_out;
logic fsm_s10_out;
logic fsm_s11_out;
logic fsm_s12_out;
logic fsm_s13_out;
logic fsm_s14_out;
logic fsm_s15_out;
logic fsm_s16_out;
logic fsm_s17_out;
logic fsm_s18_out;
logic fsm_s19_out;
logic fsm_s20_out;
logic fsm_s21_out;
logic fsm_s22_out;
logic fsm_s23_out;
logic fsm_s24_out;
logic fsm_s25_out;
logic fsm_s26_out;
logic fsm_s27_out;
logic fsm_s28_out;
logic fsm_s29_out;
fsm_gemm_def fsm (
  .clk(clk),
  .reset(reset),
  .adder0_left(adder0_left),
  .adder0_right(adder0_right),
  .adder1_left(adder1_left),
  .adder1_right(adder1_right),
  .adder_left(adder_left),
  .adder_right(adder_right),
  .arg_mem_0_content_en(arg_mem_0_content_en),
  .arg_mem_0_write_en(arg_mem_0_write_en),
  .arg_mem_1_content_en(arg_mem_1_content_en),
  .arg_mem_1_write_en(arg_mem_1_write_en),
  .arg_mem_3_content_en(arg_mem_3_content_en),
  .arg_mem_3_write_en(arg_mem_3_write_en),
  .cond_reg0_in(cond_reg0_in),
  .cond_reg0_write_en(cond_reg0_write_en),
  .cond_reg1_in(cond_reg1_in),
  .cond_reg1_write_en(cond_reg1_write_en),
  .cond_reg_in(cond_reg_in),
  .cond_reg_write_en(cond_reg_write_en),
  .for_0_induction_var_reg_write_en(for_0_induction_var_reg_write_en),
  .for_1_induction_var_reg_write_en(for_1_induction_var_reg_write_en),
  .for_2_induction_var_reg_write_en(for_2_induction_var_reg_write_en),
  .fsm_done_in(fsm_done_in),
  .idx0_in(idx0_in),
  .idx0_write_en(idx0_write_en),
  .idx1_in(idx1_in),
  .idx1_write_en(idx1_write_en),
  .idx_in(idx_in),
  .idx_write_en(idx_write_en),
  .load_0_reg_write_en(load_0_reg_write_en),
  .lt0_left(lt0_left),
  .lt0_right(lt0_right),
  .lt1_left(lt1_left),
  .lt1_right(lt1_right),
  .lt_left(lt_left),
  .lt_right(lt_right),
  .muli_0_reg_write_en(muli_0_reg_write_en),
  .muli_1_reg_write_en(muli_1_reg_write_en),
  .muli_2_reg_write_en(muli_2_reg_write_en),
  .muli_3_reg_write_en(muli_3_reg_write_en),
  .std_mult_pipe_0_go(std_mult_pipe_0_go),
  .std_mult_pipe_1_go(std_mult_pipe_1_go),
  .std_mult_pipe_2_go(std_mult_pipe_2_go),
  .std_mult_pipe_3_go(std_mult_pipe_3_go),
  .idx0_out(idx0_out),
  .idx1_out(idx1_out),
  .idx_out(idx_out),
  .lt0_out(lt0_out),
  .lt1_out(lt1_out),
  .lt_out(lt_out),
  .adder0_out(adder0_out),
  .adder1_out(adder1_out),
  .adder_out(adder_out),
  .fsm_start_out(fsm_start_out),
  .cond_reg1_done(cond_reg1_done),
  .idx1_done(idx1_done),
  .cond_reg1_out(cond_reg1_out),
  .cond_reg0_done(cond_reg0_done),
  .idx0_done(idx0_done),
  .cond_reg0_out(cond_reg0_out),
  .cond_reg_done(cond_reg_done),
  .idx_done(idx_done),
  .cond_reg_out(cond_reg_out),
  .fsm_s0_out(fsm_s0_out),
  .fsm_s1_out(fsm_s1_out),
  .fsm_s2_out(fsm_s2_out),
  .fsm_s3_out(fsm_s3_out),
  .fsm_s4_out(fsm_s4_out),
  .fsm_s5_out(fsm_s5_out),
  .fsm_s6_out(fsm_s6_out),
  .fsm_s7_out(fsm_s7_out),
  .fsm_s8_out(fsm_s8_out),
  .fsm_s9_out(fsm_s9_out),
  .fsm_s10_out(fsm_s10_out),
  .fsm_s11_out(fsm_s11_out),
  .fsm_s12_out(fsm_s12_out),
  .fsm_s13_out(fsm_s13_out),
  .fsm_s14_out(fsm_s14_out),
  .fsm_s15_out(fsm_s15_out),
  .fsm_s16_out(fsm_s16_out),
  .fsm_s17_out(fsm_s17_out),
  .fsm_s18_out(fsm_s18_out),
  .fsm_s19_out(fsm_s19_out),
  .fsm_s20_out(fsm_s20_out),
  .fsm_s21_out(fsm_s21_out),
  .fsm_s22_out(fsm_s22_out),
  .fsm_s23_out(fsm_s23_out),
  .fsm_s24_out(fsm_s24_out),
  .fsm_s25_out(fsm_s25_out),
  .fsm_s26_out(fsm_s26_out),
  .fsm_s27_out(fsm_s27_out),
  .fsm_s28_out(fsm_s28_out),
  .fsm_s29_out(fsm_s29_out)
);

assign for_2_induction_var_reg_in =
       fsm_s1_out ? 32'd0 :
       fsm_s27_out ? std_add_6_out :
       'dx;
<<<<<<< Updated upstream
assign std_mult_pipe_0_right = 32'd30;
assign std_mult_pipe_0_left = for_2_induction_var_reg_out;
assign for_1_induction_var_reg_in =
=======
assign comb_reg_in = std_slt_0_out;
assign std_mult_pipe_0_left = while_2_arg0_reg_out;
assign while_1_arg0_reg_in =
>>>>>>> Stashed changes
       fsm_s3_out ? 32'd0 :
       fsm_s25_out ? std_add_5_out :
       'dx;
<<<<<<< Updated upstream
=======
assign std_mult_pipe_0_right = 32'd30;
>>>>>>> Stashed changes
assign muli_0_reg_in = std_mult_pipe_0_out;
assign for_0_induction_var_reg_in =
       fsm_s8_out ? 32'd0 :
       fsm_s23_out ? std_add_4_out :
       'dx;
<<<<<<< Updated upstream
assign std_slice_3_in = std_add_1_out;
assign arg_mem_0_addr0 = std_slice_3_out;
assign std_add_1_left = muli_0_reg_out;
assign std_add_1_right = for_0_induction_var_reg_out;
assign std_mult_pipe_2_left = for_0_induction_var_reg_out;
=======
assign comb_reg1_in = std_slt_2_out;
assign std_add_4_right = while_0_arg0_reg_out;
assign arg_mem_0_addr0 = std_slice_3_out;
assign std_add_4_left = muli_0_reg_out;
assign std_slice_3_in = std_add_4_out;
assign std_mult_pipe_2_left = while_0_arg0_reg_out;
>>>>>>> Stashed changes
assign std_mult_pipe_1_right = arg_mem_0_read_data;
assign std_mult_pipe_2_right = 32'd30;
<<<<<<< Updated upstream
assign muli_2_reg_in = std_mult_pipe_2_out;
assign muli_1_reg_in = std_mult_pipe_1_out;
assign std_slice_2_in = std_add_2_out;
assign std_add_2_right = for_1_induction_var_reg_out;
assign std_add_2_left = muli_2_reg_out;
assign arg_mem_1_addr0 = std_slice_2_out;
assign std_mult_pipe_3_left = muli_1_reg_out;
assign std_mult_pipe_3_right = arg_mem_1_read_data;
assign muli_3_reg_in = std_mult_pipe_3_out;
assign std_add_0_left = muli_0_reg_out;
assign std_slice_1_in = std_add_0_out;
=======
assign std_mult_pipe_1_left = in0;
assign muli_2_reg_in = std_mult_pipe_2_out;
assign muli_1_reg_in = std_mult_pipe_1_out;
assign std_add_5_left = muli_2_reg_out;
assign std_add_5_right = while_1_arg0_reg_out;
assign arg_mem_1_addr0 = std_slice_2_out;
assign std_slice_2_in = std_add_5_out;
assign std_mult_pipe_3_left = muli_1_reg_out;
assign std_mult_pipe_3_right = arg_mem_1_read_data;
assign muli_3_reg_in = std_mult_pipe_3_out;
>>>>>>> Stashed changes
assign arg_mem_3_addr0 =
       fsm_s20_out ? std_slice_1_out :
       fsm_s22_out ? std_slice_0_out :
       'dx;
<<<<<<< Updated upstream
assign std_add_0_right = for_1_induction_var_reg_out;
assign load_0_reg_in = arg_mem_3_read_data;
assign std_add_3_left = load_0_reg_out;
assign arg_mem_3_write_data = std_add_3_out;
assign std_add_3_right = muli_3_reg_out;
assign std_slice_0_in = std_add_0_out;
assign std_add_4_left = for_0_induction_var_reg_out;
assign std_add_4_right = 32'd1;
assign std_add_5_right = 32'd1;
assign std_add_5_left = for_1_induction_var_reg_out;
assign std_add_6_right = 32'd1;
assign std_add_6_left = for_2_induction_var_reg_out;
assign cond_reg1_clk = clk;
assign cond_reg1_reset = reset;
=======
assign std_slice_1_in = std_add_2_out;
assign std_add_2_right = while_1_arg0_reg_out;
assign std_add_2_left = muli_0_reg_out;
assign load_0_reg_in = arg_mem_3_read_data;
assign std_slice_0_in = std_add_2_out;
assign std_add_6_left = load_0_reg_out;
assign std_add_6_right = muli_3_reg_out;
assign arg_mem_3_write_data = std_add_6_out;
assign std_add_3_right = 32'd1;
assign std_add_3_left = while_0_arg0_reg_out;
assign std_add_1_right = 32'd1;
assign std_add_1_left = while_1_arg0_reg_out;
assign std_add_0_left = while_2_arg0_reg_out;
assign std_add_0_right = 32'd1;
>>>>>>> Stashed changes
assign done = fsm_done_out;
assign arg_mem_1_write_data = 32'd0;
assign arg_mem_2_addr0 = 10'd0;
assign arg_mem_2_content_en = 1'd0;
assign arg_mem_0_write_data = 32'd0;
assign arg_mem_2_write_en = 1'd0;
assign arg_mem_2_write_data = 32'd0;
assign muli_3_reg_clk = clk;
assign muli_3_reg_reset = reset;
assign idx1_clk = clk;
assign idx1_reset = reset;
assign load_0_reg_clk = clk;
assign load_0_reg_reset = reset;
assign cond_reg0_clk = clk;
assign cond_reg0_reset = reset;
assign for_0_induction_var_reg_clk = clk;
assign for_0_induction_var_reg_reset = reset;
assign std_mult_pipe_3_clk = clk;
assign std_mult_pipe_3_reset = reset;
assign std_mult_pipe_2_clk = clk;
assign std_mult_pipe_2_reset = reset;
assign idx0_clk = clk;
assign idx0_reset = reset;
assign muli_1_reg_clk = clk;
assign muli_1_reg_reset = reset;
assign muli_0_reg_clk = clk;
assign muli_0_reg_reset = reset;
assign idx_clk = clk;
assign idx_reset = reset;
assign muli_2_reg_clk = clk;
assign muli_2_reg_reset = reset;
assign std_mult_pipe_0_clk = clk;
assign std_mult_pipe_0_reset = reset;
assign for_2_induction_var_reg_clk = clk;
assign for_2_induction_var_reg_reset = reset;
assign std_mult_pipe_1_clk = clk;
assign std_mult_pipe_1_reset = reset;
assign for_1_induction_var_reg_clk = clk;
assign for_1_induction_var_reg_reset = reset;
assign fsm_start_in = go;
assign cond_reg_clk = clk;
assign cond_reg_reset = reset;
// COMPONENT END: gemm
endmodule
