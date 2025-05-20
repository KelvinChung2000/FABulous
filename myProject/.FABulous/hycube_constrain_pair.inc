#RES_reg_unit:RES_reg_in
ALU:data_out 32 reg_unit:reg_in 32 3 

#const_unit:const_out
ALU:data_in1 32 const_unit:const_out 32 8 
ALU:data_in2 32 const_unit:const_out 32 8 
compare:c_B 32 const_unit:const_out 32 7 

#RES_pred_reg_unit_WIDTH_1:RES_pred_reg_in
logic_op:l_Y 1 reg_unit_WIDTH_1:reg_in 1 11 
compare:c_Y 1 reg_unit_WIDTH_1:reg_in 1 12 

