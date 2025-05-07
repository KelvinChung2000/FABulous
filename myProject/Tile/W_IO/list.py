from myProject.Tile.W_IO.metadata.W_IO_ports import W_IO_ports


class MuxList(W_IO_ports):

    def construct(self):
        self.W_from_fabric //= self.in1
        # self.out1 //= self.W_to_fabric
        for i in range(8):
            self.out1[i] //= [self.W_to_fabric[j] for j in range(8)]

        self.out1[31:8] //= self.W_to_fabric[31:8]
