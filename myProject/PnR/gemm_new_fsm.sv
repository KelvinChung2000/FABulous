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

module fsm_main_def (
  input logic clk,
  input logic reset,
  input logic fsm_start_out,
  input logic invoke0_done_out,
  input logic invoke1_done_out,
  output logic s0_out,
  output logic s1_out,
  output logic s2_out,
  output logic s3_out
);
  parameter s0 = 2'd0;
  parameter s1 = 2'd1;
  parameter s2 = 2'd2;
  parameter s3 = 2'd3;
  reg [1:0] state_reg;
  always_ff @(posedge clk) begin
    if (reset) begin
      state_reg <= s0;
      s0_out <= 1'b0;
      s1_out <= 1'b0;
      s2_out <= 1'b0;
      s3_out <= 1'b0;
    end
    else begin
      case ( state_reg )
        s0: begin
          s0_out <= 1'b1;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          if (fsm_start_out) begin
            state_reg <= s1;
          end
          else begin
            state_reg <= s0;
          end
        end
        s1: begin
          s0_out <= 1'b0;
          s1_out <= 1'b1;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          if (invoke0_done_out) begin
            state_reg <= s2;
          end
          else begin
            state_reg <= s1;
          end
        end
        s2: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b1;
          s3_out <= 1'b0;
          if (invoke1_done_out) begin
            state_reg <= s3;
          end
          else begin
            state_reg <= s2;
          end
        end
        s3: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b1;
          state_reg <= s0;
        end
      endcase
    end
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
logic [31:0] gemm_instance_arg_mem_2_read_data;
logic [31:0] gemm_instance_arg_mem_1_read_data;
logic gemm_instance_arg_mem_0_content_en;
logic [9:0] gemm_instance_arg_mem_0_addr0;
logic gemm_instance_arg_mem_0_write_en;
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
logic invoke0_go_in;
logic invoke0_go_out;
logic invoke0_done_in;
logic invoke0_done_out;
logic invoke1_go_in;
logic invoke1_go_out;
logic invoke1_done_in;
logic invoke1_done_out;
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
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
    .clk(gemm_instance_clk),
    .done(gemm_instance_done),
    .go(gemm_instance_go),
    .in0(gemm_instance_in0),
    .in1(gemm_instance_in1),
    .reset(gemm_instance_reset)
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
) fsm_start (
    .in(fsm_start_in),
    .out(fsm_start_out)
);
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
fsm_main_def fsm (
  .fsm_start_out(fsm_start_out),
  .invoke0_done_out(invoke0_done_out),
  .invoke1_done_out(invoke1_done_out),
  .s0_out(fsm_s0_out),
  .s1_out(fsm_s1_out),
  .s2_out(fsm_s2_out),
  .s3_out(fsm_s3_out),
  .*
);
assign invoke0_go_in = fsm_s1_out;
assign invoke1_go_in = fsm_s2_out;
assign fsm_done_in = fsm_s3_out;
assign done = fsm_done_out;
assign mem_2_write_en =
 invoke1_go_out ? gemm_instance_arg_mem_2_write_en : 1'd0;
assign mem_2_clk = clk;
assign mem_2_addr0 = gemm_instance_arg_mem_2_addr0;
assign mem_2_content_en =
 invoke1_go_out ? gemm_instance_arg_mem_2_content_en : 1'd0;
assign mem_2_reset = reset;
assign mem_2_write_data = gemm_instance_arg_mem_2_write_data;
assign mem_1_write_en =
 invoke1_go_out ? gemm_instance_arg_mem_1_write_en : 1'd0;
assign mem_1_clk = clk;
assign mem_1_addr0 = gemm_instance_arg_mem_1_addr0;
assign mem_1_content_en =
 invoke1_go_out ? gemm_instance_arg_mem_1_content_en : 1'd0;
assign mem_1_reset = reset;
assign invoke0_done_in = gemm_instance_done;
assign mem_0_write_en =
 invoke1_go_out ? gemm_instance_arg_mem_0_write_en : 1'd0;
assign mem_0_clk = clk;
assign mem_0_addr0 = gemm_instance_arg_mem_0_addr0;
assign mem_0_content_en =
 invoke1_go_out ? gemm_instance_arg_mem_0_content_en : 1'd0;
