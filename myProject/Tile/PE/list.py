from myProject.Tile.PE.PE_ports import PE_ports


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
            self.RES_reg_in,
            self.N_reg_in,
            self.E_reg_in,
            self.S_reg_in,
            self.W_reg_in,
        ]

        self.RES_reg_in //= self.data_out

        for i in range(4):
            self[f"out{i}"] //= self.data_out

        self.N_reg_in //= self.in0
        self.E_reg_in //= self.in1
        self.S_reg_in //= self.in2
        self.W_reg_in //= self.in3

        self.N_reg_in //= self.N_reg_out
        self.E_reg_in //= self.E_reg_out
        self.S_reg_in //= self.S_reg_out
        self.W_reg_in //= self.W_reg_out

        self.spanOut[1] //= self.spanIn[0]
        self.spanOut[0] //= self.spanIn[1]
        wOut = self.NewWire("testOut", 32)
        w1 = self.NewWire("test1", 16)
        w2 = self.NewWire("test2", 16)
        wOut[31:16] //= w1
        wOut[15:0] //= w2
