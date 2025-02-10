from myProject.Tile.E_IO.metadata.E_IO_ports import E_IO_ports


class MuxList(E_IO_ports):

    def construct(self):
        self.out3 //= self.in1
        self.out1 //= self.in3
