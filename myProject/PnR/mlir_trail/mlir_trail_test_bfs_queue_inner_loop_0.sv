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
   (* keep *)output logic [ WIDTH-1:0] read_data,

   // Write signals
   (* keep *)input wire logic [ WIDTH-1:0] write_data,
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
  input logic [63:0] in1,
  input logic [31:0] in2,
  (* clk=1 *) input logic clk,
  (* reset=1 *) input logic reset,
  (* go=1 *) input logic go,
  (* done=1 *) output logic done
);
// COMPONENT START: main
logic mem_3_clk;
logic mem_3_reset;
logic [7:0] mem_3_addr0;
logic mem_3_content_en;
logic mem_3_write_en;
logic [63:0] mem_3_write_data;
logic [63:0] mem_3_read_data;
logic mem_3_done;
logic mem_2_clk;
logic mem_2_reset;
logic [3:0] mem_2_addr0;
logic mem_2_content_en;
logic mem_2_write_en;
logic [63:0] mem_2_write_data;
logic [63:0] mem_2_read_data;
logic mem_2_done;
logic mem_1_clk;
logic mem_1_reset;
logic [7:0] mem_1_addr0;
logic mem_1_content_en;
logic mem_1_write_en;
logic [7:0] mem_1_write_data;
logic [7:0] mem_1_read_data;
logic mem_1_done;
logic mem_0_clk;
logic mem_0_reset;
logic [11:0] mem_0_addr0;
logic mem_0_content_en;
logic mem_0_write_en;
logic [63:0] mem_0_write_data;
logic [63:0] mem_0_read_data;
logic mem_0_done;
logic [31:0] bfs_queue_inner_loop_0_instance_in0;
logic [63:0] bfs_queue_inner_loop_0_instance_in1;
logic [31:0] bfs_queue_inner_loop_0_instance_in4;
logic bfs_queue_inner_loop_0_instance_clk;
logic bfs_queue_inner_loop_0_instance_reset;
logic bfs_queue_inner_loop_0_instance_go;
logic [63:0] bfs_queue_inner_loop_0_instance_out0;
logic bfs_queue_inner_loop_0_instance_done;
logic [63:0] bfs_queue_inner_loop_0_instance_arg_mem_0_read_data;
logic bfs_queue_inner_loop_0_instance_arg_mem_0_done;
logic [7:0] bfs_queue_inner_loop_0_instance_arg_mem_1_write_data;
logic [63:0] bfs_queue_inner_loop_0_instance_arg_mem_3_read_data;
logic [63:0] bfs_queue_inner_loop_0_instance_arg_mem_2_read_data;
logic [7:0] bfs_queue_inner_loop_0_instance_arg_mem_3_addr0;
logic [63:0] bfs_queue_inner_loop_0_instance_arg_mem_3_write_data;
logic [7:0] bfs_queue_inner_loop_0_instance_arg_mem_1_read_data;
logic bfs_queue_inner_loop_0_instance_arg_mem_0_content_en;
logic [11:0] bfs_queue_inner_loop_0_instance_arg_mem_0_addr0;
logic bfs_queue_inner_loop_0_instance_arg_mem_3_content_en;
logic bfs_queue_inner_loop_0_instance_arg_mem_3_done;
logic bfs_queue_inner_loop_0_instance_arg_mem_0_write_en;
logic bfs_queue_inner_loop_0_instance_arg_mem_3_write_en;
logic [3:0] bfs_queue_inner_loop_0_instance_arg_mem_2_addr0;
logic bfs_queue_inner_loop_0_instance_arg_mem_2_done;
logic bfs_queue_inner_loop_0_instance_arg_mem_1_done;
logic bfs_queue_inner_loop_0_instance_arg_mem_2_content_en;
logic [63:0] bfs_queue_inner_loop_0_instance_arg_mem_0_write_data;
logic bfs_queue_inner_loop_0_instance_arg_mem_1_write_en;
logic bfs_queue_inner_loop_0_instance_arg_mem_2_write_en;
logic [63:0] bfs_queue_inner_loop_0_instance_arg_mem_2_write_data;
logic [7:0] bfs_queue_inner_loop_0_instance_arg_mem_1_addr0;
logic bfs_queue_inner_loop_0_instance_arg_mem_1_content_en;
logic invoke0_go_in;
logic invoke0_go_out;
logic invoke0_done_in;
logic invoke0_done_out;
(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(8),
    .SIZE(256),
    .WIDTH(64)
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

(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(4),
    .SIZE(10),
    .WIDTH(64)
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

(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(8),
    .SIZE(256),
    .WIDTH(8)
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

(* external=1, data=1 *)
seq_mem_d1 # (
    .IDX_SIZE(12),
    .SIZE(4096),
    .WIDTH(64)
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

(* data=1 *)
bfs_queue_inner_loop_0 bfs_queue_inner_loop_0_instance (
    .arg_mem_0_addr0(bfs_queue_inner_loop_0_instance_arg_mem_0_addr0),
    .arg_mem_0_content_en(bfs_queue_inner_loop_0_instance_arg_mem_0_content_en),
    .arg_mem_0_done(bfs_queue_inner_loop_0_instance_arg_mem_0_done),
    .arg_mem_0_read_data(bfs_queue_inner_loop_0_instance_arg_mem_0_read_data),
    .arg_mem_0_write_data(bfs_queue_inner_loop_0_instance_arg_mem_0_write_data),
    .arg_mem_0_write_en(bfs_queue_inner_loop_0_instance_arg_mem_0_write_en),
    .arg_mem_1_addr0(bfs_queue_inner_loop_0_instance_arg_mem_1_addr0),
    .arg_mem_1_content_en(bfs_queue_inner_loop_0_instance_arg_mem_1_content_en),
    .arg_mem_1_done(bfs_queue_inner_loop_0_instance_arg_mem_1_done),
    .arg_mem_1_read_data(bfs_queue_inner_loop_0_instance_arg_mem_1_read_data),
    .arg_mem_1_write_data(bfs_queue_inner_loop_0_instance_arg_mem_1_write_data),
    .arg_mem_1_write_en(bfs_queue_inner_loop_0_instance_arg_mem_1_write_en),
    .arg_mem_2_addr0(bfs_queue_inner_loop_0_instance_arg_mem_2_addr0),
    .arg_mem_2_content_en(bfs_queue_inner_loop_0_instance_arg_mem_2_content_en),
    .arg_mem_2_done(bfs_queue_inner_loop_0_instance_arg_mem_2_done),
    .arg_mem_2_read_data(bfs_queue_inner_loop_0_instance_arg_mem_2_read_data),
    .arg_mem_2_write_data(bfs_queue_inner_loop_0_instance_arg_mem_2_write_data),
    .arg_mem_2_write_en(bfs_queue_inner_loop_0_instance_arg_mem_2_write_en),
    .arg_mem_3_addr0(bfs_queue_inner_loop_0_instance_arg_mem_3_addr0),
    .arg_mem_3_content_en(bfs_queue_inner_loop_0_instance_arg_mem_3_content_en),
    .arg_mem_3_done(bfs_queue_inner_loop_0_instance_arg_mem_3_done),
    .arg_mem_3_read_data(bfs_queue_inner_loop_0_instance_arg_mem_3_read_data),
    .arg_mem_3_write_data(bfs_queue_inner_loop_0_instance_arg_mem_3_write_data),
    .arg_mem_3_write_en(bfs_queue_inner_loop_0_instance_arg_mem_3_write_en),
    .clk(bfs_queue_inner_loop_0_instance_clk),
    .done(bfs_queue_inner_loop_0_instance_done),
    .go(bfs_queue_inner_loop_0_instance_go),
    .in0(bfs_queue_inner_loop_0_instance_in0),
    .in1(bfs_queue_inner_loop_0_instance_in1),
    .in4(bfs_queue_inner_loop_0_instance_in4),
    .out0(bfs_queue_inner_loop_0_instance_out0),
    .reset(bfs_queue_inner_loop_0_instance_reset)
);

assign invoke0_go_out = invoke0_go_in;
assign invoke0_done_out = invoke0_done_in;
assign bfs_queue_inner_loop_0_instance_arg_mem_0_read_data =
 invoke0_go_out ? mem_0_read_data : 64'd0;
assign bfs_queue_inner_loop_0_instance_arg_mem_0_done =
 invoke0_go_out ? mem_0_done : 1'd0;
assign bfs_queue_inner_loop_0_instance_arg_mem_2_read_data =
 invoke0_go_out ? mem_2_read_data : 64'd0;
assign bfs_queue_inner_loop_0_instance_in1 =
 invoke0_go_out ? in1 : 64'd0;
assign bfs_queue_inner_loop_0_instance_arg_mem_1_read_data =
 invoke0_go_out ? mem_1_read_data : 8'd0;
assign bfs_queue_inner_loop_0_instance_clk = clk;
assign bfs_queue_inner_loop_0_instance_in4 =
 invoke0_go_out ? in2 : 32'd0;
assign bfs_queue_inner_loop_0_instance_arg_mem_3_done =
 invoke0_go_out ? mem_3_done : 1'd0;
assign bfs_queue_inner_loop_0_instance_reset = reset;
assign bfs_queue_inner_loop_0_instance_go = invoke0_go_out;
assign bfs_queue_inner_loop_0_instance_arg_mem_2_done =
 invoke0_go_out ? mem_2_done : 1'd0;
assign bfs_queue_inner_loop_0_instance_arg_mem_1_done =
 invoke0_go_out ? mem_1_done : 1'd0;
assign bfs_queue_inner_loop_0_instance_in0 =
 invoke0_go_out ? in0 : 32'd0;
assign done = invoke0_done_out;
assign mem_2_write_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_2_write_en : 1'd0;
assign mem_2_clk = clk;
assign mem_2_addr0 = bfs_queue_inner_loop_0_instance_arg_mem_2_addr0;
assign mem_2_content_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_2_content_en : 1'd0;
assign mem_2_reset = reset;
assign mem_2_write_data = bfs_queue_inner_loop_0_instance_arg_mem_2_write_data;
assign invoke0_go_in = go;
assign mem_1_write_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_1_write_en : 1'd0;
assign mem_1_clk = clk;
assign mem_1_addr0 = bfs_queue_inner_loop_0_instance_arg_mem_1_addr0;
assign mem_1_content_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_1_content_en : 1'd0;
assign mem_1_reset = reset;
assign mem_1_write_data = bfs_queue_inner_loop_0_instance_arg_mem_1_write_data;
assign invoke0_done_in = bfs_queue_inner_loop_0_instance_done;
assign mem_0_write_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_0_write_en : 1'd0;
assign mem_0_clk = clk;
assign mem_0_addr0 = bfs_queue_inner_loop_0_instance_arg_mem_0_addr0;
assign mem_0_content_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_0_content_en : 1'd0;
assign mem_0_reset = reset;
assign mem_3_write_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_3_write_en : 1'd0;
assign mem_3_clk = clk;
assign mem_3_addr0 = bfs_queue_inner_loop_0_instance_arg_mem_3_addr0;
assign mem_3_content_en =
 invoke0_go_out ? bfs_queue_inner_loop_0_instance_arg_mem_3_content_en : 1'd0;
assign mem_3_reset = reset;
assign mem_3_write_data = bfs_queue_inner_loop_0_instance_arg_mem_3_write_data;
// COMPONENT END: main
endmodule

module fsm_bfs_queue_inner_loop_0_def (
  input logic clk,
  input logic reset,
  output logic [0:0] fsm__this_arg_mem_0_write_en_in,
  output logic [0:0] fsm__this_arg_mem_0_content_en_in,
  output logic [31:0] fsm_std_slice_9_in_in,
  output logic [11:0] fsm__this_arg_mem_0_addr0_in,
  output logic [0:0] fsm__this_arg_mem_1_write_en_in,
  output logic [31:0] fsm_std_slice_8_in_in,
  output logic [7:0] fsm__this_arg_mem_1_addr0_in,
  output logic [63:0] fsm_std_slice_0_in_in,
  output logic [0:0] fsm__this_arg_mem_1_content_en_in,
  output logic [7:0] fsm_load_0_reg_in_in,
  output logic [0:0] fsm_load_0_reg_write_en_in,
  output logic [7:0] fsm_std_signext_0_in_in,
  output logic [31:0] fsm_std_eq_0_left_in,
  output logic [0:0] fsm_comb_wire_in_in,
  output logic [31:0] fsm_std_eq_0_right_in,
  output logic [31:0] fsm_std_slice_7_in_in,
  output logic [7:0] fsm_load_1_reg_in_in,
  output logic [0:0] fsm_load_1_reg_write_en_in,
  output logic [31:0] fsm_std_add_0_right_in,
  output logic [7:0] fsm__this_arg_mem_1_write_data_in,
  output logic [31:0] fsm_std_slice_6_in_in,
  output logic [31:0] fsm_std_add_0_left_in,
  output logic [7:0] fsm_std_signext_1_in_in,
  output logic [31:0] fsm_std_slice_1_in_in,
  output logic [0:0] fsm__this_arg_mem_2_content_en_in,
  output logic [7:0] fsm_std_pad_0_in_in,
  output logic [0:0] fsm__this_arg_mem_2_write_en_in,
  output logic [3:0] fsm__this_arg_mem_2_addr0_in,
  output logic [31:0] fsm_std_slice_5_in_in,
  output logic [0:0] fsm_load_2_reg_write_en_in,
  output logic [63:0] fsm_load_2_reg_in_in,
  output logic [63:0] fsm__this_arg_mem_2_write_data_in,
  output logic [63:0] fsm_std_add_1_left_in,
  output logic [63:0] fsm_std_add_1_right_in,
  output logic [31:0] fsm_std_slice_4_in_in,
  output logic [0:0] fsm_comb_wire0_in_in,
  output logic [63:0] fsm_std_eq_1_left_in,
  output logic [63:0] fsm_std_eq_1_right_in,
  output logic [0:0] fsm_if_res_0_reg_write_en_in,
  output logic [63:0] fsm_std_add_2_left_in,
  output logic [63:0] fsm_if_res_0_reg_in_in,
  output logic [63:0] fsm_std_add_2_right_in,
  output logic [63:0] fsm__this_arg_mem_3_write_data_in,
  output logic [63:0] fsm_std_slice_2_in_in,
  output logic [0:0] fsm__this_arg_mem_3_content_en_in,
  output logic [7:0] fsm__this_arg_mem_3_addr0_in,
  output logic [0:0] fsm__this_arg_mem_3_write_en_in,
  output logic [31:0] fsm_std_slice_3_in_in,
  output logic [0:0] fsm_std_rems_pipe_0_go_in,
  output logic [63:0] fsm_std_add_3_left_in,
  output logic [63:0] fsm_remsi_0_reg_in_in,
  output logic [63:0] fsm_std_rems_pipe_0_left_in,
  output logic [63:0] fsm_std_rems_pipe_0_right_in,
  output logic [63:0] fsm_std_add_3_right_in,
  output logic [0:0] fsm_remsi_0_reg_write_en_in,
  output logic [63:0] fsm_if_res_1_reg_in_in,
  output logic [0:0] fsm_if_res_1_reg_write_en_in,
  output logic [0:0] fsm_ret_arg0_reg_write_en_in,
  output logic [63:0] fsm_ret_arg0_reg_in_in,
  output logic [0:0] fsm_done_in,
  input logic [31:0] in0,
  input logic [0:0] arg_mem_0_done,
  input logic [11:0] std_slice_9_out,
  input logic [7:0] std_slice_8_out,
  input logic [0:0] arg_mem_1_done,
  input logic [31:0] std_slice_0_out,
  input logic [63:0] arg_mem_0_read_data,
  input logic [7:0] arg_mem_1_read_data,
  input logic [0:0] load_0_reg_done,
  input logic [31:0] std_signext_0_out,
  input logic [7:0] load_0_reg_out,
  input logic [0:0] std_eq_0_out,
  input logic [7:0] std_slice_7_out,
  input logic [31:0] in4,
  input logic [0:0] load_1_reg_done,
  input logic [7:0] std_slice_6_out,
  input logic [7:0] std_slice_1_out,
  input logic [31:0] std_add_0_out,
  input logic [31:0] std_signext_1_out,
  input logic [7:0] load_1_reg_out,
  input logic [3:0] std_slice_5_out,
  input logic [0:0] arg_mem_2_done,
  input logic [31:0] std_pad_0_out,
  input logic [63:0] arg_mem_2_read_data,
  input logic [0:0] load_2_reg_done,
  input logic [3:0] std_slice_4_out,
  input logic [63:0] std_add_1_out,
  input logic [63:0] load_2_reg_out,
  input logic [63:0] in1,
  input logic [0:0] std_eq_1_out,
  input logic [63:0] std_add_2_out,
  input logic [0:0] comb_wire0_out,
  input logic [31:0] std_slice_2_out,
  input logic [0:0] arg_mem_3_done,
  input logic [7:0] std_slice_3_out,
  input logic [63:0] if_res_0_reg_out,
  input logic [63:0] std_add_3_out,
  input logic [0:0] remsi_0_reg_done,
  input logic [63:0] std_rems_pipe_0_out_remainder,
  input logic [0:0] std_rems_pipe_0_done,
  input logic [63:0] remsi_0_reg_out,
  input logic [0:0] if_res_1_reg_done,
  input logic [63:0] if_res_1_reg_out,
  input logic [0:0] ret_arg0_reg_done,
  input logic [0:0] fsm_start_out,
  input logic [0:0] comb_wire_out
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
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (fsm_start_out) begin
            next_state = S1;
          end
          else begin
            next_state = S0;
          end
        end
        S1: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (arg_mem_0_done) begin
            next_state = S2;
          end
          else begin
            next_state = S1;
          end
        end
        S2: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (arg_mem_1_done) begin
            next_state = S3;
          end
          else begin
            next_state = S2;
          end
        end
        S3: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 1'd1;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (load_0_reg_done) begin
            next_state = S4;
          end
          else begin
            next_state = S3;
          end
        end
        S4: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (comb_wire_out) begin
            next_state = S5;
          end
          else if (~(comb_wire_out)) begin
            next_state = S16;
          end
          else begin
            next_state = S4;
          end
        end
        S5: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (arg_mem_1_done) begin
            next_state = S6;
          end
          else begin
            next_state = S5;
          end
        end
        S6: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 1'd1;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (load_1_reg_done) begin
            next_state = S7;
          end
          else begin
            next_state = S6;
          end
        end
        S7: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (arg_mem_1_done) begin
            next_state = S8;
          end
          else begin
            next_state = S7;
          end
        end
        S8: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (arg_mem_2_done) begin
            next_state = S9;
          end
          else begin
            next_state = S8;
          end
        end
        S9: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 1'd1;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (load_2_reg_done) begin
            next_state = S10;
          end
          else begin
            next_state = S9;
          end
        end
        S10: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (arg_mem_2_done) begin
            next_state = S11;
          end
          else begin
            next_state = S10;
          end
        end
        S11: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          next_state = S12;
        end
        S12: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 1'd1;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          next_state = S13;
        end
        S13: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (arg_mem_3_done) begin
            next_state = S14;
          end
          else begin
            next_state = S13;
          end
        end
        S14: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = std_rems_pipe_0_done;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 1'd1;
          if (remsi_0_reg_done) begin
            next_state = S15;
          end
          else begin
            next_state = S14;
          end
        end
        S15: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 1'd1;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (if_res_1_reg_done) begin
            next_state = S17;
          end
          else begin
            next_state = S15;
          end
        end
        S16: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 1'd1;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (if_res_1_reg_done) begin
            next_state = S17;
          end
          else begin
            next_state = S16;
          end
        end
        S17: begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 1'd1;
          fsm_std_rems_pipe_0_go_in = 'b0;
          if (ret_arg0_reg_done) begin
            next_state = S18;
          end
          else begin
            next_state = S17;
          end
        end
        S18: begin
          fsm_done_in = 1'd1;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          next_state = S0;
        end
      default begin
          fsm_done_in = 'b0;
          fsm_if_res_0_reg_write_en_in = 'b0;
          fsm_if_res_1_reg_write_en_in = 'b0;
          fsm_load_0_reg_write_en_in = 'b0;
          fsm_load_1_reg_write_en_in = 'b0;
          fsm_load_2_reg_write_en_in = 'b0;
          fsm_remsi_0_reg_write_en_in = 'b0;
          fsm_ret_arg0_reg_write_en_in = 'b0;
          fsm_std_rems_pipe_0_go_in = 'b0;
          next_state = S0;
      end
    endcase
  end
assign fsm__this_arg_mem_0_write_en_in = 1'd0;
assign fsm__this_arg_mem_0_addr0_in = std_slice_9_out;
assign fsm_std_slice_9_in_in = in0;
assign fsm__this_arg_mem_0_content_en_in = 1'd1;
assign fsm__this_arg_mem_1_addr0_in = 
       ((current_state == S2) & (~(arg_mem_1_done))) ? std_slice_8_out :
       ((current_state == S5) & (~(arg_mem_1_done))) ? std_slice_7_out :
       ((current_state == S7) & (~(arg_mem_1_done))) ? std_slice_6_out :
       8'dx;
assign fsm__this_arg_mem_1_write_en_in = 
       ((current_state == S2) & (~(arg_mem_1_done))) ? 1'd0 :
       ((current_state == S5) & (~(arg_mem_1_done))) ? 1'd0 :
       ((current_state == S7) & (~(arg_mem_1_done))) ? 1'd1 :
       1'dx;
assign fsm_std_slice_0_in_in = arg_mem_0_read_data;
assign fsm__this_arg_mem_1_content_en_in = 1'd1;
assign fsm_std_slice_8_in_in = std_slice_0_out;
assign fsm_load_0_reg_in_in = arg_mem_1_read_data;
assign fsm_std_signext_0_in_in = load_0_reg_out;
assign fsm_std_eq_0_right_in = 32'd127;
assign fsm_std_eq_0_left_in = std_signext_0_out;
assign fsm_comb_wire_in_in = std_eq_0_out;
assign fsm_std_slice_7_in_in = in4;
assign fsm_load_1_reg_in_in = arg_mem_1_read_data;
assign fsm_std_add_0_right_in = 32'd1;
assign fsm_std_slice_1_in_in = std_add_0_out;
assign fsm_std_add_0_left_in = std_signext_1_out;
assign fsm_std_signext_1_in_in = load_1_reg_out;
assign fsm__this_arg_mem_1_write_data_in = std_slice_1_out;
assign fsm_std_slice_6_in_in = std_slice_0_out;
assign fsm__this_arg_mem_2_addr0_in = 
       ((current_state == S8) & (~(arg_mem_2_done))) ? std_slice_5_out :
       ((current_state == S10) & (~(arg_mem_2_done))) ? std_slice_4_out :
       4'dx;
assign fsm__this_arg_mem_2_content_en_in = 1'd1;
assign fsm_std_pad_0_in_in = std_slice_1_out;
assign fsm_std_slice_5_in_in = std_pad_0_out;
assign fsm__this_arg_mem_2_write_en_in = 
       ((current_state == S8) & (~(arg_mem_2_done))) ? 1'd0 :
       ((current_state == S10) & (~(arg_mem_2_done))) ? 1'd1 :
       1'dx;
assign fsm_load_2_reg_in_in = arg_mem_2_read_data;
assign fsm_std_add_1_left_in = load_2_reg_out;
assign fsm_std_add_1_right_in = 64'd1;
assign fsm__this_arg_mem_2_write_data_in = std_add_1_out;
assign fsm_std_slice_4_in_in = std_pad_0_out;
assign fsm_std_eq_1_right_in = 64'd0;
assign fsm_comb_wire0_in_in = std_eq_1_out;
assign fsm_std_eq_1_left_in = in1;
assign fsm_std_add_2_left_in = in1;
assign fsm_std_add_2_right_in = 64'd18446744073709551615;
assign fsm_if_res_0_reg_in_in = 
       ((current_state == S12) & (comb_wire0_out)) ? 64'd255 :
       ((current_state == S12) & (~(comb_wire0_out))) ? std_add_2_out :
       64'dx;
assign fsm_std_slice_2_in_in = if_res_0_reg_out;
assign fsm__this_arg_mem_3_addr0_in = std_slice_3_out;
assign fsm_std_slice_3_in_in = std_slice_2_out;
assign fsm__this_arg_mem_3_content_en_in = 1'd1;
assign fsm__this_arg_mem_3_write_data_in = arg_mem_0_read_data;
assign fsm__this_arg_mem_3_write_en_in = 1'd1;
assign fsm_std_add_3_right_in = 64'd1;
assign fsm_std_rems_pipe_0_right_in = 64'd256;
assign fsm_std_rems_pipe_0_left_in = std_add_3_out;
assign fsm_std_add_3_left_in = in1;
assign fsm_remsi_0_reg_in_in = std_rems_pipe_0_out_remainder;
assign fsm_if_res_1_reg_in_in = 
       ((current_state == S15) & (~(if_res_1_reg_done))) ? remsi_0_reg_out :
       ((current_state == S16) & (~(if_res_1_reg_done))) ? in1 :
       64'dx;
assign fsm_ret_arg0_reg_in_in = if_res_1_reg_out;
endmodule

module bfs_queue_inner_loop_0(
  input logic [31:0] in0,
  input logic [63:0] in1,
  input logic [31:0] in4,
  (* clk=1 *) input logic clk,
  (* reset=1 *) input logic reset,
  (* go=1 *) input logic go,
  output logic [63:0] out0,
  (* done=1 *) output logic done,
  (* data=1 *) output logic [7:0] arg_mem_3_addr0,
  output logic arg_mem_3_content_en,
  output logic arg_mem_3_write_en,
  (* data=1 *) output logic [63:0] arg_mem_3_write_data,
  input logic [63:0] arg_mem_3_read_data,
  input logic arg_mem_3_done,
  (* data=1 *) output logic [3:0] arg_mem_2_addr0,
  output logic arg_mem_2_content_en,
  output logic arg_mem_2_write_en,
  (* data=1 *) output logic [63:0] arg_mem_2_write_data,
  input logic [63:0] arg_mem_2_read_data,
  input logic arg_mem_2_done,
  (* data=1 *) output logic [7:0] arg_mem_1_addr0,
  output logic arg_mem_1_content_en,
  output logic arg_mem_1_write_en,
  (* data=1 *) output logic [7:0] arg_mem_1_write_data,
  input logic [7:0] arg_mem_1_read_data,
  input logic arg_mem_1_done,
  (* data=1 *) output logic [11:0] arg_mem_0_addr0,
  output logic arg_mem_0_content_en,
  output logic arg_mem_0_write_en,
  (* data=1 *) output logic [63:0] arg_mem_0_write_data,
  input logic [63:0] arg_mem_0_read_data,
  input logic arg_mem_0_done
);
// COMPONENT START: bfs_queue_inner_loop_0
logic [31:0] std_slice_9_in;
logic [11:0] std_slice_9_out;
logic [31:0] std_slice_8_in;
logic [7:0] std_slice_8_out;
logic [31:0] std_slice_7_in;
logic [7:0] std_slice_7_out;
logic [31:0] std_slice_6_in;
logic [7:0] std_slice_6_out;
logic [31:0] std_slice_5_in;
logic [3:0] std_slice_5_out;
logic [31:0] std_slice_4_in;
logic [3:0] std_slice_4_out;
logic [31:0] std_slice_3_in;
logic [7:0] std_slice_3_out;
logic [63:0] remsi_0_reg_in;
logic remsi_0_reg_write_en;
logic remsi_0_reg_clk;
logic remsi_0_reg_reset;
logic [63:0] remsi_0_reg_out;
logic remsi_0_reg_done;
logic std_rems_pipe_0_clk;
logic std_rems_pipe_0_reset;
logic std_rems_pipe_0_go;
logic [63:0] std_rems_pipe_0_left;
logic [63:0] std_rems_pipe_0_right;
logic [63:0] std_rems_pipe_0_out_quotient;
logic [63:0] std_rems_pipe_0_out_remainder;
logic std_rems_pipe_0_done;
logic [63:0] std_add_3_left;
logic [63:0] std_add_3_right;
logic [63:0] std_add_3_out;
logic [63:0] std_slice_2_in;
logic [31:0] std_slice_2_out;
logic [63:0] std_add_2_left;
logic [63:0] std_add_2_right;
logic [63:0] std_add_2_out;
logic [63:0] std_eq_1_left;
logic [63:0] std_eq_1_right;
logic std_eq_1_out;
logic [63:0] std_add_1_left;
logic [63:0] std_add_1_right;
logic [63:0] std_add_1_out;
logic [63:0] load_2_reg_in;
logic load_2_reg_write_en;
logic load_2_reg_clk;
logic load_2_reg_reset;
logic [63:0] load_2_reg_out;
logic load_2_reg_done;
logic [7:0] std_pad_0_in;
logic [31:0] std_pad_0_out;
logic [31:0] std_slice_1_in;
logic [7:0] std_slice_1_out;
logic [31:0] std_add_0_left;
logic [31:0] std_add_0_right;
logic [31:0] std_add_0_out;
logic [7:0] std_signext_1_in;
logic [31:0] std_signext_1_out;
logic [7:0] load_1_reg_in;
logic load_1_reg_write_en;
logic load_1_reg_clk;
logic load_1_reg_reset;
logic [7:0] load_1_reg_out;
logic load_1_reg_done;
logic [31:0] std_eq_0_left;
logic [31:0] std_eq_0_right;
logic std_eq_0_out;
logic [7:0] std_signext_0_in;
logic [31:0] std_signext_0_out;
logic [7:0] load_0_reg_in;
logic load_0_reg_write_en;
logic load_0_reg_clk;
logic load_0_reg_reset;
logic [7:0] load_0_reg_out;
logic load_0_reg_done;
logic [63:0] std_slice_0_in;
logic [31:0] std_slice_0_out;
logic [63:0] if_res_1_reg_in;
logic if_res_1_reg_write_en;
logic if_res_1_reg_clk;
logic if_res_1_reg_reset;
logic [63:0] if_res_1_reg_out;
logic if_res_1_reg_done;
logic [63:0] if_res_0_reg_in;
logic if_res_0_reg_write_en;
logic if_res_0_reg_clk;
logic if_res_0_reg_reset;
logic [63:0] if_res_0_reg_out;
logic if_res_0_reg_done;
logic [63:0] ret_arg0_reg_in;
logic ret_arg0_reg_write_en;
logic ret_arg0_reg_clk;
logic ret_arg0_reg_reset;
logic [63:0] ret_arg0_reg_out;
logic ret_arg0_reg_done;
logic comb_wire_in;
logic comb_wire_out;
logic comb_wire0_in;
logic comb_wire0_out;
logic [31:0] fsm_std_slice_9_in_in;
logic [31:0] fsm_std_slice_9_in_out;
logic [11:0] fsm__this_arg_mem_0_addr0_in;
logic [11:0] fsm__this_arg_mem_0_addr0_out;
logic fsm__this_arg_mem_0_content_en_in;
logic fsm__this_arg_mem_0_content_en_out;
logic fsm__this_arg_mem_0_write_en_in;
logic fsm__this_arg_mem_0_write_en_out;
logic [7:0] fsm__this_arg_mem_1_addr0_in;
logic [7:0] fsm__this_arg_mem_1_addr0_out;
logic fsm__this_arg_mem_1_content_en_in;
logic fsm__this_arg_mem_1_content_en_out;
logic fsm__this_arg_mem_1_write_en_in;
logic fsm__this_arg_mem_1_write_en_out;
logic [31:0] fsm_std_slice_8_in_in;
logic [31:0] fsm_std_slice_8_in_out;
logic [63:0] fsm_std_slice_0_in_in;
logic [63:0] fsm_std_slice_0_in_out;
logic fsm_load_0_reg_write_en_in;
logic fsm_load_0_reg_write_en_out;
logic [7:0] fsm_load_0_reg_in_in;
logic [7:0] fsm_load_0_reg_in_out;
logic [31:0] fsm_std_eq_0_left_in;
logic [31:0] fsm_std_eq_0_left_out;
logic [31:0] fsm_std_eq_0_right_in;
logic [31:0] fsm_std_eq_0_right_out;
logic [7:0] fsm_std_signext_0_in_in;
logic [7:0] fsm_std_signext_0_in_out;
logic fsm_comb_wire_in_in;
logic fsm_comb_wire_in_out;
logic [31:0] fsm_std_slice_7_in_in;
logic [31:0] fsm_std_slice_7_in_out;
logic fsm_load_1_reg_write_en_in;
logic fsm_load_1_reg_write_en_out;
logic [7:0] fsm_load_1_reg_in_in;
logic [7:0] fsm_load_1_reg_in_out;
logic [31:0] fsm_std_slice_6_in_in;
logic [31:0] fsm_std_slice_6_in_out;
logic [7:0] fsm__this_arg_mem_1_write_data_in;
logic [7:0] fsm__this_arg_mem_1_write_data_out;
logic [31:0] fsm_std_slice_1_in_in;
logic [31:0] fsm_std_slice_1_in_out;
logic [31:0] fsm_std_add_0_left_in;
logic [31:0] fsm_std_add_0_left_out;
logic [7:0] fsm_std_signext_1_in_in;
logic [7:0] fsm_std_signext_1_in_out;
logic [31:0] fsm_std_add_0_right_in;
logic [31:0] fsm_std_add_0_right_out;
logic [3:0] fsm__this_arg_mem_2_addr0_in;
logic [3:0] fsm__this_arg_mem_2_addr0_out;
logic fsm__this_arg_mem_2_content_en_in;
logic fsm__this_arg_mem_2_content_en_out;
logic fsm__this_arg_mem_2_write_en_in;
logic fsm__this_arg_mem_2_write_en_out;
logic [31:0] fsm_std_slice_5_in_in;
logic [31:0] fsm_std_slice_5_in_out;
logic [7:0] fsm_std_pad_0_in_in;
logic [7:0] fsm_std_pad_0_in_out;
logic fsm_load_2_reg_write_en_in;
logic fsm_load_2_reg_write_en_out;
logic [63:0] fsm_load_2_reg_in_in;
logic [63:0] fsm_load_2_reg_in_out;
logic [31:0] fsm_std_slice_4_in_in;
logic [31:0] fsm_std_slice_4_in_out;
logic [63:0] fsm__this_arg_mem_2_write_data_in;
logic [63:0] fsm__this_arg_mem_2_write_data_out;
logic [63:0] fsm_std_add_1_left_in;
logic [63:0] fsm_std_add_1_left_out;
logic [63:0] fsm_std_add_1_right_in;
logic [63:0] fsm_std_add_1_right_out;
logic [63:0] fsm_std_eq_1_left_in;
logic [63:0] fsm_std_eq_1_left_out;
logic [63:0] fsm_std_eq_1_right_in;
logic [63:0] fsm_std_eq_1_right_out;
logic fsm_comb_wire0_in_in;
logic fsm_comb_wire0_in_out;
logic fsm_if_res_0_reg_write_en_in;
logic fsm_if_res_0_reg_write_en_out;
logic [63:0] fsm_if_res_0_reg_in_in;
logic [63:0] fsm_if_res_0_reg_in_out;
logic [63:0] fsm_std_add_2_left_in;
logic [63:0] fsm_std_add_2_left_out;
logic [63:0] fsm_std_add_2_right_in;
logic [63:0] fsm_std_add_2_right_out;
logic [31:0] fsm_std_slice_3_in_in;
logic [31:0] fsm_std_slice_3_in_out;
logic [7:0] fsm__this_arg_mem_3_addr0_in;
logic [7:0] fsm__this_arg_mem_3_addr0_out;
logic [63:0] fsm__this_arg_mem_3_write_data_in;
logic [63:0] fsm__this_arg_mem_3_write_data_out;
logic fsm__this_arg_mem_3_write_en_in;
logic fsm__this_arg_mem_3_write_en_out;
logic fsm__this_arg_mem_3_content_en_in;
logic fsm__this_arg_mem_3_content_en_out;
logic [63:0] fsm_std_slice_2_in_in;
logic [63:0] fsm_std_slice_2_in_out;
logic [63:0] fsm_std_rems_pipe_0_left_in;
logic [63:0] fsm_std_rems_pipe_0_left_out;
logic [63:0] fsm_std_rems_pipe_0_right_in;
logic [63:0] fsm_std_rems_pipe_0_right_out;
logic [63:0] fsm_remsi_0_reg_in_in;
logic [63:0] fsm_remsi_0_reg_in_out;
logic fsm_remsi_0_reg_write_en_in;
logic fsm_remsi_0_reg_write_en_out;
logic fsm_std_rems_pipe_0_go_in;
logic fsm_std_rems_pipe_0_go_out;
logic [63:0] fsm_std_add_3_left_in;
logic [63:0] fsm_std_add_3_left_out;
logic [63:0] fsm_std_add_3_right_in;
logic [63:0] fsm_std_add_3_right_out;
logic fsm_if_res_1_reg_write_en_in;
logic fsm_if_res_1_reg_write_en_out;
logic [63:0] fsm_if_res_1_reg_in_in;
logic [63:0] fsm_if_res_1_reg_in_out;
logic fsm_ret_arg0_reg_write_en_in;
logic fsm_ret_arg0_reg_write_en_out;
logic [63:0] fsm_ret_arg0_reg_in_in;
logic [63:0] fsm_ret_arg0_reg_in_out;
logic fsm_start_in;
logic fsm_start_out;
logic fsm_done_in;
logic fsm_done_out;
(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(12)
) std_slice_9 (
    .in(std_slice_9_in),
    .out(std_slice_9_out)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(8)
) std_slice_8 (
    .in(std_slice_8_in),
    .out(std_slice_8_out)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(8)
) std_slice_7 (
    .in(std_slice_7_in),
    .out(std_slice_7_out)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(8)
) std_slice_6 (
    .in(std_slice_6_in),
    .out(std_slice_6_out)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(4)
) std_slice_5 (
    .in(std_slice_5_in),
    .out(std_slice_5_out)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(4)
) std_slice_4 (
    .in(std_slice_4_in),
    .out(std_slice_4_out)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(8)
) std_slice_3 (
    .in(std_slice_3_in),
    .out(std_slice_3_out)
);

(* data=1 *)
std_reg # (
    .WIDTH(64)
) remsi_0_reg (
    .clk(remsi_0_reg_clk),
    .done(remsi_0_reg_done),
    .in(remsi_0_reg_in),
    .out(remsi_0_reg_out),
    .reset(remsi_0_reg_reset),
    .write_en(remsi_0_reg_write_en)
);

(* data=1 *)
std_sdiv_pipe # (
    .WIDTH(64)
) std_rems_pipe_0 (
    .clk(std_rems_pipe_0_clk),
    .done(std_rems_pipe_0_done),
    .go(std_rems_pipe_0_go),
    .left(std_rems_pipe_0_left),
    .out_quotient(std_rems_pipe_0_out_quotient),
    .out_remainder(std_rems_pipe_0_out_remainder),
    .reset(std_rems_pipe_0_reset),
    .right(std_rems_pipe_0_right)
);

(* data=1 *)
std_add # (
    .WIDTH(64)
) std_add_3 (
    .left(std_add_3_left),
    .out(std_add_3_out),
    .right(std_add_3_right)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(64),
    .OUT_WIDTH(32)
) std_slice_2 (
    .in(std_slice_2_in),
    .out(std_slice_2_out)
);

(* data=1 *)
std_add # (
    .WIDTH(64)
) std_add_2 (
    .left(std_add_2_left),
    .out(std_add_2_out),
    .right(std_add_2_right)
);

