from myProject.Tile.E_IO.metadata.E_IO_ports import E_IO_ports


class MuxList(E_IO_ports):
    def construct(self):
        self.E_from_fabric //= self.in3
        self.out3 //= self.E_to_fabric
        self.E_pred_from_fabric //= self.pred_in3
        self.pred_out3 //= self.E_pred_to_fabric