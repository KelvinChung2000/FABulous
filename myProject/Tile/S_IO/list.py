from myProject.Tile.S_IO.metadata.S_IO_ports import S_IO_ports


class MuxList(S_IO_ports):
    def construct(self):
        self.S_from_fabric //= self.in0
        self.out0 //= self.S_to_fabric

        self.S_pred_from_fabric //= self.pred_in0
        self.pred_out0 //= self.S_pred_to_fabric