(* control=1 *)
std_eq # (
    .WIDTH(64)
) std_eq_1 (
    .left(std_eq_1_left),
    .out(std_eq_1_out),
    .right(std_eq_1_right)
);

(* data=1 *)
std_add # (
    .WIDTH(64)
) std_add_1 (
    .left(std_add_1_left),
    .out(std_add_1_out),
    .right(std_add_1_right)
);

(* data=1 *)
std_reg # (
    .WIDTH(64)
) load_2_reg (
    .clk(load_2_reg_clk),
    .done(load_2_reg_done),
    .in(load_2_reg_in),
    .out(load_2_reg_out),
    .reset(load_2_reg_reset),
    .write_en(load_2_reg_write_en)
);

(* data=1 *)
std_pad # (
    .IN_WIDTH(8),
    .OUT_WIDTH(32)
) std_pad_0 (
    .in(std_pad_0_in),
    .out(std_pad_0_out)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(32),
    .OUT_WIDTH(8)
) std_slice_1 (
    .in(std_slice_1_in),
    .out(std_slice_1_out)
);

(* data=1 *)
std_add # (
    .WIDTH(32)
) std_add_0 (
    .left(std_add_0_left),
    .out(std_add_0_out),
    .right(std_add_0_right)
);

(* data=1 *)
std_signext # (
    .IN_WIDTH(8),
    .OUT_WIDTH(32)
) std_signext_1 (
    .in(std_signext_1_in),
    .out(std_signext_1_out)
);

