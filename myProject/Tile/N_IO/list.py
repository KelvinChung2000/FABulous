from myProject.Tile.N_IO.metadata.N_IO_ports import N_IO_ports


class MuxList(N_IO_ports):

    def construct(self):
        self.N_from_fabric //= self.in2
        self.out2 //= self.N_to_fabric
