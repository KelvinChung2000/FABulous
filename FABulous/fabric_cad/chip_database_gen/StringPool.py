from FABulous.fabric_cad.bba import BBAWriter
from FABulous.fabric_cad.chip_database_gen.define import IdString


class StringPool:
    def __init__(self):
        self.strs = {"": 0}
        self.known_id_count = 1

    def read_constids(self, file: str):
        idx = 1
        with open(file, "r") as f:
            for line in f:
                l = line.strip()
                if not l.startswith("X("):
                    continue
                l = l[2:]
                assert l.endswith(")"), l
                l = l[:-1].strip()
                i = self.id(l)
                assert i.index == idx, (i, idx, l)
                idx += 1
        self.known_id_count = idx

    def id(self, val: str):
        if val in self.strs:
            return IdString(self.strs[val], val)
        else:
            idx = len(self.strs)
            self.strs[val] = idx
            return IdString(idx, val)

    def serialise_lists(self, context: str, bba: BBAWriter):
        bba.label(f"{context}_strs")
        for s, idx in sorted(self.strs.items(), key=lambda x: x[1]):  # sort by index
            if idx < self.known_id_count:
                continue
            bba.str(s)

    def __getitem__(self, id: IdString) -> str:
        for s, i in self.strs.items():
            if i == id.index:
                return s
        else:
            raise ValueError(f"Unknown id {id}")

    def serialise(self, context: str, bba: BBAWriter):
        bba.u32(self.known_id_count)
        bba.slice(f"{context}_strs", len(self.strs) - self.known_id_count)

    def toConstStringId(self, file: str):
        with open(file, "w") as f:
            for s in self.strs.keys():
                f.write(f"X({s})\n")