(* data=1 *)
std_reg # (
    .WIDTH(8)
) load_1_reg (
    .clk(load_1_reg_clk),
    .done(load_1_reg_done),
    .in(load_1_reg_in),
    .out(load_1_reg_out),
    .reset(load_1_reg_reset),
    .write_en(load_1_reg_write_en)
);

(* control=1 *)
std_eq # (
    .WIDTH(32)
) std_eq_0 (
    .left(std_eq_0_left),
    .out(std_eq_0_out),
    .right(std_eq_0_right)
);

(* control=1 *)
std_signext # (
    .IN_WIDTH(8),
    .OUT_WIDTH(32)
) std_signext_0 (
    .in(std_signext_0_in),
    .out(std_signext_0_out)
);

(* data=1 *)
std_reg # (
    .WIDTH(8)
) load_0_reg (
    .clk(load_0_reg_clk),
    .done(load_0_reg_done),
    .in(load_0_reg_in),
    .out(load_0_reg_out),
    .reset(load_0_reg_reset),
    .write_en(load_0_reg_write_en)
);

(* data=1 *)
std_slice # (
    .IN_WIDTH(64),
    .OUT_WIDTH(32)
) std_slice_0 (
    .in(std_slice_0_in),
    .out(std_slice_0_out)
);

(* data=1 *)
std_reg # (
    .WIDTH(64)
) if_res_1_reg (
    .clk(if_res_1_reg_clk),
    .done(if_res_1_reg_done),
    .in(if_res_1_reg_in),
    .out(if_res_1_reg_out),
    .reset(if_res_1_reg_reset),
    .write_en(if_res_1_reg_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(64)
) if_res_0_reg (
    .clk(if_res_0_reg_clk),
    .done(if_res_0_reg_done),
    .in(if_res_0_reg_in),
    .out(if_res_0_reg_out),
    .reset(if_res_0_reg_reset),
    .write_en(if_res_0_reg_write_en)
);

(* data=1 *)
std_reg # (
    .WIDTH(64)
) ret_arg0_reg (
    .clk(ret_arg0_reg_clk),
    .done(ret_arg0_reg_done),
    .in(ret_arg0_reg_in),
    .out(ret_arg0_reg_out),
    .reset(ret_arg0_reg_reset),
    .write_en(ret_arg0_reg_write_en)
);

