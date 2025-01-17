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
  input logic gemm_instance_done,
  output logic s0_out,
  output logic s1_out,
  output logic s2_out,
  output logic s3_out
);

  localparam logic[1:0] S0 = 2'd0;
  localparam logic[1:0] S1 = 2'd1;
  localparam logic[1:0] S2 = 2'd2;
  localparam logic[1:0] S3 = 2'd3;

  logic [1:0] current_state;
  logic [1:0] next_state;

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
          s0_out = 1'b1;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          if (fsm_start_out) begin
            next_state = S1;
          end
          else begin
            next_state = S0;
          end
        end
        S1: begin
          s0_out = 1'b0;
          s1_out = 1'b1;
          s2_out = 1'b0;
          s3_out = 1'b0;
          if (gemm_instance_done) begin
            next_state = S2;
          end
          else begin
            next_state = S1;
          end
        end
        S2: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b1;
          s3_out = 1'b0;
          if (gemm_instance_done) begin
            next_state = S3;
          end
          else begin
            next_state = S2;
          end
        end
        S3: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b1;
          next_state = S0;
        end
      default begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          next_state = S0;
      end
    endcase
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
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
  assign mem_0_write_data = 'd0;
  assign mem_1_write_data = 'd0;
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
  .s0_out(fsm_s0_out),
  .s1_out(fsm_s1_out),
  .s2_out(fsm_s2_out),
  .s3_out(fsm_s3_out),
  .fsm_start_out(fsm_start_out),
  .gemm_instance_done(gemm_instance_done),
);
assign gemm_instance_go =
         fsm_s1_out ? 1'd1 :
         fsm_s2_out ? 1'd1 :
         1'd0;
assign gemm_instance_reset =
         fsm_s1_out ? 1'd1 :
         1'd0;
assign gemm_instance_arg_mem_1_done =
         fsm_s2_out ? mem_1_done :
         1'd0;
assign gemm_instance_arg_mem_0_read_data =
         fsm_s2_out ? mem_0_read_data :
         32'd0;
assign mem_2_write_data =
         fsm_s2_out ? gemm_instance_arg_mem_2_write_data :
         'x;
assign mem_1_write_en =
         fsm_s2_out ? gemm_instance_arg_mem_1_write_en :
         1'd0;
assign mem_1_content_en =
         fsm_s2_out ? gemm_instance_arg_mem_1_content_en :
         1'd0;
assign mem_0_content_en =
         fsm_s2_out ? gemm_instance_arg_mem_0_content_en :
         1'd0;
assign gemm_instance_arg_mem_1_read_data =
         fsm_s2_out ? mem_1_read_data :
         32'd0;
assign gemm_instance_arg_mem_2_done =
         fsm_s2_out ? mem_2_done :
         1'd0;
assign gemm_instance_in1 =
         fsm_s2_out ? in1 :
         32'd0;
assign gemm_instance_arg_mem_0_done =
         fsm_s2_out ? mem_0_done :
         1'd0;
assign gemm_instance_in0 =
         fsm_s2_out ? in0 :
         32'd0;
assign mem_2_addr0 =
         fsm_s2_out ? gemm_instance_arg_mem_2_addr0 :
         'x;
assign mem_0_write_en =
         fsm_s2_out ? gemm_instance_arg_mem_0_write_en :
         1'd0;
assign mem_0_addr0 =
         fsm_s2_out ? gemm_instance_arg_mem_0_addr0 :
         'x;
assign gemm_instance_arg_mem_2_read_data =
         fsm_s2_out ? mem_2_read_data :
         32'd0;
assign mem_2_write_en =
         fsm_s2_out ? gemm_instance_arg_mem_2_write_en :
         1'd0;
assign mem_2_content_en =
         fsm_s2_out ? gemm_instance_arg_mem_2_content_en :
         1'd0;
assign mem_1_addr0 =
         fsm_s2_out ? gemm_instance_arg_mem_1_addr0 :
         'x;
