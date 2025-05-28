from myProject.Tile.PE.metadata.PE_ports import PE_ports


class MuxList(PE_ports):
    def construct(self):
        self.data_in1 //= [self.in0, self.in1, self.in2, self.in3, self.A_reg_out, self.const_out]
        self.data_in2 //= [self.in0, self.in1, self.in2, self.in3, self.B_reg_out, self.const_out]

        self.A_reg_in //= [self.in0, self.in1, self.in2, self.in3, self.RES_reg_out, self.data_out]
        self.B_reg_in //= [self.in0, self.in1, self.in2, self.in3, self.RES_reg_out, self.data_out]

        self.c_A //= [self.A_reg_out, self.const_out]
        self.c_B //= [self.B_reg_out, self.const_out]

        self.RES_reg_in //= self.data_out

        self.out0 //= [self.in0, self.in1, self.in2, self.in3, self.RES_reg_out, self.data_out]
        self.out1 //= [self.in0, self.in1, self.in2, self.in3, self.RES_reg_out, self.data_out]
        self.out2 //= [self.in0, self.in1, self.in2, self.in3, self.RES_reg_out, self.data_out]
        self.out3 //= [self.in0, self.in1, self.in2, self.in3, self.RES_reg_out, self.data_out]

        # Pred network
        self.data_in3 //= [
            self.pred_in0,
            self.pred_in1,
            self.pred_in2,
            self.pred_in3,
            self.l_Y,
            self.c_Y,
            self.RES_pred_reg_out,
            self.A_pred_reg_out,
            self.B_pred_reg_out,
        ]

        self.SEN //= [
            self.pred_in0,
            self.pred_in1,
            self.pred_in2,
            self.pred_in3,
            self.RES_pred_reg_out,
            self.l_Y,
            self.c_Y,
            self.VCC,
            self.GND,
        ]
        self.SR //= [
            self.pred_in0,
            self.pred_in1,
            self.pred_in2,
            self.pred_in3,
            self.RES_pred_reg_out,
            self.l_Y,
            self.c_Y,
            self.VCC,
            self.GND,
        ]

        self.A_pred_reg_in //= [self.pred_in0, self.pred_in1, self.pred_in2, self.pred_in3, self.RES_pred_reg_out]
        self.B_pred_reg_in //= [self.pred_in0, self.pred_in1, self.pred_in2, self.pred_in3, self.RES_pred_reg_out]
        self.RES_pred_reg_in //= [self.l_Y, self.c_Y]

        self.l_A //= [
            self.pred_in0,
            self.pred_in1,
            self.pred_in2,
            self.pred_in3,
            self.A_pred_reg_out,
            self.RES_pred_reg_out,
        ]
        self.l_B //= [
            self.pred_in0,
            self.pred_in1,
            self.pred_in2,
            self.pred_in3,
            self.B_pred_reg_out,
            self.RES_pred_reg_out,
        ]

        for i in range(4):
            self[f"pred_out{i}"] //= [
                self.pred_in0,
                self.pred_in1,
                self.pred_in2,
                self.pred_in3,
                self.RES_pred_reg_out,
                self.l_Y,
                self.c_Y,
            ]

        # self.spanOut[1] //= self.spanIn[0]
        # self.spanOut[0] //= self.spanIn[1]
        # testOut_i, testOut_o = self.NewWire("testOut_i", "testOut_o", 32)
        # test1_i, test1_o = self.NewWire("test1_i", "test1_o", 16)
        # test2_i, test2_o = self.NewWire("test2_i", "test2_o", 16)
        # test3_i, test3_o = self.NewWire("test3_i", "test3_o", 16)
        # testOut_i[31:16] //= [test3_o, test1_o]
        # testOut_i[15:0] //= test2_o
