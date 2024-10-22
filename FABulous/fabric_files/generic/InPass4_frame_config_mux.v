// Copyright 2021 University of Manchester
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


(* FABulous, BelMap,
I0_reg=0,
I1_reg=1,
I2_reg=2,
I3_reg=3,
*)
module InPass4_frame_config (I0, I1, I2, I3, O0, O1, O2, O3, UserCLK, ConfigBits);
	parameter NoConfigBits = 4;
	// Pin0
	(* FABulous, EXTERNAL *) input I0; //EXTERNAL
	(* FABulous, EXTERNAL *) input I1; //EXTERNAL
	(* FABulous, EXTERNAL *) input I2; //EXTERNAL
	(* FABulous, EXTERNAL *) input I3; //EXTERNAL
	(* FABulous, EXTERNAL *) output O0; //EXTERNAL
	(* FABulous, EXTERNAL *) output O1; //EXTERNAL
	(* FABulous, EXTERNAL *) output O2; //EXTERNAL
	(* FABulous, EXTERNAL *) output O3; //EXTERNAL
	// Tile IO ports from BELs
	(* FABulous, EXTERNAL, SHARED_PORT *) input UserCLK; //EXTERNAL -- SHARED_PORT -- ## the EXTERNAL keyword will send this signal all the way to top and the --SHARED Allows multiple BELs using the same port (e.g. for exporting a clock to the top)
	// GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
	(* FABulous, GLOBAL *) input [NoConfigBits - 1 : 0] ConfigBits;
	//_____   ______
	//    I----+--->|FLOP|-Q-|1 M |
	//         |             |  U |-------> O
	//         +-------------|0 X |               
	// I am instantiating an IOBUF primitive.
	// However, it is possible to connect corresponding pins all the way to top, just by adding an "-- EXTERNAL" comment (see PAD in the entity)
	reg Q0, Q1, Q2, Q3; // FLOPs
	
	always @ (posedge UserCLK)
	begin
		Q0 <= I0;
		Q1 <= I1;
		Q2 <= I2;
		Q3 <= I3;
	end
	// ConfigBits ( '0' combinatorial; '1' registered )
	//assign O0 = ConfigBits[0] ? Q0 : I0;
	//assign O1 = ConfigBits[1] ? Q1 : I1;
	//assign O2 = ConfigBits[2] ? Q2 : I2;
	//assign O3 = ConfigBits[3] ? Q3 : I3;

    cus_mux21_buf cus_mux21_buf_inst0(
    .A0(I0),
    .A1(Q0),
    .S(ConfigBits[0]),
    .X(O0)
    );

    cus_mux21_buf cus_mux21_buf_inst1(
    .A0(I1),
    .A1(Q1),
    .S(ConfigBits[1]),
    .X(O1)
    );

    cus_mux21_buf cus_mux21_buf_inst2(
    .A0(I2),
    .A1(Q2),
    .S(ConfigBits[2]),
    .X(O2)
    );

    cus_mux21_buf cus_mux21_buf_inst3(
    .A0(I3),
    .A1(Q3),
    .S(ConfigBits[3]),
    .X(O3)
    );	
endmodule