assign comb_wire_out = comb_wire_in;
assign comb_wire0_out = comb_wire0_in;
assign fsm_std_slice_9_in_out = fsm_std_slice_9_in_in;
assign fsm__this_arg_mem_0_addr0_out = fsm__this_arg_mem_0_addr0_in;
assign fsm__this_arg_mem_0_content_en_out = fsm__this_arg_mem_0_content_en_in;
assign fsm__this_arg_mem_0_write_en_out = fsm__this_arg_mem_0_write_en_in;
assign fsm__this_arg_mem_1_addr0_out = fsm__this_arg_mem_1_addr0_in;
assign fsm__this_arg_mem_1_content_en_out = fsm__this_arg_mem_1_content_en_in;
assign fsm__this_arg_mem_1_write_en_out = fsm__this_arg_mem_1_write_en_in;
assign fsm_std_slice_8_in_out = fsm_std_slice_8_in_in;
assign fsm_std_slice_0_in_out = fsm_std_slice_0_in_in;
assign fsm_load_0_reg_write_en_out = fsm_load_0_reg_write_en_in;
assign fsm_load_0_reg_in_out = fsm_load_0_reg_in_in;
assign fsm_std_eq_0_left_out = fsm_std_eq_0_left_in;
assign fsm_std_eq_0_right_out = fsm_std_eq_0_right_in;
assign fsm_std_signext_0_in_out = fsm_std_signext_0_in_in;
assign fsm_comb_wire_in_out = fsm_comb_wire_in_in;
assign fsm_std_slice_7_in_out = fsm_std_slice_7_in_in;
assign fsm_load_1_reg_write_en_out = fsm_load_1_reg_write_en_in;
assign fsm_load_1_reg_in_out = fsm_load_1_reg_in_in;
assign fsm_std_slice_6_in_out = fsm_std_slice_6_in_in;
assign fsm__this_arg_mem_1_write_data_out = fsm__this_arg_mem_1_write_data_in;
assign fsm_std_slice_1_in_out = fsm_std_slice_1_in_in;
assign fsm_std_add_0_left_out = fsm_std_add_0_left_in;
assign fsm_std_signext_1_in_out = fsm_std_signext_1_in_in;
assign fsm_std_add_0_right_out = fsm_std_add_0_right_in;
assign fsm__this_arg_mem_2_addr0_out = fsm__this_arg_mem_2_addr0_in;
assign fsm__this_arg_mem_2_content_en_out = fsm__this_arg_mem_2_content_en_in;
assign fsm__this_arg_mem_2_write_en_out = fsm__this_arg_mem_2_write_en_in;
assign fsm_std_slice_5_in_out = fsm_std_slice_5_in_in;
assign fsm_std_pad_0_in_out = fsm_std_pad_0_in_in;
assign fsm_load_2_reg_write_en_out = fsm_load_2_reg_write_en_in;
assign fsm_load_2_reg_in_out = fsm_load_2_reg_in_in;
assign fsm_std_slice_4_in_out = fsm_std_slice_4_in_in;
assign fsm__this_arg_mem_2_write_data_out = fsm__this_arg_mem_2_write_data_in;
assign fsm_std_add_1_left_out = fsm_std_add_1_left_in;
assign fsm_std_add_1_right_out = fsm_std_add_1_right_in;
assign fsm_std_eq_1_left_out = fsm_std_eq_1_left_in;
assign fsm_std_eq_1_right_out = fsm_std_eq_1_right_in;
assign fsm_comb_wire0_in_out = fsm_comb_wire0_in_in;
assign fsm_if_res_0_reg_write_en_out = fsm_if_res_0_reg_write_en_in;
assign fsm_if_res_0_reg_in_out = fsm_if_res_0_reg_in_in;
assign fsm_std_add_2_left_out = fsm_std_add_2_left_in;
assign fsm_std_add_2_right_out = fsm_std_add_2_right_in;
assign fsm_std_slice_3_in_out = fsm_std_slice_3_in_in;
assign fsm__this_arg_mem_3_addr0_out = fsm__this_arg_mem_3_addr0_in;
assign fsm__this_arg_mem_3_write_data_out = fsm__this_arg_mem_3_write_data_in;
assign fsm__this_arg_mem_3_write_en_out = fsm__this_arg_mem_3_write_en_in;
assign fsm__this_arg_mem_3_content_en_out = fsm__this_arg_mem_3_content_en_in;
assign fsm_std_slice_2_in_out = fsm_std_slice_2_in_in;
assign fsm_std_rems_pipe_0_left_out = fsm_std_rems_pipe_0_left_in;
assign fsm_std_rems_pipe_0_right_out = fsm_std_rems_pipe_0_right_in;
assign fsm_remsi_0_reg_in_out = fsm_remsi_0_reg_in_in;
assign fsm_remsi_0_reg_write_en_out = fsm_remsi_0_reg_write_en_in;
assign fsm_std_rems_pipe_0_go_out = fsm_std_rems_pipe_0_go_in;
assign fsm_std_add_3_left_out = fsm_std_add_3_left_in;
assign fsm_std_add_3_right_out = fsm_std_add_3_right_in;
assign fsm_if_res_1_reg_write_en_out = fsm_if_res_1_reg_write_en_in;
assign fsm_if_res_1_reg_in_out = fsm_if_res_1_reg_in_in;
assign fsm_ret_arg0_reg_write_en_out = fsm_ret_arg0_reg_write_en_in;
assign fsm_ret_arg0_reg_in_out = fsm_ret_arg0_reg_in_in;
assign fsm_start_out = fsm_start_in;
assign fsm_done_out = fsm_done_in;
fsm_bfs_queue_inner_loop_0_def fsm (
  .clk(clk),
  .reset(reset),
  .fsm__this_arg_mem_0_addr0_in(fsm__this_arg_mem_0_addr0_in),
  .fsm_std_slice_9_in_in(fsm_std_slice_9_in_in),
  .fsm__this_arg_mem_0_write_en_in(fsm__this_arg_mem_0_write_en_in),
  .fsm__this_arg_mem_0_content_en_in(fsm__this_arg_mem_0_content_en_in),
  .fsm_std_slice_0_in_in(fsm_std_slice_0_in_in),
  .fsm__this_arg_mem_1_content_en_in(fsm__this_arg_mem_1_content_en_in),
  .fsm__this_arg_mem_1_addr0_in(fsm__this_arg_mem_1_addr0_in),
  .fsm__this_arg_mem_1_write_en_in(fsm__this_arg_mem_1_write_en_in),
  .fsm_std_slice_8_in_in(fsm_std_slice_8_in_in),
  .fsm_load_0_reg_write_en_in(fsm_load_0_reg_write_en_in),
  .fsm_load_0_reg_in_in(fsm_load_0_reg_in_in),
  .fsm_std_signext_0_in_in(fsm_std_signext_0_in_in),
  .fsm_std_eq_0_left_in(fsm_std_eq_0_left_in),
  .fsm_comb_wire_in_in(fsm_comb_wire_in_in),
  .fsm_std_eq_0_right_in(fsm_std_eq_0_right_in),
  .fsm_std_slice_7_in_in(fsm_std_slice_7_in_in),
  .fsm_load_1_reg_write_en_in(fsm_load_1_reg_write_en_in),
  .fsm_load_1_reg_in_in(fsm_load_1_reg_in_in),
  .fsm_std_add_0_left_in(fsm_std_add_0_left_in),
  .fsm_std_slice_6_in_in(fsm_std_slice_6_in_in),
  .fsm_std_slice_1_in_in(fsm_std_slice_1_in_in),
  .fsm__this_arg_mem_1_write_data_in(fsm__this_arg_mem_1_write_data_in),
  .fsm_std_signext_1_in_in(fsm_std_signext_1_in_in),
  .fsm_std_add_0_right_in(fsm_std_add_0_right_in),
  .fsm_std_pad_0_in_in(fsm_std_pad_0_in_in),
  .fsm__this_arg_mem_2_addr0_in(fsm__this_arg_mem_2_addr0_in),
  .fsm__this_arg_mem_2_write_en_in(fsm__this_arg_mem_2_write_en_in),
  .fsm_std_slice_5_in_in(fsm_std_slice_5_in_in),
  .fsm__this_arg_mem_2_content_en_in(fsm__this_arg_mem_2_content_en_in),
  .fsm_load_2_reg_in_in(fsm_load_2_reg_in_in),
  .fsm_load_2_reg_write_en_in(fsm_load_2_reg_write_en_in),
  .fsm__this_arg_mem_2_write_data_in(fsm__this_arg_mem_2_write_data_in),
  .fsm_std_slice_4_in_in(fsm_std_slice_4_in_in),
  .fsm_std_add_1_left_in(fsm_std_add_1_left_in),
  .fsm_std_add_1_right_in(fsm_std_add_1_right_in),
  .fsm_std_eq_1_left_in(fsm_std_eq_1_left_in),
  .fsm_comb_wire0_in_in(fsm_comb_wire0_in_in),
  .fsm_std_eq_1_right_in(fsm_std_eq_1_right_in),
  .fsm_if_res_0_reg_write_en_in(fsm_if_res_0_reg_write_en_in),
  .fsm_if_res_0_reg_in_in(fsm_if_res_0_reg_in_in),
  .fsm_std_add_2_right_in(fsm_std_add_2_right_in),
  .fsm_std_add_2_left_in(fsm_std_add_2_left_in),
  .fsm_std_slice_2_in_in(fsm_std_slice_2_in_in),
  .fsm__this_arg_mem_3_content_en_in(fsm__this_arg_mem_3_content_en_in),
  .fsm__this_arg_mem_3_write_en_in(fsm__this_arg_mem_3_write_en_in),
  .fsm__this_arg_mem_3_addr0_in(fsm__this_arg_mem_3_addr0_in),
  .fsm_std_slice_3_in_in(fsm_std_slice_3_in_in),
  .fsm__this_arg_mem_3_write_data_in(fsm__this_arg_mem_3_write_data_in),
  .fsm_remsi_0_reg_in_in(fsm_remsi_0_reg_in_in),
  .fsm_std_rems_pipe_0_go_in(fsm_std_rems_pipe_0_go_in),
  .fsm_remsi_0_reg_write_en_in(fsm_remsi_0_reg_write_en_in),
  .fsm_std_add_3_right_in(fsm_std_add_3_right_in),
  .fsm_std_rems_pipe_0_left_in(fsm_std_rems_pipe_0_left_in),
  .fsm_std_rems_pipe_0_right_in(fsm_std_rems_pipe_0_right_in),
  .fsm_std_add_3_left_in(fsm_std_add_3_left_in),
  .fsm_if_res_1_reg_in_in(fsm_if_res_1_reg_in_in),
  .fsm_if_res_1_reg_write_en_in(fsm_if_res_1_reg_write_en_in),
  .fsm_ret_arg0_reg_in_in(fsm_ret_arg0_reg_in_in),
  .fsm_ret_arg0_reg_write_en_in(fsm_ret_arg0_reg_write_en_in),
  .fsm_done_in(fsm_done_in),
  .in0(in0),
  .arg_mem_0_done(arg_mem_0_done),
  .std_slice_9_out(std_slice_9_out),
  .std_slice_8_out(std_slice_8_out),
  .arg_mem_1_done(arg_mem_1_done),
  .std_slice_0_out(std_slice_0_out),
  .arg_mem_0_read_data(arg_mem_0_read_data),
  .arg_mem_1_read_data(arg_mem_1_read_data),
  .load_0_reg_done(load_0_reg_done),
  .std_signext_0_out(std_signext_0_out),
  .load_0_reg_out(load_0_reg_out),
  .std_eq_0_out(std_eq_0_out),
  .std_slice_7_out(std_slice_7_out),
  .in4(in4),
  .load_1_reg_done(load_1_reg_done),
  .std_slice_6_out(std_slice_6_out),
  .std_slice_1_out(std_slice_1_out),
  .std_add_0_out(std_add_0_out),
  .std_signext_1_out(std_signext_1_out),
  .load_1_reg_out(load_1_reg_out),
  .std_slice_5_out(std_slice_5_out),
  .arg_mem_2_done(arg_mem_2_done),
  .std_pad_0_out(std_pad_0_out),
  .arg_mem_2_read_data(arg_mem_2_read_data),
  .load_2_reg_done(load_2_reg_done),
  .std_slice_4_out(std_slice_4_out),
  .std_add_1_out(std_add_1_out),
  .load_2_reg_out(load_2_reg_out),
  .in1(in1),
  .std_eq_1_out(std_eq_1_out),
  .std_add_2_out(std_add_2_out),
  .comb_wire0_out(comb_wire0_out),
  .std_slice_2_out(std_slice_2_out),
  .arg_mem_3_done(arg_mem_3_done),
  .std_slice_3_out(std_slice_3_out),
  .if_res_0_reg_out(if_res_0_reg_out),
  .std_add_3_out(std_add_3_out),
  .remsi_0_reg_done(remsi_0_reg_done),
  .std_rems_pipe_0_out_remainder(std_rems_pipe_0_out_remainder),
  .std_rems_pipe_0_done(std_rems_pipe_0_done),
  .remsi_0_reg_out(remsi_0_reg_out),
  .if_res_1_reg_done(if_res_1_reg_done),
  .if_res_1_reg_out(if_res_1_reg_out),
  .ret_arg0_reg_done(ret_arg0_reg_done),
  .fsm_start_out(fsm_start_out),
  .comb_wire_out(comb_wire_out)
);
assign std_slice_4_in = fsm_std_slice_4_in_out;
assign if_res_0_reg_write_en =
 ~comb_wire0_out | comb_wire0_out ? fsm_if_res_0_reg_write_en_out : 1'd0;
