"""Memory mapping generation with object-oriented design and factory pattern."""

import textwrap
from dataclasses import field
from pathlib import Path

from hdlgen.code_gen import CodeGenerator
from hdlgen.define import WriterType as codeGenWriterType

from FABulous.fabric_cad.synth_file_generator.memory_port import (
    ARPort,
    ARSWPort,
    SRPort,
    SRSWPort,
    SWPort,
)
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.define import YosysJson, YosysModule

from .memory_port_factory import MemoryConfigurationOption, MemoryPortFactory

MemoryPort = ARPort | SRPort | SWPort | ARSWPort | SRSWPort


class MemoryMapping:
    """Represents a complete memory mapping specification."""

    module_name: str
    bel: Bel
    module: YosysModule
    address_bits: int
    data_widths: list[int]  # Support multiple widths
    init_value: str
    cell_config_options: list[MemoryConfigurationOption]

    signal_mapping: dict[str, tuple]
    parameters: dict[str, str]

    def __init__(self, cell_files: list[Path], module_name: str, bel: Bel):
        """Create unified memory mapping from multiple cell JSON files using options."""
        if not cell_files:
            raise ValueError("No cell files provided.")

        self.cell_config_options: list[MemoryConfigurationOption] = []

        all_address_bits: list[int] = []
        all_data_widths: list[int] = []

        # Process cell files directly to create configuration options
        for idx, file_path in enumerate(cell_files):
            yosys_json = YosysJson(file_path)
            module: YosysModule = yosys_json.modules[next(iter(yosys_json.modules))]

            # Find memory cell
            mem_cell = None
            for cell in module.cells.values():
                if cell.type == "$mem_v2":
                    mem_cell = cell
                    break

            if mem_cell is None:
                raise ValueError(f"No memory cell found in {file_path}")

            parameters = mem_cell.parameters
            connections = mem_cell.connections

            # Extract basic parameters
            address_bits = int(parameters["ABITS"], 2)
            data_width = int(parameters["WIDTH"], 2)
            init_value_raw = parameters["INIT"]

            # Track all address bits and data widths
            all_address_bits.append(address_bits)
            all_data_widths.append(data_width)

            # Determine init value
            if init_value_raw == "x" * (2**address_bits):
                init_value = "none"
            elif init_value_raw == "0" * (2**address_bits):
                init_value = "zero"
            else:
                init_value = "any"

            # Determine port types by creating actual ports
            ports, mapping, cost = MemoryPortFactory().create_memory_ports(
                parameters, connections, address_bits, data_width
            )

            config_option = MemoryConfigurationOption(
                name=file_path.stem,
                value=idx,
                init_value=init_value,
                cost=cost,
                port_options=ports,
                signal_mapping=mapping,
            )
            # Store per-config dimensions
            config_option.address_bits = address_bits
            config_option.data_width = data_width

            self.cell_config_options.append(config_option)

        if not self.cell_config_options:
            raise ValueError("No valid configurations found in cell files.")

        # Validate configurations have consistent dimensions or support multiple widths
        unique_address_bits = list(set(all_address_bits))
        unique_data_widths = list(set(all_data_widths))

        if len(unique_address_bits) > 1:
            raise ValueError(
                f"Configurations have different address bits: {unique_address_bits}. "
                "Address bits must be consistent across configurations."
            )

        # Use the first configuration for reference values
        first_config = self.cell_config_options[0]

        self.module_name = module_name
        self.address_bits = unique_address_bits[
            0
        ]  # All configs must have same address bits
        self.data_widths = sorted(unique_data_widths)  # Support multiple widths
        self.cost = max(config.cost for config in self.cell_config_options)
        self.signal_mapping = first_config.signal_mapping
        self.bel = bel
        self.parameters = {}  # Will be populated from reference module if needed

    def generate_memory_mapping(self, path: Path):
        """Generate the memory mapping string with options and portoptions."""
        lines = [f"ram distributed {self.module_name} {{"]
        lines.append(f"    abits {self.address_bits};")

        # Handle multiple widths according to Yosys documentation
        if len(self.data_widths) == 1:
            lines.append(f"    width {self.data_widths[0]};")
        else:
            # Multiple widths - use widths array format
            widths_str = " ".join(str(w) for w in self.data_widths)
            lines.append(f"    widths {widths_str};")

        for option in self.cell_config_options:
            lines.append(f'    option "{option.name}" {option.value} {{')
            lines.append(f"        cost {option.cost};")
            lines.append(f"        init {option.init_value};")

            # Add width-specific information if this config has different width
            if len(self.data_widths) > 1:
                lines.append(f"        width {option.data_width};")

            lines.append("")
            lines.append(textwrap.indent(option.get_port_options_str(), " " * 8))
            lines.append("")
            lines.append("    }")

        lines.append("}")

        with open(path, "w") as f:
            f.write("\n".join(lines))

    def _add_forbid_constraints(self, lines: list[str], port_options) -> None:
        """Add forbid constraints for mutually exclusive port types."""
        # Get compound port types that should be mutually exclusive
        compound_ports = [po for po in port_options if po.port_type in ["srsw", "arsw"]]

        if len(compound_ports) > 1:
            # Create forbid constraint for compound port types
            port_type_names = [f'"{po.port_type}"' for po in compound_ports]
            forbid_line = f"        portoption {' '.join(port_type_names)} {{"
            lines.append(forbid_line)
            lines.append("            forbid;")
            lines.append("        }")
            lines.append("")

    def _add_option_parameters(self, parameter_region) -> None:
        """Add option-related parameters to the parameter region."""
        for option in self.cell_config_options:
            # Add RAM-level option parameter
            parameter_region.Parameter(f"OPTION_{option.name}", str(option.value))

            # Add config-level dimensions
            parameter_region.Parameter(
                f"OPTION_{option.name}_ADDRESS_BITS", str(option.address_bits)
            )
            parameter_region.Parameter(
                f"OPTION_{option.name}_DATA_WIDTH", str(option.data_width)
            )

            # Add port-level parameters from memory ports
            for port in option.port_options:
                # Add basic port parameters
                parameter_region.Parameter(
                    f"PORT_{port.name}_ADDRESS_BITS", str(port.address_bits)
                )
                parameter_region.Parameter(
                    f"PORT_{port.name}_DATA_WIDTH", str(port.data_width)
                )

    def generate_verilog_mapping(self) -> None:
        """Generate Verilog mapping for unified memory mapping with options."""
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
                # Add option parameters
                self._add_option_parameters(pr)

            portDict = {}
            with m.PortRegion() as pr:
                # Create ports from options
                for option in self.cell_config_options:
                    for port in option.port_options:
                        # Create ports based on memory port configurations
                        port_configs = port.get_port_configurations()
                        for port_name, config in port_configs.items():
                            if not config.is_parameter and port_name not in portDict:
                                # Create actual Verilog ports (avoid duplicates)
                                portDict[port_name] = pr.Port(
                                    port_name, config.direction, config.width
                                )

            with m.LogicRegion() as lr:
                # Initialize parameters
                params = [lr.ConnectPair("INIT", init)]

                # Add option parameters as connections
                for option in self.cell_config_options:
                    params.append(lr.ConnectPair(f"OPTION_{option.name}", option.value))

                    # Add config-level dimensions
                    params.append(
                        lr.ConnectPair(
                            f"OPTION_{option.name}_ADDRESS_BITS", option.address_bits
                        )
                    )
                    params.append(
                        lr.ConnectPair(
                            f"OPTION_{option.name}_DATA_WIDTH", option.data_width
                        )
                    )

                    for port in option.port_options:
                        # Add basic port parameters
                        params.append(
                            lr.ConnectPair(
                                f"PORT_{port.name}_ADDRESS_BITS", port.address_bits
                            )
                        )
                        params.append(
                            lr.ConnectPair(
                                f"PORT_{port.name}_DATA_WIDTH", port.data_width
                            )
                        )

                # Add configuration bits from the reference module
                if self.module:
                    for idx, netname in self.module.netnames.items():
                        if (
                            hasattr(netname, "attributes")
                            and "CONFIG_BIT" in netname.attributes
                        ):
                            v = int("".join([str(i) for i in netname.bits]), 2)
                            params.append(lr.ConnectPair(idx, v))

                # Create port connections using signal mapping
                portConnect = []
                if self.module:
                    for module_port, port_detail in self.module.ports.items():
                        # Skip user clock ports
                        if (
                            module_port in self.module.netnames
                            and hasattr(self.module.netnames[module_port], "attributes")
                            and "USER_CLK"
                            in self.module.netnames[module_port].attributes
                        ):
                            continue

                        # Find matching signal in our mapping
                        for mapped_port, signal_bits in self.signal_mapping.items():
                            if mapped_port in portDict:
                                # Check if the signal bits match the module port bits
                                if self._signals_match(signal_bits, port_detail.bits):
                                    portConnect.append(
                                        lr.ConnectPair(
                                            module_port, portDict[mapped_port]
                                        )
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


def genMemMap(bel: Bel, dest: Path) -> None:
    """Generate unified memory mapping file using options syntax."""
    # Clear the destination files
    with open(dest, "w"):
        pass

    filePath = bel.src.parent / "metadata" / bel.name
    with open(Path(f"{filePath}/map_{bel.name}.v"), "w"):
        pass

    # Collect all cell JSON files
    paths = list(filePath.glob(f"cell_{bel.name}*.json"))

    if not paths:
        print(f"No cell files found for {bel.name}")
        return

    print(f"Found {len(paths)} cell files for {bel.name}")
    for p in paths:
        print(f"  {p}")

    # Generate unified memory mapping
    unified_mapping = MemoryMapping(paths, f"$__{bel.name}", bel)

    unified_mapping.generate_memory_mapping(dest)

    print(f"Generated unified memory mapping for {bel.name}")

    # Generate single Verilog mapping file based on the unified mapping itself
    unified_mapping.generate_verilog_mapping()
