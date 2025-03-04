from myProject.Tile.W_IO.metadata.W_IO_ports import W_IO_ports


class MuxList(W_IO_ports):

    def construct(self):
        self.out1 //= self.W_from_fabric
        self.W_to_fabric //= self.in1
        