from myProject.Tile.N_IO.metadata.N_IO_ports import N_IO_ports


class MuxList(N_IO_ports):
    def construct(self):
        self.N_from_fabric //= self.in2
        self.out2 //= self.N_to_fabric
        
        self.N_pred_from_fabric //= self.pred_in2
        self.pred_out2 //= self.N_pred_to_fabric