assign if_res_0_reg_clk = clk;
assign if_res_0_reg_reset = reset;
assign if_res_0_reg_in = fsm_if_res_0_reg_in_out;
assign std_signext_0_in = fsm_std_signext_0_in_out;
assign done = fsm_done_out;
assign arg_mem_1_write_data = fsm__this_arg_mem_1_write_data_out;
assign out0 = ret_arg0_reg_out;
assign arg_mem_3_addr0 = fsm__this_arg_mem_3_addr0_out;
assign arg_mem_3_write_data = fsm__this_arg_mem_3_write_data_out;
assign arg_mem_0_content_en =
 ~arg_mem_0_done ? fsm__this_arg_mem_0_content_en_out : 1'd0;
assign arg_mem_0_addr0 = fsm__this_arg_mem_0_addr0_out;
assign arg_mem_3_content_en =
 ~arg_mem_3_done ? fsm__this_arg_mem_3_content_en_out : 1'd0;
assign arg_mem_0_write_en =
 ~arg_mem_0_done ? fsm__this_arg_mem_0_write_en_out : 1'd0;
assign arg_mem_3_write_en =
 ~arg_mem_3_done ? fsm__this_arg_mem_3_write_en_out : 1'd0;
assign arg_mem_2_addr0 = fsm__this_arg_mem_2_addr0_out;
assign arg_mem_2_content_en =
 ~arg_mem_2_done ? fsm__this_arg_mem_2_content_en_out : 1'd0;