assign fsm_done_in =
         fsm_s3_out ? 1'd1 :
         1'd0;
assign done = fsm_done_out;
assign mem_2_clk = clk;
assign mem_2_reset = reset;
assign mem_1_clk = clk;
assign mem_1_reset = reset;
assign mem_0_clk = clk;
assign mem_0_reset = reset;
assign fsm_start_in = go;
assign gemm_instance_clk = clk;
// COMPONENT END: main
endmodule

module fsm_gemm_def (
  input logic clk,
  input logic reset,
  input logic fsm_start_out,
  input logic while_2_arg0_reg_done,
  input logic comb_reg_out,
  input logic while_1_arg0_reg_done,
  input logic comb_reg0_out,
  input logic arg_mem_2_done,
  input logic muli_6_reg_done,
  input logic comb_reg1_out,
  input logic arg_mem_0_done,
  input logic arg_mem_1_done,
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
  output logic s23_out,
  output logic s24_out,
  output logic s25_out,
  output logic s26_out,
  output logic s27_out,
  output logic s28_out,
  output logic s29_out,
  output logic s30_out,
  output logic s31_out,
  output logic s32_out,
  output logic s33_out,
  output logic s34_out,
  output logic s35_out,
  output logic s36_out,
  output logic s37_out,
  output logic s38_out,
  output logic s39_out,
  output logic s40_out,
  output logic s41_out,
  output logic s42_out,
  output logic s43_out,
  output logic s44_out,
  output logic s45_out,
  output logic s46_out
);

  localparam logic[5:0] S0 = 6'd0;
  localparam logic[5:0] S1 = 6'd1;
  localparam logic[5:0] S2 = 6'd2;
  localparam logic[5:0] S3 = 6'd3;
  localparam logic[5:0] S4 = 6'd4;
  localparam logic[5:0] S5 = 6'd5;
  localparam logic[5:0] S6 = 6'd6;
  localparam logic[5:0] S7 = 6'd7;
  localparam logic[5:0] S8 = 6'd8;
  localparam logic[5:0] S9 = 6'd9;
  localparam logic[5:0] S10 = 6'd10;
  localparam logic[5:0] S11 = 6'd11;
  localparam logic[5:0] S12 = 6'd12;
  localparam logic[5:0] S13 = 6'd13;
  localparam logic[5:0] S14 = 6'd14;
  localparam logic[5:0] S15 = 6'd15;
  localparam logic[5:0] S16 = 6'd16;
  localparam logic[5:0] S17 = 6'd17;
  localparam logic[5:0] S18 = 6'd18;
  localparam logic[5:0] S19 = 6'd19;
  localparam logic[5:0] S20 = 6'd20;
  localparam logic[5:0] S21 = 6'd21;
  localparam logic[5:0] S22 = 6'd22;
  localparam logic[5:0] S23 = 6'd23;
  localparam logic[5:0] S24 = 6'd24;
  localparam logic[5:0] S25 = 6'd25;
  localparam logic[5:0] S26 = 6'd26;
  localparam logic[5:0] S27 = 6'd27;
  localparam logic[5:0] S28 = 6'd28;
  localparam logic[5:0] S29 = 6'd29;
  localparam logic[5:0] S30 = 6'd30;
  localparam logic[5:0] S31 = 6'd31;
  localparam logic[5:0] S32 = 6'd32;
  localparam logic[5:0] S33 = 6'd33;
  localparam logic[5:0] S34 = 6'd34;
  localparam logic[5:0] S35 = 6'd35;
  localparam logic[5:0] S36 = 6'd36;
  localparam logic[5:0] S37 = 6'd37;
  localparam logic[5:0] S38 = 6'd38;
  localparam logic[5:0] S39 = 6'd39;
  localparam logic[5:0] S40 = 6'd40;
  localparam logic[5:0] S41 = 6'd41;
  localparam logic[5:0] S42 = 6'd42;
  localparam logic[5:0] S43 = 6'd43;
  localparam logic[5:0] S44 = 6'd44;
  localparam logic[5:0] S45 = 6'd45;
  localparam logic[5:0] S46 = 6'd46;

  logic [5:0] current_state;
  logic [5:0] next_state;

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
          s0_out = 1'b1;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (fsm_start_out) begin
            next_state = S1;
          end
          else begin
            next_state = S0;
          end
        end
        S1: begin
          s0_out = 1'b0;
          s1_out = 1'b1;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (while_2_arg0_reg_done) begin
            next_state = S2;
          end
          else begin
            next_state = S1;
          end
        end
        S2: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b1;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (comb_reg_out) begin
            next_state = S3;
          end
          else if (~(comb_reg_out)) begin
            next_state = S46;
          end
          else begin
            next_state = S2;
          end
        end
        S3: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b1;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (while_1_arg0_reg_done) begin
            next_state = S4;
          end
          else begin
            next_state = S3;
          end
        end
        S4: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b1;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (comb_reg0_out) begin
            next_state = S5;
          end
          else if (~(comb_reg0_out)) begin
            next_state = S44;
          end
          else begin
            next_state = S4;
          end
        end
        S5: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b1;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S6;
        end
        S6: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b1;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S7;
        end
        S7: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b1;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S8;
        end
        S8: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b1;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S9;
        end
        S9: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b1;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (arg_mem_2_done) begin
            next_state = S10;
          end
          else begin
            next_state = S9;
          end
        end
        S10: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b1;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (muli_6_reg_done) begin
            next_state = S11;
          end
          else begin
            next_state = S10;
          end
        end
        S11: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b1;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S12;
        end
        S12: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b1;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S13;
        end
        S13: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b1;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S14;
        end
        S14: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b1;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S15;
        end
        S15: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b1;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S16;
        end
        S16: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b1;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (comb_reg1_out) begin
            next_state = S17;
          end
          else if (~(comb_reg1_out)) begin
            next_state = S37;
          end
          else begin
            next_state = S16;
          end
        end
        S17: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b1;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S18;
        end
        S18: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b1;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S19;
        end
        S19: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b1;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S20;
        end
        S20: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b1;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S21;
        end
        S21: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b1;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (arg_mem_0_done) begin
            next_state = S22;
          end
          else begin
            next_state = S21;
          end
        end
        S22: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b1;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S23;
        end
        S23: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b1;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S24;
        end
        S24: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b1;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S25;
        end
        S25: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b1;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S26;
        end
        S26: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b1;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S27;
        end
        S27: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b1;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S28;
        end
        S28: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b1;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S29;
        end
        S29: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b1;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S30;
        end
        S30: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b1;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (arg_mem_1_done) begin
            next_state = S31;
          end
          else begin
            next_state = S30;
          end
        end
        S31: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b1;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S32;
        end
        S32: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b1;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S33;
        end
        S33: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b1;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S34;
        end
        S34: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b1;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S35;
        end
        S35: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b1;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S36;
        end
        S36: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b1;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (comb_reg1_out) begin
            next_state = S17;
          end
          else if (~(comb_reg1_out)) begin
            next_state = S37;
          end
          else begin
            next_state = S36;
          end
        end
        S37: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b1;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S38;
        end
        S38: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b1;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S39;
        end
        S39: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b1;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S40;
        end
        S40: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b1;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S41;
        end
        S41: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b1;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (arg_mem_2_done) begin
            next_state = S42;
          end
          else begin
            next_state = S41;
          end
        end
        S42: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b1;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (while_1_arg0_reg_done) begin
            next_state = S43;
          end
          else begin
            next_state = S42;
          end
        end
        S43: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b1;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (comb_reg0_out) begin
            next_state = S5;
          end
          else if (~(comb_reg0_out)) begin
            next_state = S44;
          end
          else begin
            next_state = S43;
          end
        end
        S44: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b1;
          s45_out = 1'b0;
          s46_out = 1'b0;
          if (while_2_arg0_reg_done) begin
            next_state = S45;
          end
          else begin
            next_state = S44;
          end
        end
        S45: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b1;
          s46_out = 1'b0;
          if (comb_reg_out) begin
            next_state = S3;
          end
          else if (~(comb_reg_out)) begin
            next_state = S46;
          end
          else begin
            next_state = S45;
          end
        end
        S46: begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b1;
          next_state = S0;
        end
      default begin
          s0_out = 1'b0;
          s1_out = 1'b0;
          s2_out = 1'b0;
          s3_out = 1'b0;
          s4_out = 1'b0;
          s5_out = 1'b0;
          s6_out = 1'b0;
          s7_out = 1'b0;
          s8_out = 1'b0;
          s9_out = 1'b0;
          s10_out = 1'b0;
          s11_out = 1'b0;
          s12_out = 1'b0;
          s13_out = 1'b0;
          s14_out = 1'b0;
          s15_out = 1'b0;
          s16_out = 1'b0;
          s17_out = 1'b0;
          s18_out = 1'b0;
          s19_out = 1'b0;
          s20_out = 1'b0;
          s21_out = 1'b0;
          s22_out = 1'b0;
          s23_out = 1'b0;
          s24_out = 1'b0;
          s25_out = 1'b0;
          s26_out = 1'b0;
          s27_out = 1'b0;
          s28_out = 1'b0;
          s29_out = 1'b0;
          s30_out = 1'b0;
          s31_out = 1'b0;
          s32_out = 1'b0;
          s33_out = 1'b0;
          s34_out = 1'b0;
          s35_out = 1'b0;
          s36_out = 1'b0;
          s37_out = 1'b0;
          s38_out = 1'b0;
          s39_out = 1'b0;
          s40_out = 1'b0;
          s41_out = 1'b0;
          s42_out = 1'b0;
          s43_out = 1'b0;
          s44_out = 1'b0;
          s45_out = 1'b0;
          s46_out = 1'b0;
          next_state = S0;
      end
    endcase
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
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
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
logic fsm_s30_out;
logic fsm_s31_out;
logic fsm_s32_out;
logic fsm_s33_out;
logic fsm_s34_out;
logic fsm_s35_out;
logic fsm_s36_out;
logic fsm_s37_out;
logic fsm_s38_out;
logic fsm_s39_out;
logic fsm_s40_out;
logic fsm_s41_out;
logic fsm_s42_out;
logic fsm_s43_out;
logic fsm_s44_out;
logic fsm_s45_out;
logic fsm_s46_out;
fsm_gemm_def fsm (
  .s0_out(fsm_s0_out),
  .s1_out(fsm_s1_out),
  .s2_out(fsm_s2_out),
  .s3_out(fsm_s3_out),
  .s4_out(fsm_s4_out),
  .s5_out(fsm_s5_out),
  .s6_out(fsm_s6_out),
  .s7_out(fsm_s7_out),
  .s8_out(fsm_s8_out),
  .s9_out(fsm_s9_out),
  .s10_out(fsm_s10_out),
  .s11_out(fsm_s11_out),
  .s12_out(fsm_s12_out),
  .s13_out(fsm_s13_out),
  .s14_out(fsm_s14_out),
  .s15_out(fsm_s15_out),
  .s16_out(fsm_s16_out),
  .s17_out(fsm_s17_out),
  .s18_out(fsm_s18_out),
  .s19_out(fsm_s19_out),
  .s20_out(fsm_s20_out),
  .s21_out(fsm_s21_out),
  .s22_out(fsm_s22_out),
  .s23_out(fsm_s23_out),
  .s24_out(fsm_s24_out),
  .s25_out(fsm_s25_out),
  .s26_out(fsm_s26_out),
  .s27_out(fsm_s27_out),
  .s28_out(fsm_s28_out),
  .s29_out(fsm_s29_out),
  .s30_out(fsm_s30_out),
  .s31_out(fsm_s31_out),
  .s32_out(fsm_s32_out),
  .s33_out(fsm_s33_out),
  .s34_out(fsm_s34_out),
  .s35_out(fsm_s35_out),
  .s36_out(fsm_s36_out),
  .s37_out(fsm_s37_out),
  .s38_out(fsm_s38_out),
  .s39_out(fsm_s39_out),
  .s40_out(fsm_s40_out),
  .s41_out(fsm_s41_out),
  .s42_out(fsm_s42_out),
  .s43_out(fsm_s43_out),
  .s44_out(fsm_s44_out),
  .s45_out(fsm_s45_out),
  .s46_out(fsm_s46_out),
  .fsm_start_out(fsm_start_out),
  .while_2_arg0_reg_done(while_2_arg0_reg_done),
  .comb_reg_out(comb_reg_out),
  .while_1_arg0_reg_done(while_1_arg0_reg_done),
  .comb_reg0_out(comb_reg0_out),
  .arg_mem_2_done(arg_mem_2_done),
  .muli_6_reg_done(muli_6_reg_done),
  .comb_reg1_out(comb_reg1_out),
  .arg_mem_0_done(arg_mem_0_done),
  .arg_mem_1_done(arg_mem_1_done),
);
assign while_2_arg0_reg_in =
         fsm_s1_out ? 32'd0 :
         fsm_s44_out ? std_add_6_out :
         'x;
