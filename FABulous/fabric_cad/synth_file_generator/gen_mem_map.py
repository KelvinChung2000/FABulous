"""Memory mapping generation with object-oriented design and factory pattern."""

from dataclasses import dataclass, field
from functools import partial
from pathlib import Path

from hdlgen.code_gen import CodeGenerator
from hdlgen.define import WriterType as codeGenWriterType

try:
    from pyosys import libyosys as ys
except ImportError:
    import yosys as ys

from FABulous.fabric_cad.synth_file_generator.memory_port import (
    ARPort,
    ARSWPort,
    SRPort,
    SRSWPort,
    SWPort,
)
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import YosysJson, YosysModule

from .memory_port_factory import MemoryPortFactory

MemoryPort = ARPort | SRPort | SWPort | ARSWPort | SRSWPort


@dataclass
class MemoryMapping:
    """Represents a complete memory mapping specification."""

    module_name: str
    address_bits: int
    data_width: int
    init_value: str
    bel: Bel
    module: YosysModule
    cost: int = 1
    ports: list[MemoryPort] = field(default_factory=list)
    signal_mapping: dict[str, tuple] = field(default_factory=dict)
    parameters: dict[str, str] = field(default_factory=dict)

    def to_memory_mapping_string(self) -> str:
        """Generate the complete memory mapping string."""
        lines = [
            f"ram distributed {self.module_name} {{",
            f"    abits {self.address_bits};",
            f"    width {self.data_width};",
            f"    cost {self.cost};",
            f"    init {self.init_value};",
        ]

        for port in self.ports:
            lines.append(str(port))

        lines.append("}")
        return "\n".join(lines)

    def generate_verilog_mapping(self, file_path: Path) -> None:
        """Generate Verilog mapping file using integrated logic based on Yosys memlib
        standard."""
        if not self.bel or not self.module or not self.parameters:
            raise ValueError("Missing required data for Verilog generation")

        design = ys.Design()
        runPass = partial(lambda design, cmd: ys.run_pass(cmd, design), design)
        runPass("read_json " + str(file_path))
        mod = design.top_module()

        cg = CodeGenerator(
            Path(
                f"{self.bel.src.parent}/metadata/{self.bel.name}/map_{self.bel.name}.v"
            ),
            codeGenWriterType.VERILOG,
            writeMode="a",
        )

        with cg.Module(self.module_name) as m:
            with m.ParameterRegion() as pr:
                init = pr.Parameter("INIT", self.parameters.get("INIT", "0"))

                # Add parameters using the new port methods
                for port in self.ports:
                    port_configs = port.get_port_configurations()

                    for port_name, config in port_configs.items():
                        if config.is_parameter and config.parameter_value is not None:
                            # Create parameters for WIDTH, USED, and CLKPOL
                            pr.Parameter(port_name, config.parameter_value)

            portDict = {}
            with m.PortRegion() as pr:
                # Create ports using the new port methods for complete Yosys memlib compliance
                for port in self.ports:
                    port_configs = port.get_port_configurations()

                    for port_name, config in port_configs.items():
                        if not config.is_parameter:
                            # Create actual Verilog ports
                            portDict[port_name] = pr.Port(
                                port_name, config.direction, config.width
                            )

            with m.LogicRegion() as lr:
                runPass("select a:CONFIG_BIT")
                wires = [i.name.str().removeprefix("\\") for i in mod.selected_wires()]

                # Initialize parameters
                params = [lr.ConnectPair("INIT", init)]

                # Add configuration bits as parameters
                for idx in wires:
                    if idx in self.module.netnames:
                        v = int(
                            "".join([str(i) for i in self.module.netnames[idx].bits]), 2
                        )
                        params.append(lr.ConnectPair(idx, v))

                # Create port connections using signal mapping
                portConnect = []
                for module_port, port_detail in self.module.ports.items():
                    # Skip user clock ports
                    if (
                        module_port in self.module.netnames
                        and "USER_CLK" in self.module.netnames[module_port].attributes
                    ):
                        continue

                    # Find matching signal in our mapping
                    for mapped_port, signal_bits in self.signal_mapping.items():
                        if mapped_port in portDict:
                            # Check if the signal bits match the module port bits
                            if self._signals_match(signal_bits, port_detail.bits):
                                portConnect.append(
                                    lr.ConnectPair(module_port, portDict[mapped_port])
                                )
                                break

                # Initialize the replacement module
                lr.InitModule(
                    f"{self.bel.name}", "_TECHMAP_REPLACE_", portConnect, params
                )

    def _signals_match(self, signal_bits: tuple, port_bits: list) -> bool:
        """Check if signal bits match port bits for proper mapping."""
        # Convert both to sets for comparison
        signal_set = set(signal_bits)
        port_set = set(port_bits)

        # Check if signal bits are a subset of port bits (allowing for partial matches)
        return signal_set.issubset(port_set) or signal_set == port_set


def generate_memory_mapping(
    module: YosysModule, module_name: str, bel: Bel
) -> MemoryMapping:
    """Generate memory mapping from Yosys JSON file using factory pattern."""
    # Find memory cell
    mem_cell = None
    for cell in module.cells.values():
        if cell.type == "$mem_v2":
            mem_cell = cell
            break

    if mem_cell is None:
        raise ValueError("No memory cell found in the module.")

    parameters = mem_cell.parameters
    connections = mem_cell.connections

    # Extract basic parameters
    address_bits = int(parameters["ABITS"], 2)
    data_width = int(parameters["WIDTH"], 2)
    init_value_raw = parameters["INIT"]

    # Determine init value
    if init_value_raw == "x" * (2**address_bits):
        init_value = "none"
    elif init_value_raw == "0" * (2**address_bits):
        init_value = "zero"
    else:
        init_value = "any"

    # Create memory ports using factory
    factory = MemoryPortFactory()
    ports, signal_mapping, cost = factory.create_memory_ports(
        parameters, connections, address_bits, data_width
    )

    # Create memory mapping
    memory_mapping = MemoryMapping(
        module_name=module_name,
        address_bits=address_bits,
        data_width=data_width,
        init_value=init_value,
        cost=cost,
        ports=ports,
        signal_mapping=signal_mapping,
        bel=bel,
        module=module,
        parameters=parameters,
    )

    return memory_mapping


def genMemMap(bel: Bel, dest: Path) -> None:
    """Generate memory mapping file using the new object-oriented factory approach."""
    with open(dest, "w") as f:
        pass

    filePath = bel.src.parent / "metadata" / bel.name
    with open(Path(f"{filePath}/map_{bel.name}.v"), "w") as f:
        pass

    paths = list(filePath.glob(f"cell_{bel.name}*.json"))

    for c in paths:
        print(c)
        yosysJson = YosysJson(c)
        module: YosysModule = yosysJson.modules[next(iter(yosysJson.modules))]
        memory_mapping = generate_memory_mapping(module, f"$__{c.stem}", bel)
        with open(dest, "a") as f:
            f.write(memory_mapping.to_memory_mapping_string())
            f.write("\n")

        # Generate Verilog mapping using the new method
        memory_mapping.generate_verilog_mapping(c)