assign arg_mem_0_write_data = 64'd0;
assign arg_mem_1_write_en =
 ~arg_mem_1_done ? fsm__this_arg_mem_1_write_en_out : 1'd0;
assign arg_mem_2_write_en =
 ~arg_mem_2_done ? fsm__this_arg_mem_2_write_en_out : 1'd0;
assign arg_mem_2_write_data = fsm__this_arg_mem_2_write_data_out;
assign arg_mem_1_addr0 = fsm__this_arg_mem_1_addr0_out;
assign arg_mem_1_content_en =
 ~arg_mem_1_done ? fsm__this_arg_mem_1_content_en_out : 1'd0;
assign std_slice_5_in = fsm_std_slice_5_in_out;
assign std_rems_pipe_0_clk = clk;
assign std_rems_pipe_0_left = fsm_std_rems_pipe_0_left_out;
assign std_rems_pipe_0_reset = reset;
assign std_rems_pipe_0_go =
 ~remsi_0_reg_done ? fsm_std_rems_pipe_0_go_out : 1'd0;
assign std_rems_pipe_0_right = fsm_std_rems_pipe_0_right_out;
assign std_eq_0_left = fsm_std_eq_0_left_out;
assign std_eq_0_right = fsm_std_eq_0_right_out;
assign std_slice_8_in = fsm_std_slice_8_in_out;
assign load_0_reg_write_en =
 ~load_0_reg_done ? fsm_load_0_reg_write_en_out : 1'd0;
