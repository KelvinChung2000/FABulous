from myProject.Tile.W_IO.W_IO_ports import W_IO_ports


class MuxList(W_IO_ports):

    def construct(self):
        self.out1 //= self.in3
        self.out3 //= self.in1
