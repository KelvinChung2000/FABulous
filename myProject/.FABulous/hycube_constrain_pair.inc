#RES_reg_unit:RES_reg_in
ALU:data_out 32 reg_unit:reg_in 32 3 

#const_unit:const_out
ALU:data_in1 32 const_unit:const_out 32 8 
compare:c_B 32 const_unit:const_out 32 7 
ALU:data_in2 32 const_unit:const_out 32 8 