assign while_2_arg0_reg_write_en =
         fsm_s1_out ? 1'd1 :
         fsm_s44_out ? 1'd1 :
         1'd0;
assign std_slt_2_left =
         fsm_s2_out ? while_2_arg0_reg_out :
         fsm_s4_out ? while_1_arg0_reg_out :
         fsm_s16_out ? while_0_arg0_reg_out :
         fsm_s36_out ? while_0_arg0_reg_out :
         fsm_s43_out ? while_1_arg0_reg_out :
         fsm_s45_out ? while_2_arg0_reg_out :
         32'd0;
assign std_slt_2_right =
         fsm_s2_out ? 32'd20 :
         fsm_s4_out ? 32'd20 :
         fsm_s16_out ? 32'd20 :
         fsm_s36_out ? 32'd20 :
         fsm_s43_out ? 32'd20 :
         fsm_s45_out ? 32'd20 :
         32'd0;
assign comb_reg_write_en =
         fsm_s2_out ? 1'd1 :
         fsm_s45_out ? 1'd1 :
         1'd0;
assign comb_reg_in =
         fsm_s2_out ? std_slt_2_out :
         fsm_s45_out ? std_slt_2_out :
         1'd0;
assign while_1_arg0_reg_write_en =
         fsm_s3_out ? 1'd1 :
         fsm_s42_out ? 1'd1 :
         1'd0;
