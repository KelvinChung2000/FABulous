from myProject.Tile.N_IO.N_IO_ports import N_IO_ports


class MuxList(N_IO_ports):

    def construct(self):
        self.out0 //= self.in2
        self.out2 //= self.in0
