#RES_reg_unit:RES_reg_in
reg_unit:reg_in 32 ALU:data_out 32 1 

#c_compare:c_A
compare:A 32 reg_unit:reg_out 32 1 
compare:A 32 const_unit:const_out 32 3 

#c_compare:c_B
compare:B 32 reg_unit:reg_out 32 2 
compare:B 32 const_unit:const_out 32 3 

#A_reg_unit:A_reg_out
ALU:data_in1 32 reg_unit:reg_out 32 2 
compare:A 32 reg_unit:reg_out 32 1 

#B_reg_unit:B_reg_out
ALU:data_in2 32 reg_unit:reg_out 32 3 
compare:B 32 reg_unit:reg_out 32 2 

#const_unit:const_out
ALU:data_in1 32 const_unit:const_out 32 4 
ALU:data_in2 32 const_unit:const_out 32 4 
compare:A 32 const_unit:const_out 32 3 
compare:B 32 const_unit:const_out 32 3 

#RES_pred_reg_unit_WIDTH_1:RES_pred_reg_in
reg_unit_WIDTH_1:reg_in 1 logic_op:Y 1 1 
compare:Y 1 reg_unit_WIDTH_1:reg_in 1 4 

#A_pred_reg_unit_WIDTH_1:A_pred_reg_out
ALU:data_in3 1 reg_unit_WIDTH_1:reg_out 1 7 
logic_op:A 1 reg_unit_WIDTH_1:reg_out 1 1 

#B_pred_reg_unit_WIDTH_1:B_pred_reg_out
ALU:data_in3 1 reg_unit_WIDTH_1:reg_out 1 8 
logic_op:B 1 reg_unit_WIDTH_1:reg_out 1 2 