assign while_1_arg0_reg_in =
         fsm_s3_out ? 32'd0 :
         fsm_s42_out ? std_add_6_out :
         'x;
assign comb_reg0_write_en =
         fsm_s4_out ? 1'd1 :
         fsm_s43_out ? 1'd1 :
         1'd0;
assign comb_reg0_in =
         fsm_s4_out ? std_slt_2_out :
         fsm_s43_out ? std_slt_2_out :
         1'd0;
assign std_mult_pipe_6_go =
         fsm_s5_out ? 1'd1 :
         fsm_s6_out ? 1'd1 :
         fsm_s7_out ? 1'd1 :
         fsm_s11_out ? 1'd1 :
         fsm_s12_out ? 1'd1 :
         fsm_s13_out ? 1'd1 :
         fsm_s17_out ? 1'd1 :
         fsm_s18_out ? 1'd1 :
         fsm_s19_out ? 1'd1 :
         fsm_s22_out ? 1'd1 :
         fsm_s31_out ? 1'd1 :
         fsm_s32_out ? 1'd1 :
         fsm_s33_out ? 1'd1 :
         fsm_s37_out ? 1'd1 :
         fsm_s38_out ? 1'd1 :
         fsm_s39_out ? 1'd1 :
         1'd0;
assign std_mult_pipe_6_right =
         fsm_s5_out ? 32'd30 :
         fsm_s6_out ? 32'd30 :
         fsm_s7_out ? 32'd30 :
         fsm_s11_out ? in1 :
         fsm_s12_out ? in1 :
         fsm_s13_out ? in1 :
         fsm_s17_out ? 32'd30 :
         fsm_s18_out ? 32'd30 :
         fsm_s19_out ? 32'd30 :
         fsm_s22_out ? arg_mem_0_read_data :
         fsm_s23_out ? arg_mem_0_read_data :
         fsm_s24_out ? arg_mem_0_read_data :
         fsm_s26_out ? 32'd30 :
         fsm_s27_out ? 32'd30 :
         fsm_s28_out ? 32'd30 :
         fsm_s31_out ? arg_mem_1_read_data :
         fsm_s32_out ? arg_mem_1_read_data :
         fsm_s33_out ? arg_mem_1_read_data :
         fsm_s37_out ? 32'd30 :
         fsm_s38_out ? 32'd30 :
         fsm_s39_out ? 32'd30 :
         'x;