assign load_0_reg_clk = clk;
assign load_0_reg_reset = reset;
assign load_0_reg_in = fsm_load_0_reg_in_out;
assign ret_arg0_reg_write_en =
 ~ret_arg0_reg_done ? fsm_ret_arg0_reg_write_en_out : 1'd0;
assign ret_arg0_reg_clk = clk;
assign ret_arg0_reg_reset = reset;
assign ret_arg0_reg_in = fsm_ret_arg0_reg_in_out;
assign std_add_2_left = fsm_std_add_2_left_out;
assign std_add_2_right = fsm_std_add_2_right_out;
assign std_slice_3_in = fsm_std_slice_3_in_out;
assign comb_wire_in = fsm_comb_wire_in_out;
assign std_slice_6_in = fsm_std_slice_6_in_out;
assign std_add_3_left = fsm_std_add_3_left_out;
assign std_add_3_right = fsm_std_add_3_right_out;
assign std_eq_1_left = fsm_std_eq_1_left_out;
assign std_eq_1_right = fsm_std_eq_1_right_out;
assign std_add_1_left = fsm_std_add_1_left_out;
assign std_add_1_right = fsm_std_add_1_right_out;
assign std_slice_7_in = fsm_std_slice_7_in_out;
assign std_add_0_left = fsm_std_add_0_left_out;
assign std_add_0_right = fsm_std_add_0_right_out;
assign if_res_1_reg_write_en =
 ~if_res_1_reg_done ? fsm_if_res_1_reg_write_en_out : 1'd0;
