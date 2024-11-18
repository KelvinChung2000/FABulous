// TODO: find a more fun test design

(* blackbox *)
module INBUF (output O);
endmodule

(* blackbox *)
module OUTBUF (input I);
endmodule

(* blackbox *)
module Global_Clock (output CLK);
endmodule

module top_wrapper;

  wire [7:0] a, b, dst;

  (* keep, BEL="X1Y3/IO7" *) OUTBUF io23_i (.I(dst[7]));
  (* keep, BEL="X1Y3/IO6" *) OUTBUF io22_i (.I(dst[6]));
  (* keep, BEL="X1Y3/IO5" *) OUTBUF io21_i (.I(dst[5]));
  (* keep, BEL="X1Y3/IO4" *) OUTBUF io20_i (.I(dst[4]));
  (* keep, BEL="X1Y3/IO3" *) OUTBUF io19_i (.I(dst[3]));
  (* keep, BEL="X1Y3/IO2" *) OUTBUF io18_i (.I(dst[2]));
  (* keep, BEL="X1Y3/IO1" *) OUTBUF io17_i (.I(dst[1]));
  (* keep, BEL="X1Y3/IO0" *) OUTBUF io16_i (.I(dst[0]));

  (* keep, BEL="X2Y0/IO7" *) INBUF io15_i (.O(b[7]));
  (* keep, BEL="X2Y0/IO6" *) INBUF io14_i (.O(b[6]));
  (* keep, BEL="X2Y0/IO5" *) INBUF io13_i (.O(b[5]));
  (* keep, BEL="X2Y0/IO4" *) INBUF io12_i (.O(b[4]));
  (* keep, BEL="X2Y0/IO3" *) INBUF io11_i (.O(b[3]));
  (* keep, BEL="X2Y0/IO2" *) INBUF io10_i (.O(b[2]));
  (* keep, BEL="X2Y0/IO1" *)  INBUF io9_i  (.O(b[1]));
  (* keep, BEL="X2Y0/IO0" *)  INBUF io8_i  (.O(b[0]));

  (* keep, BEL="X1Y0/IO7" *) INBUF io7_i (.O(a[7]));
  (* keep, BEL="X1Y0/IO6" *) INBUF io6_i (.O(a[6]));
  (* keep, BEL="X1Y0/IO5" *) INBUF io5_i (.O(a[5]));
  (* keep, BEL="X1Y0/IO4" *) INBUF io4_i (.O(a[4]));
  (* keep, BEL="X1Y0/IO3" *) INBUF io3_i (.O(a[3]));
  (* keep, BEL="X1Y0/IO2" *) INBUF io2_i (.O(a[2]));
  (* keep, BEL="X1Y0/IO1" *) INBUF io1_i (.O(a[1]));
  (* keep, BEL="X1Y0/IO0" *) INBUF io0_i (.O(a[0]));

  // 07389725796
  // A008626

  // (* keep, BEL="X1Y3/IO7" *) OUTBUF io23_i (.I(dst[7]));
  // (* keep, BEL="X1Y3/IO6" *) OUTBUF io22_i (.I(dst[6]));
  // (* keep, BEL="X1Y3/IO5" *) OUTBUF io21_i (.I(dst[5]));
  // (* keep, BEL="X1Y3/IO4" *) OUTBUF io20_i (.I(dst[4]));
  // (* keep, BEL="X1Y3/IO3" *) OUTBUF io19_i (.I(dst[3]));
  // (* keep, BEL="X1Y3/IO2" *) OUTBUF io18_i (.I(dst[2]));
  // (* keep, BEL="X1Y3/IO1" *) OUTBUF io17_i (.I(dst[1]));
  // (* keep, BEL="X1Y3/IO0" *) OUTBUF io16_i (.I(dst[0]));

  // (* keep, BEL="X2Y0/IO7" *) INBUF io15_i (.O(b[7]));
  // (* keep, BEL="X2Y0/IO6" *) INBUF io14_i (.O(b[6]));
  // (* keep, BEL="X2Y0/IO5" *) INBUF io13_i (.O(b[5]));
  // (* keep, BEL="X2Y0/IO4" *) INBUF io12_i (.O(b[4]));
  // (* keep, BEL="X2Y0/IO3" *) INBUF io11_i (.O(b[3]));
  // (* keep, BEL="X2Y0/IO2" *) INBUF io10_i (.O(b[2]));
  // (* keep, BEL="X2Y0/IO1" *)  INBUF io9_i  (.O(b[1]));
  // (* keep, BEL="X2Y0/IO0" *)  INBUF io8_i  (.O(b[0]));

  // (* keep, BEL="X1Y0/IO7" *) INBUF io7_i (.O(a[7]));
  // (* keep, BEL="X1Y0/IO6" *) INBUF io6_i (.O(a[6]));
  // (* keep, BEL="X1Y0/IO5" *) INBUF io5_i (.O(a[5]));
  // (* keep, BEL="X1Y0/IO4" *) INBUF io4_i (.O(a[4]));
  // (* keep, BEL="X1Y0/IO3" *) INBUF io3_i (.O(a[3]));
  // (* keep, BEL="X1Y0/IO2" *) INBUF io2_i (.O(a[2]));
  // (* keep, BEL="X1Y0/IO1" *) INBUF io1_i (.O(a[1]));
  // (* keep, BEL="X1Y0/IO0" *) INBUF io0_i (.O(a[0]));

  wire clk;
  top top_i(.clk(clk),
            .a(a),
            .b(b),
            .dst(dst));

endmodule