assign std_mult_pipe_6_left =
         fsm_s5_out ? while_2_arg0_reg_out :
         fsm_s6_out ? while_2_arg0_reg_out :
         fsm_s7_out ? while_2_arg0_reg_out :
         fsm_s11_out ? muli_6_reg_out :
         fsm_s12_out ? muli_6_reg_out :
         fsm_s13_out ? muli_6_reg_out :
         fsm_s17_out ? while_2_arg0_reg_out :
         fsm_s18_out ? while_2_arg0_reg_out :
         fsm_s19_out ? while_2_arg0_reg_out :
         fsm_s22_out ? in0 :
         fsm_s23_out ? in0 :
         fsm_s24_out ? in0 :
         fsm_s26_out ? while_0_arg0_reg_out :
         fsm_s27_out ? while_0_arg0_reg_out :
         fsm_s28_out ? while_0_arg0_reg_out :
         fsm_s31_out ? muli_3_reg_out :
         fsm_s32_out ? muli_3_reg_out :
         fsm_s33_out ? muli_3_reg_out :
         fsm_s37_out ? while_2_arg0_reg_out :
         fsm_s38_out ? while_2_arg0_reg_out :
         fsm_s39_out ? while_2_arg0_reg_out :
         'x;
assign muli_6_reg_in =
         fsm_s8_out ? std_mult_pipe_6_out :
         fsm_s10_out ? arg_mem_2_read_data :
         fsm_s14_out ? std_mult_pipe_6_out :
         fsm_s20_out ? std_mult_pipe_6_out :
         fsm_s29_out ? std_mult_pipe_6_out :
         fsm_s34_out ? std_mult_pipe_6_out :
         fsm_s40_out ? std_mult_pipe_6_out :
         'x;