assign if_res_1_reg_clk = clk;
assign if_res_1_reg_reset = reset;
assign if_res_1_reg_in = fsm_if_res_1_reg_in_out;
assign std_slice_2_in = fsm_std_slice_2_in_out;
assign std_slice_1_in = fsm_std_slice_1_in_out;
assign std_slice_0_in = fsm_std_slice_0_in_out;
assign comb_wire0_in = fsm_comb_wire0_in_out;
assign std_pad_0_in = fsm_std_pad_0_in_out;
assign remsi_0_reg_write_en =
 ~remsi_0_reg_done ? fsm_remsi_0_reg_write_en_out : 1'd0;
assign remsi_0_reg_clk = clk;
assign remsi_0_reg_reset = reset;
assign remsi_0_reg_in = fsm_remsi_0_reg_in_out;
assign fsm_start_in = go;
assign std_slice_9_in = fsm_std_slice_9_in_out;
assign load_2_reg_write_en =
 ~load_2_reg_done ? fsm_load_2_reg_write_en_out : 1'd0;
assign load_2_reg_clk = clk;
assign load_2_reg_reset = reset;
assign load_2_reg_in = fsm_load_2_reg_in_out;
assign std_signext_1_in = fsm_std_signext_1_in_out;
assign load_1_reg_write_en =
 ~load_1_reg_done ? fsm_load_1_reg_write_en_out : 1'd0;
assign load_1_reg_clk = clk;
assign load_1_reg_reset = reset;
assign load_1_reg_in = fsm_load_1_reg_in_out;
// COMPONENT END: bfs_queue_inner_loop_0
endmodule
