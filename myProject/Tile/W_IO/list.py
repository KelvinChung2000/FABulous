from myProject.Tile.W_IO.metadata.W_IO_ports import W_IO_ports


class MuxList(W_IO_ports):

    def construct(self):
        self.W_from_fabric //= self.in1
        self.out1 //= self.W_to_fabric
