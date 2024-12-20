module std_fp_add (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left + right;
endmodule
module std_fp_sub (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left - right;
endmodule
module std_fp_mult_pipe (
	left,
	right,
	go,
	clk,
	reset,
	out,
	done
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	parameter SIGNED = 0;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	input wire go;
	input wire clk;
	input wire reset;
	output wire [WIDTH - 1:0] out;
	output wire done;
	reg [WIDTH - 1:0] rtmp;
	reg [WIDTH - 1:0] ltmp;
	reg [(WIDTH << 1) - 1:0] out_tmp;
	reg done_buf [1:0];
	assign done = done_buf[1];
	assign out = out_tmp[((WIDTH << 1) - INT_WIDTH) - 1:WIDTH - INT_WIDTH];
	wire start;
	assign start = go;
	always @(posedge clk)
		if (start)
			done_buf[0] <= 1;
		else
			done_buf[0] <= 0;
	always @(posedge clk)
		if (go)
			done_buf[1] <= done_buf[0];
		else
			done_buf[1] <= 0;
	always @(posedge clk)
		if (reset) begin
			rtmp <= 0;
			ltmp <= 0;
		end
		else if (go) begin
			if (SIGNED) begin
				rtmp <= $signed(right);
				ltmp <= $signed(left);
			end
			else begin
				rtmp <= right;
				ltmp <= left;
			end
		end
		else begin
			rtmp <= 0;
			ltmp <= 0;
		end
	always @(posedge clk)
		if (reset)
			out_tmp <= 0;
		else if (go) begin
			if (SIGNED)
				out_tmp <= $signed({{WIDTH {ltmp[WIDTH - 1]}}, ltmp} * {{WIDTH {rtmp[WIDTH - 1]}}, rtmp});
			else
				out_tmp <= ltmp * rtmp;
		end
		else
			out_tmp <= out_tmp;
endmodule
module std_fp_div_pipe (
	go,
	clk,
	reset,
	left,
	right,
	out_remainder,
	out_quotient,
	done
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input wire go;
	input wire clk;
	input wire reset;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output reg [WIDTH - 1:0] out_remainder;
	output reg [WIDTH - 1:0] out_quotient;
	output reg done;
	localparam ITERATIONS = WIDTH + FRAC_WIDTH;
	reg [WIDTH - 1:0] quotient;
	reg [WIDTH - 1:0] quotient_next;
	reg [WIDTH:0] acc;
	reg [WIDTH:0] acc_next;
	reg [$clog2(ITERATIONS) - 1:0] idx;
	wire start;
	reg running;
	wire finished;
	wire dividend_is_zero;
	assign start = go && !running;
	assign dividend_is_zero = start && (left == 0);
	assign finished = (idx == (ITERATIONS - 1)) && running;
	always @(posedge clk)
		if ((reset || finished) || dividend_is_zero)
			running <= 0;
		else if (start)
			running <= 1;
		else
			running <= running;
	always @(*)
		if (acc >= {1'b0, right}) begin
			acc_next = acc - right;
			{acc_next, quotient_next} = {acc_next[WIDTH - 1:0], quotient, 1'b1};
		end
		else
			{acc_next, quotient_next} = {acc, quotient} << 1;
	always @(posedge clk)
		if (dividend_is_zero || finished)
			done <= 1;
		else
			done <= 0;
	always @(posedge clk)
		if (running)
			idx <= idx + 1;
		else
			idx <= 0;
	always @(posedge clk)
		if (reset) begin
			out_quotient <= 0;
			out_remainder <= 0;
		end
		else if (start) begin
			out_quotient <= 0;
			out_remainder <= left;
		end
		else if (go == 0) begin
			out_quotient <= out_quotient;
			out_remainder <= out_remainder;
		end
		else if (dividend_is_zero) begin
			out_quotient <= 0;
			out_remainder <= 0;
		end
		else if (finished) begin
			out_quotient <= quotient_next;
			out_remainder <= out_remainder;
		end
		else begin
			out_quotient <= out_quotient;
			if (right <= out_remainder)
				out_remainder <= out_remainder - right;
			else
				out_remainder <= out_remainder;
		end
	always @(posedge clk)
		if (reset) begin
			acc <= 0;
			quotient <= 0;
		end
		else if (start)
			{acc, quotient} <= {{WIDTH {1'b0}}, left, 1'b0};
		else begin
			acc <= acc_next;
			quotient <= quotient_next;
		end
endmodule
module std_fp_gt (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire out;
	assign out = left > right;
endmodule
module std_fp_sadd (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out;
	assign out = $signed(left + right);
endmodule
module std_fp_ssub (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out;
	assign out = $signed(left - right);
endmodule
module std_fp_smult_pipe (
	left,
	right,
	reset,
	go,
	clk,
	out,
	done
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input [WIDTH - 1:0] left;
	input [WIDTH - 1:0] right;
	input wire reset;
	input wire go;
	input wire clk;
	output wire [WIDTH - 1:0] out;
	output wire done;
	std_fp_mult_pipe #(
		.WIDTH(WIDTH),
		.INT_WIDTH(INT_WIDTH),
		.FRAC_WIDTH(FRAC_WIDTH),
		.SIGNED(1)
	) comp(
		.clk(clk),
		.done(done),
		.reset(reset),
		.go(go),
		.left(left),
		.right(right),
		.out(out)
	);
endmodule
module std_fp_sdiv_pipe (
	clk,
	go,
	reset,
	left,
	right,
	out_quotient,
	out_remainder,
	done
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input clk;
	input go;
	input reset;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out_quotient;
	output wire signed [WIDTH - 1:0] out_remainder;
	output wire done;
	wire signed [WIDTH - 1:0] left_abs;
	wire signed [WIDTH - 1:0] right_abs;
	wire signed [WIDTH - 1:0] comp_out_q;
	wire signed [WIDTH - 1:0] comp_out_r;
	reg signed [WIDTH - 1:0] right_save;
	wire signed [WIDTH - 1:0] out_rem_intermediate;
	wire different_signs;
	reg left_sign;
	reg right_sign;
	always @(posedge clk)
		if (go) begin
			right_save <= right_abs;
			left_sign <= left[WIDTH - 1];
			right_sign <= right[WIDTH - 1];
		end
		else begin
			left_sign <= left_sign;
			right_save <= right_save;
			right_sign <= right_sign;
		end
	assign right_abs = (right[WIDTH - 1] ? -right : right);
	assign left_abs = (left[WIDTH - 1] ? -left : left);
	assign different_signs = left_sign ^ right_sign;
	assign out_quotient = (different_signs ? -comp_out_q : comp_out_q);
	assign out_rem_intermediate = (different_signs & |comp_out_r ? $signed(right_save - comp_out_r) : comp_out_r);
	assign out_remainder = (right_sign ? -out_rem_intermediate : out_rem_intermediate);
	std_fp_div_pipe #(
		.WIDTH(WIDTH),
		.INT_WIDTH(INT_WIDTH),
		.FRAC_WIDTH(FRAC_WIDTH)
	) comp(
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
module std_fp_sgt (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input wire signed [WIDTH - 1:0] left;
	input wire signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left > right);
endmodule
module std_fp_slt (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	parameter INT_WIDTH = 16;
	parameter FRAC_WIDTH = 16;
	input wire signed [WIDTH - 1:0] left;
	input wire signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left < right);
endmodule
module std_mult_pipe (
	left,
	right,
	reset,
	go,
	clk,
	out,
	done
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	input wire reset;
	input wire go;
	input wire clk;
	output wire [WIDTH - 1:0] out;
	output wire done;
	std_fp_mult_pipe #(
		.WIDTH(WIDTH),
		.INT_WIDTH(WIDTH),
		.FRAC_WIDTH(0),
		.SIGNED(0)
	) comp(
		.reset(reset),
		.clk(clk),
		.done(done),
		.go(go),
		.left(left),
		.right(right),
		.out(out)
	);
endmodule
module std_div_pipe (
	reset,
	clk,
	go,
	left,
	right,
	out_remainder,
	out_quotient,
	done
);
	parameter WIDTH = 32;
	input reset;
	input clk;
	input go;
	input [WIDTH - 1:0] left;
	input [WIDTH - 1:0] right;
	output reg [WIDTH - 1:0] out_remainder;
	output reg [WIDTH - 1:0] out_quotient;
	output reg done;
	reg [WIDTH - 1:0] dividend;
	reg [(WIDTH - 1) * 2:0] divisor;
	reg [WIDTH - 1:0] quotient;
	reg [WIDTH - 1:0] quotient_msk;
	wire start;
	reg running;
	wire finished;
	wire dividend_is_zero;
	assign start = go && !running;
	assign finished = (quotient_msk == 0) && running;
	assign dividend_is_zero = start && (left == 0);
	always @(posedge clk)
		if (finished || dividend_is_zero)
			done <= 1;
		else
			done <= 0;
	always @(posedge clk)
		if ((reset || finished) || dividend_is_zero)
			running <= 0;
		else if (start)
			running <= 1;
		else
			running <= running;
	always @(posedge clk)
		if (dividend_is_zero || start) begin
			out_quotient <= 0;
			out_remainder <= 0;
		end
		else if (finished) begin
			out_quotient <= quotient;
			out_remainder <= dividend;
		end
		else begin
			out_quotient <= out_quotient;
			out_remainder <= out_remainder;
		end
	always @(posedge clk)
		if (start)
			quotient_msk <= 1 << (WIDTH - 1);
		else if (running)
			quotient_msk <= quotient_msk >> 1;
		else
			quotient_msk <= quotient_msk;
	always @(posedge clk)
		if (start)
			quotient <= 0;
		else if (divisor <= dividend)
			quotient <= quotient | quotient_msk;
		else
			quotient <= quotient;
	always @(posedge clk)
		if (start)
			dividend <= left;
		else if (divisor <= dividend)
			dividend <= dividend - divisor;
		else
			dividend <= dividend;
	always @(posedge clk)
		if (start)
			divisor <= right << (WIDTH - 1);
		else if (finished)
			divisor <= 0;
		else
			divisor <= divisor >> 1;
endmodule
module std_sadd (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out;
	assign out = $signed(left + right);
endmodule
module std_ssub (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out;
	assign out = $signed(left - right);
endmodule
module std_smult_pipe (
	reset,
	go,
	clk,
	left,
	right,
	out,
	done
);
	parameter WIDTH = 32;
	input wire reset;
	input wire go;
	input wire clk;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out;
	output wire done;
	std_fp_mult_pipe #(
		.WIDTH(WIDTH),
		.INT_WIDTH(WIDTH),
		.FRAC_WIDTH(0),
		.SIGNED(1)
	) comp(
		.reset(reset),
		.clk(clk),
		.done(done),
		.go(go),
		.left(left),
		.right(right),
		.out(out)
	);
endmodule
module std_sdiv_pipe (
	reset,
	clk,
	go,
	left,
	right,
	out_quotient,
	out_remainder,
	done
);
	parameter WIDTH = 32;
	input reset;
	input clk;
	input go;
	input wire signed [WIDTH - 1:0] left;
	input wire signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out_quotient;
	output wire signed [WIDTH - 1:0] out_remainder;
	output wire done;
	wire signed [WIDTH - 1:0] left_abs;
	wire signed [WIDTH - 1:0] right_abs;
	wire signed [WIDTH - 1:0] comp_out_q;
	wire signed [WIDTH - 1:0] comp_out_r;
	reg signed [WIDTH - 1:0] right_save;
	wire signed [WIDTH - 1:0] out_rem_intermediate;
	wire different_signs;
	reg left_sign;
	reg right_sign;
	always @(posedge clk)
		if (go) begin
			right_save <= right_abs;
			left_sign <= left[WIDTH - 1];
			right_sign <= right[WIDTH - 1];
		end
		else begin
			left_sign <= left_sign;
			right_save <= right_save;
			right_sign <= right_sign;
		end
	assign right_abs = (right[WIDTH - 1] ? -right : right);
	assign left_abs = (left[WIDTH - 1] ? -left : left);
	assign different_signs = left_sign ^ right_sign;
	assign out_quotient = (different_signs ? -comp_out_q : comp_out_q);
	assign out_rem_intermediate = (different_signs & |comp_out_r ? $signed(right_save - comp_out_r) : comp_out_r);
	assign out_remainder = (right_sign ? -out_rem_intermediate : out_rem_intermediate);
	std_div_pipe #(.WIDTH(WIDTH)) comp(
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
module std_sgt (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left > right);
endmodule
module std_slt (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left < right);
endmodule
module std_seq (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left == right);
endmodule
module std_sneq (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left != right);
endmodule
module std_sge (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left >= right);
endmodule
module std_sle (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed  out;
	assign out = $signed(left <= right);
endmodule
module std_slsh (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out;
	assign out = left <<< right;
endmodule
module std_srsh (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input signed [WIDTH - 1:0] left;
	input signed [WIDTH - 1:0] right;
	output wire signed [WIDTH - 1:0] out;
	assign out = left >>> right;
endmodule
module std_signext (
	in,
	out
);
	parameter IN_WIDTH = 32;
	parameter OUT_WIDTH = 32;
	input wire [IN_WIDTH - 1:0] in;
	output wire [OUT_WIDTH - 1:0] out;
	localparam EXTEND = OUT_WIDTH - IN_WIDTH;
	assign out = {{EXTEND {in[IN_WIDTH - 1]}}, in};
endmodule
module std_const_mult (
	in,
	out
);
	parameter WIDTH = 32;
	parameter VALUE = 1;
	input signed [WIDTH - 1:0] in;
	output wire signed [WIDTH - 1:0] out;
	assign out = in * VALUE;
endmodule
module std_slice (
	in,
	out
);
	parameter IN_WIDTH = 32;
	parameter OUT_WIDTH = 32;
	input wire [IN_WIDTH - 1:0] in;
	output wire [OUT_WIDTH - 1:0] out;
	assign out = in[OUT_WIDTH - 1:0];
endmodule
module std_pad (
	in,
	out
);
	parameter IN_WIDTH = 32;
	parameter OUT_WIDTH = 32;
	input wire [IN_WIDTH - 1:0] in;
	output wire [OUT_WIDTH - 1:0] out;
	localparam EXTEND = OUT_WIDTH - IN_WIDTH;
	assign out = {{EXTEND {1'b0}}, in};
endmodule
module std_cat (
	left,
	right,
	out
);
	parameter LEFT_WIDTH = 32;
	parameter RIGHT_WIDTH = 32;
	parameter OUT_WIDTH = 64;
	input wire [LEFT_WIDTH - 1:0] left;
	input wire [RIGHT_WIDTH - 1:0] right;
	output wire [OUT_WIDTH - 1:0] out;
	assign out = {left, right};
endmodule
module std_not (
	in,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] in;
	output wire [WIDTH - 1:0] out;
	assign out = ~in;
endmodule
module std_and (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left & right;
endmodule
module std_or (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left | right;
endmodule
module std_xor (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left ^ right;
endmodule
module std_sub (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left - right;
endmodule
module std_gt (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire out;
	assign out = left > right;
endmodule
module std_lt (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire out;
	assign out = left < right;
endmodule
module std_eq (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire out;
	assign out = left == right;
endmodule
module std_neq (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire out;
	assign out = left != right;
endmodule
module std_ge (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire out;
	assign out = left >= right;
endmodule
module std_le (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire out;
	assign out = left <= right;
endmodule
module std_rsh (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left >> right;
endmodule
module std_mux (
	cond,
	tru,
	fal,
	out
);
	parameter WIDTH = 32;
	input wire cond;
	input wire [WIDTH - 1:0] tru;
	input wire [WIDTH - 1:0] fal;
	output wire [WIDTH - 1:0] out;
	assign out = (cond ? tru : fal);
endmodule
module std_bit_slice (
	in,
	out
);
	parameter IN_WIDTH = 32;
	parameter START_IDX = 0;
	parameter END_IDX = 31;
	parameter OUT_WIDTH = 32;
	input wire [IN_WIDTH - 1:0] in;
	output wire [OUT_WIDTH - 1:0] out;
	assign out = in[END_IDX:START_IDX];
endmodule
module std_skid_buffer (
	in,
	i_valid,
	i_ready,
	clk,
	reset,
	out,
	o_valid,
	o_ready
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] in;
	input wire i_valid;
	input wire i_ready;
	input wire clk;
	input wire reset;
	output wire [WIDTH - 1:0] out;
	output wire o_valid;
	output wire o_ready;
	reg [WIDTH - 1:0] val;
	reg bypass_rg;
	always @(posedge clk)
		if (reset) begin
			val <= 1'sb0;
			bypass_rg <= 1'b1;
		end
		else if (bypass_rg) begin
			if (!i_ready && i_valid) begin
				val <= in;
				bypass_rg <= 1'b0;
			end
		end
		else if (i_ready)
			bypass_rg <= 1'b1;
	assign o_ready = bypass_rg;
	assign out = (bypass_rg ? in : val);
	assign o_valid = (bypass_rg ? i_valid : 1'b1);
endmodule
module std_bypass_reg (
	in,
	write_en,
	clk,
	reset,
	out,
	done
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] in;
	input wire write_en;
	input wire clk;
	input wire reset;
	output wire [WIDTH - 1:0] out;
	output reg done;
	reg [WIDTH - 1:0] val;
	assign out = (write_en ? in : val);
	always @(posedge clk)
		if (reset) begin
			val <= 0;
			done <= 0;
		end
		else if (write_en) begin
			val <= in;
			done <= 1'd1;
		end
		else
			done <= 1'd0;
endmodule
module seq_mem_d1 (
	clk,
	reset,
	addr0,
	content_en,
	done,
	read_data,
	write_data,
	write_en
);
	parameter WIDTH = 32;
	parameter SIZE = 16;
	parameter IDX_SIZE = 4;
	input wire clk;
	input wire reset;
	input wire [IDX_SIZE - 1:0] addr0;
	input wire content_en;
	output reg done;
	output wire [WIDTH - 1:0] read_data;
	input wire [WIDTH - 1:0] write_data;
	input wire write_en;
	reg [WIDTH - 1:0] mem [SIZE - 1:0];
	reg [WIDTH - 1:0] read_out;
	assign read_data = read_out;
	always @(posedge clk)
		if (reset)
			read_out <= 1'sb0;
		else if (content_en && !write_en)
			read_out <= mem[addr0];
		else if (content_en && write_en)
			read_out <= 1'sbx;
		else
			read_out <= read_out;
	always @(posedge clk)
		if (reset)
			done <= 1'sb0;
		else if (content_en)
			done <= 1'sb1;
		else
			done <= 1'sb0;
	always @(posedge clk)
		if ((!reset && content_en) && write_en)
			mem[addr0] <= write_data;
endmodule
module seq_mem_d2 (
	clk,
	reset,
	addr0,
	addr1,
	content_en,
	done,
	read_data,
	write_en,
	write_data
);
	parameter WIDTH = 32;
	parameter D0_SIZE = 16;
	parameter D1_SIZE = 16;
	parameter D0_IDX_SIZE = 4;
	parameter D1_IDX_SIZE = 4;
	input wire clk;
	input wire reset;
	input wire [D0_IDX_SIZE - 1:0] addr0;
	input wire [D1_IDX_SIZE - 1:0] addr1;
	input wire content_en;
	output wire done;
	output wire [WIDTH - 1:0] read_data;
	input wire write_en;
	input wire [WIDTH - 1:0] write_data;
	wire [(D0_IDX_SIZE + D1_IDX_SIZE) - 1:0] addr;
	assign addr = (addr0 * D1_SIZE) + addr1;
	seq_mem_d1 #(
		.WIDTH(WIDTH),
		.SIZE(D0_SIZE * D1_SIZE),
		.IDX_SIZE(D0_IDX_SIZE + D1_IDX_SIZE)
	) mem(
		.clk(clk),
		.reset(reset),
		.addr0(addr),
		.content_en(content_en),
		.read_data(read_data),
		.write_data(write_data),
		.write_en(write_en),
		.done(done)
	);
endmodule
module seq_mem_d3 (
	clk,
	reset,
	addr0,
	addr1,
	addr2,
	content_en,
	done,
	read_data,
	write_en,
	write_data
);
	parameter WIDTH = 32;
	parameter D0_SIZE = 16;
	parameter D1_SIZE = 16;
	parameter D2_SIZE = 16;
	parameter D0_IDX_SIZE = 4;
	parameter D1_IDX_SIZE = 4;
	parameter D2_IDX_SIZE = 4;
	input wire clk;
	input wire reset;
	input wire [D0_IDX_SIZE - 1:0] addr0;
	input wire [D1_IDX_SIZE - 1:0] addr1;
	input wire [D2_IDX_SIZE - 1:0] addr2;
	input wire content_en;
	output wire done;
	output wire [WIDTH - 1:0] read_data;
	input wire write_en;
	input wire [WIDTH - 1:0] write_data;
	wire [((D0_IDX_SIZE + D1_IDX_SIZE) + D2_IDX_SIZE) - 1:0] addr;
	assign addr = ((addr0 * (D1_SIZE * D2_SIZE)) + (addr1 * D2_SIZE)) + addr2;
	seq_mem_d1 #(
		.WIDTH(WIDTH),
		.SIZE((D0_SIZE * D1_SIZE) * D2_SIZE),
		.IDX_SIZE((D0_IDX_SIZE + D1_IDX_SIZE) + D2_IDX_SIZE)
	) mem(
		.clk(clk),
		.reset(reset),
		.addr0(addr),
		.content_en(content_en),
		.read_data(read_data),
		.write_data(write_data),
		.write_en(write_en),
		.done(done)
	);
endmodule
module seq_mem_d4 (
	clk,
	reset,
	addr0,
	addr1,
	addr2,
	addr3,
	content_en,
	done,
	read_data,
	write_en,
	write_data
);
	parameter WIDTH = 32;
	parameter D0_SIZE = 16;
	parameter D1_SIZE = 16;
	parameter D2_SIZE = 16;
	parameter D3_SIZE = 16;
	parameter D0_IDX_SIZE = 4;
	parameter D1_IDX_SIZE = 4;
	parameter D2_IDX_SIZE = 4;
	parameter D3_IDX_SIZE = 4;
	input wire clk;
	input wire reset;
	input wire [D0_IDX_SIZE - 1:0] addr0;
	input wire [D1_IDX_SIZE - 1:0] addr1;
	input wire [D2_IDX_SIZE - 1:0] addr2;
	input wire [D3_IDX_SIZE - 1:0] addr3;
	input wire content_en;
	output wire done;
	output wire [WIDTH - 1:0] read_data;
	input wire write_en;
	input wire [WIDTH - 1:0] write_data;
	wire [(((D0_IDX_SIZE + D1_IDX_SIZE) + D2_IDX_SIZE) + D3_IDX_SIZE) - 1:0] addr;
	assign addr = (((addr0 * ((D1_SIZE * D2_SIZE) * D3_SIZE)) + (addr1 * (D2_SIZE * D3_SIZE))) + (addr2 * D3_SIZE)) + addr3;
	seq_mem_d1 #(
		.WIDTH(WIDTH),
		.SIZE(((D0_SIZE * D1_SIZE) * D2_SIZE) * D3_SIZE),
		.IDX_SIZE(((D0_IDX_SIZE + D1_IDX_SIZE) + D2_IDX_SIZE) + D3_IDX_SIZE)
	) mem(
		.clk(clk),
		.reset(reset),
		.addr0(addr),
		.content_en(content_en),
		.read_data(read_data),
		.write_data(write_data),
		.write_en(write_en),
		.done(done)
	);
endmodule
module undef (out);
	parameter WIDTH = 32;
	output wire [WIDTH - 1:0] out;
	assign out = 1'sbx;
endmodule
module std_const (out);
	parameter WIDTH = 32;
	parameter VALUE = 32;
	output wire [WIDTH - 1:0] out;
	assign out = VALUE;
endmodule
module std_wire (
	in,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] in;
	output wire [WIDTH - 1:0] out;
	assign out = in;
endmodule
module std_add (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left + right;
endmodule
module std_lsh (
	left,
	right,
	out
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] left;
	input wire [WIDTH - 1:0] right;
	output wire [WIDTH - 1:0] out;
	assign out = left << right;
endmodule
module std_reg (
	in,
	write_en,
	clk,
	reset,
	out,
	done
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] in;
	input wire write_en;
	input wire clk;
	input wire reset;
	output reg [WIDTH - 1:0] out;
	output reg done;
	always @(posedge clk)
		if (reset) begin
			out <= 0;
			done <= 0;
		end
		else if (write_en) begin
			out <= in;
			done <= 1'd1;
		end
		else
			done <= 1'd0;
endmodule
module init_one_reg (
	in,
	write_en,
	clk,
	reset,
	out,
	done
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] in;
	input wire write_en;
	input wire clk;
	input wire reset;
	output reg [WIDTH - 1:0] out;
	output reg done;
	always @(posedge clk)
		if (reset) begin
			out <= 1;
			done <= 0;
		end
		else if (write_en) begin
			out <= in;
			done <= 1'd1;
		end
		else
			done <= 1'd0;
endmodule
module main (
	in0,
	in1,
	clk,
	reset,
	go,
	done
);
	reg _sv2v_0;
	input wire [31:0] in0;
	input wire [31:0] in1;
	input wire clk;
	input wire reset;
	input wire go;
	output wire done;
	// string DATA;
	// reg signed [31:0] CODE;
	// initial begin
	// 	CODE = $value$plusargs("DATA=%s", DATA);
	// 	$display("DATA (path to meminit files): %s", DATA);
	// 	$readmemh({DATA, "/mem_2.dat"}, mem_2.mem.mem);
	// 	$readmemh({DATA, "/mem_1.dat"}, mem_1.mem.mem);
	// 	$readmemh({DATA, "/mem_0.dat"}, mem_0.mem.mem);
	// end
	// final begin
	// 	$writememh({DATA, "/mem_2.out"}, mem_2.mem.mem);
	// 	$writememh({DATA, "/mem_1.out"}, mem_1.mem.mem);
	// 	$writememh({DATA, "/mem_0.out"}, mem_0.mem.mem);
	// end
	wire mem_2_clk;
	wire mem_2_reset;
	wire [4:0] mem_2_addr0;
	wire [4:0] mem_2_addr1;
	wire mem_2_content_en;
	wire mem_2_write_en;
	wire [31:0] mem_2_write_data;
	wire [31:0] mem_2_read_data;
	wire mem_2_done;
	wire mem_1_clk;
	wire mem_1_reset;
	wire [4:0] mem_1_addr0;
	wire [4:0] mem_1_addr1;
	wire mem_1_content_en;
	wire mem_1_write_en;
	wire [31:0] mem_1_write_data;
	wire [31:0] mem_1_read_data;
	wire mem_1_done;
	wire mem_0_clk;
	wire mem_0_reset;
	wire [4:0] mem_0_addr0;
	wire [4:0] mem_0_addr1;
	wire mem_0_content_en;
	wire mem_0_write_en;
	wire [31:0] mem_0_write_data;
	wire [31:0] mem_0_read_data;
	wire mem_0_done;
	wire [31:0] gemm_instance_in0;
	wire [31:0] gemm_instance_in1;
	wire gemm_instance_clk;
	wire gemm_instance_reset;
	wire gemm_instance_go;
	wire gemm_instance_done;
	wire [31:0] gemm_instance_arg_mem_0_read_data;
	wire gemm_instance_arg_mem_1_done;
	wire gemm_instance_arg_mem_0_write_en;
	wire [31:0] gemm_instance_arg_mem_2_read_data;
	wire gemm_instance_arg_mem_0_done;
	wire [4:0] gemm_instance_arg_mem_2_addr0;
	wire [31:0] gemm_instance_arg_mem_1_write_data;
	wire [4:0] gemm_instance_arg_mem_2_addr1;
	wire [31:0] gemm_instance_arg_mem_1_read_data;
	wire [31:0] gemm_instance_arg_mem_2_write_data;
	wire gemm_instance_arg_mem_0_content_en;
	wire [4:0] gemm_instance_arg_mem_0_addr0;
	wire gemm_instance_arg_mem_2_content_en;
	wire gemm_instance_arg_mem_1_write_en;
	wire [4:0] gemm_instance_arg_mem_0_addr1;
	wire [31:0] gemm_instance_arg_mem_0_write_data;
	wire gemm_instance_arg_mem_1_content_en;
	wire [4:0] gemm_instance_arg_mem_1_addr1;
	wire gemm_instance_arg_mem_2_write_en;
	wire [4:0] gemm_instance_arg_mem_1_addr0;
	wire gemm_instance_arg_mem_2_done;
	wire [1:0] fsm_in;
	wire fsm_write_en;
	wire fsm_clk;
	wire fsm_reset;
	wire [1:0] fsm_out;
	wire fsm_done;
	wire invoke0_go_in;
	wire invoke0_go_out;
	wire invoke0_done_in;
	wire invoke0_done_out;
	wire invoke1_go_in;
	wire invoke1_go_out;
	wire invoke1_done_in;
	wire invoke1_done_out;
	wire tdcc_go_in;
	wire tdcc_go_out;
	wire tdcc_done_in;
	wire tdcc_done_out;
	seq_mem_d2 #(
		.D0_IDX_SIZE(5),
		.D0_SIZE(30),
		.D1_IDX_SIZE(5),
		.D1_SIZE(30),
		.WIDTH(32)
	) mem_2(
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
	seq_mem_d2 #(
		.D0_IDX_SIZE(5),
		.D0_SIZE(30),
		.D1_IDX_SIZE(5),
		.D1_SIZE(30),
		.WIDTH(32)
	) mem_1(
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
	seq_mem_d2 #(
		.D0_IDX_SIZE(5),
		.D0_SIZE(30),
		.D1_IDX_SIZE(5),
		.D1_SIZE(30),
		.WIDTH(32)
	) mem_0(
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
	gemm gemm_instance(
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
	std_reg #(.WIDTH(2)) fsm(
		.clk(fsm_clk),
		.done(fsm_done),
		.in(fsm_in),
		.out(fsm_out),
		.reset(fsm_reset),
		.write_en(fsm_write_en)
	);
	std_wire #(.WIDTH(1)) invoke0_go(
		.in(invoke0_go_in),
		.out(invoke0_go_out)
	);
	std_wire #(.WIDTH(1)) invoke0_done(
		.in(invoke0_done_in),
		.out(invoke0_done_out)
	);
	std_wire #(.WIDTH(1)) invoke1_go(
		.in(invoke1_go_in),
		.out(invoke1_go_out)
	);
	std_wire #(.WIDTH(1)) invoke1_done(
		.in(invoke1_done_in),
		.out(invoke1_done_out)
	);
	std_wire #(.WIDTH(1)) tdcc_go(
		.in(tdcc_go_in),
		.out(tdcc_go_out)
	);
	std_wire #(.WIDTH(1)) tdcc_done(
		.in(tdcc_done_in),
		.out(tdcc_done_out)
	);
	wire _guard0 = 1;
	wire _guard1 = tdcc_done_out;
	wire _guard2 = fsm_out == 2'd2;
	wire _guard3 = fsm_out == 2'd0;
	wire _guard4 = invoke0_done_out;
	wire _guard5 = _guard3 & _guard4;
	wire _guard6 = tdcc_go_out;
	wire _guard7 = _guard5 & _guard6;
	wire _guard8 = _guard2 | _guard7;
	wire _guard9 = fsm_out == 2'd1;
	wire _guard10 = invoke1_done_out;
	wire _guard11 = _guard9 & _guard10;
	wire _guard12 = tdcc_go_out;
	wire _guard13 = _guard11 & _guard12;
	wire _guard14 = _guard8 | _guard13;
	wire _guard15 = fsm_out == 2'd0;
	wire _guard16 = invoke0_done_out;
	wire _guard17 = _guard15 & _guard16;
	wire _guard18 = tdcc_go_out;
	wire _guard19 = _guard17 & _guard18;
	wire _guard20 = fsm_out == 2'd2;
	wire _guard21 = fsm_out == 2'd1;
	wire _guard22 = invoke1_done_out;
	wire _guard23 = _guard21 & _guard22;
	wire _guard24 = tdcc_go_out;
	wire _guard25 = _guard23 & _guard24;
	wire _guard26 = invoke1_go_out;
	wire _guard27 = invoke1_go_out;
	wire _guard28 = invoke1_go_out;
	wire _guard29 = invoke1_go_out;
	wire _guard30 = invoke1_go_out;
	wire _guard31 = invoke0_done_out;
	wire _guard32 = ~_guard31;
	wire _guard33 = fsm_out == 2'd0;
	wire _guard34 = _guard32 & _guard33;
	wire _guard35 = tdcc_go_out;
	wire _guard36 = _guard34 & _guard35;
	wire _guard37 = invoke1_go_out;
	wire _guard38 = invoke1_go_out;
	wire _guard39 = invoke1_go_out;
	wire _guard40 = invoke1_go_out;
	wire _guard41 = invoke1_go_out;
	wire _guard42 = invoke1_done_out;
	wire _guard43 = ~_guard42;
	wire _guard44 = fsm_out == 2'd1;
	wire _guard45 = _guard43 & _guard44;
	wire _guard46 = tdcc_go_out;
	wire _guard47 = _guard45 & _guard46;
	wire _guard48 = invoke1_go_out;
	wire _guard49 = invoke1_go_out;
	wire _guard50 = invoke1_go_out;
	wire _guard51 = invoke1_go_out;
	wire _guard52 = invoke1_go_out;
	wire _guard53 = fsm_out == 2'd2;
	wire _guard54 = invoke1_go_out;
	wire _guard55 = invoke1_go_out;
	wire _guard56 = invoke1_go_out;
	wire _guard57 = invoke1_go_out;
	wire _guard58 = invoke1_go_out;
	wire _guard59 = invoke0_go_out;
	wire _guard60 = invoke0_go_out;
	wire _guard61 = invoke1_go_out;
	wire _guard62 = _guard60 | _guard61;
	wire _guard63 = invoke1_go_out;
	wire _guard64 = invoke1_go_out;
	wire _guard65 = invoke1_go_out;
	assign done = _guard1;
	assign fsm_write_en = _guard14;
	assign fsm_clk = clk;
	assign fsm_reset = reset;
	assign fsm_in = (_guard19 ? 2'd1 : (_guard20 ? 2'd0 : (_guard25 ? 2'd2 : 2'd0)));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard25, _guard20, _guard19}))
			$fatal(2, "Multiple assignment to port `fsm.in'.");
	end
	assign mem_2_write_en = (_guard26 ? gemm_instance_arg_mem_2_write_en : 1'd0);
	assign mem_2_clk = clk;
	assign mem_2_addr0 = gemm_instance_arg_mem_2_addr0;
	assign mem_2_content_en = (_guard28 ? gemm_instance_arg_mem_2_content_en : 1'd0);
	assign mem_2_reset = reset;
	assign mem_2_write_data = gemm_instance_arg_mem_2_write_data;
	assign mem_2_addr1 = gemm_instance_arg_mem_2_addr1;
	assign invoke0_go_in = _guard36;
	assign tdcc_go_in = go;
	assign mem_1_write_en = (_guard37 ? gemm_instance_arg_mem_1_write_en : 1'd0);
	assign mem_1_clk = clk;
	assign mem_1_addr0 = gemm_instance_arg_mem_1_addr0;
	assign mem_1_content_en = (_guard39 ? gemm_instance_arg_mem_1_content_en : 1'd0);
	assign mem_1_reset = reset;
	assign mem_1_write_data = gemm_instance_arg_mem_1_write_data;
	assign mem_1_addr1 = gemm_instance_arg_mem_1_addr1;
	assign invoke0_done_in = gemm_instance_done;
	assign invoke1_go_in = _guard47;
	assign mem_0_write_en = (_guard48 ? gemm_instance_arg_mem_0_write_en : 1'd0);
	assign mem_0_clk = clk;
	assign mem_0_addr0 = gemm_instance_arg_mem_0_addr0;
	assign mem_0_content_en = (_guard50 ? gemm_instance_arg_mem_0_content_en : 1'd0);
	assign mem_0_reset = reset;
	assign mem_0_write_data = gemm_instance_arg_mem_0_write_data;
	assign mem_0_addr1 = gemm_instance_arg_mem_0_addr1;
	assign tdcc_done_in = _guard53;
	assign invoke1_done_in = gemm_instance_done;
	assign gemm_instance_arg_mem_0_read_data = (_guard54 ? mem_0_read_data : 32'd0);
	assign gemm_instance_arg_mem_0_done = (_guard55 ? mem_0_done : 1'd0);
	assign gemm_instance_arg_mem_2_read_data = (_guard56 ? mem_2_read_data : 32'd0);
	assign gemm_instance_in1 = (_guard57 ? in1 : 32'd0);
	assign gemm_instance_arg_mem_1_read_data = (_guard58 ? mem_1_read_data : 32'd0);
	assign gemm_instance_clk = clk;
	assign gemm_instance_reset = (_guard0 ? reset : (_guard59 ? 1'd1 : 1'd0));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard59, _guard0}))
			$fatal(2, "Multiple assignment to port `gemm_instance.reset'.");
	end
	assign gemm_instance_go = _guard62;
	assign gemm_instance_arg_mem_2_done = (_guard63 ? mem_2_done : 1'd0);
	assign gemm_instance_arg_mem_1_done = (_guard64 ? mem_1_done : 1'd0);
	assign gemm_instance_in0 = (_guard65 ? in0 : 32'd0);
	initial _sv2v_0 = 0;
endmodule
module gemm (
	in0,
	in1,
	clk,
	reset,
	go,
	done,
	arg_mem_2_addr0,
	arg_mem_2_addr1,
	arg_mem_2_content_en,
	arg_mem_2_write_en,
	arg_mem_2_write_data,
	arg_mem_2_read_data,
	arg_mem_2_done,
	arg_mem_1_addr0,
	arg_mem_1_addr1,
	arg_mem_1_content_en,
	arg_mem_1_write_en,
	arg_mem_1_write_data,
	arg_mem_1_read_data,
	arg_mem_1_done,
	arg_mem_0_addr0,
	arg_mem_0_addr1,
	arg_mem_0_content_en,
	arg_mem_0_write_en,
	arg_mem_0_write_data,
	arg_mem_0_read_data,
	arg_mem_0_done
);
	reg _sv2v_0;
	input wire [31:0] in0;
	input wire [31:0] in1;
	input wire clk;
	input wire reset;
	input wire go;
	output wire done;
	output wire [4:0] arg_mem_2_addr0;
	output wire [4:0] arg_mem_2_addr1;
	output wire arg_mem_2_content_en;
	output wire arg_mem_2_write_en;
	output wire [31:0] arg_mem_2_write_data;
	input wire [31:0] arg_mem_2_read_data;
	input wire arg_mem_2_done;
	output wire [4:0] arg_mem_1_addr0;
	output wire [4:0] arg_mem_1_addr1;
	output wire arg_mem_1_content_en;
	output wire arg_mem_1_write_en;
	output wire [31:0] arg_mem_1_write_data;
	input wire [31:0] arg_mem_1_read_data;
	input wire arg_mem_1_done;
	output wire [4:0] arg_mem_0_addr0;
	output wire [4:0] arg_mem_0_addr1;
	output wire arg_mem_0_content_en;
	output wire arg_mem_0_write_en;
	output wire [31:0] arg_mem_0_write_data;
	input wire [31:0] arg_mem_0_read_data;
	input wire arg_mem_0_done;
	wire [31:0] std_slice_7_in;
	wire [4:0] std_slice_7_out;
	wire [31:0] std_slice_6_in;
	wire [4:0] std_slice_6_out;
	wire [31:0] std_add_3_left;
	wire [31:0] std_add_3_right;
	wire [31:0] std_add_3_out;
	wire [31:0] muli_2_reg_in;
	wire muli_2_reg_write_en;
	wire muli_2_reg_clk;
	wire muli_2_reg_reset;
	wire [31:0] muli_2_reg_out;
	wire muli_2_reg_done;
	wire std_mult_pipe_2_clk;
	wire std_mult_pipe_2_reset;
	wire std_mult_pipe_2_go;
	wire [31:0] std_mult_pipe_2_left;
	wire [31:0] std_mult_pipe_2_right;
	wire [31:0] std_mult_pipe_2_out;
	wire std_mult_pipe_2_done;
	wire [31:0] std_add_2_left;
	wire [31:0] std_add_2_right;
	wire [31:0] std_add_2_out;
	wire [31:0] std_slt_2_left;
	wire [31:0] std_slt_2_right;
	wire std_slt_2_out;
	wire [31:0] while_2_arg0_reg_in;
	wire while_2_arg0_reg_write_en;
	wire while_2_arg0_reg_clk;
	wire while_2_arg0_reg_reset;
	wire [31:0] while_2_arg0_reg_out;
	wire while_2_arg0_reg_done;
	wire [31:0] while_1_arg0_reg_in;
	wire while_1_arg0_reg_write_en;
	wire while_1_arg0_reg_clk;
	wire while_1_arg0_reg_reset;
	wire [31:0] while_1_arg0_reg_out;
	wire while_1_arg0_reg_done;
	wire [31:0] while_0_arg1_reg_in;
	wire while_0_arg1_reg_write_en;
	wire while_0_arg1_reg_clk;
	wire while_0_arg1_reg_reset;
	wire [31:0] while_0_arg1_reg_out;
	wire while_0_arg1_reg_done;
	wire [31:0] while_0_arg0_reg_in;
	wire while_0_arg0_reg_write_en;
	wire while_0_arg0_reg_clk;
	wire while_0_arg0_reg_reset;
	wire [31:0] while_0_arg0_reg_out;
	wire while_0_arg0_reg_done;
	wire comb_reg_in;
	wire comb_reg_write_en;
	wire comb_reg_clk;
	wire comb_reg_reset;
	wire comb_reg_out;
	wire comb_reg_done;
	wire comb_reg0_in;
	wire comb_reg0_write_en;
	wire comb_reg0_clk;
	wire comb_reg0_reset;
	wire comb_reg0_out;
	wire comb_reg0_done;
	wire comb_reg1_in;
	wire comb_reg1_write_en;
	wire comb_reg1_clk;
	wire comb_reg1_reset;
	wire comb_reg1_out;
	wire comb_reg1_done;
	wire [2:0] fsm_in;
	wire fsm_write_en;
	wire fsm_clk;
	wire fsm_reset;
	wire [2:0] fsm_out;
	wire fsm_done;
	wire ud_out;
	wire [2:0] adder_left;
	wire [2:0] adder_right;
	wire [2:0] adder_out;
	wire ud0_out;
	wire [2:0] adder0_left;
	wire [2:0] adder0_right;
	wire [2:0] adder0_out;
	wire ud1_out;
	wire [2:0] adder1_left;
	wire [2:0] adder1_right;
	wire [2:0] adder1_out;
	wire ud2_out;
	wire [2:0] adder2_left;
	wire [2:0] adder2_right;
	wire [2:0] adder2_out;
	wire ud3_out;
	wire [2:0] adder3_left;
	wire [2:0] adder3_right;
	wire [2:0] adder3_out;
	wire ud4_out;
	wire [2:0] adder4_left;
	wire [2:0] adder4_right;
	wire [2:0] adder4_out;
	wire signal_reg_in;
	wire signal_reg_write_en;
	wire signal_reg_clk;
	wire signal_reg_reset;
	wire signal_reg_out;
	wire signal_reg_done;
	wire [4:0] fsm0_in;
	wire fsm0_write_en;
	wire fsm0_clk;
	wire fsm0_reset;
	wire [4:0] fsm0_out;
	wire fsm0_done;
	wire beg_spl_bb0_4_go_in;
	wire beg_spl_bb0_4_go_out;
	wire beg_spl_bb0_4_done_in;
	wire beg_spl_bb0_4_done_out;
	wire bb0_8_go_in;
	wire bb0_8_go_out;
	wire bb0_8_done_in;
	wire bb0_8_done_out;
	wire bb0_10_go_in;
	wire bb0_10_go_out;
	wire bb0_10_done_in;
	wire bb0_10_done_out;
	wire assign_while_0_latch_go_in;
	wire assign_while_0_latch_go_out;
	wire assign_while_0_latch_done_in;
	wire assign_while_0_latch_done_out;
	wire bb0_13_go_in;
	wire bb0_13_go_out;
	wire bb0_13_done_in;
	wire bb0_13_done_out;
	wire invoke0_go_in;
	wire invoke0_go_out;
	wire invoke0_done_in;
	wire invoke0_done_out;
	wire invoke1_go_in;
	wire invoke1_go_out;
	wire invoke1_done_in;
	wire invoke1_done_out;
	wire invoke2_go_in;
	wire invoke2_go_out;
	wire invoke2_done_in;
	wire invoke2_done_out;
	wire invoke11_go_in;
	wire invoke11_go_out;
	wire invoke11_done_in;
	wire invoke11_done_out;
	wire invoke12_go_in;
	wire invoke12_go_out;
	wire invoke12_done_in;
	wire invoke12_done_out;
	wire early_reset_bb0_00_go_in;
	wire early_reset_bb0_00_go_out;
	wire early_reset_bb0_00_done_in;
	wire early_reset_bb0_00_done_out;
	wire early_reset_bb0_20_go_in;
	wire early_reset_bb0_20_go_out;
	wire early_reset_bb0_20_done_in;
	wire early_reset_bb0_20_done_out;
	wire early_reset_bb0_60_go_in;
	wire early_reset_bb0_60_go_out;
	wire early_reset_bb0_60_done_in;
	wire early_reset_bb0_60_done_out;
	wire early_reset_static_seq_go_in;
	wire early_reset_static_seq_go_out;
	wire early_reset_static_seq_done_in;
	wire early_reset_static_seq_done_out;
	wire early_reset_static_seq0_go_in;
	wire early_reset_static_seq0_go_out;
	wire early_reset_static_seq0_done_in;
	wire early_reset_static_seq0_done_out;
	wire early_reset_static_seq1_go_in;
	wire early_reset_static_seq1_go_out;
	wire early_reset_static_seq1_done_in;
	wire early_reset_static_seq1_done_out;
	wire wrapper_early_reset_bb0_00_go_in;
	wire wrapper_early_reset_bb0_00_go_out;
	wire wrapper_early_reset_bb0_00_done_in;
	wire wrapper_early_reset_bb0_00_done_out;
	wire wrapper_early_reset_bb0_20_go_in;
	wire wrapper_early_reset_bb0_20_go_out;
	wire wrapper_early_reset_bb0_20_done_in;
	wire wrapper_early_reset_bb0_20_done_out;
	wire wrapper_early_reset_static_seq_go_in;
	wire wrapper_early_reset_static_seq_go_out;
	wire wrapper_early_reset_static_seq_done_in;
	wire wrapper_early_reset_static_seq_done_out;
	wire wrapper_early_reset_bb0_60_go_in;
	wire wrapper_early_reset_bb0_60_go_out;
	wire wrapper_early_reset_bb0_60_done_in;
	wire wrapper_early_reset_bb0_60_done_out;
	wire wrapper_early_reset_static_seq0_go_in;
	wire wrapper_early_reset_static_seq0_go_out;
	wire wrapper_early_reset_static_seq0_done_in;
	wire wrapper_early_reset_static_seq0_done_out;
	wire wrapper_early_reset_static_seq1_go_in;
	wire wrapper_early_reset_static_seq1_go_out;
	wire wrapper_early_reset_static_seq1_done_in;
	wire wrapper_early_reset_static_seq1_done_out;
	wire tdcc_go_in;
	wire tdcc_go_out;
	wire tdcc_done_in;
	wire tdcc_done_out;
	std_slice #(
		.IN_WIDTH(32),
		.OUT_WIDTH(5)
	) std_slice_7(
		.in(std_slice_7_in),
		.out(std_slice_7_out)
	);
	std_slice #(
		.IN_WIDTH(32),
		.OUT_WIDTH(5)
	) std_slice_6(
		.in(std_slice_6_in),
		.out(std_slice_6_out)
	);
	std_add #(.WIDTH(32)) std_add_3(
		.left(std_add_3_left),
		.out(std_add_3_out),
		.right(std_add_3_right)
	);
	std_reg #(.WIDTH(32)) muli_2_reg(
		.clk(muli_2_reg_clk),
		.done(muli_2_reg_done),
		.in(muli_2_reg_in),
		.out(muli_2_reg_out),
		.reset(muli_2_reg_reset),
		.write_en(muli_2_reg_write_en)
	);
	std_mult_pipe #(.WIDTH(32)) std_mult_pipe_2(
		.clk(std_mult_pipe_2_clk),
		.done(std_mult_pipe_2_done),
		.go(std_mult_pipe_2_go),
		.left(std_mult_pipe_2_left),
		.out(std_mult_pipe_2_out),
		.reset(std_mult_pipe_2_reset),
		.right(std_mult_pipe_2_right)
	);
	std_add #(.WIDTH(32)) std_add_2(
		.left(std_add_2_left),
		.out(std_add_2_out),
		.right(std_add_2_right)
	);
	std_slt #(.WIDTH(32)) std_slt_2(
		.left(std_slt_2_left),
		.out(std_slt_2_out),
		.right(std_slt_2_right)
	);
	std_reg #(.WIDTH(32)) while_2_arg0_reg(
		.clk(while_2_arg0_reg_clk),
		.done(while_2_arg0_reg_done),
		.in(while_2_arg0_reg_in),
		.out(while_2_arg0_reg_out),
		.reset(while_2_arg0_reg_reset),
		.write_en(while_2_arg0_reg_write_en)
	);
	std_reg #(.WIDTH(32)) while_1_arg0_reg(
		.clk(while_1_arg0_reg_clk),
		.done(while_1_arg0_reg_done),
		.in(while_1_arg0_reg_in),
		.out(while_1_arg0_reg_out),
		.reset(while_1_arg0_reg_reset),
		.write_en(while_1_arg0_reg_write_en)
	);
	std_reg #(.WIDTH(32)) while_0_arg1_reg(
		.clk(while_0_arg1_reg_clk),
		.done(while_0_arg1_reg_done),
		.in(while_0_arg1_reg_in),
		.out(while_0_arg1_reg_out),
		.reset(while_0_arg1_reg_reset),
		.write_en(while_0_arg1_reg_write_en)
	);
	std_reg #(.WIDTH(32)) while_0_arg0_reg(
		.clk(while_0_arg0_reg_clk),
		.done(while_0_arg0_reg_done),
		.in(while_0_arg0_reg_in),
		.out(while_0_arg0_reg_out),
		.reset(while_0_arg0_reg_reset),
		.write_en(while_0_arg0_reg_write_en)
	);
	std_reg #(.WIDTH(1)) comb_reg(
		.clk(comb_reg_clk),
		.done(comb_reg_done),
		.in(comb_reg_in),
		.out(comb_reg_out),
		.reset(comb_reg_reset),
		.write_en(comb_reg_write_en)
	);
	std_reg #(.WIDTH(1)) comb_reg0(
		.clk(comb_reg0_clk),
		.done(comb_reg0_done),
		.in(comb_reg0_in),
		.out(comb_reg0_out),
		.reset(comb_reg0_reset),
		.write_en(comb_reg0_write_en)
	);
	std_reg #(.WIDTH(1)) comb_reg1(
		.clk(comb_reg1_clk),
		.done(comb_reg1_done),
		.in(comb_reg1_in),
		.out(comb_reg1_out),
		.reset(comb_reg1_reset),
		.write_en(comb_reg1_write_en)
	);
	std_reg #(.WIDTH(3)) fsm(
		.clk(fsm_clk),
		.done(fsm_done),
		.in(fsm_in),
		.out(fsm_out),
		.reset(fsm_reset),
		.write_en(fsm_write_en)
	);
	undef #(.WIDTH(1)) ud(.out(ud_out));
	std_add #(.WIDTH(3)) adder(
		.left(adder_left),
		.out(adder_out),
		.right(adder_right)
	);
	undef #(.WIDTH(1)) ud0(.out(ud0_out));
	std_add #(.WIDTH(3)) adder0(
		.left(adder0_left),
		.out(adder0_out),
		.right(adder0_right)
	);
	undef #(.WIDTH(1)) ud1(.out(ud1_out));
	std_add #(.WIDTH(3)) adder1(
		.left(adder1_left),
		.out(adder1_out),
		.right(adder1_right)
	);
	undef #(.WIDTH(1)) ud2(.out(ud2_out));
	std_add #(.WIDTH(3)) adder2(
		.left(adder2_left),
		.out(adder2_out),
		.right(adder2_right)
	);
	undef #(.WIDTH(1)) ud3(.out(ud3_out));
	std_add #(.WIDTH(3)) adder3(
		.left(adder3_left),
		.out(adder3_out),
		.right(adder3_right)
	);
	undef #(.WIDTH(1)) ud4(.out(ud4_out));
	std_add #(.WIDTH(3)) adder4(
		.left(adder4_left),
		.out(adder4_out),
		.right(adder4_right)
	);
	std_reg #(.WIDTH(1)) signal_reg(
		.clk(signal_reg_clk),
		.done(signal_reg_done),
		.in(signal_reg_in),
		.out(signal_reg_out),
		.reset(signal_reg_reset),
		.write_en(signal_reg_write_en)
	);
	std_reg #(.WIDTH(5)) fsm0(
		.clk(fsm0_clk),
		.done(fsm0_done),
		.in(fsm0_in),
		.out(fsm0_out),
		.reset(fsm0_reset),
		.write_en(fsm0_write_en)
	);
	std_wire #(.WIDTH(1)) beg_spl_bb0_4_go(
		.in(beg_spl_bb0_4_go_in),
		.out(beg_spl_bb0_4_go_out)
	);
	std_wire #(.WIDTH(1)) beg_spl_bb0_4_done(
		.in(beg_spl_bb0_4_done_in),
		.out(beg_spl_bb0_4_done_out)
	);
	std_wire #(.WIDTH(1)) bb0_8_go(
		.in(bb0_8_go_in),
		.out(bb0_8_go_out)
	);
	std_wire #(.WIDTH(1)) bb0_8_done(
		.in(bb0_8_done_in),
		.out(bb0_8_done_out)
	);
	std_wire #(.WIDTH(1)) bb0_10_go(
		.in(bb0_10_go_in),
		.out(bb0_10_go_out)
	);
	std_wire #(.WIDTH(1)) bb0_10_done(
		.in(bb0_10_done_in),
		.out(bb0_10_done_out)
	);
	std_wire #(.WIDTH(1)) assign_while_0_latch_go(
		.in(assign_while_0_latch_go_in),
		.out(assign_while_0_latch_go_out)
	);
	std_wire #(.WIDTH(1)) assign_while_0_latch_done(
		.in(assign_while_0_latch_done_in),
		.out(assign_while_0_latch_done_out)
	);
	std_wire #(.WIDTH(1)) bb0_13_go(
		.in(bb0_13_go_in),
		.out(bb0_13_go_out)
	);
	std_wire #(.WIDTH(1)) bb0_13_done(
		.in(bb0_13_done_in),
		.out(bb0_13_done_out)
	);
	std_wire #(.WIDTH(1)) invoke0_go(
		.in(invoke0_go_in),
		.out(invoke0_go_out)
	);
	std_wire #(.WIDTH(1)) invoke0_done(
		.in(invoke0_done_in),
		.out(invoke0_done_out)
	);
	std_wire #(.WIDTH(1)) invoke1_go(
		.in(invoke1_go_in),
		.out(invoke1_go_out)
	);
	std_wire #(.WIDTH(1)) invoke1_done(
		.in(invoke1_done_in),
		.out(invoke1_done_out)
	);
	std_wire #(.WIDTH(1)) invoke2_go(
		.in(invoke2_go_in),
		.out(invoke2_go_out)
	);
	std_wire #(.WIDTH(1)) invoke2_done(
		.in(invoke2_done_in),
		.out(invoke2_done_out)
	);
	std_wire #(.WIDTH(1)) invoke11_go(
		.in(invoke11_go_in),
		.out(invoke11_go_out)
	);
	std_wire #(.WIDTH(1)) invoke11_done(
		.in(invoke11_done_in),
		.out(invoke11_done_out)
	);
	std_wire #(.WIDTH(1)) invoke12_go(
		.in(invoke12_go_in),
		.out(invoke12_go_out)
	);
	std_wire #(.WIDTH(1)) invoke12_done(
		.in(invoke12_done_in),
		.out(invoke12_done_out)
	);
	std_wire #(.WIDTH(1)) early_reset_bb0_00_go(
		.in(early_reset_bb0_00_go_in),
		.out(early_reset_bb0_00_go_out)
	);
	std_wire #(.WIDTH(1)) early_reset_bb0_00_done(
		.in(early_reset_bb0_00_done_in),
		.out(early_reset_bb0_00_done_out)
	);
	std_wire #(.WIDTH(1)) early_reset_bb0_20_go(
		.in(early_reset_bb0_20_go_in),
		.out(early_reset_bb0_20_go_out)
	);
	std_wire #(.WIDTH(1)) early_reset_bb0_20_done(
		.in(early_reset_bb0_20_done_in),
		.out(early_reset_bb0_20_done_out)
	);
	std_wire #(.WIDTH(1)) early_reset_bb0_60_go(
		.in(early_reset_bb0_60_go_in),
		.out(early_reset_bb0_60_go_out)
	);
	std_wire #(.WIDTH(1)) early_reset_bb0_60_done(
		.in(early_reset_bb0_60_done_in),
		.out(early_reset_bb0_60_done_out)
	);
	std_wire #(.WIDTH(1)) early_reset_static_seq_go(
		.in(early_reset_static_seq_go_in),
		.out(early_reset_static_seq_go_out)
	);
	std_wire #(.WIDTH(1)) early_reset_static_seq_done(
		.in(early_reset_static_seq_done_in),
		.out(early_reset_static_seq_done_out)
	);
	std_wire #(.WIDTH(1)) early_reset_static_seq0_go(
		.in(early_reset_static_seq0_go_in),
		.out(early_reset_static_seq0_go_out)
	);
	std_wire #(.WIDTH(1)) early_reset_static_seq0_done(
		.in(early_reset_static_seq0_done_in),
		.out(early_reset_static_seq0_done_out)
	);
	std_wire #(.WIDTH(1)) early_reset_static_seq1_go(
		.in(early_reset_static_seq1_go_in),
		.out(early_reset_static_seq1_go_out)
	);
	std_wire #(.WIDTH(1)) early_reset_static_seq1_done(
		.in(early_reset_static_seq1_done_in),
		.out(early_reset_static_seq1_done_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_bb0_00_go(
		.in(wrapper_early_reset_bb0_00_go_in),
		.out(wrapper_early_reset_bb0_00_go_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_bb0_00_done(
		.in(wrapper_early_reset_bb0_00_done_in),
		.out(wrapper_early_reset_bb0_00_done_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_bb0_20_go(
		.in(wrapper_early_reset_bb0_20_go_in),
		.out(wrapper_early_reset_bb0_20_go_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_bb0_20_done(
		.in(wrapper_early_reset_bb0_20_done_in),
		.out(wrapper_early_reset_bb0_20_done_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_static_seq_go(
		.in(wrapper_early_reset_static_seq_go_in),
		.out(wrapper_early_reset_static_seq_go_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_static_seq_done(
		.in(wrapper_early_reset_static_seq_done_in),
		.out(wrapper_early_reset_static_seq_done_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_bb0_60_go(
		.in(wrapper_early_reset_bb0_60_go_in),
		.out(wrapper_early_reset_bb0_60_go_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_bb0_60_done(
		.in(wrapper_early_reset_bb0_60_done_in),
		.out(wrapper_early_reset_bb0_60_done_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_static_seq0_go(
		.in(wrapper_early_reset_static_seq0_go_in),
		.out(wrapper_early_reset_static_seq0_go_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_static_seq0_done(
		.in(wrapper_early_reset_static_seq0_done_in),
		.out(wrapper_early_reset_static_seq0_done_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_static_seq1_go(
		.in(wrapper_early_reset_static_seq1_go_in),
		.out(wrapper_early_reset_static_seq1_go_out)
	);
	std_wire #(.WIDTH(1)) wrapper_early_reset_static_seq1_done(
		.in(wrapper_early_reset_static_seq1_done_in),
		.out(wrapper_early_reset_static_seq1_done_out)
	);
	std_wire #(.WIDTH(1)) tdcc_go(
		.in(tdcc_go_in),
		.out(tdcc_go_out)
	);
	std_wire #(.WIDTH(1)) tdcc_done(
		.in(tdcc_done_in),
		.out(tdcc_done_out)
	);
	wire _guard0 = 1;
	wire _guard1 = early_reset_bb0_60_go_out;
	wire _guard2 = early_reset_bb0_60_go_out;
	wire _guard3 = assign_while_0_latch_done_out;
	wire _guard4 = ~_guard3;
	wire _guard5 = fsm0_out == 5'd12;
	wire _guard6 = _guard4 & _guard5;
	wire _guard7 = tdcc_go_out;
	wire _guard8 = _guard6 & _guard7;
	wire _guard9 = while_0_arg1_reg_done;
	wire _guard10 = while_0_arg0_reg_done;
	wire _guard11 = _guard9 & _guard10;
	wire _guard12 = tdcc_done_out;
	wire _guard13 = beg_spl_bb0_4_go_out;
	wire _guard14 = bb0_13_go_out;
	wire _guard15 = _guard13 | _guard14;
	wire _guard16 = bb0_8_go_out;
	wire _guard17 = bb0_8_go_out;
	wire _guard18 = bb0_8_go_out;
	wire _guard19 = bb0_8_go_out;
	wire _guard20 = beg_spl_bb0_4_go_out;
	wire _guard21 = bb0_13_go_out;
	wire _guard22 = _guard20 | _guard21;
	wire _guard23 = beg_spl_bb0_4_go_out;
	wire _guard24 = bb0_13_go_out;
	wire _guard25 = _guard23 | _guard24;
	wire _guard26 = bb0_10_go_out;
	wire _guard27 = bb0_10_go_out;
	wire _guard28 = bb0_13_go_out;
	wire _guard29 = beg_spl_bb0_4_go_out;
	wire _guard30 = bb0_13_go_out;
	wire _guard31 = bb0_10_go_out;
	wire _guard32 = bb0_10_go_out;
	wire _guard33 = early_reset_bb0_00_go_out;
	wire _guard34 = early_reset_bb0_20_go_out;
	wire _guard35 = _guard33 | _guard34;
	wire _guard36 = early_reset_bb0_60_go_out;
	wire _guard37 = _guard35 | _guard36;
	wire _guard38 = early_reset_static_seq_go_out;
	wire _guard39 = _guard37 | _guard38;
	wire _guard40 = early_reset_static_seq0_go_out;
	wire _guard41 = _guard39 | _guard40;
	wire _guard42 = early_reset_static_seq1_go_out;
	wire _guard43 = _guard41 | _guard42;
	wire _guard44 = fsm_out != 3'd0;
	wire _guard45 = early_reset_bb0_60_go_out;
	wire _guard46 = _guard44 & _guard45;
	wire _guard47 = fsm_out != 3'd0;
	wire _guard48 = early_reset_bb0_00_go_out;
	wire _guard49 = _guard47 & _guard48;
	wire _guard50 = fsm_out != 3'd3;
	wire _guard51 = early_reset_static_seq1_go_out;
	wire _guard52 = _guard50 & _guard51;
	wire _guard53 = fsm_out != 3'd4;
	wire _guard54 = early_reset_static_seq_go_out;
	wire _guard55 = _guard53 & _guard54;
	wire _guard56 = fsm_out != 3'd3;
	wire _guard57 = early_reset_static_seq0_go_out;
	wire _guard58 = _guard56 & _guard57;
	wire _guard59 = fsm_out != 3'd0;
	wire _guard60 = early_reset_bb0_20_go_out;
	wire _guard61 = _guard59 & _guard60;
	wire _guard62 = fsm_out == 3'd0;
	wire _guard63 = early_reset_bb0_00_go_out;
	wire _guard64 = _guard62 & _guard63;
	wire _guard65 = fsm_out == 3'd0;
	wire _guard66 = early_reset_bb0_20_go_out;
	wire _guard67 = _guard65 & _guard66;
	wire _guard68 = _guard64 | _guard67;
	wire _guard69 = fsm_out == 3'd0;
	wire _guard70 = early_reset_bb0_60_go_out;
	wire _guard71 = _guard69 & _guard70;
	wire _guard72 = _guard68 | _guard71;
	wire _guard73 = fsm_out == 3'd4;
	wire _guard74 = early_reset_static_seq_go_out;
	wire _guard75 = _guard73 & _guard74;
	wire _guard76 = _guard72 | _guard75;
	wire _guard77 = fsm_out == 3'd3;
	wire _guard78 = early_reset_static_seq0_go_out;
	wire _guard79 = _guard77 & _guard78;
	wire _guard80 = _guard76 | _guard79;
	wire _guard81 = fsm_out == 3'd3;
	wire _guard82 = early_reset_static_seq1_go_out;
	wire _guard83 = _guard81 & _guard82;
	wire _guard84 = _guard80 | _guard83;
	wire _guard85 = early_reset_bb0_00_go_out;
	wire _guard86 = early_reset_bb0_00_go_out;
	wire _guard87 = early_reset_static_seq1_go_out;
	wire _guard88 = early_reset_static_seq1_go_out;
	wire _guard89 = invoke2_done_out;
	wire _guard90 = ~_guard89;
	wire _guard91 = fsm0_out == 5'd5;
	wire _guard92 = _guard90 & _guard91;
	wire _guard93 = tdcc_go_out;
	wire _guard94 = _guard92 & _guard93;
	wire _guard95 = fsm_out == 3'd0;
	wire _guard96 = signal_reg_out;
	wire _guard97 = _guard95 & _guard96;
	wire _guard98 = invoke1_go_out;
	wire _guard99 = invoke11_go_out;
	wire _guard100 = _guard98 | _guard99;
	wire _guard101 = invoke1_go_out;
	wire _guard102 = invoke11_go_out;
	wire _guard103 = early_reset_bb0_00_go_out;
	wire _guard104 = early_reset_bb0_00_go_out;
	wire _guard105 = wrapper_early_reset_bb0_00_done_out;
	wire _guard106 = ~_guard105;
	wire _guard107 = fsm0_out == 5'd1;
	wire _guard108 = _guard106 & _guard107;
	wire _guard109 = tdcc_go_out;
	wire _guard110 = _guard108 & _guard109;
	wire _guard111 = wrapper_early_reset_bb0_00_done_out;
	wire _guard112 = ~_guard111;
	wire _guard113 = fsm0_out == 5'd18;
	wire _guard114 = _guard112 & _guard113;
	wire _guard115 = tdcc_go_out;
	wire _guard116 = _guard114 & _guard115;
	wire _guard117 = _guard110 | _guard116;
	wire _guard118 = assign_while_0_latch_go_out;
	wire _guard119 = assign_while_0_latch_go_out;
	wire _guard120 = early_reset_bb0_20_go_out;
	wire _guard121 = early_reset_bb0_60_go_out;
	wire _guard122 = early_reset_bb0_00_go_out;
	wire _guard123 = early_reset_bb0_00_go_out;
	wire _guard124 = early_reset_bb0_20_go_out;
	wire _guard125 = _guard123 | _guard124;
	wire _guard126 = early_reset_bb0_60_go_out;
	wire _guard127 = _guard125 | _guard126;
	wire _guard128 = wrapper_early_reset_static_seq0_go_out;
	wire _guard129 = fsm_out == 3'd0;
	wire _guard130 = signal_reg_out;
	wire _guard131 = _guard129 & _guard130;
	wire _guard132 = fsm_out < 3'd3;
	wire _guard133 = early_reset_static_seq0_go_out;
	wire _guard134 = _guard132 & _guard133;
	wire _guard135 = fsm_out < 3'd3;
	wire _guard136 = early_reset_static_seq_go_out;
	wire _guard137 = _guard135 & _guard136;
	wire _guard138 = fsm_out < 3'd3;
	wire _guard139 = early_reset_static_seq1_go_out;
	wire _guard140 = _guard138 & _guard139;
	wire _guard141 = _guard137 | _guard140;
	wire _guard142 = fsm_out < 3'd3;
	wire _guard143 = early_reset_static_seq_go_out;
	wire _guard144 = _guard142 & _guard143;
	wire _guard145 = fsm_out < 3'd3;
	wire _guard146 = early_reset_static_seq0_go_out;
	wire _guard147 = _guard145 & _guard146;
	wire _guard148 = _guard144 | _guard147;
	wire _guard149 = fsm_out < 3'd3;
	wire _guard150 = early_reset_static_seq1_go_out;
	wire _guard151 = _guard149 & _guard150;
	wire _guard152 = _guard148 | _guard151;
	wire _guard153 = fsm_out < 3'd3;
	wire _guard154 = early_reset_static_seq0_go_out;
	wire _guard155 = _guard153 & _guard154;
	wire _guard156 = fsm_out < 3'd3;
	wire _guard157 = early_reset_static_seq_go_out;
	wire _guard158 = _guard156 & _guard157;
	wire _guard159 = fsm_out < 3'd3;
	wire _guard160 = early_reset_static_seq1_go_out;
	wire _guard161 = _guard159 & _guard160;
	wire _guard162 = assign_while_0_latch_go_out;
	wire _guard163 = fsm_out == 3'd4;
	wire _guard164 = early_reset_static_seq_go_out;
	wire _guard165 = _guard163 & _guard164;
	wire _guard166 = _guard162 | _guard165;
	wire _guard167 = fsm_out == 3'd4;
	wire _guard168 = early_reset_static_seq_go_out;
	wire _guard169 = _guard167 & _guard168;
	wire _guard170 = assign_while_0_latch_go_out;
	wire _guard171 = early_reset_bb0_60_go_out;
	wire _guard172 = early_reset_bb0_60_go_out;
	wire _guard173 = bb0_10_done_out;
	wire _guard174 = ~_guard173;
	wire _guard175 = fsm0_out == 5'd10;
	wire _guard176 = _guard174 & _guard175;
	wire _guard177 = tdcc_go_out;
	wire _guard178 = _guard176 & _guard177;
	wire _guard179 = invoke11_done_out;
	wire _guard180 = ~_guard179;
	wire _guard181 = fsm0_out == 5'd15;
	wire _guard182 = _guard180 & _guard181;
	wire _guard183 = tdcc_go_out;
	wire _guard184 = _guard182 & _guard183;
	wire _guard185 = fsm_out == 3'd0;
	wire _guard186 = signal_reg_out;
	wire _guard187 = _guard185 & _guard186;
	wire _guard188 = wrapper_early_reset_static_seq0_done_out;
	wire _guard189 = ~_guard188;
	wire _guard190 = fsm0_out == 5'd9;
	wire _guard191 = _guard189 & _guard190;
	wire _guard192 = tdcc_go_out;
	wire _guard193 = _guard191 & _guard192;
	wire _guard194 = beg_spl_bb0_4_go_out;
	wire _guard195 = bb0_10_go_out;
	wire _guard196 = _guard194 | _guard195;
	wire _guard197 = bb0_13_go_out;
	wire _guard198 = _guard196 | _guard197;
	wire _guard199 = bb0_8_go_out;
	wire _guard200 = invoke11_go_out;
	wire _guard201 = invoke12_go_out;
	wire _guard202 = assign_while_0_latch_go_out;
	wire _guard203 = assign_while_0_latch_go_out;
	wire _guard204 = invoke11_go_out;
	wire _guard205 = invoke12_go_out;
	wire _guard206 = _guard204 | _guard205;
	wire _guard207 = early_reset_bb0_20_go_out;
	wire _guard208 = early_reset_bb0_20_go_out;
	wire _guard209 = invoke0_done_out;
	wire _guard210 = ~_guard209;
	wire _guard211 = fsm0_out == 5'd0;
	wire _guard212 = _guard210 & _guard211;
	wire _guard213 = tdcc_go_out;
	wire _guard214 = _guard212 & _guard213;
	wire _guard215 = invoke12_done_out;
	wire _guard216 = ~_guard215;
	wire _guard217 = fsm0_out == 5'd17;
	wire _guard218 = _guard216 & _guard217;
	wire _guard219 = tdcc_go_out;
	wire _guard220 = _guard218 & _guard219;
	wire _guard221 = wrapper_early_reset_bb0_60_go_out;
	wire _guard222 = wrapper_early_reset_static_seq1_go_out;
	wire _guard223 = bb0_10_go_out;
	wire _guard224 = beg_spl_bb0_4_go_out;
	wire _guard225 = bb0_8_go_out;
	wire _guard226 = _guard224 | _guard225;
	wire _guard227 = bb0_13_go_out;
	wire _guard228 = _guard226 | _guard227;
	wire _guard229 = invoke0_go_out;
	wire _guard230 = invoke12_go_out;
	wire _guard231 = _guard229 | _guard230;
	wire _guard232 = invoke0_go_out;
	wire _guard233 = invoke12_go_out;
	wire _guard234 = early_reset_static_seq_go_out;
	wire _guard235 = early_reset_static_seq_go_out;
	wire _guard236 = fsm0_out == 5'd19;
	wire _guard237 = fsm0_out == 5'd0;
	wire _guard238 = invoke0_done_out;
	wire _guard239 = _guard237 & _guard238;
	wire _guard240 = tdcc_go_out;
	wire _guard241 = _guard239 & _guard240;
	wire _guard242 = _guard236 | _guard241;
	wire _guard243 = fsm0_out == 5'd1;
	wire _guard244 = wrapper_early_reset_bb0_00_done_out;
	wire _guard245 = comb_reg_out;
	wire _guard246 = _guard244 & _guard245;
	wire _guard247 = _guard243 & _guard246;
	wire _guard248 = tdcc_go_out;
	wire _guard249 = _guard247 & _guard248;
	wire _guard250 = _guard242 | _guard249;
	wire _guard251 = fsm0_out == 5'd18;
	wire _guard252 = wrapper_early_reset_bb0_00_done_out;
	wire _guard253 = comb_reg_out;
	wire _guard254 = _guard252 & _guard253;
	wire _guard255 = _guard251 & _guard254;
	wire _guard256 = tdcc_go_out;
	wire _guard257 = _guard255 & _guard256;
	wire _guard258 = _guard250 | _guard257;
	wire _guard259 = fsm0_out == 5'd2;
	wire _guard260 = invoke1_done_out;
	wire _guard261 = _guard259 & _guard260;
	wire _guard262 = tdcc_go_out;
	wire _guard263 = _guard261 & _guard262;
	wire _guard264 = _guard258 | _guard263;
	wire _guard265 = fsm0_out == 5'd3;
	wire _guard266 = wrapper_early_reset_bb0_20_done_out;
	wire _guard267 = comb_reg0_out;
	wire _guard268 = _guard266 & _guard267;
	wire _guard269 = _guard265 & _guard268;
	wire _guard270 = tdcc_go_out;
	wire _guard271 = _guard269 & _guard270;
	wire _guard272 = _guard264 | _guard271;
	wire _guard273 = fsm0_out == 5'd16;
	wire _guard274 = wrapper_early_reset_bb0_20_done_out;
	wire _guard275 = comb_reg0_out;
	wire _guard276 = _guard274 & _guard275;
	wire _guard277 = _guard273 & _guard276;
	wire _guard278 = tdcc_go_out;
	wire _guard279 = _guard277 & _guard278;
	wire _guard280 = _guard272 | _guard279;
	wire _guard281 = fsm0_out == 5'd4;
	wire _guard282 = beg_spl_bb0_4_done_out;
	wire _guard283 = _guard281 & _guard282;
	wire _guard284 = tdcc_go_out;
	wire _guard285 = _guard283 & _guard284;
	wire _guard286 = _guard280 | _guard285;
	wire _guard287 = fsm0_out == 5'd5;
	wire _guard288 = invoke2_done_out;
	wire _guard289 = _guard287 & _guard288;
	wire _guard290 = tdcc_go_out;
	wire _guard291 = _guard289 & _guard290;
	wire _guard292 = _guard286 | _guard291;
	wire _guard293 = fsm0_out == 5'd6;
	wire _guard294 = wrapper_early_reset_static_seq_done_out;
	wire _guard295 = _guard293 & _guard294;
	wire _guard296 = tdcc_go_out;
	wire _guard297 = _guard295 & _guard296;
	wire _guard298 = _guard292 | _guard297;
	wire _guard299 = fsm0_out == 5'd7;
	wire _guard300 = wrapper_early_reset_bb0_60_done_out;
	wire _guard301 = comb_reg1_out;
	wire _guard302 = _guard300 & _guard301;
	wire _guard303 = _guard299 & _guard302;
	wire _guard304 = tdcc_go_out;
	wire _guard305 = _guard303 & _guard304;
	wire _guard306 = _guard298 | _guard305;
	wire _guard307 = fsm0_out == 5'd13;
	wire _guard308 = wrapper_early_reset_bb0_60_done_out;
	wire _guard309 = comb_reg1_out;
	wire _guard310 = _guard308 & _guard309;
	wire _guard311 = _guard307 & _guard310;
	wire _guard312 = tdcc_go_out;
	wire _guard313 = _guard311 & _guard312;
	wire _guard314 = _guard306 | _guard313;
	wire _guard315 = fsm0_out == 5'd8;
	wire _guard316 = bb0_8_done_out;
	wire _guard317 = _guard315 & _guard316;
	wire _guard318 = tdcc_go_out;
	wire _guard319 = _guard317 & _guard318;
	wire _guard320 = _guard314 | _guard319;
	wire _guard321 = fsm0_out == 5'd9;
	wire _guard322 = wrapper_early_reset_static_seq0_done_out;
	wire _guard323 = _guard321 & _guard322;
	wire _guard324 = tdcc_go_out;
	wire _guard325 = _guard323 & _guard324;
	wire _guard326 = _guard320 | _guard325;
	wire _guard327 = fsm0_out == 5'd10;
	wire _guard328 = bb0_10_done_out;
	wire _guard329 = _guard327 & _guard328;
	wire _guard330 = tdcc_go_out;
	wire _guard331 = _guard329 & _guard330;
	wire _guard332 = _guard326 | _guard331;
	wire _guard333 = fsm0_out == 5'd11;
	wire _guard334 = wrapper_early_reset_static_seq1_done_out;
	wire _guard335 = _guard333 & _guard334;
	wire _guard336 = tdcc_go_out;
	wire _guard337 = _guard335 & _guard336;
	wire _guard338 = _guard332 | _guard337;
	wire _guard339 = fsm0_out == 5'd12;
	wire _guard340 = assign_while_0_latch_done_out;
	wire _guard341 = _guard339 & _guard340;
	wire _guard342 = tdcc_go_out;
	wire _guard343 = _guard341 & _guard342;
	wire _guard344 = _guard338 | _guard343;
	wire _guard345 = fsm0_out == 5'd7;
	wire _guard346 = wrapper_early_reset_bb0_60_done_out;
	wire _guard347 = comb_reg1_out;
	wire _guard348 = ~_guard347;
	wire _guard349 = _guard346 & _guard348;
	wire _guard350 = _guard345 & _guard349;
	wire _guard351 = tdcc_go_out;
	wire _guard352 = _guard350 & _guard351;
	wire _guard353 = _guard344 | _guard352;
	wire _guard354 = fsm0_out == 5'd13;
	wire _guard355 = wrapper_early_reset_bb0_60_done_out;
	wire _guard356 = comb_reg1_out;
	wire _guard357 = ~_guard356;
	wire _guard358 = _guard355 & _guard357;
	wire _guard359 = _guard354 & _guard358;
	wire _guard360 = tdcc_go_out;
	wire _guard361 = _guard359 & _guard360;
	wire _guard362 = _guard353 | _guard361;
	wire _guard363 = fsm0_out == 5'd14;
	wire _guard364 = bb0_13_done_out;
	wire _guard365 = _guard363 & _guard364;
	wire _guard366 = tdcc_go_out;
	wire _guard367 = _guard365 & _guard366;
	wire _guard368 = _guard362 | _guard367;
	wire _guard369 = fsm0_out == 5'd15;
	wire _guard370 = invoke11_done_out;
	wire _guard371 = _guard369 & _guard370;
	wire _guard372 = tdcc_go_out;
	wire _guard373 = _guard371 & _guard372;
	wire _guard374 = _guard368 | _guard373;
	wire _guard375 = fsm0_out == 5'd3;
	wire _guard376 = wrapper_early_reset_bb0_20_done_out;
	wire _guard377 = comb_reg0_out;
	wire _guard378 = ~_guard377;
	wire _guard379 = _guard376 & _guard378;
	wire _guard380 = _guard375 & _guard379;
	wire _guard381 = tdcc_go_out;
	wire _guard382 = _guard380 & _guard381;
	wire _guard383 = _guard374 | _guard382;
	wire _guard384 = fsm0_out == 5'd16;
	wire _guard385 = wrapper_early_reset_bb0_20_done_out;
	wire _guard386 = comb_reg0_out;
	wire _guard387 = ~_guard386;
	wire _guard388 = _guard385 & _guard387;
	wire _guard389 = _guard384 & _guard388;
	wire _guard390 = tdcc_go_out;
	wire _guard391 = _guard389 & _guard390;
	wire _guard392 = _guard383 | _guard391;
	wire _guard393 = fsm0_out == 5'd17;
	wire _guard394 = invoke12_done_out;
	wire _guard395 = _guard393 & _guard394;
	wire _guard396 = tdcc_go_out;
	wire _guard397 = _guard395 & _guard396;
	wire _guard398 = _guard392 | _guard397;
	wire _guard399 = fsm0_out == 5'd1;
	wire _guard400 = wrapper_early_reset_bb0_00_done_out;
	wire _guard401 = comb_reg_out;
	wire _guard402 = ~_guard401;
	wire _guard403 = _guard400 & _guard402;
	wire _guard404 = _guard399 & _guard403;
	wire _guard405 = tdcc_go_out;
	wire _guard406 = _guard404 & _guard405;
	wire _guard407 = _guard398 | _guard406;
	wire _guard408 = fsm0_out == 5'd18;
	wire _guard409 = wrapper_early_reset_bb0_00_done_out;
	wire _guard410 = comb_reg_out;
	wire _guard411 = ~_guard410;
	wire _guard412 = _guard409 & _guard411;
	wire _guard413 = _guard408 & _guard412;
	wire _guard414 = tdcc_go_out;
	wire _guard415 = _guard413 & _guard414;
	wire _guard416 = _guard407 | _guard415;
	wire _guard417 = fsm0_out == 5'd0;
	wire _guard418 = invoke0_done_out;
	wire _guard419 = _guard417 & _guard418;
	wire _guard420 = tdcc_go_out;
	wire _guard421 = _guard419 & _guard420;
	wire _guard422 = fsm0_out == 5'd14;
	wire _guard423 = bb0_13_done_out;
	wire _guard424 = _guard422 & _guard423;
	wire _guard425 = tdcc_go_out;
	wire _guard426 = _guard424 & _guard425;
	wire _guard427 = fsm0_out == 5'd17;
	wire _guard428 = invoke12_done_out;
	wire _guard429 = _guard427 & _guard428;
	wire _guard430 = tdcc_go_out;
	wire _guard431 = _guard429 & _guard430;
	wire _guard432 = fsm0_out == 5'd15;
	wire _guard433 = invoke11_done_out;
	wire _guard434 = _guard432 & _guard433;
	wire _guard435 = tdcc_go_out;
	wire _guard436 = _guard434 & _guard435;
	wire _guard437 = fsm0_out == 5'd19;
	wire _guard438 = fsm0_out == 5'd2;
	wire _guard439 = invoke1_done_out;
	wire _guard440 = _guard438 & _guard439;
	wire _guard441 = tdcc_go_out;
	wire _guard442 = _guard440 & _guard441;
	wire _guard443 = fsm0_out == 5'd12;
	wire _guard444 = assign_while_0_latch_done_out;
	wire _guard445 = _guard443 & _guard444;
	wire _guard446 = tdcc_go_out;
	wire _guard447 = _guard445 & _guard446;
	wire _guard448 = fsm0_out == 5'd7;
	wire _guard449 = wrapper_early_reset_bb0_60_done_out;
	wire _guard450 = comb_reg1_out;
	wire _guard451 = ~_guard450;
	wire _guard452 = _guard449 & _guard451;
	wire _guard453 = _guard448 & _guard452;
	wire _guard454 = tdcc_go_out;
	wire _guard455 = _guard453 & _guard454;
	wire _guard456 = fsm0_out == 5'd13;
	wire _guard457 = wrapper_early_reset_bb0_60_done_out;
	wire _guard458 = comb_reg1_out;
	wire _guard459 = ~_guard458;
	wire _guard460 = _guard457 & _guard459;
	wire _guard461 = _guard456 & _guard460;
	wire _guard462 = tdcc_go_out;
	wire _guard463 = _guard461 & _guard462;
	wire _guard464 = _guard455 | _guard463;
	wire _guard465 = fsm0_out == 5'd4;
	wire _guard466 = beg_spl_bb0_4_done_out;
	wire _guard467 = _guard465 & _guard466;
	wire _guard468 = tdcc_go_out;
	wire _guard469 = _guard467 & _guard468;
	wire _guard470 = fsm0_out == 5'd11;
	wire _guard471 = wrapper_early_reset_static_seq1_done_out;
	wire _guard472 = _guard470 & _guard471;
	wire _guard473 = tdcc_go_out;
	wire _guard474 = _guard472 & _guard473;
	wire _guard475 = fsm0_out == 5'd1;
	wire _guard476 = wrapper_early_reset_bb0_00_done_out;
	wire _guard477 = comb_reg_out;
	wire _guard478 = _guard476 & _guard477;
	wire _guard479 = _guard475 & _guard478;
	wire _guard480 = tdcc_go_out;
	wire _guard481 = _guard479 & _guard480;
	wire _guard482 = fsm0_out == 5'd18;
	wire _guard483 = wrapper_early_reset_bb0_00_done_out;
	wire _guard484 = comb_reg_out;
	wire _guard485 = _guard483 & _guard484;
	wire _guard486 = _guard482 & _guard485;
	wire _guard487 = tdcc_go_out;
	wire _guard488 = _guard486 & _guard487;
	wire _guard489 = _guard481 | _guard488;
	wire _guard490 = fsm0_out == 5'd7;
	wire _guard491 = wrapper_early_reset_bb0_60_done_out;
	wire _guard492 = comb_reg1_out;
	wire _guard493 = _guard491 & _guard492;
	wire _guard494 = _guard490 & _guard493;
	wire _guard495 = tdcc_go_out;
	wire _guard496 = _guard494 & _guard495;
	wire _guard497 = fsm0_out == 5'd13;
	wire _guard498 = wrapper_early_reset_bb0_60_done_out;
	wire _guard499 = comb_reg1_out;
	wire _guard500 = _guard498 & _guard499;
	wire _guard501 = _guard497 & _guard500;
	wire _guard502 = tdcc_go_out;
	wire _guard503 = _guard501 & _guard502;
	wire _guard504 = _guard496 | _guard503;
	wire _guard505 = fsm0_out == 5'd9;
	wire _guard506 = wrapper_early_reset_static_seq0_done_out;
	wire _guard507 = _guard505 & _guard506;
	wire _guard508 = tdcc_go_out;
	wire _guard509 = _guard507 & _guard508;
	wire _guard510 = fsm0_out == 5'd6;
	wire _guard511 = wrapper_early_reset_static_seq_done_out;
	wire _guard512 = _guard510 & _guard511;
	wire _guard513 = tdcc_go_out;
	wire _guard514 = _guard512 & _guard513;
	wire _guard515 = fsm0_out == 5'd10;
	wire _guard516 = bb0_10_done_out;
	wire _guard517 = _guard515 & _guard516;
	wire _guard518 = tdcc_go_out;
	wire _guard519 = _guard517 & _guard518;
	wire _guard520 = fsm0_out == 5'd1;
	wire _guard521 = wrapper_early_reset_bb0_00_done_out;
	wire _guard522 = comb_reg_out;
	wire _guard523 = ~_guard522;
	wire _guard524 = _guard521 & _guard523;
	wire _guard525 = _guard520 & _guard524;
	wire _guard526 = tdcc_go_out;
	wire _guard527 = _guard525 & _guard526;
	wire _guard528 = fsm0_out == 5'd18;
	wire _guard529 = wrapper_early_reset_bb0_00_done_out;
	wire _guard530 = comb_reg_out;
	wire _guard531 = ~_guard530;
	wire _guard532 = _guard529 & _guard531;
	wire _guard533 = _guard528 & _guard532;
	wire _guard534 = tdcc_go_out;
	wire _guard535 = _guard533 & _guard534;
	wire _guard536 = _guard527 | _guard535;
	wire _guard537 = fsm0_out == 5'd3;
	wire _guard538 = wrapper_early_reset_bb0_20_done_out;
	wire _guard539 = comb_reg0_out;
	wire _guard540 = _guard538 & _guard539;
	wire _guard541 = _guard537 & _guard540;
	wire _guard542 = tdcc_go_out;
	wire _guard543 = _guard541 & _guard542;
	wire _guard544 = fsm0_out == 5'd16;
	wire _guard545 = wrapper_early_reset_bb0_20_done_out;
	wire _guard546 = comb_reg0_out;
	wire _guard547 = _guard545 & _guard546;
	wire _guard548 = _guard544 & _guard547;
	wire _guard549 = tdcc_go_out;
	wire _guard550 = _guard548 & _guard549;
	wire _guard551 = _guard543 | _guard550;
	wire _guard552 = fsm0_out == 5'd5;
	wire _guard553 = invoke2_done_out;
	wire _guard554 = _guard552 & _guard553;
	wire _guard555 = tdcc_go_out;
	wire _guard556 = _guard554 & _guard555;
	wire _guard557 = fsm0_out == 5'd3;
	wire _guard558 = wrapper_early_reset_bb0_20_done_out;
	wire _guard559 = comb_reg0_out;
	wire _guard560 = ~_guard559;
	wire _guard561 = _guard558 & _guard560;
	wire _guard562 = _guard557 & _guard561;
	wire _guard563 = tdcc_go_out;
	wire _guard564 = _guard562 & _guard563;
	wire _guard565 = fsm0_out == 5'd16;
	wire _guard566 = wrapper_early_reset_bb0_20_done_out;
	wire _guard567 = comb_reg0_out;
	wire _guard568 = ~_guard567;
	wire _guard569 = _guard566 & _guard568;
	wire _guard570 = _guard565 & _guard569;
	wire _guard571 = tdcc_go_out;
	wire _guard572 = _guard570 & _guard571;
	wire _guard573 = _guard564 | _guard572;
	wire _guard574 = fsm0_out == 5'd8;
	wire _guard575 = bb0_8_done_out;
	wire _guard576 = _guard574 & _guard575;
	wire _guard577 = tdcc_go_out;
	wire _guard578 = _guard576 & _guard577;
	wire _guard579 = early_reset_static_seq0_go_out;
	wire _guard580 = early_reset_static_seq0_go_out;
	wire _guard581 = fsm_out == 3'd0;
	wire _guard582 = signal_reg_out;
	wire _guard583 = _guard581 & _guard582;
	wire _guard584 = early_reset_bb0_20_go_out;
	wire _guard585 = early_reset_bb0_20_go_out;
	wire _guard586 = invoke1_done_out;
	wire _guard587 = ~_guard586;
	wire _guard588 = fsm0_out == 5'd2;
	wire _guard589 = _guard587 & _guard588;
	wire _guard590 = tdcc_go_out;
	wire _guard591 = _guard589 & _guard590;
	wire _guard592 = wrapper_early_reset_static_seq_go_out;
	wire _guard593 = fsm_out == 3'd0;
	wire _guard594 = signal_reg_out;
	wire _guard595 = _guard593 & _guard594;
	wire _guard596 = invoke2_go_out;
	wire _guard597 = fsm_out == 3'd3;
	wire _guard598 = early_reset_static_seq_go_out;
	wire _guard599 = _guard597 & _guard598;
	wire _guard600 = _guard596 | _guard599;
	wire _guard601 = fsm_out == 3'd3;
	wire _guard602 = early_reset_static_seq0_go_out;
	wire _guard603 = _guard601 & _guard602;
	wire _guard604 = _guard600 | _guard603;
	wire _guard605 = fsm_out == 3'd3;
	wire _guard606 = early_reset_static_seq1_go_out;
	wire _guard607 = _guard605 & _guard606;
	wire _guard608 = _guard604 | _guard607;
	wire _guard609 = invoke2_go_out;
	wire _guard610 = fsm_out == 3'd3;
	wire _guard611 = early_reset_static_seq_go_out;
	wire _guard612 = _guard610 & _guard611;
	wire _guard613 = fsm_out == 3'd3;
	wire _guard614 = early_reset_static_seq0_go_out;
	wire _guard615 = _guard613 & _guard614;
	wire _guard616 = _guard612 | _guard615;
	wire _guard617 = fsm_out == 3'd3;
	wire _guard618 = early_reset_static_seq1_go_out;
	wire _guard619 = _guard617 & _guard618;
	wire _guard620 = _guard616 | _guard619;
	wire _guard621 = fsm_out == 3'd0;
	wire _guard622 = signal_reg_out;
	wire _guard623 = _guard621 & _guard622;
	wire _guard624 = fsm_out == 3'd0;
	wire _guard625 = signal_reg_out;
	wire _guard626 = ~_guard625;
	wire _guard627 = _guard624 & _guard626;
	wire _guard628 = wrapper_early_reset_bb0_00_go_out;
	wire _guard629 = _guard627 & _guard628;
	wire _guard630 = _guard623 | _guard629;
	wire _guard631 = fsm_out == 3'd0;
	wire _guard632 = signal_reg_out;
	wire _guard633 = ~_guard632;
	wire _guard634 = _guard631 & _guard633;
	wire _guard635 = wrapper_early_reset_bb0_20_go_out;
	wire _guard636 = _guard634 & _guard635;
	wire _guard637 = _guard630 | _guard636;
	wire _guard638 = fsm_out == 3'd0;
	wire _guard639 = signal_reg_out;
	wire _guard640 = ~_guard639;
	wire _guard641 = _guard638 & _guard640;
	wire _guard642 = wrapper_early_reset_static_seq_go_out;
	wire _guard643 = _guard641 & _guard642;
	wire _guard644 = _guard637 | _guard643;
	wire _guard645 = fsm_out == 3'd0;
	wire _guard646 = signal_reg_out;
	wire _guard647 = ~_guard646;
	wire _guard648 = _guard645 & _guard647;
	wire _guard649 = wrapper_early_reset_bb0_60_go_out;
	wire _guard650 = _guard648 & _guard649;
	wire _guard651 = _guard644 | _guard650;
	wire _guard652 = fsm_out == 3'd0;
	wire _guard653 = signal_reg_out;
	wire _guard654 = ~_guard653;
	wire _guard655 = _guard652 & _guard654;
	wire _guard656 = wrapper_early_reset_static_seq0_go_out;
	wire _guard657 = _guard655 & _guard656;
	wire _guard658 = _guard651 | _guard657;
	wire _guard659 = fsm_out == 3'd0;
	wire _guard660 = signal_reg_out;
	wire _guard661 = ~_guard660;
	wire _guard662 = _guard659 & _guard661;
	wire _guard663 = wrapper_early_reset_static_seq1_go_out;
	wire _guard664 = _guard662 & _guard663;
	wire _guard665 = _guard658 | _guard664;
	wire _guard666 = fsm_out == 3'd0;
	wire _guard667 = signal_reg_out;
	wire _guard668 = ~_guard667;
	wire _guard669 = _guard666 & _guard668;
	wire _guard670 = wrapper_early_reset_bb0_00_go_out;
	wire _guard671 = _guard669 & _guard670;
	wire _guard672 = fsm_out == 3'd0;
	wire _guard673 = signal_reg_out;
	wire _guard674 = ~_guard673;
	wire _guard675 = _guard672 & _guard674;
	wire _guard676 = wrapper_early_reset_bb0_20_go_out;
	wire _guard677 = _guard675 & _guard676;
	wire _guard678 = _guard671 | _guard677;
	wire _guard679 = fsm_out == 3'd0;
	wire _guard680 = signal_reg_out;
	wire _guard681 = ~_guard680;
	wire _guard682 = _guard679 & _guard681;
	wire _guard683 = wrapper_early_reset_static_seq_go_out;
	wire _guard684 = _guard682 & _guard683;
	wire _guard685 = _guard678 | _guard684;
	wire _guard686 = fsm_out == 3'd0;
	wire _guard687 = signal_reg_out;
	wire _guard688 = ~_guard687;
	wire _guard689 = _guard686 & _guard688;
	wire _guard690 = wrapper_early_reset_bb0_60_go_out;
	wire _guard691 = _guard689 & _guard690;
	wire _guard692 = _guard685 | _guard691;
	wire _guard693 = fsm_out == 3'd0;
	wire _guard694 = signal_reg_out;
	wire _guard695 = ~_guard694;
	wire _guard696 = _guard693 & _guard695;
	wire _guard697 = wrapper_early_reset_static_seq0_go_out;
	wire _guard698 = _guard696 & _guard697;
	wire _guard699 = _guard692 | _guard698;
	wire _guard700 = fsm_out == 3'd0;
	wire _guard701 = signal_reg_out;
	wire _guard702 = ~_guard701;
	wire _guard703 = _guard700 & _guard702;
	wire _guard704 = wrapper_early_reset_static_seq1_go_out;
	wire _guard705 = _guard703 & _guard704;
	wire _guard706 = _guard699 | _guard705;
	wire _guard707 = fsm_out == 3'd0;
	wire _guard708 = signal_reg_out;
	wire _guard709 = _guard707 & _guard708;
	wire _guard710 = wrapper_early_reset_bb0_00_go_out;
	wire _guard711 = wrapper_early_reset_bb0_20_done_out;
	wire _guard712 = ~_guard711;
	wire _guard713 = fsm0_out == 5'd3;
	wire _guard714 = _guard712 & _guard713;
	wire _guard715 = tdcc_go_out;
	wire _guard716 = _guard714 & _guard715;
	wire _guard717 = wrapper_early_reset_bb0_20_done_out;
	wire _guard718 = ~_guard717;
	wire _guard719 = fsm0_out == 5'd16;
	wire _guard720 = _guard718 & _guard719;
	wire _guard721 = tdcc_go_out;
	wire _guard722 = _guard720 & _guard721;
	wire _guard723 = _guard716 | _guard722;
	wire _guard724 = fsm0_out == 5'd19;
	wire _guard725 = wrapper_early_reset_static_seq1_done_out;
	wire _guard726 = ~_guard725;
	wire _guard727 = fsm0_out == 5'd11;
	wire _guard728 = _guard726 & _guard727;
	wire _guard729 = tdcc_go_out;
	wire _guard730 = _guard728 & _guard729;
	wire _guard731 = assign_while_0_latch_go_out;
	wire _guard732 = fsm_out == 3'd4;
	wire _guard733 = early_reset_static_seq_go_out;
	wire _guard734 = _guard732 & _guard733;
	wire _guard735 = _guard731 | _guard734;
	wire _guard736 = assign_while_0_latch_go_out;
	wire _guard737 = fsm_out == 3'd4;
	wire _guard738 = early_reset_static_seq_go_out;
	wire _guard739 = _guard737 & _guard738;
	wire _guard740 = wrapper_early_reset_bb0_20_go_out;
	wire _guard741 = wrapper_early_reset_bb0_60_done_out;
	wire _guard742 = ~_guard741;
	wire _guard743 = fsm0_out == 5'd7;
	wire _guard744 = _guard742 & _guard743;
	wire _guard745 = tdcc_go_out;
	wire _guard746 = _guard744 & _guard745;
	wire _guard747 = wrapper_early_reset_bb0_60_done_out;
	wire _guard748 = ~_guard747;
	wire _guard749 = fsm0_out == 5'd13;
	wire _guard750 = _guard748 & _guard749;
	wire _guard751 = tdcc_go_out;
	wire _guard752 = _guard750 & _guard751;
	wire _guard753 = _guard746 | _guard752;
	wire _guard754 = beg_spl_bb0_4_done_out;
	wire _guard755 = ~_guard754;
	wire _guard756 = fsm0_out == 5'd4;
	wire _guard757 = _guard755 & _guard756;
	wire _guard758 = tdcc_go_out;
	wire _guard759 = _guard757 & _guard758;
	wire _guard760 = wrapper_early_reset_static_seq_done_out;
	wire _guard761 = ~_guard760;
	wire _guard762 = fsm0_out == 5'd6;
	wire _guard763 = _guard761 & _guard762;
	wire _guard764 = tdcc_go_out;
	wire _guard765 = _guard763 & _guard764;
	wire _guard766 = fsm_out == 3'd0;
	wire _guard767 = signal_reg_out;
	wire _guard768 = _guard766 & _guard767;
	wire _guard769 = bb0_8_done_out;
	wire _guard770 = ~_guard769;
	wire _guard771 = fsm0_out == 5'd8;
	wire _guard772 = _guard770 & _guard771;
	wire _guard773 = tdcc_go_out;
	wire _guard774 = _guard772 & _guard773;
	wire _guard775 = bb0_13_done_out;
	wire _guard776 = ~_guard775;
	wire _guard777 = fsm0_out == 5'd14;
	wire _guard778 = _guard776 & _guard777;
	wire _guard779 = tdcc_go_out;
	wire _guard780 = _guard778 & _guard779;
	assign adder1_left = (_guard1 ? fsm_out : 3'd0);
	assign adder1_right = (_guard2 ? 3'd1 : 3'd0);
	assign assign_while_0_latch_go_in = _guard8;
	assign assign_while_0_latch_done_in = _guard11;
	assign done = _guard12;
	assign arg_mem_2_addr1 = (_guard15 ? std_slice_6_out : 5'd0);
	assign arg_mem_0_addr1 = (_guard16 ? std_slice_6_out : 5'd0);
	assign arg_mem_0_content_en = _guard17;
	assign arg_mem_0_addr0 = (_guard18 ? std_slice_7_out : 5'd0);
	assign arg_mem_0_write_en = (_guard19 ? 1'd0 : 1'd0);
	assign arg_mem_2_addr0 = (_guard22 ? std_slice_7_out : 5'd0);
	assign arg_mem_2_content_en = _guard25;
	assign arg_mem_1_addr1 = (_guard26 ? std_slice_6_out : 5'd0);
	assign arg_mem_1_write_en = (_guard27 ? 1'd0 : 1'd0);
	assign arg_mem_2_write_en = (_guard28 ? 1'd1 : (_guard29 ? 1'd0 : 1'd0));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard29, _guard28}))
			$fatal(2, "Multiple assignment to port `_this.arg_mem_2_write_en'.");
	end
	assign arg_mem_2_write_data = (_guard30 ? while_0_arg1_reg_out : 32'd0);
	assign arg_mem_1_addr0 = (_guard31 ? std_slice_7_out : 5'd0);
	assign arg_mem_1_content_en = _guard32;
	assign fsm_write_en = _guard43;
	assign fsm_clk = clk;
	assign fsm_reset = reset;
	assign fsm_in = (_guard46 ? adder1_out : (_guard49 ? adder_out : (_guard52 ? adder4_out : (_guard55 ? adder2_out : (_guard58 ? adder3_out : (_guard61 ? adder0_out : (_guard84 ? 3'd0 : 3'd0)))))));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard84, _guard61, _guard58, _guard55, _guard52, _guard49, _guard46}))
			$fatal(2, "Multiple assignment to port `fsm.in'.");
	end
	assign adder_left = (_guard85 ? fsm_out : 3'd0);
	assign adder_right = (_guard86 ? 3'd1 : 3'd0);
	assign invoke11_done_in = while_1_arg0_reg_done;
	assign early_reset_bb0_60_done_in = ud1_out;
	assign adder4_left = (_guard87 ? fsm_out : 3'd0);
	assign adder4_right = (_guard88 ? 3'd1 : 3'd0);
	assign beg_spl_bb0_4_done_in = arg_mem_2_done;
	assign invoke2_go_in = _guard94;
	assign wrapper_early_reset_bb0_20_done_in = _guard97;
	assign while_1_arg0_reg_write_en = _guard100;
	assign while_1_arg0_reg_clk = clk;
	assign while_1_arg0_reg_reset = reset;
	assign while_1_arg0_reg_in = (_guard101 ? 32'd0 : (_guard102 ? std_add_3_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard102, _guard101}))
			$fatal(2, "Multiple assignment to port `while_1_arg0_reg.in'.");
	end
	assign comb_reg_write_en = _guard103;
	assign comb_reg_clk = clk;
	assign comb_reg_reset = reset;
	assign comb_reg_in = (_guard104 ? std_slt_2_out : 1'd0);
	assign wrapper_early_reset_bb0_00_go_in = _guard117;
	assign std_add_2_left = while_0_arg0_reg_out;
	assign std_add_2_right = 32'd1;
	assign std_slt_2_left = (_guard120 ? while_1_arg0_reg_out : (_guard121 ? while_0_arg0_reg_out : (_guard122 ? while_2_arg0_reg_out : 32'd0)));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard122, _guard121, _guard120}))
			$fatal(2, "Multiple assignment to port `std_slt_2.left'.");
	end
	assign std_slt_2_right = (_guard127 ? 32'd20 : 32'd0);
	assign early_reset_static_seq0_go_in = _guard128;
	assign wrapper_early_reset_static_seq1_done_in = _guard131;
	assign std_mult_pipe_2_clk = clk;
	assign std_mult_pipe_2_left = (_guard134 ? in0 : (_guard141 ? muli_2_reg_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard141, _guard134}))
			$fatal(2, "Multiple assignment to port `std_mult_pipe_2.left'.");
	end
	assign std_mult_pipe_2_reset = reset;
	assign std_mult_pipe_2_go = _guard152;
	assign std_mult_pipe_2_right = (_guard155 ? arg_mem_0_read_data : (_guard158 ? in1 : (_guard161 ? arg_mem_1_read_data : {32 {1'sbx}})));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard161, _guard158, _guard155}))
			$fatal(2, "Multiple assignment to port `std_mult_pipe_2.right'.");
	end
	assign while_0_arg0_reg_write_en = _guard166;
	assign while_0_arg0_reg_clk = clk;
	assign while_0_arg0_reg_reset = reset;
	assign while_0_arg0_reg_in = (_guard169 ? 32'd0 : (_guard170 ? std_add_2_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard170, _guard169}))
			$fatal(2, "Multiple assignment to port `while_0_arg0_reg.in'.");
	end
	assign comb_reg1_write_en = _guard171;
	assign comb_reg1_clk = clk;
	assign comb_reg1_reset = reset;
	assign comb_reg1_in = (_guard172 ? std_slt_2_out : 1'd0);
	assign bb0_10_go_in = _guard178;
	assign bb0_13_done_in = arg_mem_2_done;
	assign invoke11_go_in = _guard184;
	assign early_reset_static_seq1_done_in = ud4_out;
	assign wrapper_early_reset_bb0_60_done_in = _guard187;
	assign wrapper_early_reset_static_seq0_go_in = _guard193;
	assign std_slice_6_in = (_guard198 ? while_1_arg0_reg_out : (_guard199 ? while_0_arg0_reg_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard199, _guard198}))
			$fatal(2, "Multiple assignment to port `std_slice_6.in'.");
	end
	assign std_add_3_left = (_guard200 ? while_1_arg0_reg_out : (_guard201 ? while_2_arg0_reg_out : (_guard202 ? while_0_arg1_reg_out : {32 {1'sbx}})));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard202, _guard201, _guard200}))
			$fatal(2, "Multiple assignment to port `std_add_3.left'.");
	end
	assign std_add_3_right = (_guard203 ? muli_2_reg_out : (_guard206 ? 32'd1 : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard206, _guard203}))
			$fatal(2, "Multiple assignment to port `std_add_3.right'.");
	end
	assign comb_reg0_write_en = _guard207;
	assign comb_reg0_clk = clk;
	assign comb_reg0_reset = reset;
	assign comb_reg0_in = (_guard208 ? std_slt_2_out : 1'd0);
	assign invoke0_go_in = _guard214;
	assign tdcc_go_in = go;
	assign invoke12_go_in = _guard220;
	assign early_reset_bb0_60_go_in = _guard221;
	assign early_reset_static_seq1_go_in = _guard222;
	assign std_slice_7_in = (_guard223 ? while_0_arg0_reg_out : (_guard228 ? while_2_arg0_reg_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard228, _guard223}))
			$fatal(2, "Multiple assignment to port `std_slice_7.in'.");
	end
	assign while_2_arg0_reg_write_en = _guard231;
	assign while_2_arg0_reg_clk = clk;
	assign while_2_arg0_reg_reset = reset;
	assign while_2_arg0_reg_in = (_guard232 ? 32'd0 : (_guard233 ? std_add_3_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard233, _guard232}))
			$fatal(2, "Multiple assignment to port `while_2_arg0_reg.in'.");
	end
	assign adder2_left = (_guard234 ? fsm_out : 3'd0);
	assign adder2_right = (_guard235 ? 3'd1 : 3'd0);
	assign fsm0_write_en = _guard416;
	assign fsm0_clk = clk;
	assign fsm0_reset = reset;
	assign fsm0_in = (_guard421 ? 5'd1 : (_guard426 ? 5'd15 : (_guard431 ? 5'd18 : (_guard436 ? 5'd16 : (_guard437 ? 5'd0 : (_guard442 ? 5'd3 : (_guard447 ? 5'd13 : (_guard464 ? 5'd14 : (_guard469 ? 5'd5 : (_guard474 ? 5'd12 : (_guard489 ? 5'd2 : (_guard504 ? 5'd8 : (_guard509 ? 5'd10 : (_guard514 ? 5'd7 : (_guard519 ? 5'd11 : (_guard536 ? 5'd19 : (_guard551 ? 5'd4 : (_guard556 ? 5'd6 : (_guard573 ? 5'd17 : (_guard578 ? 5'd9 : 5'd0))))))))))))))))))));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard578, _guard573, _guard556, _guard551, _guard536, _guard519, _guard514, _guard509, _guard504, _guard489, _guard474, _guard469, _guard464, _guard447, _guard442, _guard437, _guard436, _guard431, _guard426, _guard421}))
			$fatal(2, "Multiple assignment to port `fsm0.in'.");
	end
	assign adder3_left = (_guard579 ? fsm_out : 3'd0);
	assign adder3_right = (_guard580 ? 3'd1 : 3'd0);
	assign invoke12_done_in = while_2_arg0_reg_done;
	assign wrapper_early_reset_static_seq_done_in = _guard583;
	assign adder0_left = (_guard584 ? fsm_out : 3'd0);
	assign adder0_right = (_guard585 ? 3'd1 : 3'd0);
	assign invoke0_done_in = while_2_arg0_reg_done;
	assign invoke1_go_in = _guard591;
	assign early_reset_static_seq_go_in = _guard592;
	assign wrapper_early_reset_bb0_00_done_in = _guard595;
	assign muli_2_reg_write_en = _guard608;
	assign muli_2_reg_clk = clk;
	assign muli_2_reg_reset = reset;
	assign muli_2_reg_in = (_guard609 ? arg_mem_2_read_data : (_guard620 ? std_mult_pipe_2_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard620, _guard609}))
			$fatal(2, "Multiple assignment to port `muli_2_reg.in'.");
	end
	assign signal_reg_write_en = _guard665;
	assign signal_reg_clk = clk;
	assign signal_reg_reset = reset;
	assign signal_reg_in = (_guard706 ? 1'd1 : (_guard709 ? 1'd0 : 1'd0));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard709, _guard706}))
			$fatal(2, "Multiple assignment to port `signal_reg.in'.");
	end
	assign bb0_8_done_in = arg_mem_0_done;
	assign invoke2_done_in = muli_2_reg_done;
	assign early_reset_bb0_00_go_in = _guard710;
	assign wrapper_early_reset_bb0_20_go_in = _guard723;
	assign tdcc_done_in = _guard724;
	assign early_reset_bb0_00_done_in = ud_out;
	assign early_reset_static_seq_done_in = ud2_out;
	assign wrapper_early_reset_static_seq1_go_in = _guard730;
	assign while_0_arg1_reg_write_en = _guard735;
	assign while_0_arg1_reg_clk = clk;
	assign while_0_arg1_reg_reset = reset;
	assign while_0_arg1_reg_in = (_guard736 ? std_add_3_out : (_guard739 ? muli_2_reg_out : {32 {1'sbx}}));
	always @(*) begin
		if (_sv2v_0)
			;
		if (~$onehot0({_guard739, _guard736}))
			$fatal(2, "Multiple assignment to port `while_0_arg1_reg.in'.");
	end
	assign early_reset_bb0_20_go_in = _guard740;
	assign wrapper_early_reset_bb0_60_go_in = _guard753;
	assign invoke1_done_in = while_1_arg0_reg_done;
	assign beg_spl_bb0_4_go_in = _guard759;
	assign early_reset_static_seq0_done_in = ud3_out;
	assign wrapper_early_reset_static_seq_go_in = _guard765;
	assign wrapper_early_reset_static_seq0_done_in = _guard768;
	assign bb0_8_go_in = _guard774;
	assign bb0_10_done_in = arg_mem_1_done;
	assign bb0_13_go_in = _guard780;
	assign early_reset_bb0_20_done_in = ud0_out;
	initial _sv2v_0 = 0;
endmodule
