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

module main(
  input logic [31:0] in0,
  input logic [31:0] in1,
  input logic clk,
  input logic reset,
  input logic go,
  output logic done
);
// COMPONENT START: main
logic mem_2_clk;
logic mem_2_reset;
logic [4:0] mem_2_addr0;
logic [4:0] mem_2_addr1;
logic mem_2_content_en;
logic mem_2_write_en;
logic [31:0] mem_2_write_data;
logic [31:0] mem_2_read_data;
logic mem_2_done;
logic mem_1_clk;
logic mem_1_reset;
logic [4:0] mem_1_addr0;
logic [4:0] mem_1_addr1;
logic mem_1_content_en;
logic mem_1_write_en;
logic [31:0] mem_1_write_data;
logic [31:0] mem_1_read_data;
logic mem_1_done;
logic mem_0_clk;
logic mem_0_reset;
logic [4:0] mem_0_addr0;
logic [4:0] mem_0_addr1;
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
logic [4:0] gemm_instance_arg_mem_2_addr1;
logic [31:0] gemm_instance_arg_mem_1_write_data;
logic [31:0] gemm_instance_arg_mem_2_read_data;
logic [31:0] gemm_instance_arg_mem_1_read_data;
logic [4:0] gemm_instance_arg_mem_0_addr1;
logic gemm_instance_arg_mem_0_content_en;
logic [4:0] gemm_instance_arg_mem_0_addr0;
logic gemm_instance_arg_mem_0_write_en;
logic [4:0] gemm_instance_arg_mem_2_addr0;
logic gemm_instance_arg_mem_2_done;
logic gemm_instance_arg_mem_1_done;
logic gemm_instance_arg_mem_2_content_en;
logic [31:0] gemm_instance_arg_mem_0_write_data;
logic [4:0] gemm_instance_arg_mem_1_addr1;
logic gemm_instance_arg_mem_1_write_en;
logic gemm_instance_arg_mem_2_write_en;
logic [31:0] gemm_instance_arg_mem_2_write_data;
logic [4:0] gemm_instance_arg_mem_1_addr0;
logic gemm_instance_arg_mem_1_content_en;
logic [1:0] fsm_in;
logic fsm_write_en;
logic fsm_clk;
logic fsm_reset;
logic [1:0] fsm_out;
logic fsm_done;
logic invoke0_go_in;
logic invoke0_go_out;
logic invoke0_done_in;
logic invoke0_done_out;
logic invoke1_go_in;
logic invoke1_go_out;
logic invoke1_done_in;
logic invoke1_done_out;
logic tdcc_go_in;
logic tdcc_go_out;
logic tdcc_done_in;
logic tdcc_done_out;
seq_mem_d2 # (
    .D0_IDX_SIZE(5),
    .D0_SIZE(30),
    .D1_IDX_SIZE(5),
    .D1_SIZE(30),
    .WIDTH(32)
) mem_2 (
    .addr0(mem_2_addr0),
    .addr1(mem_2_addr1),
    .clk(mem_2_clk),
    .content_en(mem_2_content_en),
    .done(mem_2_done),
    .read_data(mem_2_read_data),
    .reset(mem_2_reset),
    .write_data(mem_2_write_data),
    .write_en(mem_2_write_en)
);
seq_mem_d2 # (
    .D0_IDX_SIZE(5),
    .D0_SIZE(30),
    .D1_IDX_SIZE(5),
    .D1_SIZE(30),
    .WIDTH(32)
) mem_1 (
    .addr0(mem_1_addr0),
    .addr1(mem_1_addr1),
    .clk(mem_1_clk),
    .content_en(mem_1_content_en),
    .done(mem_1_done),
    .read_data(mem_1_read_data),
    .reset(mem_1_reset),
    .write_data(mem_1_write_data),
    .write_en(mem_1_write_en)
);
seq_mem_d2 # (
    .D0_IDX_SIZE(5),
    .D0_SIZE(30),
    .D1_IDX_SIZE(5),
    .D1_SIZE(30),
    .WIDTH(32)
) mem_0 (
    .addr0(mem_0_addr0),
    .addr1(mem_0_addr1),
    .clk(mem_0_clk),
    .content_en(mem_0_content_en),
    .done(mem_0_done),
    .read_data(mem_0_read_data),
    .reset(mem_0_reset),
    .write_data(mem_0_write_data),
    .write_en(mem_0_write_en)
);
gemm gemm_instance (
    .arg_mem_0_addr0(gemm_instance_arg_mem_0_addr0),
    .arg_mem_0_addr1(gemm_instance_arg_mem_0_addr1),
    .arg_mem_0_content_en(gemm_instance_arg_mem_0_content_en),
    .arg_mem_0_done(gemm_instance_arg_mem_0_done),
    .arg_mem_0_read_data(gemm_instance_arg_mem_0_read_data),
    .arg_mem_0_write_data(gemm_instance_arg_mem_0_write_data),
    .arg_mem_0_write_en(gemm_instance_arg_mem_0_write_en),
    .arg_mem_1_addr0(gemm_instance_arg_mem_1_addr0),
    .arg_mem_1_addr1(gemm_instance_arg_mem_1_addr1),
    .arg_mem_1_content_en(gemm_instance_arg_mem_1_content_en),
    .arg_mem_1_done(gemm_instance_arg_mem_1_done),
    .arg_mem_1_read_data(gemm_instance_arg_mem_1_read_data),
    .arg_mem_1_write_data(gemm_instance_arg_mem_1_write_data),
    .arg_mem_1_write_en(gemm_instance_arg_mem_1_write_en),
    .arg_mem_2_addr0(gemm_instance_arg_mem_2_addr0),
    .arg_mem_2_addr1(gemm_instance_arg_mem_2_addr1),
    .arg_mem_2_content_en(gemm_instance_arg_mem_2_content_en),
    .arg_mem_2_done(gemm_instance_arg_mem_2_done),
    .arg_mem_2_read_data(gemm_instance_arg_mem_2_read_data),
    .arg_mem_2_write_data(gemm_instance_arg_mem_2_write_data),
    .arg_mem_2_write_en(gemm_instance_arg_mem_2_write_en),
    .clk(gemm_instance_clk),
    .done(gemm_instance_done),
    .go(gemm_instance_go),
    .in0(gemm_instance_in0),
    .in1(gemm_instance_in1),
    .reset(gemm_instance_reset)
);
std_reg # (
    .WIDTH(2)
) fsm (
    .clk(fsm_clk),
    .done(fsm_done),
    .in(fsm_in),
    .out(fsm_out),
    .reset(fsm_reset),
    .write_en(fsm_write_en)
);
std_wire # (
    .WIDTH(1)
) invoke0_go (
    .in(invoke0_go_in),
    .out(invoke0_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke0_done (
    .in(invoke0_done_in),
    .out(invoke0_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke1_go (
    .in(invoke1_go_in),
    .out(invoke1_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke1_done (
    .in(invoke1_done_in),
    .out(invoke1_done_out)
);
std_wire # (
    .WIDTH(1)
) tdcc_go (
    .in(tdcc_go_in),
    .out(tdcc_go_out)
);
std_wire # (
    .WIDTH(1)
) tdcc_done (
    .in(tdcc_done_in),
    .out(tdcc_done_out)
);
assign done = tdcc_done_out;
assign fsm_write_en = fsm_out == 2'd2 | fsm_out == 2'd0 & invoke0_done_out & tdcc_go_out | fsm_out == 2'd1 & invoke1_done_out & tdcc_go_out;
assign fsm_clk = clk;
assign fsm_reset = reset;
assign fsm_in =
 fsm_out == 2'd0 & invoke0_done_out & tdcc_go_out ? 2'd1 :
 fsm_out == 2'd2 ? 2'd0 :
 fsm_out == 2'd1 & invoke1_done_out & tdcc_go_out ? 2'd2 : 2'd0;
assign mem_2_write_en =
 invoke1_go_out ? gemm_instance_arg_mem_2_write_en : 1'd0;
assign mem_2_clk = clk;
assign mem_2_addr0 = gemm_instance_arg_mem_2_addr0;
assign mem_2_content_en =
 invoke1_go_out ? gemm_instance_arg_mem_2_content_en : 1'd0;
assign mem_2_reset = reset;
assign mem_2_write_data = gemm_instance_arg_mem_2_write_data;
assign mem_2_addr1 = gemm_instance_arg_mem_2_addr1;
assign invoke0_go_in = ~invoke0_done_out & fsm_out == 2'd0 & tdcc_go_out;
assign tdcc_go_in = go;
assign mem_1_write_en =
 invoke1_go_out ? gemm_instance_arg_mem_1_write_en : 1'd0;
assign mem_1_clk = clk;
assign mem_1_addr0 = gemm_instance_arg_mem_1_addr0;
assign mem_1_content_en =
 invoke1_go_out ? gemm_instance_arg_mem_1_content_en : 1'd0;
assign mem_1_reset = reset;
assign mem_1_addr1 = gemm_instance_arg_mem_1_addr1;
assign invoke0_done_in = gemm_instance_done;
assign invoke1_go_in = ~invoke1_done_out & fsm_out == 2'd1 & tdcc_go_out;
assign mem_0_write_en =
 invoke1_go_out ? gemm_instance_arg_mem_0_write_en : 1'd0;
assign mem_0_clk = clk;
assign mem_0_addr0 = gemm_instance_arg_mem_0_addr0;
assign mem_0_content_en =
 invoke1_go_out ? gemm_instance_arg_mem_0_content_en : 1'd0;
assign mem_0_reset = reset;
assign mem_0_addr1 = gemm_instance_arg_mem_0_addr1;
assign tdcc_done_in = fsm_out == 2'd2;
assign invoke1_done_in = gemm_instance_done;
assign gemm_instance_arg_mem_0_read_data =
 invoke1_go_out ? mem_0_read_data : 32'd0;
assign gemm_instance_arg_mem_0_done =
 invoke1_go_out ? mem_0_done : 1'd0;
assign gemm_instance_arg_mem_2_read_data =
 invoke1_go_out ? mem_2_read_data : 32'd0;
assign gemm_instance_in1 =
 invoke1_go_out ? in1 : 32'd0;
assign gemm_instance_arg_mem_1_read_data =
 invoke1_go_out ? mem_1_read_data : 32'd0;
assign gemm_instance_clk = clk;
assign gemm_instance_reset =
 1'b1 ? reset :
 invoke0_go_out ? 1'd1 : 1'd0;
assign gemm_instance_go = invoke0_go_out | invoke1_go_out;
assign gemm_instance_arg_mem_2_done =
 invoke1_go_out ? mem_2_done : 1'd0;
assign gemm_instance_arg_mem_1_done =
 invoke1_go_out ? mem_1_done : 1'd0;
assign gemm_instance_in0 =
 invoke1_go_out ? in0 : 32'd0;
// COMPONENT END: main
endmodule
module gemm(
  input logic [31:0] in0,
  input logic [31:0] in1,
  input logic clk,
  input logic reset,
  input logic go,
  output logic done,
  output logic [4:0] arg_mem_2_addr0,
  output logic [4:0] arg_mem_2_addr1,
  output logic arg_mem_2_content_en,
  output logic arg_mem_2_write_en,
  output logic [31:0] arg_mem_2_write_data,
  input logic [31:0] arg_mem_2_read_data,
  input logic arg_mem_2_done,
  output logic [4:0] arg_mem_1_addr0,
  output logic [4:0] arg_mem_1_addr1,
  output logic arg_mem_1_content_en,
  output logic arg_mem_1_write_en,
  output logic [31:0] arg_mem_1_write_data,
  input logic [31:0] arg_mem_1_read_data,
  input logic arg_mem_1_done,
  output logic [4:0] arg_mem_0_addr0,
  output logic [4:0] arg_mem_0_addr1,
  output logic arg_mem_0_content_en,
  output logic arg_mem_0_write_en,
  output logic [31:0] arg_mem_0_write_data,
  input logic [31:0] arg_mem_0_read_data,
  input logic arg_mem_0_done
);
// COMPONENT START: gemm
logic [31:0] std_slice_7_in;
logic [4:0] std_slice_7_out;
logic [31:0] std_slice_6_in;
logic [4:0] std_slice_6_out;
logic [31:0] std_add_3_left;
logic [31:0] std_add_3_right;
logic [31:0] std_add_3_out;
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
logic [31:0] std_add_2_left;
logic [31:0] std_add_2_right;
logic [31:0] std_add_2_out;
logic [31:0] std_slt_2_left;
logic [31:0] std_slt_2_right;
logic std_slt_2_out;
logic [31:0] while_2_arg0_reg_in;
logic while_2_arg0_reg_write_en;
logic while_2_arg0_reg_clk;
logic while_2_arg0_reg_reset;
logic [31:0] while_2_arg0_reg_out;
logic while_2_arg0_reg_done;
logic [31:0] while_1_arg0_reg_in;
logic while_1_arg0_reg_write_en;
logic while_1_arg0_reg_clk;
logic while_1_arg0_reg_reset;
logic [31:0] while_1_arg0_reg_out;
logic while_1_arg0_reg_done;
logic [31:0] while_0_arg1_reg_in;
logic while_0_arg1_reg_write_en;
logic while_0_arg1_reg_clk;
logic while_0_arg1_reg_reset;
logic [31:0] while_0_arg1_reg_out;
logic while_0_arg1_reg_done;
logic [31:0] while_0_arg0_reg_in;
logic while_0_arg0_reg_write_en;
logic while_0_arg0_reg_clk;
logic while_0_arg0_reg_reset;
logic [31:0] while_0_arg0_reg_out;
logic while_0_arg0_reg_done;
logic comb_reg_in;
logic comb_reg_write_en;
logic comb_reg_clk;
logic comb_reg_reset;
logic comb_reg_out;
logic comb_reg_done;
logic comb_reg0_in;
logic comb_reg0_write_en;
logic comb_reg0_clk;
logic comb_reg0_reset;
logic comb_reg0_out;
logic comb_reg0_done;
logic comb_reg1_in;
logic comb_reg1_write_en;
logic comb_reg1_clk;
logic comb_reg1_reset;
logic comb_reg1_out;
logic comb_reg1_done;
logic [2:0] fsm_in;
logic fsm_write_en;
logic fsm_clk;
logic fsm_reset;
logic [2:0] fsm_out;
logic fsm_done;
logic [2:0] adder_left;
logic [2:0] adder_right;
logic [2:0] adder_out;
logic ud1_out;
logic [2:0] adder0_left;
logic [2:0] adder0_right;
logic [2:0] adder0_out;
logic ud3_out;
logic [2:0] adder1_left;
logic [2:0] adder1_right;
logic [2:0] adder1_out;
logic ud4_out;
logic ud5_out;
logic ud6_out;
logic ud7_out;
logic signal_reg_in;
logic signal_reg_write_en;
logic signal_reg_clk;
logic signal_reg_reset;
logic signal_reg_out;
logic signal_reg_done;
logic [4:0] fsm0_in;
logic fsm0_write_en;
logic fsm0_clk;
logic fsm0_reset;
logic [4:0] fsm0_out;
logic fsm0_done;
logic beg_spl_bb0_4_go_in;
logic beg_spl_bb0_4_go_out;
logic beg_spl_bb0_4_done_in;
logic beg_spl_bb0_4_done_out;
logic bb0_8_go_in;
logic bb0_8_go_out;
logic bb0_8_done_in;
logic bb0_8_done_out;
logic bb0_10_go_in;
logic bb0_10_go_out;
logic bb0_10_done_in;
logic bb0_10_done_out;
logic assign_while_0_latch_go_in;
logic assign_while_0_latch_go_out;
logic assign_while_0_latch_done_in;
logic assign_while_0_latch_done_out;
logic bb0_13_go_in;
logic bb0_13_go_out;
logic bb0_13_done_in;
logic bb0_13_done_out;
logic invoke0_go_in;
logic invoke0_go_out;
logic invoke0_done_in;
logic invoke0_done_out;
logic invoke1_go_in;
logic invoke1_go_out;
logic invoke1_done_in;
logic invoke1_done_out;
logic invoke2_go_in;
logic invoke2_go_out;
logic invoke2_done_in;
logic invoke2_done_out;
logic invoke11_go_in;
logic invoke11_go_out;
logic invoke11_done_in;
logic invoke11_done_out;
logic invoke12_go_in;
logic invoke12_go_out;
logic invoke12_done_in;
logic invoke12_done_out;
logic early_reset_static_seq_go_in;
logic early_reset_static_seq_go_out;
logic early_reset_static_seq_done_in;
logic early_reset_static_seq_done_out;
logic early_reset_static_seq0_go_in;
logic early_reset_static_seq0_go_out;
logic early_reset_static_seq0_done_in;
logic early_reset_static_seq0_done_out;
logic early_reset_static_seq1_go_in;
logic early_reset_static_seq1_go_out;
logic early_reset_static_seq1_done_in;
logic early_reset_static_seq1_done_out;
logic early_reset_bb0_600_go_in;
logic early_reset_bb0_600_go_out;
logic early_reset_bb0_600_done_in;
logic early_reset_bb0_600_done_out;
logic early_reset_bb0_200_go_in;
logic early_reset_bb0_200_go_out;
logic early_reset_bb0_200_done_in;
logic early_reset_bb0_200_done_out;
logic early_reset_bb0_000_go_in;
logic early_reset_bb0_000_go_out;
logic early_reset_bb0_000_done_in;
logic early_reset_bb0_000_done_out;
logic wrapper_early_reset_bb0_000_go_in;
logic wrapper_early_reset_bb0_000_go_out;
logic wrapper_early_reset_bb0_000_done_in;
logic wrapper_early_reset_bb0_000_done_out;
logic wrapper_early_reset_bb0_200_go_in;
logic wrapper_early_reset_bb0_200_go_out;
logic wrapper_early_reset_bb0_200_done_in;
logic wrapper_early_reset_bb0_200_done_out;
logic wrapper_early_reset_static_seq_go_in;
logic wrapper_early_reset_static_seq_go_out;
logic wrapper_early_reset_static_seq_done_in;
logic wrapper_early_reset_static_seq_done_out;
logic wrapper_early_reset_bb0_600_go_in;
logic wrapper_early_reset_bb0_600_go_out;
logic wrapper_early_reset_bb0_600_done_in;
logic wrapper_early_reset_bb0_600_done_out;
logic wrapper_early_reset_static_seq0_go_in;
logic wrapper_early_reset_static_seq0_go_out;
logic wrapper_early_reset_static_seq0_done_in;
logic wrapper_early_reset_static_seq0_done_out;
logic wrapper_early_reset_static_seq1_go_in;
logic wrapper_early_reset_static_seq1_go_out;
logic wrapper_early_reset_static_seq1_done_in;
logic wrapper_early_reset_static_seq1_done_out;
logic tdcc_go_in;
logic tdcc_go_out;
logic tdcc_done_in;
logic tdcc_done_out;
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(5)
) std_slice_7 (
    .in(std_slice_7_in),
    .out(std_slice_7_out)
);
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(5)
) std_slice_6 (
    .in(std_slice_6_in),
    .out(std_slice_6_out)
);
std_add # (
    .WIDTH(32)
) std_add_3 (
    .left(std_add_3_left),
    .out(std_add_3_out),
    .right(std_add_3_right)
);
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
std_add # (
    .WIDTH(32)
) std_add_2 (
    .left(std_add_2_left),
    .out(std_add_2_out),
    .right(std_add_2_right)
);
std_slt # (
    .WIDTH(32)
) std_slt_2 (
    .left(std_slt_2_left),
    .out(std_slt_2_out),
    .right(std_slt_2_right)
);
std_reg # (
    .WIDTH(32)
) while_2_arg0_reg (
    .clk(while_2_arg0_reg_clk),
    .done(while_2_arg0_reg_done),
    .in(while_2_arg0_reg_in),
    .out(while_2_arg0_reg_out),
    .reset(while_2_arg0_reg_reset),
    .write_en(while_2_arg0_reg_write_en)
);
std_reg # (
    .WIDTH(32)
) while_1_arg0_reg (
    .clk(while_1_arg0_reg_clk),
    .done(while_1_arg0_reg_done),
    .in(while_1_arg0_reg_in),
    .out(while_1_arg0_reg_out),
    .reset(while_1_arg0_reg_reset),
    .write_en(while_1_arg0_reg_write_en)
);
std_reg # (
    .WIDTH(32)
) while_0_arg1_reg (
    .clk(while_0_arg1_reg_clk),
    .done(while_0_arg1_reg_done),
    .in(while_0_arg1_reg_in),
    .out(while_0_arg1_reg_out),
    .reset(while_0_arg1_reg_reset),
    .write_en(while_0_arg1_reg_write_en)
);
std_reg # (
    .WIDTH(32)
) while_0_arg0_reg (
    .clk(while_0_arg0_reg_clk),
    .done(while_0_arg0_reg_done),
    .in(while_0_arg0_reg_in),
    .out(while_0_arg0_reg_out),
    .reset(while_0_arg0_reg_reset),
    .write_en(while_0_arg0_reg_write_en)
);
std_reg # (
    .WIDTH(1)
) comb_reg (
    .clk(comb_reg_clk),
    .done(comb_reg_done),
    .in(comb_reg_in),
    .out(comb_reg_out),
    .reset(comb_reg_reset),
    .write_en(comb_reg_write_en)
);
std_reg # (
    .WIDTH(1)
) comb_reg0 (
    .clk(comb_reg0_clk),
    .done(comb_reg0_done),
    .in(comb_reg0_in),
    .out(comb_reg0_out),
    .reset(comb_reg0_reset),
    .write_en(comb_reg0_write_en)
);
std_reg # (
    .WIDTH(1)
) comb_reg1 (
    .clk(comb_reg1_clk),
    .done(comb_reg1_done),
    .in(comb_reg1_in),
    .out(comb_reg1_out),
    .reset(comb_reg1_reset),
    .write_en(comb_reg1_write_en)
);
std_reg # (
    .WIDTH(3)
) fsm (
    .clk(fsm_clk),
    .done(fsm_done),
    .in(fsm_in),
    .out(fsm_out),
    .reset(fsm_reset),
    .write_en(fsm_write_en)
);
std_add # (
    .WIDTH(3)
) adder (
    .left(adder_left),
    .out(adder_out),
    .right(adder_right)
);
undef # (
    .WIDTH(1)
) ud1 (
    .out(ud1_out)
);
std_add # (
    .WIDTH(3)
) adder0 (
    .left(adder0_left),
    .out(adder0_out),
    .right(adder0_right)
);
undef # (
    .WIDTH(1)
) ud3 (
    .out(ud3_out)
);
std_add # (
    .WIDTH(3)
) adder1 (
    .left(adder1_left),
    .out(adder1_out),
    .right(adder1_right)
);
undef # (
    .WIDTH(1)
) ud4 (
    .out(ud4_out)
);
undef # (
    .WIDTH(1)
) ud5 (
    .out(ud5_out)
);
undef # (
    .WIDTH(1)
) ud6 (
    .out(ud6_out)
);
undef # (
    .WIDTH(1)
) ud7 (
    .out(ud7_out)
);
std_reg # (
    .WIDTH(1)
) signal_reg (
    .clk(signal_reg_clk),
    .done(signal_reg_done),
    .in(signal_reg_in),
    .out(signal_reg_out),
    .reset(signal_reg_reset),
    .write_en(signal_reg_write_en)
);
std_reg # (
    .WIDTH(5)
) fsm0 (
    .clk(fsm0_clk),
    .done(fsm0_done),
    .in(fsm0_in),
    .out(fsm0_out),
    .reset(fsm0_reset),
    .write_en(fsm0_write_en)
);
std_wire # (
    .WIDTH(1)
) beg_spl_bb0_4_go (
    .in(beg_spl_bb0_4_go_in),
    .out(beg_spl_bb0_4_go_out)
);
std_wire # (
    .WIDTH(1)
) beg_spl_bb0_4_done (
    .in(beg_spl_bb0_4_done_in),
    .out(beg_spl_bb0_4_done_out)
);
std_wire # (
    .WIDTH(1)
) bb0_8_go (
    .in(bb0_8_go_in),
    .out(bb0_8_go_out)
);
std_wire # (
    .WIDTH(1)
) bb0_8_done (
    .in(bb0_8_done_in),
    .out(bb0_8_done_out)
);
std_wire # (
    .WIDTH(1)
) bb0_10_go (
    .in(bb0_10_go_in),
    .out(bb0_10_go_out)
);
std_wire # (
    .WIDTH(1)
) bb0_10_done (
    .in(bb0_10_done_in),
    .out(bb0_10_done_out)
);
std_wire # (
    .WIDTH(1)
) assign_while_0_latch_go (
    .in(assign_while_0_latch_go_in),
    .out(assign_while_0_latch_go_out)
);
std_wire # (
    .WIDTH(1)
) assign_while_0_latch_done (
    .in(assign_while_0_latch_done_in),
    .out(assign_while_0_latch_done_out)
);
std_wire # (
    .WIDTH(1)
) bb0_13_go (
    .in(bb0_13_go_in),
    .out(bb0_13_go_out)
);
std_wire # (
    .WIDTH(1)
) bb0_13_done (
    .in(bb0_13_done_in),
    .out(bb0_13_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke0_go (
    .in(invoke0_go_in),
    .out(invoke0_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke0_done (
    .in(invoke0_done_in),
    .out(invoke0_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke1_go (
    .in(invoke1_go_in),
    .out(invoke1_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke1_done (
    .in(invoke1_done_in),
    .out(invoke1_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke2_go (
    .in(invoke2_go_in),
    .out(invoke2_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke2_done (
    .in(invoke2_done_in),
    .out(invoke2_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke11_go (
    .in(invoke11_go_in),
    .out(invoke11_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke11_done (
    .in(invoke11_done_in),
    .out(invoke11_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke12_go (
    .in(invoke12_go_in),
    .out(invoke12_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke12_done (
    .in(invoke12_done_in),
    .out(invoke12_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq_go (
    .in(early_reset_static_seq_go_in),
    .out(early_reset_static_seq_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq_done (
    .in(early_reset_static_seq_done_in),
    .out(early_reset_static_seq_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq0_go (
    .in(early_reset_static_seq0_go_in),
    .out(early_reset_static_seq0_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq0_done (
    .in(early_reset_static_seq0_done_in),
    .out(early_reset_static_seq0_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq1_go (
    .in(early_reset_static_seq1_go_in),
    .out(early_reset_static_seq1_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq1_done (
    .in(early_reset_static_seq1_done_in),
    .out(early_reset_static_seq1_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_600_go (
    .in(early_reset_bb0_600_go_in),
    .out(early_reset_bb0_600_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_600_done (
    .in(early_reset_bb0_600_done_in),
    .out(early_reset_bb0_600_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_200_go (
    .in(early_reset_bb0_200_go_in),
    .out(early_reset_bb0_200_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_200_done (
    .in(early_reset_bb0_200_done_in),
    .out(early_reset_bb0_200_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_000_go (
    .in(early_reset_bb0_000_go_in),
    .out(early_reset_bb0_000_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_000_done (
    .in(early_reset_bb0_000_done_in),
    .out(early_reset_bb0_000_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_bb0_000_go (
    .in(wrapper_early_reset_bb0_000_go_in),
    .out(wrapper_early_reset_bb0_000_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_bb0_000_done (
    .in(wrapper_early_reset_bb0_000_done_in),
    .out(wrapper_early_reset_bb0_000_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_bb0_200_go (
    .in(wrapper_early_reset_bb0_200_go_in),
    .out(wrapper_early_reset_bb0_200_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_bb0_200_done (
    .in(wrapper_early_reset_bb0_200_done_in),
    .out(wrapper_early_reset_bb0_200_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq_go (
    .in(wrapper_early_reset_static_seq_go_in),
    .out(wrapper_early_reset_static_seq_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq_done (
    .in(wrapper_early_reset_static_seq_done_in),
    .out(wrapper_early_reset_static_seq_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_bb0_600_go (
    .in(wrapper_early_reset_bb0_600_go_in),
    .out(wrapper_early_reset_bb0_600_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_bb0_600_done (
    .in(wrapper_early_reset_bb0_600_done_in),
    .out(wrapper_early_reset_bb0_600_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq0_go (
    .in(wrapper_early_reset_static_seq0_go_in),
    .out(wrapper_early_reset_static_seq0_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq0_done (
    .in(wrapper_early_reset_static_seq0_done_in),
    .out(wrapper_early_reset_static_seq0_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq1_go (
    .in(wrapper_early_reset_static_seq1_go_in),
    .out(wrapper_early_reset_static_seq1_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq1_done (
    .in(wrapper_early_reset_static_seq1_done_in),
    .out(wrapper_early_reset_static_seq1_done_out)
);
std_wire # (
    .WIDTH(1)
) tdcc_go (
    .in(tdcc_go_in),
    .out(tdcc_go_out)
);
std_wire # (
    .WIDTH(1)
) tdcc_done (
    .in(tdcc_done_in),
    .out(tdcc_done_out)
);
assign adder1_left =
 early_reset_static_seq1_go_out ? fsm_out : 3'd0;
assign adder1_right =
 early_reset_static_seq1_go_out ? 3'd1 : 3'd0;
assign assign_while_0_latch_go_in = ~assign_while_0_latch_done_out & fsm0_out == 5'd12 & tdcc_go_out;
assign assign_while_0_latch_done_in = while_0_arg1_reg_done & while_0_arg0_reg_done;
assign wrapper_early_reset_bb0_200_done_in = signal_reg_out;
assign wrapper_early_reset_bb0_600_done_in = signal_reg_out;
assign done = tdcc_done_out;
assign arg_mem_2_addr1 = std_slice_6_out;
assign arg_mem_0_addr1 = std_slice_6_out;
assign arg_mem_0_content_en = bb0_8_go_out;
assign arg_mem_0_addr0 = std_slice_7_out;
assign arg_mem_0_write_en =
 bb0_8_go_out ? 1'd0 : 1'd0;
assign arg_mem_2_addr0 = std_slice_7_out;
assign arg_mem_2_content_en = beg_spl_bb0_4_go_out | bb0_13_go_out;
assign arg_mem_1_addr1 = std_slice_6_out;
assign arg_mem_1_write_en =
 bb0_10_go_out ? 1'd0 : 1'd0;
assign arg_mem_2_write_en =
 bb0_13_go_out ? 1'd1 :
 beg_spl_bb0_4_go_out ? 1'd0 : 1'd0;
assign arg_mem_2_write_data = while_0_arg1_reg_out;
assign arg_mem_1_addr0 = std_slice_7_out;
assign arg_mem_1_content_en = bb0_10_go_out;
assign fsm_write_en = fsm_out != 3'd4 & early_reset_static_seq_go_out | fsm_out == 3'd4 & early_reset_static_seq_go_out | fsm_out != 3'd3 & early_reset_static_seq0_go_out | fsm_out == 3'd3 & early_reset_static_seq0_go_out | fsm_out != 3'd3 & early_reset_static_seq1_go_out | fsm_out == 3'd3 & early_reset_static_seq1_go_out;
assign fsm_clk = clk;
assign fsm_reset = reset;
assign fsm_in =
 fsm_out != 3'd3 & early_reset_static_seq1_go_out ? adder1_out :
 fsm_out != 3'd4 & early_reset_static_seq_go_out ? adder_out :
 fsm_out != 3'd3 & early_reset_static_seq0_go_out ? adder0_out :
 fsm_out == 3'd4 & early_reset_static_seq_go_out | fsm_out == 3'd3 & early_reset_static_seq0_go_out | fsm_out == 3'd3 & early_reset_static_seq1_go_out ? 3'd0 : 3'd0;
assign adder_left =
 early_reset_static_seq_go_out ? fsm_out : 3'd0;
assign adder_right =
 early_reset_static_seq_go_out ? 3'd1 : 3'd0;
assign invoke11_done_in = while_1_arg0_reg_done;
assign beg_spl_bb0_4_done_in = arg_mem_2_done;
assign invoke2_go_in = ~invoke2_done_out & fsm0_out == 5'd5 & tdcc_go_out;
assign early_reset_bb0_600_done_in = ud5_out;
assign while_1_arg0_reg_write_en = invoke1_go_out | invoke11_go_out;
assign while_1_arg0_reg_clk = clk;
assign while_1_arg0_reg_reset = reset;
assign while_1_arg0_reg_in =
 invoke1_go_out ? 32'd0 :
 invoke11_go_out ? std_add_3_out : 'x;
assign comb_reg_write_en = early_reset_bb0_000_go_out;
assign comb_reg_clk = clk;
assign comb_reg_reset = reset;
assign comb_reg_in =
 early_reset_bb0_000_go_out ? std_slt_2_out : 1'd0;
assign std_add_2_left = while_0_arg0_reg_out;
assign std_add_2_right = 32'd1;
assign std_slt_2_left =
 early_reset_bb0_200_go_out ? while_1_arg0_reg_out :
 early_reset_bb0_600_go_out ? while_0_arg0_reg_out :
 early_reset_bb0_000_go_out ? while_2_arg0_reg_out : 32'd0;
assign std_slt_2_right =
 early_reset_bb0_600_go_out | early_reset_bb0_200_go_out | early_reset_bb0_000_go_out ? 32'd20 : 32'd0;
assign early_reset_static_seq0_go_in = wrapper_early_reset_static_seq0_go_out;
assign early_reset_bb0_200_done_in = ud6_out;
assign wrapper_early_reset_static_seq1_done_in = signal_reg_out;
assign std_mult_pipe_2_clk = clk;
assign std_mult_pipe_2_left =
 fsm_out < 3'd3 & early_reset_static_seq0_go_out ? in0 :
 fsm_out < 3'd3 & early_reset_static_seq_go_out | fsm_out < 3'd3 & early_reset_static_seq1_go_out ? muli_2_reg_out : 'x;
assign std_mult_pipe_2_reset = reset;
assign std_mult_pipe_2_go = fsm_out < 3'd3 & early_reset_static_seq_go_out | fsm_out < 3'd3 & early_reset_static_seq0_go_out | fsm_out < 3'd3 & early_reset_static_seq1_go_out;
assign std_mult_pipe_2_right =
 fsm_out < 3'd3 & early_reset_static_seq0_go_out ? arg_mem_0_read_data :
 fsm_out < 3'd3 & early_reset_static_seq_go_out ? in1 :
 fsm_out < 3'd3 & early_reset_static_seq1_go_out ? arg_mem_1_read_data : 'x;
assign while_0_arg0_reg_write_en = assign_while_0_latch_go_out | fsm_out == 3'd4 & early_reset_static_seq_go_out;
assign while_0_arg0_reg_clk = clk;
assign while_0_arg0_reg_reset = reset;
assign while_0_arg0_reg_in =
 fsm_out == 3'd4 & early_reset_static_seq_go_out ? 32'd0 :
 assign_while_0_latch_go_out ? std_add_2_out : 'x;
assign comb_reg1_write_en = early_reset_bb0_600_go_out;
assign comb_reg1_clk = clk;
assign comb_reg1_reset = reset;
assign comb_reg1_in =
 early_reset_bb0_600_go_out ? std_slt_2_out : 1'd0;
assign bb0_10_go_in = ~bb0_10_done_out & fsm0_out == 5'd10 & tdcc_go_out;
assign bb0_13_done_in = arg_mem_2_done;
assign invoke11_go_in = ~invoke11_done_out & fsm0_out == 5'd15 & tdcc_go_out;
assign early_reset_static_seq1_done_in = ud4_out;
assign wrapper_early_reset_static_seq0_go_in = ~wrapper_early_reset_static_seq0_done_out & fsm0_out == 5'd9 & tdcc_go_out;
assign std_slice_6_in =
 beg_spl_bb0_4_go_out | bb0_10_go_out | bb0_13_go_out ? while_1_arg0_reg_out :
 bb0_8_go_out ? while_0_arg0_reg_out : 'x;
assign std_add_3_left =
 invoke11_go_out ? while_1_arg0_reg_out :
 invoke12_go_out ? while_2_arg0_reg_out :
 assign_while_0_latch_go_out ? while_0_arg1_reg_out : 'x;
assign std_add_3_right =
 assign_while_0_latch_go_out ? muli_2_reg_out :
 invoke11_go_out | invoke12_go_out ? 32'd1 : 'x;
assign comb_reg0_write_en = early_reset_bb0_200_go_out;
assign comb_reg0_clk = clk;
assign comb_reg0_reset = reset;
assign comb_reg0_in =
 early_reset_bb0_200_go_out ? std_slt_2_out : 1'd0;
assign invoke0_go_in = ~invoke0_done_out & fsm0_out == 5'd0 & tdcc_go_out;
assign tdcc_go_in = go;
assign invoke12_go_in = ~invoke12_done_out & fsm0_out == 5'd17 & tdcc_go_out;
assign early_reset_static_seq1_go_in = wrapper_early_reset_static_seq1_go_out;
assign std_slice_7_in =
 bb0_10_go_out ? while_0_arg0_reg_out :
 beg_spl_bb0_4_go_out | bb0_8_go_out | bb0_13_go_out ? while_2_arg0_reg_out : 'x;
assign while_2_arg0_reg_write_en = invoke0_go_out | invoke12_go_out;
assign while_2_arg0_reg_clk = clk;
assign while_2_arg0_reg_reset = reset;
assign while_2_arg0_reg_in =
 invoke0_go_out ? 32'd0 :
 invoke12_go_out ? std_add_3_out : 'x;
assign fsm0_write_en = fsm0_out == 5'd19 | fsm0_out == 5'd0 & invoke0_done_out & tdcc_go_out | fsm0_out == 5'd1 & wrapper_early_reset_bb0_000_done_out & comb_reg_out & tdcc_go_out | fsm0_out == 5'd18 & wrapper_early_reset_bb0_000_done_out & comb_reg_out & tdcc_go_out | fsm0_out == 5'd2 & invoke1_done_out & tdcc_go_out | fsm0_out == 5'd3 & wrapper_early_reset_bb0_200_done_out & comb_reg0_out & tdcc_go_out | fsm0_out == 5'd16 & wrapper_early_reset_bb0_200_done_out & comb_reg0_out & tdcc_go_out | fsm0_out == 5'd4 & beg_spl_bb0_4_done_out & tdcc_go_out | fsm0_out == 5'd5 & invoke2_done_out & tdcc_go_out | fsm0_out == 5'd6 & wrapper_early_reset_static_seq_done_out & tdcc_go_out | fsm0_out == 5'd7 & wrapper_early_reset_bb0_600_done_out & comb_reg1_out & tdcc_go_out | fsm0_out == 5'd13 & wrapper_early_reset_bb0_600_done_out & comb_reg1_out & tdcc_go_out | fsm0_out == 5'd8 & bb0_8_done_out & tdcc_go_out | fsm0_out == 5'd9 & wrapper_early_reset_static_seq0_done_out & tdcc_go_out | fsm0_out == 5'd10 & bb0_10_done_out & tdcc_go_out | fsm0_out == 5'd11 & wrapper_early_reset_static_seq1_done_out & tdcc_go_out | fsm0_out == 5'd12 & assign_while_0_latch_done_out & tdcc_go_out | fsm0_out == 5'd7 & wrapper_early_reset_bb0_600_done_out & ~comb_reg1_out & tdcc_go_out | fsm0_out == 5'd13 & wrapper_early_reset_bb0_600_done_out & ~comb_reg1_out & tdcc_go_out | fsm0_out == 5'd14 & bb0_13_done_out & tdcc_go_out | fsm0_out == 5'd15 & invoke11_done_out & tdcc_go_out | fsm0_out == 5'd3 & wrapper_early_reset_bb0_200_done_out & ~comb_reg0_out & tdcc_go_out | fsm0_out == 5'd16 & wrapper_early_reset_bb0_200_done_out & ~comb_reg0_out & tdcc_go_out | fsm0_out == 5'd17 & invoke12_done_out & tdcc_go_out | fsm0_out == 5'd1 & wrapper_early_reset_bb0_000_done_out & ~comb_reg_out & tdcc_go_out | fsm0_out == 5'd18 & wrapper_early_reset_bb0_000_done_out & ~comb_reg_out & tdcc_go_out;
assign fsm0_clk = clk;
assign fsm0_reset = reset;
assign fsm0_in =
 fsm0_out == 5'd0 & invoke0_done_out & tdcc_go_out ? 5'd1 :
 fsm0_out == 5'd14 & bb0_13_done_out & tdcc_go_out ? 5'd15 :
 fsm0_out == 5'd17 & invoke12_done_out & tdcc_go_out ? 5'd18 :
 fsm0_out == 5'd15 & invoke11_done_out & tdcc_go_out ? 5'd16 :
 fsm0_out == 5'd19 ? 5'd0 :
 fsm0_out == 5'd2 & invoke1_done_out & tdcc_go_out ? 5'd3 :
 fsm0_out == 5'd12 & assign_while_0_latch_done_out & tdcc_go_out ? 5'd13 :
 fsm0_out == 5'd7 & wrapper_early_reset_bb0_600_done_out & ~comb_reg1_out & tdcc_go_out | fsm0_out == 5'd13 & wrapper_early_reset_bb0_600_done_out & ~comb_reg1_out & tdcc_go_out ? 5'd14 :
 fsm0_out == 5'd4 & beg_spl_bb0_4_done_out & tdcc_go_out ? 5'd5 :
 fsm0_out == 5'd11 & wrapper_early_reset_static_seq1_done_out & tdcc_go_out ? 5'd12 :
 fsm0_out == 5'd1 & wrapper_early_reset_bb0_000_done_out & comb_reg_out & tdcc_go_out | fsm0_out == 5'd18 & wrapper_early_reset_bb0_000_done_out & comb_reg_out & tdcc_go_out ? 5'd2 :
 fsm0_out == 5'd7 & wrapper_early_reset_bb0_600_done_out & comb_reg1_out & tdcc_go_out | fsm0_out == 5'd13 & wrapper_early_reset_bb0_600_done_out & comb_reg1_out & tdcc_go_out ? 5'd8 :
 fsm0_out == 5'd9 & wrapper_early_reset_static_seq0_done_out & tdcc_go_out ? 5'd10 :
 fsm0_out == 5'd6 & wrapper_early_reset_static_seq_done_out & tdcc_go_out ? 5'd7 :
 fsm0_out == 5'd10 & bb0_10_done_out & tdcc_go_out ? 5'd11 :
 fsm0_out == 5'd1 & wrapper_early_reset_bb0_000_done_out & ~comb_reg_out & tdcc_go_out | fsm0_out == 5'd18 & wrapper_early_reset_bb0_000_done_out & ~comb_reg_out & tdcc_go_out ? 5'd19 :
 fsm0_out == 5'd3 & wrapper_early_reset_bb0_200_done_out & comb_reg0_out & tdcc_go_out | fsm0_out == 5'd16 & wrapper_early_reset_bb0_200_done_out & comb_reg0_out & tdcc_go_out ? 5'd4 :
 fsm0_out == 5'd5 & invoke2_done_out & tdcc_go_out ? 5'd6 :
 fsm0_out == 5'd3 & wrapper_early_reset_bb0_200_done_out & ~comb_reg0_out & tdcc_go_out | fsm0_out == 5'd16 & wrapper_early_reset_bb0_200_done_out & ~comb_reg0_out & tdcc_go_out ? 5'd17 :
 fsm0_out == 5'd8 & bb0_8_done_out & tdcc_go_out ? 5'd9 : 5'd0;
assign wrapper_early_reset_bb0_200_go_in = ~wrapper_early_reset_bb0_200_done_out & fsm0_out == 5'd3 & tdcc_go_out | ~wrapper_early_reset_bb0_200_done_out & fsm0_out == 5'd16 & tdcc_go_out;
assign invoke12_done_in = while_2_arg0_reg_done;
assign early_reset_bb0_000_go_in = wrapper_early_reset_bb0_000_go_out;
assign wrapper_early_reset_static_seq_done_in = signal_reg_out;
assign adder0_left =
 early_reset_static_seq0_go_out ? fsm_out : 3'd0;
assign adder0_right =
 early_reset_static_seq0_go_out ? 3'd1 : 3'd0;
assign invoke0_done_in = while_2_arg0_reg_done;
assign invoke1_go_in = ~invoke1_done_out & fsm0_out == 5'd2 & tdcc_go_out;
assign early_reset_static_seq_go_in = wrapper_early_reset_static_seq_go_out;
assign muli_2_reg_write_en = invoke2_go_out | fsm_out == 3'd3 & early_reset_static_seq_go_out | fsm_out == 3'd3 & early_reset_static_seq0_go_out | fsm_out == 3'd3 & early_reset_static_seq1_go_out;
assign muli_2_reg_clk = clk;
assign muli_2_reg_reset = reset;
assign muli_2_reg_in =
 invoke2_go_out ? arg_mem_2_read_data :
 fsm_out == 3'd3 & early_reset_static_seq_go_out | fsm_out == 3'd3 & early_reset_static_seq0_go_out | fsm_out == 3'd3 & early_reset_static_seq1_go_out ? std_mult_pipe_2_out : 'x;
assign signal_reg_write_en = signal_reg_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_000_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_200_go_out | fsm_out == 3'd4 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_600_go_out | fsm_out == 3'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq0_go_out | fsm_out == 3'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq1_go_out;
assign signal_reg_clk = clk;
assign signal_reg_reset = reset;
assign signal_reg_in =
 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_000_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_200_go_out | fsm_out == 3'd4 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_600_go_out | fsm_out == 3'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq0_go_out | fsm_out == 3'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq1_go_out ? 1'd1 :
 signal_reg_out ? 1'd0 : 1'd0;
assign bb0_8_done_in = arg_mem_0_done;
assign invoke2_done_in = muli_2_reg_done;
assign early_reset_bb0_200_go_in = wrapper_early_reset_bb0_200_go_out;
assign wrapper_early_reset_bb0_000_go_in = ~wrapper_early_reset_bb0_000_done_out & fsm0_out == 5'd1 & tdcc_go_out | ~wrapper_early_reset_bb0_000_done_out & fsm0_out == 5'd18 & tdcc_go_out;
assign tdcc_done_in = fsm0_out == 5'd19;
assign early_reset_static_seq_done_in = ud1_out;
assign early_reset_bb0_600_go_in = wrapper_early_reset_bb0_600_go_out;
assign early_reset_bb0_000_done_in = ud7_out;
assign wrapper_early_reset_bb0_000_done_in = signal_reg_out;
assign wrapper_early_reset_static_seq1_go_in = ~wrapper_early_reset_static_seq1_done_out & fsm0_out == 5'd11 & tdcc_go_out;
assign while_0_arg1_reg_write_en = assign_while_0_latch_go_out | fsm_out == 3'd4 & early_reset_static_seq_go_out;
assign while_0_arg1_reg_clk = clk;
assign while_0_arg1_reg_reset = reset;
assign while_0_arg1_reg_in =
 assign_while_0_latch_go_out ? std_add_3_out :
 fsm_out == 3'd4 & early_reset_static_seq_go_out ? muli_2_reg_out : 'x;
assign wrapper_early_reset_bb0_600_go_in = ~wrapper_early_reset_bb0_600_done_out & fsm0_out == 5'd7 & tdcc_go_out | ~wrapper_early_reset_bb0_600_done_out & fsm0_out == 5'd13 & tdcc_go_out;
assign invoke1_done_in = while_1_arg0_reg_done;
assign beg_spl_bb0_4_go_in = ~beg_spl_bb0_4_done_out & fsm0_out == 5'd4 & tdcc_go_out;
assign early_reset_static_seq0_done_in = ud3_out;
assign wrapper_early_reset_static_seq_go_in = ~wrapper_early_reset_static_seq_done_out & fsm0_out == 5'd6 & tdcc_go_out;
assign wrapper_early_reset_static_seq0_done_in = signal_reg_out;
assign bb0_8_go_in = ~bb0_8_done_out & fsm0_out == 5'd8 & tdcc_go_out;
assign bb0_10_done_in = arg_mem_1_done;
assign bb0_13_go_in = ~bb0_13_done_out & fsm0_out == 5'd14 & tdcc_go_out;
// COMPONENT END: gemm
endmodule
