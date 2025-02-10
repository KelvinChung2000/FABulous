from myProject.Tile.S_IO.metadata.S_IO_ports import S_IO_ports

class MuxList(S_IO_ports):

    def construct(self):
        self.out0 //= self.in2
        self.out2 //= self.in0