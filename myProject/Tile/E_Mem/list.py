# Do not modify the boilerplate code, as it is used to generate the listFile.py file

from myProject.Tile.E_Mem.metadata.E_Mem_ports import E_Mem_ports

class MuxList(E_Mem_ports):

    def construct(self):
        # remove the placeholder pass and add your code here
        # To access the available ports use self.portName
        # To connect ports use the following syntax:
        # self.a //= self.b
        # To create a new wire use the following syntax:
        # <any_placeholder_name> = self.NewWire('<generated_name>', width)
        # You can slice ports using the normal python slicing syntax.
        # For example: self.a[3:0] //= self.b[7:4]
        # We follow the Verilog slicing convention, where the left side 
        # of the slicing operator is the MSB and the right side is the LSB
        # if you want to use string to access the ports, you can use the following syntax:
        # self["portName"] //= self["portName"]
        # Since this is running a python script, you can use any python code here
        # All the input to a mux will be in the order which the connections are made
        # For example, if you connect self.out //= self.a and then self.out //= self.b
        # The inputs to the mux will be [self.a, self.b]
        self.A_addr0 //= [self.E_Mem_top_in3, self.E_Mem_bot_in3]
        self.A_write_data //= [self.E_Mem_top_in3, self.E_Mem_bot_in3]
        self.A_write_en //= [self.E_Mem_top_pred_in3, self.E_Mem_bot_pred_in3]
        self.A_reset //= [self.E_Mem_top_pred_in3, self.E_Mem_bot_pred_in3]
        self.E_Mem_bot_out3 //= self.A_read_data
        self.E_Mem_top_out3 //= self.A_read_data

        self.B_addr0 //= [self.E_Mem_top_in3, self.E_Mem_bot_in3]
        self.B_write_data //= [self.E_Mem_top_in3, self.E_Mem_bot_in3]
        self.B_write_en //= [self.E_Mem_top_pred_in3, self.E_Mem_bot_pred_in3]
        self.B_reset //= [self.E_Mem_top_pred_in3, self.E_Mem_bot_pred_in3]
        self.E_Mem_bot_out3 //= self.B_read_data
        self.E_Mem_top_out3 //= self.B_read_data