assign mem_0_reset = reset;
assign invoke1_done_in = gemm_instance_done;
assign fsm_start_in = go;
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
module fsm0_gemm_def (
  input logic clk,
  input logic reset,
  input logic fsm0_start_out,
  input logic invoke0_done_out,
  input logic wrapper_early_reset_bb0_000_done_out,
  input logic comb_reg_out,
  input logic invoke1_done_out,
  input logic wrapper_early_reset_bb0_200_done_out,
  input logic comb_reg0_out,
  input logic wrapper_early_reset_static_seq_done_out,
  input logic beg_spl_bb0_6_done_out,
  input logic invoke4_done_out,
  input logic wrapper_early_reset_static_seq0_done_out,
  input logic wrapper_early_reset_bb0_800_done_out,
  input logic comb_reg1_out,
  input logic wrapper_early_reset_static_seq1_done_out,
  input logic bb0_12_done_out,
  input logic wrapper_early_reset_static_seq2_done_out,
  input logic bb0_16_done_out,
  input logic wrapper_early_reset_static_seq3_done_out,
  input logic assign_while_0_latch_done_out,
  input logic wrapper_early_reset_static_seq4_done_out,
  input logic bb0_21_done_out,
  input logic invoke19_done_out,
  input logic invoke20_done_out,
  output logic s0_out,
  output logic s1_out,
  output logic s2_out,
  output logic s3_out,
  output logic s4_out,
  output logic s5_out,
  output logic s6_out,
  output logic s7_out,
  output logic s8_out,
  output logic s9_out,
  output logic s10_out,
  output logic s11_out,
  output logic s12_out,
  output logic s13_out,
  output logic s14_out,
  output logic s15_out,
  output logic s16_out,
  output logic s17_out,
  output logic s18_out,
  output logic s19_out,
  output logic s20_out,
  output logic s21_out,
  output logic s22_out,
  output logic s23_out
);
  parameter s0 = 5'd0;
  parameter s1 = 5'd1;
  parameter s2 = 5'd2;
  parameter s3 = 5'd3;
  parameter s4 = 5'd4;
  parameter s5 = 5'd5;
  parameter s6 = 5'd6;
  parameter s7 = 5'd7;
  parameter s8 = 5'd8;
  parameter s9 = 5'd9;
  parameter s10 = 5'd10;
  parameter s11 = 5'd11;
  parameter s12 = 5'd12;
  parameter s13 = 5'd13;
  parameter s14 = 5'd14;
  parameter s15 = 5'd15;
  parameter s16 = 5'd16;
  parameter s17 = 5'd17;
  parameter s18 = 5'd18;
  parameter s19 = 5'd19;
  parameter s20 = 5'd20;
  parameter s21 = 5'd21;
  parameter s22 = 5'd22;
  parameter s23 = 5'd23;
  reg [4:0] state_reg;
  always_ff @(posedge clk) begin
    if (reset) begin
      state_reg <= s0;
      s0_out <= 1'b0;
      s1_out <= 1'b0;
      s2_out <= 1'b0;
      s3_out <= 1'b0;
      s4_out <= 1'b0;
      s5_out <= 1'b0;
      s6_out <= 1'b0;
      s7_out <= 1'b0;
      s8_out <= 1'b0;
      s9_out <= 1'b0;
      s10_out <= 1'b0;
      s11_out <= 1'b0;
      s12_out <= 1'b0;
      s13_out <= 1'b0;
      s14_out <= 1'b0;
      s15_out <= 1'b0;
      s16_out <= 1'b0;
      s17_out <= 1'b0;
      s18_out <= 1'b0;
      s19_out <= 1'b0;
      s20_out <= 1'b0;
      s21_out <= 1'b0;
      s22_out <= 1'b0;
      s23_out <= 1'b0;
    end
    else begin
      case ( state_reg )
        s0: begin
          s0_out <= 1'b1;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (fsm0_start_out) begin
            state_reg <= s1;
          end
          else begin
            state_reg <= s0;
          end
        end
        s1: begin
          s0_out <= 1'b0;
          s1_out <= 1'b1;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (invoke0_done_out) begin
            state_reg <= s2;
          end
          else begin
            state_reg <= s1;
          end
        end
        s2: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b1;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if ((wrapper_early_reset_bb0_000_done_out) & (comb_reg_out)) begin
            state_reg <= s3;
          end
          else if ((wrapper_early_reset_bb0_000_done_out) & (~(comb_reg_out))) begin
            state_reg <= s23;
          end
          else begin
            state_reg <= s2;
          end
        end
        s3: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b1;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (invoke1_done_out) begin
            state_reg <= s4;
          end
          else begin
            state_reg <= s3;
          end
        end
        s4: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b1;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if ((wrapper_early_reset_bb0_200_done_out) & (comb_reg0_out)) begin
            state_reg <= s5;
          end
          else if ((wrapper_early_reset_bb0_200_done_out) & (~(comb_reg0_out))) begin
            state_reg <= s21;
          end
          else begin
            state_reg <= s4;
          end
        end
        s5: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b1;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (wrapper_early_reset_static_seq_done_out) begin
            state_reg <= s6;
          end
          else begin
            state_reg <= s5;
          end
        end
        s6: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b1;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (beg_spl_bb0_6_done_out) begin
            state_reg <= s7;
          end
          else begin
            state_reg <= s6;
          end
        end
        s7: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b1;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (invoke4_done_out) begin
            state_reg <= s8;
          end
          else begin
            state_reg <= s7;
          end
        end
        s8: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b1;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (wrapper_early_reset_static_seq0_done_out) begin
            state_reg <= s9;
          end
          else begin
            state_reg <= s8;
          end
        end
        s9: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b1;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if ((wrapper_early_reset_bb0_800_done_out) & (comb_reg1_out)) begin
            state_reg <= s10;
          end
          else if ((wrapper_early_reset_bb0_800_done_out) & (~(comb_reg1_out))) begin
            state_reg <= s17;
          end
          else begin
            state_reg <= s9;
          end
        end
        s10: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b1;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (wrapper_early_reset_static_seq1_done_out) begin
            state_reg <= s11;
          end
          else begin
            state_reg <= s10;
          end
        end
        s11: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b1;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (bb0_12_done_out) begin
            state_reg <= s12;
          end
          else begin
            state_reg <= s11;
          end
        end
        s12: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b1;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (wrapper_early_reset_static_seq2_done_out) begin
            state_reg <= s13;
          end
          else begin
            state_reg <= s12;
          end
        end
        s13: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b1;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (bb0_16_done_out) begin
            state_reg <= s14;
          end
          else begin
            state_reg <= s13;
          end
        end
        s14: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b1;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (wrapper_early_reset_static_seq3_done_out) begin
            state_reg <= s15;
          end
          else begin
            state_reg <= s14;
          end
        end
        s15: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b1;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (assign_while_0_latch_done_out) begin
            state_reg <= s16;
          end
          else begin
            state_reg <= s15;
          end
        end
        s16: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b1;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if ((wrapper_early_reset_bb0_800_done_out) & (comb_reg1_out)) begin
            state_reg <= s10;
          end
          else if ((wrapper_early_reset_bb0_800_done_out) & (~(comb_reg1_out))) begin
            state_reg <= s17;
          end
          else begin
            state_reg <= s16;
          end
        end
        s17: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b1;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (wrapper_early_reset_static_seq4_done_out) begin
            state_reg <= s18;
          end
          else begin
            state_reg <= s17;
          end
        end
        s18: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b1;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (bb0_21_done_out) begin
            state_reg <= s19;
          end
          else begin
            state_reg <= s18;
          end
        end
        s19: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b1;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (invoke19_done_out) begin
            state_reg <= s20;
          end
          else begin
            state_reg <= s19;
          end
        end
        s20: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b1;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if ((wrapper_early_reset_bb0_200_done_out) & (comb_reg0_out)) begin
            state_reg <= s5;
          end
          else if ((wrapper_early_reset_bb0_200_done_out) & (~(comb_reg0_out))) begin
            state_reg <= s21;
          end
          else begin
            state_reg <= s20;
          end
        end
        s21: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b1;
          s22_out <= 1'b0;
          s23_out <= 1'b0;
          if (invoke20_done_out) begin
            state_reg <= s22;
          end
          else begin
            state_reg <= s21;
          end
        end
        s22: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b1;
          s23_out <= 1'b0;
          if ((wrapper_early_reset_bb0_000_done_out) & (comb_reg_out)) begin
            state_reg <= s3;
          end
          else if ((wrapper_early_reset_bb0_000_done_out) & (~(comb_reg_out))) begin
            state_reg <= s23;
          end
          else begin
            state_reg <= s22;
          end
        end
        s23: begin
          s0_out <= 1'b0;
          s1_out <= 1'b0;
          s2_out <= 1'b0;
          s3_out <= 1'b0;
          s4_out <= 1'b0;
          s5_out <= 1'b0;
          s6_out <= 1'b0;
          s7_out <= 1'b0;
          s8_out <= 1'b0;
          s9_out <= 1'b0;
          s10_out <= 1'b0;
          s11_out <= 1'b0;
          s12_out <= 1'b0;
          s13_out <= 1'b0;
          s14_out <= 1'b0;
          s15_out <= 1'b0;
          s16_out <= 1'b0;
          s17_out <= 1'b0;
          s18_out <= 1'b0;
          s19_out <= 1'b0;
          s20_out <= 1'b0;
          s21_out <= 1'b0;
          s22_out <= 1'b0;
          s23_out <= 1'b1;
          state_reg <= s0;
        end
      endcase
    end
  end
