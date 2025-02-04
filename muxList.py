from templated import PE_ports

class MuxList(PE_ports):

    def construct(self):
        self.data_in1 //= [self.in0, self.in1]
        self.data_in2 //= self.in1

        data_test = 