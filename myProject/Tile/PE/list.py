from myProject.Tile.PE.metadata.PE_ports import PE_ports


class MuxList(PE_ports):

    def construct(self):
        self.data_in1 //= [self.in0, self.in1, self.in2, self.in3]
        self.data_in1 //= [
            self.RES_reg_out,
            self.N_reg_out,
            self.E_reg_out,
            self.S_reg_out,
            self.W_reg_out,
        ]
        self.data_in2 //= [self.in0, self.in1, self.in2, self.in3, self.const_out]
        self.data_in2 //= [
            self.RES_reg_out,
            self.N_reg_out,
            self.E_reg_out,
            self.S_reg_out,
            self.W_reg_out,
        ]
        self.data_in3 //= [self.in0[0], self.in1[0], self.in2[0], self.in3[0], self.Y]

        self.A //= [self.in0, self.in1, self.in2, self.in3]
        self.B //= [self.in0, self.in1, self.in2, self.in3, self.const_out]

        self.RES_reg_in //= self.data_out

        for i in range(4):
            self[f"out{i}"] //= self.data_out
            self[f"out{i}"] //= self.RES_reg_out

        self.out0 //= [self.in0, self.in1, self.in2, self.in3]
        self.out1 //= [self.in0, self.in1, self.in2, self.in3]
        self.out2 //= [self.in0, self.in1, self.in2, self.in3]
        self.out3 //= [self.in0, self.in1, self.in2, self.in3]

        self.N_reg_in //= self.in0
        self.E_reg_in //= self.in1
        self.S_reg_in //= self.in2
        self.W_reg_in //= self.in3

        self.N_reg_in //= self.N_reg_out
        self.E_reg_in //= self.E_reg_out
        self.S_reg_in //= self.S_reg_out
        self.W_reg_in //= self.W_reg_out

        for i in ["N", "E", "S", "W"]:
            self[f"{i}_en"] //= [self.Y, self.pred_in0, self.pred_in1, self.pred_in2, self.pred_in3]
            self[f"{i}_rst"] //= [self.Y, self.pred_in0, self.pred_in1, self.pred_in2, self.pred_in3]

        # self.spanOut[1] //= self.spanIn[0]
        # self.spanOut[0] //= self.spanIn[1]
        # testOut_i, testOut_o = self.NewWire("testOut_i", "testOut_o", 32)
        # test1_i, test1_o = self.NewWire("test1_i", "test1_o", 16)
        # test2_i, test2_o = self.NewWire("test2_i", "test2_o", 16)
        # test3_i, test3_o = self.NewWire("test3_i", "test3_o", 16)
        # testOut_i[31:16] //= [test3_o, test1_o]
        # testOut_i[15:0] //= test2_o
