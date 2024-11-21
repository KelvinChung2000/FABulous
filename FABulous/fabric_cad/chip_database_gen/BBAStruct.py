import abc

from FABulous.fabric_cad.bba import BBAWriter


class BBAStruct(abc.ABC):
    def serialise_lists(self, context: str, bba: BBAWriter):
        pass

    def serialise(self, context: str, bba: BBAWriter):
        pass