endmodule
module gemm(
  input logic [31:0] in0,
  input logic [31:0] in1,
  input logic clk,
  input logic reset,
  input logic go,
  output logic done,
  output logic [9:0] arg_mem_2_addr0,
  output logic arg_mem_2_content_en,
  output logic arg_mem_2_write_en,
  output logic [31:0] arg_mem_2_write_data,
  input logic [31:0] arg_mem_2_read_data,
  input logic arg_mem_2_done,
  output logic [9:0] arg_mem_1_addr0,
  output logic arg_mem_1_content_en,
  output logic arg_mem_1_write_en,
  output logic [31:0] arg_mem_1_write_data,
  input logic [31:0] arg_mem_1_read_data,
  input logic arg_mem_1_done,
  output logic [9:0] arg_mem_0_addr0,
  output logic arg_mem_0_content_en,
  output logic arg_mem_0_write_en,
  output logic [31:0] arg_mem_0_write_data,
  input logic [31:0] arg_mem_0_read_data,
  input logic arg_mem_0_done
);
// COMPONENT START: gemm
logic [31:0] std_slice_3_in;
logic [9:0] std_slice_3_out;
logic [31:0] muli_6_reg_in;
logic muli_6_reg_write_en;
logic muli_6_reg_clk;
logic muli_6_reg_reset;
logic [31:0] muli_6_reg_out;
logic muli_6_reg_done;
logic std_mult_pipe_6_clk;
logic std_mult_pipe_6_reset;
logic std_mult_pipe_6_go;
logic [31:0] std_mult_pipe_6_left;
logic [31:0] std_mult_pipe_6_right;
logic [31:0] std_mult_pipe_6_out;
logic std_mult_pipe_6_done;
logic [31:0] std_add_6_left;
logic [31:0] std_add_6_right;
logic [31:0] std_add_6_out;
logic [31:0] muli_3_reg_in;
logic muli_3_reg_write_en;
logic muli_3_reg_clk;
logic muli_3_reg_reset;
logic [31:0] muli_3_reg_out;
logic muli_3_reg_done;
logic [31:0] std_add_3_left;
logic [31:0] std_add_3_right;
logic [31:0] std_add_3_out;
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
logic [3:0] fsm_in;
logic fsm_write_en;
logic fsm_clk;
logic fsm_reset;
logic [3:0] fsm_out;
logic fsm_done;
logic [3:0] adder_left;
logic [3:0] adder_right;
logic [3:0] adder_out;
logic ud1_out;
logic [3:0] adder0_left;
logic [3:0] adder0_right;
logic [3:0] adder0_out;
logic ud2_out;
logic [3:0] adder1_left;
logic [3:0] adder1_right;
logic [3:0] adder1_out;
logic ud4_out;
logic [3:0] adder2_left;
logic [3:0] adder2_right;
logic [3:0] adder2_out;
logic ud5_out;
logic [3:0] adder3_left;
logic [3:0] adder3_right;
logic [3:0] adder3_out;
logic ud6_out;
logic ud7_out;
logic [3:0] adder4_left;
logic [3:0] adder4_right;
logic [3:0] adder4_out;
logic ud8_out;
logic ud9_out;
logic ud10_out;
logic signal_reg_in;
logic signal_reg_write_en;
logic signal_reg_clk;
logic signal_reg_reset;
logic signal_reg_out;
logic signal_reg_done;
logic beg_spl_bb0_6_go_in;
logic beg_spl_bb0_6_go_out;
logic beg_spl_bb0_6_done_in;
logic beg_spl_bb0_6_done_out;
logic bb0_12_go_in;
logic bb0_12_go_out;
logic bb0_12_done_in;
logic bb0_12_done_out;
logic bb0_16_go_in;
logic bb0_16_go_out;
logic bb0_16_done_in;
logic bb0_16_done_out;
logic assign_while_0_latch_go_in;
logic assign_while_0_latch_go_out;
logic assign_while_0_latch_done_in;
logic assign_while_0_latch_done_out;
logic bb0_21_go_in;
logic bb0_21_go_out;
logic bb0_21_done_in;
logic bb0_21_done_out;
logic invoke0_go_in;
logic invoke0_go_out;
logic invoke0_done_in;
logic invoke0_done_out;
logic invoke1_go_in;
logic invoke1_go_out;
logic invoke1_done_in;
logic invoke1_done_out;
logic invoke4_go_in;
logic invoke4_go_out;
logic invoke4_done_in;
logic invoke4_done_out;
logic invoke19_go_in;
logic invoke19_go_out;
logic invoke19_done_in;
logic invoke19_done_out;
logic invoke20_go_in;
logic invoke20_go_out;
logic invoke20_done_in;
logic invoke20_done_out;
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
logic early_reset_static_seq2_go_in;
logic early_reset_static_seq2_go_out;
logic early_reset_static_seq2_done_in;
logic early_reset_static_seq2_done_out;
logic early_reset_static_seq3_go_in;
logic early_reset_static_seq3_go_out;
logic early_reset_static_seq3_done_in;
logic early_reset_static_seq3_done_out;
logic early_reset_bb0_800_go_in;
logic early_reset_bb0_800_go_out;
logic early_reset_bb0_800_done_in;
logic early_reset_bb0_800_done_out;
logic early_reset_static_seq4_go_in;
logic early_reset_static_seq4_go_out;
logic early_reset_static_seq4_done_in;
logic early_reset_static_seq4_done_out;
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
logic wrapper_early_reset_static_seq0_go_in;
logic wrapper_early_reset_static_seq0_go_out;
logic wrapper_early_reset_static_seq0_done_in;
logic wrapper_early_reset_static_seq0_done_out;
logic wrapper_early_reset_bb0_800_go_in;
logic wrapper_early_reset_bb0_800_go_out;
logic wrapper_early_reset_bb0_800_done_in;
logic wrapper_early_reset_bb0_800_done_out;
logic wrapper_early_reset_static_seq1_go_in;
logic wrapper_early_reset_static_seq1_go_out;
logic wrapper_early_reset_static_seq1_done_in;
logic wrapper_early_reset_static_seq1_done_out;
logic wrapper_early_reset_static_seq2_go_in;
logic wrapper_early_reset_static_seq2_go_out;
logic wrapper_early_reset_static_seq2_done_in;
logic wrapper_early_reset_static_seq2_done_out;
logic wrapper_early_reset_static_seq3_go_in;
logic wrapper_early_reset_static_seq3_go_out;
logic wrapper_early_reset_static_seq3_done_in;
logic wrapper_early_reset_static_seq3_done_out;
logic wrapper_early_reset_static_seq4_go_in;
logic wrapper_early_reset_static_seq4_go_out;
logic wrapper_early_reset_static_seq4_done_in;
logic wrapper_early_reset_static_seq4_done_out;
logic fsm0_start_in;
logic fsm0_start_out;
logic fsm0_done_in;
logic fsm0_done_out;
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(10)
) std_slice_3 (
    .in(std_slice_3_in),
    .out(std_slice_3_out)
);
std_reg # (
    .WIDTH(32)
) muli_6_reg (
    .clk(muli_6_reg_clk),
    .done(muli_6_reg_done),
    .in(muli_6_reg_in),
    .out(muli_6_reg_out),
    .reset(muli_6_reg_reset),
    .write_en(muli_6_reg_write_en)
);
std_mult_pipe # (
    .WIDTH(32)
) std_mult_pipe_6 (
    .clk(std_mult_pipe_6_clk),
    .done(std_mult_pipe_6_done),
    .go(std_mult_pipe_6_go),
    .left(std_mult_pipe_6_left),
    .out(std_mult_pipe_6_out),
    .reset(std_mult_pipe_6_reset),
    .right(std_mult_pipe_6_right)
);
std_add # (
    .WIDTH(32)
) std_add_6 (
    .left(std_add_6_left),
    .out(std_add_6_out),
    .right(std_add_6_right)
);
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
std_add # (
    .WIDTH(32)
) std_add_3 (
    .left(std_add_3_left),
    .out(std_add_3_out),
    .right(std_add_3_right)
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
    .WIDTH(4)
) fsm (
    .clk(fsm_clk),
    .done(fsm_done),
    .in(fsm_in),
    .out(fsm_out),
    .reset(fsm_reset),
    .write_en(fsm_write_en)
);
std_add # (
    .WIDTH(4)
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
    .WIDTH(4)
) adder0 (
    .left(adder0_left),
    .out(adder0_out),
    .right(adder0_right)
);
undef # (
    .WIDTH(1)
) ud2 (
    .out(ud2_out)
);
std_add # (
    .WIDTH(4)
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
std_add # (
    .WIDTH(4)
) adder2 (
    .left(adder2_left),
    .out(adder2_out),
    .right(adder2_right)
);
undef # (
    .WIDTH(1)
) ud5 (
    .out(ud5_out)
);
std_add # (
    .WIDTH(4)
) adder3 (
    .left(adder3_left),
    .out(adder3_out),
    .right(adder3_right)
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
std_add # (
    .WIDTH(4)
) adder4 (
    .left(adder4_left),
    .out(adder4_out),
    .right(adder4_right)
);
undef # (
    .WIDTH(1)
) ud8 (
    .out(ud8_out)
);
undef # (
    .WIDTH(1)
) ud9 (
    .out(ud9_out)
);
undef # (
    .WIDTH(1)
) ud10 (
    .out(ud10_out)
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
std_wire # (
    .WIDTH(1)
) beg_spl_bb0_6_go (
    .in(beg_spl_bb0_6_go_in),
    .out(beg_spl_bb0_6_go_out)
);
std_wire # (
    .WIDTH(1)
) beg_spl_bb0_6_done (
    .in(beg_spl_bb0_6_done_in),
    .out(beg_spl_bb0_6_done_out)
);
std_wire # (
    .WIDTH(1)
) bb0_12_go (
    .in(bb0_12_go_in),
    .out(bb0_12_go_out)
);
std_wire # (
    .WIDTH(1)
) bb0_12_done (
    .in(bb0_12_done_in),
    .out(bb0_12_done_out)
);
std_wire # (
    .WIDTH(1)
) bb0_16_go (
    .in(bb0_16_go_in),
    .out(bb0_16_go_out)
);
std_wire # (
    .WIDTH(1)
) bb0_16_done (
    .in(bb0_16_done_in),
    .out(bb0_16_done_out)
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
) bb0_21_go (
    .in(bb0_21_go_in),
    .out(bb0_21_go_out)
);
std_wire # (
    .WIDTH(1)
) bb0_21_done (
    .in(bb0_21_done_in),
    .out(bb0_21_done_out)
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
) invoke4_go (
    .in(invoke4_go_in),
    .out(invoke4_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke4_done (
    .in(invoke4_done_in),
    .out(invoke4_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke19_go (
    .in(invoke19_go_in),
    .out(invoke19_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke19_done (
    .in(invoke19_done_in),
    .out(invoke19_done_out)
);
std_wire # (
    .WIDTH(1)
) invoke20_go (
    .in(invoke20_go_in),
    .out(invoke20_go_out)
);
std_wire # (
    .WIDTH(1)
) invoke20_done (
    .in(invoke20_done_in),
    .out(invoke20_done_out)
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
) early_reset_static_seq2_go (
    .in(early_reset_static_seq2_go_in),
    .out(early_reset_static_seq2_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq2_done (
    .in(early_reset_static_seq2_done_in),
    .out(early_reset_static_seq2_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq3_go (
    .in(early_reset_static_seq3_go_in),
    .out(early_reset_static_seq3_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq3_done (
    .in(early_reset_static_seq3_done_in),
    .out(early_reset_static_seq3_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_800_go (
    .in(early_reset_bb0_800_go_in),
    .out(early_reset_bb0_800_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_bb0_800_done (
    .in(early_reset_bb0_800_done_in),
    .out(early_reset_bb0_800_done_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq4_go (
    .in(early_reset_static_seq4_go_in),
    .out(early_reset_static_seq4_go_out)
);
std_wire # (
    .WIDTH(1)
) early_reset_static_seq4_done (
    .in(early_reset_static_seq4_done_in),
    .out(early_reset_static_seq4_done_out)
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
) wrapper_early_reset_bb0_800_go (
    .in(wrapper_early_reset_bb0_800_go_in),
    .out(wrapper_early_reset_bb0_800_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_bb0_800_done (
    .in(wrapper_early_reset_bb0_800_done_in),
    .out(wrapper_early_reset_bb0_800_done_out)
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
) wrapper_early_reset_static_seq2_go (
    .in(wrapper_early_reset_static_seq2_go_in),
    .out(wrapper_early_reset_static_seq2_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq2_done (
    .in(wrapper_early_reset_static_seq2_done_in),
    .out(wrapper_early_reset_static_seq2_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq3_go (
    .in(wrapper_early_reset_static_seq3_go_in),
    .out(wrapper_early_reset_static_seq3_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq3_done (
    .in(wrapper_early_reset_static_seq3_done_in),
    .out(wrapper_early_reset_static_seq3_done_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq4_go (
    .in(wrapper_early_reset_static_seq4_go_in),
    .out(wrapper_early_reset_static_seq4_go_out)
);
std_wire # (
    .WIDTH(1)
) wrapper_early_reset_static_seq4_done (
    .in(wrapper_early_reset_static_seq4_done_in),
    .out(wrapper_early_reset_static_seq4_done_out)
);
std_wire # (
    .WIDTH(1)
) fsm0_start (
    .in(fsm0_start_in),
    .out(fsm0_start_out)
);
std_wire # (
    .WIDTH(1)
) fsm0_done (
    .in(fsm0_done_in),
    .out(fsm0_done_out)
);
logic fsm0_s0_out;
logic fsm0_s1_out;
logic fsm0_s2_out;
logic fsm0_s3_out;
logic fsm0_s4_out;
logic fsm0_s5_out;
logic fsm0_s6_out;
logic fsm0_s7_out;
logic fsm0_s8_out;
logic fsm0_s9_out;
logic fsm0_s10_out;
logic fsm0_s11_out;
logic fsm0_s12_out;
logic fsm0_s13_out;
logic fsm0_s14_out;
logic fsm0_s15_out;
logic fsm0_s16_out;
logic fsm0_s17_out;
logic fsm0_s18_out;
logic fsm0_s19_out;
logic fsm0_s20_out;
logic fsm0_s21_out;
logic fsm0_s22_out;
logic fsm0_s23_out;
fsm0_gemm_def fsm0 (
  .fsm0_start_out(fsm0_start_out),
  .invoke0_done_out(invoke0_done_out),
  .wrapper_early_reset_bb0_000_done_out(wrapper_early_reset_bb0_000_done_out),
  .comb_reg_out(comb_reg_out),
  .invoke1_done_out(invoke1_done_out),
  .wrapper_early_reset_bb0_200_done_out(wrapper_early_reset_bb0_200_done_out),
  .comb_reg0_out(comb_reg0_out),
  .wrapper_early_reset_static_seq_done_out(wrapper_early_reset_static_seq_done_out),
  .beg_spl_bb0_6_done_out(beg_spl_bb0_6_done_out),
  .invoke4_done_out(invoke4_done_out),
  .wrapper_early_reset_static_seq0_done_out(wrapper_early_reset_static_seq0_done_out),
  .wrapper_early_reset_bb0_800_done_out(wrapper_early_reset_bb0_800_done_out),
  .comb_reg1_out(comb_reg1_out),
  .wrapper_early_reset_static_seq1_done_out(wrapper_early_reset_static_seq1_done_out),
  .bb0_12_done_out(bb0_12_done_out),
  .wrapper_early_reset_static_seq2_done_out(wrapper_early_reset_static_seq2_done_out),
  .bb0_16_done_out(bb0_16_done_out),
  .wrapper_early_reset_static_seq3_done_out(wrapper_early_reset_static_seq3_done_out),
  .assign_while_0_latch_done_out(assign_while_0_latch_done_out),
  .wrapper_early_reset_static_seq4_done_out(wrapper_early_reset_static_seq4_done_out),
  .bb0_21_done_out(bb0_21_done_out),
  .invoke19_done_out(invoke19_done_out),
  .invoke20_done_out(invoke20_done_out),
  .s0_out(fsm0_s0_out),
  .s1_out(fsm0_s1_out),
  .s2_out(fsm0_s2_out),
  .s3_out(fsm0_s3_out),
  .s4_out(fsm0_s4_out),
  .s5_out(fsm0_s5_out),
  .s6_out(fsm0_s6_out),
  .s7_out(fsm0_s7_out),
  .s8_out(fsm0_s8_out),
  .s9_out(fsm0_s9_out),
  .s10_out(fsm0_s10_out),
  .s11_out(fsm0_s11_out),
  .s12_out(fsm0_s12_out),
  .s13_out(fsm0_s13_out),
  .s14_out(fsm0_s14_out),
  .s15_out(fsm0_s15_out),
  .s16_out(fsm0_s16_out),
  .s17_out(fsm0_s17_out),
  .s18_out(fsm0_s18_out),
  .s19_out(fsm0_s19_out),
  .s20_out(fsm0_s20_out),
  .s21_out(fsm0_s21_out),
  .s22_out(fsm0_s22_out),
  .s23_out(fsm0_s23_out),
  .*
);
assign invoke0_go_in = fsm0_s1_out;
assign wrapper_early_reset_bb0_000_go_in = fsm0_s2_out | fsm0_s22_out;
assign invoke1_go_in = fsm0_s3_out;
assign wrapper_early_reset_bb0_200_go_in = fsm0_s4_out | fsm0_s20_out;
assign wrapper_early_reset_static_seq_go_in = fsm0_s5_out;
assign beg_spl_bb0_6_go_in = fsm0_s6_out;
assign invoke4_go_in = fsm0_s7_out;
assign wrapper_early_reset_static_seq0_go_in = fsm0_s8_out;
assign wrapper_early_reset_bb0_800_go_in = fsm0_s9_out | fsm0_s16_out;
assign wrapper_early_reset_static_seq1_go_in = fsm0_s10_out;
assign bb0_12_go_in = fsm0_s11_out;
assign wrapper_early_reset_static_seq2_go_in = fsm0_s12_out;
assign bb0_16_go_in = fsm0_s13_out;
assign wrapper_early_reset_static_seq3_go_in = fsm0_s14_out;
assign assign_while_0_latch_go_in = fsm0_s15_out;
assign wrapper_early_reset_static_seq4_go_in = fsm0_s17_out;
assign bb0_21_go_in = fsm0_s18_out;
assign invoke19_go_in = fsm0_s19_out;
assign invoke20_go_in = fsm0_s21_out;
assign fsm0_done_in = fsm0_s23_out;
assign adder1_left =
 early_reset_static_seq1_go_out ? fsm_out : 4'd0;
assign adder1_right =
 early_reset_static_seq1_go_out ? 4'd1 : 4'd0;
assign assign_while_0_latch_done_in = while_0_arg1_reg_done & while_0_arg0_reg_done;
assign wrapper_early_reset_bb0_200_done_in = signal_reg_out;
assign done = fsm0_done_out;
assign arg_mem_0_content_en = bb0_12_go_out;
assign arg_mem_0_addr0 = std_slice_3_out;
assign arg_mem_0_write_en =
 bb0_12_go_out ? 1'd0 : 1'd0;
assign arg_mem_2_addr0 = std_slice_3_out;
assign arg_mem_2_content_en = beg_spl_bb0_6_go_out | bb0_21_go_out;
assign arg_mem_1_write_en =
 bb0_16_go_out ? 1'd0 : 1'd0;
assign arg_mem_2_write_en =
 bb0_21_go_out ? 1'd1 :
 beg_spl_bb0_6_go_out ? 1'd0 : 1'd0;
assign arg_mem_2_write_data = while_0_arg1_reg_out;
assign arg_mem_1_addr0 = std_slice_3_out;
assign arg_mem_1_content_en = bb0_16_go_out;
assign fsm_write_en = fsm_out != 4'd3 & early_reset_static_seq_go_out | fsm_out == 4'd3 & early_reset_static_seq_go_out | fsm_out != 4'd4 & early_reset_static_seq0_go_out | fsm_out == 4'd4 & early_reset_static_seq0_go_out | fsm_out != 4'd3 & early_reset_static_seq1_go_out | fsm_out == 4'd3 & early_reset_static_seq1_go_out | fsm_out != 4'd7 & early_reset_static_seq2_go_out | fsm_out == 4'd7 & early_reset_static_seq2_go_out | fsm_out != 4'd3 & early_reset_static_seq3_go_out | fsm_out == 4'd3 & early_reset_static_seq3_go_out | fsm_out != 4'd3 & early_reset_static_seq4_go_out | fsm_out == 4'd3 & early_reset_static_seq4_go_out;
assign fsm_clk = clk;
assign fsm_reset = reset;
assign fsm_in =
 fsm_out != 4'd3 & early_reset_static_seq1_go_out ? adder1_out :
 fsm_out != 4'd3 & early_reset_static_seq_go_out ? adder_out :
 fsm_out != 4'd3 & early_reset_static_seq4_go_out ? adder4_out :
 fsm_out == 4'd3 & early_reset_static_seq_go_out | fsm_out == 4'd4 & early_reset_static_seq0_go_out | fsm_out == 4'd3 & early_reset_static_seq1_go_out | fsm_out == 4'd7 & early_reset_static_seq2_go_out | fsm_out == 4'd3 & early_reset_static_seq3_go_out | fsm_out == 4'd3 & early_reset_static_seq4_go_out ? 4'd0 :
 fsm_out != 4'd7 & early_reset_static_seq2_go_out ? adder2_out :
 fsm_out != 4'd3 & early_reset_static_seq3_go_out ? adder3_out :
 fsm_out != 4'd4 & early_reset_static_seq0_go_out ? adder0_out : 4'd0;
assign adder_left =
 early_reset_static_seq_go_out ? fsm_out : 4'd0;
assign adder_right =
 early_reset_static_seq_go_out ? 4'd1 : 4'd0;
assign wrapper_early_reset_static_seq4_done_in = signal_reg_out;
assign muli_3_reg_write_en = fsm_out == 4'd3 & early_reset_static_seq2_go_out;
assign muli_3_reg_clk = clk;
assign muli_3_reg_reset = reset;
assign muli_3_reg_in = std_mult_pipe_6_out;
assign adder4_left =
 early_reset_static_seq4_go_out ? fsm_out : 4'd0;
assign adder4_right =
 early_reset_static_seq4_go_out ? 4'd1 : 4'd0;
assign beg_spl_bb0_6_done_in = arg_mem_2_done;
assign fsm0_start_in = go;
assign while_1_arg0_reg_write_en = invoke1_go_out | invoke19_go_out;
assign while_1_arg0_reg_clk = clk;
assign while_1_arg0_reg_reset = reset;
assign while_1_arg0_reg_in =
 invoke1_go_out ? 32'd0 :
 invoke19_go_out ? std_add_6_out : 'x;
assign comb_reg_write_en = early_reset_bb0_000_go_out;
assign comb_reg_clk = clk;
assign comb_reg_reset = reset;
assign comb_reg_in =
 early_reset_bb0_000_go_out ? std_slt_2_out : 1'd0;
assign bb0_12_done_in = arg_mem_0_done;
assign early_reset_static_seq2_done_in = ud5_out;
assign early_reset_static_seq3_done_in = ud6_out;
assign early_reset_static_seq4_go_in = wrapper_early_reset_static_seq4_go_out;
assign std_mult_pipe_6_clk = clk;
assign std_mult_pipe_6_left =
 fsm_out < 4'd3 & early_reset_static_seq2_go_out ? in0 :
 fsm_out < 4'd3 & early_reset_static_seq3_go_out ? muli_3_reg_out :
 fsm_out >= 4'd4 & fsm_out < 4'd7 & early_reset_static_seq2_go_out ? while_0_arg0_reg_out :
 fsm_out < 4'd3 & early_reset_static_seq_go_out | fsm_out < 4'd3 & early_reset_static_seq1_go_out | fsm_out < 4'd3 & early_reset_static_seq4_go_out ? while_2_arg0_reg_out :
 fsm_out < 4'd3 & early_reset_static_seq0_go_out ? muli_6_reg_out : 'x;
assign std_mult_pipe_6_reset = reset;
assign std_mult_pipe_6_go = fsm_out < 4'd3 & early_reset_static_seq_go_out | fsm_out < 4'd3 & early_reset_static_seq0_go_out | fsm_out < 4'd3 & early_reset_static_seq1_go_out | (fsm_out < 4'd3 | fsm_out >= 4'd4 & fsm_out < 4'd7) & early_reset_static_seq2_go_out | fsm_out < 4'd3 & early_reset_static_seq3_go_out | fsm_out < 4'd3 & early_reset_static_seq4_go_out;
assign std_mult_pipe_6_right =
 fsm_out < 4'd3 & early_reset_static_seq2_go_out ? arg_mem_0_read_data :
 fsm_out < 4'd3 & early_reset_static_seq0_go_out ? in1 :
 fsm_out < 4'd3 & early_reset_static_seq3_go_out ? arg_mem_1_read_data :
 fsm_out < 4'd3 & early_reset_static_seq_go_out | fsm_out < 4'd3 & early_reset_static_seq1_go_out | fsm_out >= 4'd4 & fsm_out < 4'd7 & early_reset_static_seq2_go_out | fsm_out < 4'd3 & early_reset_static_seq4_go_out ? 32'd30 : 'x;
assign std_slt_2_left =
 early_reset_bb0_200_go_out ? while_1_arg0_reg_out :
 early_reset_bb0_800_go_out ? while_0_arg0_reg_out :
 early_reset_bb0_000_go_out ? while_2_arg0_reg_out : 32'd0;
assign std_slt_2_right =
 early_reset_bb0_800_go_out | early_reset_bb0_200_go_out | early_reset_bb0_000_go_out ? 32'd20 : 32'd0;
assign early_reset_static_seq0_go_in = wrapper_early_reset_static_seq0_go_out;
assign early_reset_bb0_200_done_in = ud9_out;
assign wrapper_early_reset_static_seq1_done_in = signal_reg_out;
assign std_slice_3_in = std_add_6_out;
assign while_0_arg0_reg_write_en = assign_while_0_latch_go_out | fsm_out == 4'd4 & early_reset_static_seq0_go_out;
assign while_0_arg0_reg_clk = clk;
assign while_0_arg0_reg_reset = reset;
assign while_0_arg0_reg_in =
 fsm_out == 4'd4 & early_reset_static_seq0_go_out ? 32'd0 :
 assign_while_0_latch_go_out ? std_add_3_out : 'x;
assign comb_reg1_write_en = early_reset_bb0_800_go_out;
assign comb_reg1_clk = clk;
assign comb_reg1_reset = reset;
assign comb_reg1_in =
 early_reset_bb0_800_go_out ? std_slt_2_out : 1'd0;
assign invoke20_done_in = while_2_arg0_reg_done;
assign early_reset_static_seq1_done_in = ud4_out;
assign early_reset_static_seq2_go_in = wrapper_early_reset_static_seq2_go_out;
assign early_reset_static_seq3_go_in = wrapper_early_reset_static_seq3_go_out;
assign std_add_3_left = while_0_arg0_reg_out;
assign std_add_3_right = 32'd1;
assign comb_reg0_write_en = early_reset_bb0_200_go_out;
assign comb_reg0_clk = clk;
assign comb_reg0_reset = reset;
assign comb_reg0_in =
 early_reset_bb0_200_go_out ? std_slt_2_out : 1'd0;
assign early_reset_static_seq1_go_in = wrapper_early_reset_static_seq1_go_out;
assign while_2_arg0_reg_write_en = invoke0_go_out | invoke20_go_out;
assign while_2_arg0_reg_clk = clk;
assign while_2_arg0_reg_reset = reset;
assign while_2_arg0_reg_in =
 invoke0_go_out ? 32'd0 :
 invoke20_go_out ? std_add_6_out : 'x;
assign adder2_left =
 early_reset_static_seq2_go_out ? fsm_out : 4'd0;
assign adder2_right =
 early_reset_static_seq2_go_out ? 4'd1 : 4'd0;
assign std_add_6_left =
 invoke19_go_out ? while_1_arg0_reg_out :
 invoke20_go_out ? while_2_arg0_reg_out :
 beg_spl_bb0_6_go_out | bb0_12_go_out | bb0_16_go_out | bb0_21_go_out ? muli_6_reg_out :
 assign_while_0_latch_go_out ? while_0_arg1_reg_out : 'x;
assign std_add_6_right =
 beg_spl_bb0_6_go_out | bb0_16_go_out | bb0_21_go_out ? while_1_arg0_reg_out :
 bb0_12_go_out ? while_0_arg0_reg_out :
 invoke19_go_out | invoke20_go_out ? 32'd1 :
 assign_while_0_latch_go_out ? muli_6_reg_out : 'x;
assign adder3_left =
 early_reset_static_seq3_go_out ? fsm_out : 4'd0;
assign adder3_right =
 early_reset_static_seq3_go_out ? 4'd1 : 4'd0;
assign early_reset_bb0_000_go_in = wrapper_early_reset_bb0_000_go_out;
assign wrapper_early_reset_static_seq_done_in = signal_reg_out;
assign adder0_left =
 early_reset_static_seq0_go_out ? fsm_out : 4'd0;
assign adder0_right =
 early_reset_static_seq0_go_out ? 4'd1 : 4'd0;
assign invoke0_done_in = while_2_arg0_reg_done;
assign bb0_16_done_in = arg_mem_1_done;
assign invoke19_done_in = while_1_arg0_reg_done;
assign early_reset_static_seq_go_in = wrapper_early_reset_static_seq_go_out;
assign signal_reg_write_en = signal_reg_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_000_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_200_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq_go_out | fsm_out == 4'd4 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq0_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_800_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq1_go_out | fsm_out == 4'd7 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq2_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq3_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq4_go_out;
assign signal_reg_clk = clk;
assign signal_reg_reset = reset;
assign signal_reg_in =
 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_000_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_200_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq_go_out | fsm_out == 4'd4 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq0_go_out | 1'b1 & 1'b1 & ~signal_reg_out & wrapper_early_reset_bb0_800_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq1_go_out | fsm_out == 4'd7 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq2_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq3_go_out | fsm_out == 4'd3 & 1'b1 & ~signal_reg_out & wrapper_early_reset_static_seq4_go_out ? 1'd1 :
 signal_reg_out ? 1'd0 : 1'd0;
assign wrapper_early_reset_bb0_800_done_in = signal_reg_out;
assign early_reset_static_seq4_done_in = ud8_out;
assign early_reset_bb0_200_go_in = wrapper_early_reset_bb0_200_go_out;
assign wrapper_early_reset_static_seq2_done_in = signal_reg_out;
assign muli_6_reg_write_en = invoke4_go_out | fsm_out == 4'd3 & early_reset_static_seq_go_out | fsm_out == 4'd3 & early_reset_static_seq0_go_out | fsm_out == 4'd3 & early_reset_static_seq1_go_out | fsm_out == 4'd7 & early_reset_static_seq2_go_out | fsm_out == 4'd3 & early_reset_static_seq3_go_out | fsm_out == 4'd3 & early_reset_static_seq4_go_out;
assign muli_6_reg_clk = clk;
assign muli_6_reg_reset = reset;
assign muli_6_reg_in =
 invoke4_go_out ? arg_mem_2_read_data :
 fsm_out == 4'd3 & early_reset_static_seq_go_out | fsm_out == 4'd3 & early_reset_static_seq0_go_out | fsm_out == 4'd3 & early_reset_static_seq1_go_out | fsm_out == 4'd7 & early_reset_static_seq2_go_out | fsm_out == 4'd3 & early_reset_static_seq3_go_out | fsm_out == 4'd3 & early_reset_static_seq4_go_out ? std_mult_pipe_6_out : 'x;
assign early_reset_static_seq_done_in = ud1_out;
assign early_reset_bb0_000_done_in = ud10_out;
assign wrapper_early_reset_bb0_000_done_in = signal_reg_out;
assign while_0_arg1_reg_write_en = assign_while_0_latch_go_out | fsm_out == 4'd4 & early_reset_static_seq0_go_out;
assign while_0_arg1_reg_clk = clk;
assign while_0_arg1_reg_reset = reset;
assign while_0_arg1_reg_in =
 assign_while_0_latch_go_out ? std_add_6_out :
 fsm_out == 4'd4 & early_reset_static_seq0_go_out ? muli_6_reg_out : 'x;
assign bb0_21_done_in = arg_mem_2_done;
assign invoke4_done_in = muli_6_reg_done;
assign early_reset_bb0_800_done_in = ud7_out;
assign wrapper_early_reset_static_seq3_done_in = signal_reg_out;
assign invoke1_done_in = while_1_arg0_reg_done;
assign early_reset_static_seq0_done_in = ud2_out;
assign early_reset_bb0_800_go_in = wrapper_early_reset_bb0_800_go_out;
assign wrapper_early_reset_static_seq0_done_in = signal_reg_out;
// COMPONENT END: gemm
endmodule