assign muli_6_reg_write_en =
         fsm_s8_out ? 1'd1 :
         fsm_s10_out ? 1'd1 :
         fsm_s14_out ? 1'd1 :
         fsm_s20_out ? 1'd1 :
         fsm_s29_out ? 1'd1 :
         fsm_s34_out ? 1'd1 :
         fsm_s40_out ? 1'd1 :
         1'd0;
assign arg_mem_2_addr0 =
         fsm_s9_out ? std_slice_3_out :
         fsm_s41_out ? std_slice_3_out :
         'x;
assign std_add_6_right =
         fsm_s9_out ? while_1_arg0_reg_out :
         fsm_s21_out ? while_0_arg0_reg_out :
         fsm_s30_out ? while_1_arg0_reg_out :
         fsm_s35_out ? muli_6_reg_out :
         fsm_s41_out ? while_1_arg0_reg_out :
         fsm_s42_out ? 32'd1 :
         fsm_s44_out ? 32'd1 :
         'x;
assign std_slice_3_in =
         fsm_s9_out ? std_add_6_out :
         fsm_s21_out ? std_add_6_out :
         fsm_s30_out ? std_add_6_out :
         fsm_s41_out ? std_add_6_out :
         'x;
assign arg_mem_2_content_en =
         fsm_s9_out ? 1'd1 :
         fsm_s41_out ? 1'd1 :
         1'd0;
assign std_add_6_left =
         fsm_s9_out ? muli_6_reg_out :
         fsm_s21_out ? muli_6_reg_out :
         fsm_s30_out ? muli_6_reg_out :
         fsm_s35_out ? while_0_arg1_reg_out :
         fsm_s41_out ? muli_6_reg_out :
         fsm_s42_out ? while_1_arg0_reg_out :
         fsm_s44_out ? while_2_arg0_reg_out :
         'x;
assign arg_mem_2_write_en =
         fsm_s9_out ? 1'd0 :
         fsm_s41_out ? 1'd1 :
         1'd0;
assign while_0_arg1_reg_in =
         fsm_s15_out ? muli_6_reg_out :
         fsm_s35_out ? std_add_6_out :
         'x;
assign while_0_arg0_reg_in =
         fsm_s15_out ? 32'd0 :
         fsm_s35_out ? std_add_3_out :
         'x;
assign while_0_arg0_reg_write_en =
         fsm_s15_out ? 1'd1 :
         fsm_s35_out ? 1'd1 :
         1'd0;
assign while_0_arg1_reg_write_en =
         fsm_s15_out ? 1'd1 :
         fsm_s35_out ? 1'd1 :
         1'd0;
assign comb_reg1_in =
         fsm_s16_out ? std_slt_2_out :
         fsm_s36_out ? std_slt_2_out :
         1'd0;
assign comb_reg1_write_en =
         fsm_s16_out ? 1'd1 :
         fsm_s36_out ? 1'd1 :
         1'd0;
assign arg_mem_0_content_en =
         fsm_s21_out ? 1'd1 :
         1'd0;
assign arg_mem_0_addr0 =
         fsm_s21_out ? std_slice_3_out :
         'x;
assign arg_mem_0_write_en =
         fsm_s21_out ? 1'd0 :
         1'd0;
assign muli_3_reg_write_en =
         fsm_s25_out ? 1'd1 :
         1'd0;
assign muli_3_reg_in =
         fsm_s25_out ? std_mult_pipe_6_out :
         'x;
assign arg_mem_1_write_en =
         fsm_s30_out ? 1'd0 :
         1'd0;
assign arg_mem_1_addr0 =
         fsm_s30_out ? std_slice_3_out :
         'x;
assign arg_mem_1_content_en =
         fsm_s30_out ? 1'd1 :
         1'd0;
assign std_add_3_right =
         fsm_s35_out ? 32'd1 :
         'x;
assign std_add_3_left =
         fsm_s35_out ? while_0_arg0_reg_out :
         'x;
assign arg_mem_2_write_data =
         fsm_s41_out ? while_0_arg1_reg_out :
         'x;
assign fsm_done_in =
         fsm_s46_out ? 1'd1 :
         1'd0;
assign done = fsm_done_out;
assign muli_3_reg_clk = clk;
assign muli_3_reg_reset = reset;
assign while_1_arg0_reg_clk = clk;
assign while_1_arg0_reg_reset = reset;
assign comb_reg_clk = clk;
assign comb_reg_reset = reset;
assign std_mult_pipe_6_clk = clk;
assign std_mult_pipe_6_reset = reset;
assign while_0_arg0_reg_clk = clk;
assign while_0_arg0_reg_reset = reset;
assign comb_reg1_clk = clk;
assign comb_reg1_reset = reset;
assign comb_reg0_clk = clk;
assign comb_reg0_reset = reset;
assign while_2_arg0_reg_clk = clk;
assign while_2_arg0_reg_reset = reset;
assign muli_6_reg_clk = clk;
assign muli_6_reg_reset = reset;
assign while_0_arg1_reg_clk = clk;
assign while_0_arg1_reg_reset = reset;
assign fsm_start_in = go;
  assign arg_mem_0_write_data ='d0;
  assign arg_mem_1_write_data ='d0;
// COMPONENT END: gemm
endmodule
