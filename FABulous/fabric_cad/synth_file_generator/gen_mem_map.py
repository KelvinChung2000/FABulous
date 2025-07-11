"""Memory mapping generation with object-oriented design and factory pattern."""

import textwrap
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

from .memory_port_factory import MemoryPortFactory
from .MemoryConfigurationOption import MemoryConfigurationOption

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
            ports, cost = MemoryPortFactory().create_memory_ports(
                parameters, connections, address_bits, data_width
            )

            config_name: str
            value: int
            n = yosys_json.findNetWithAttribute("CONFIG_BIT")
            print(yosys_json)
            if n is not None:
                if len(n) != 1:
                    raise ValueError(
                        f"Memory cell in {file_path} must have exactly one net with CONFIG_BIT attribute."
                    )
                config_name = n[0]
                value = int(
                    "".join([str(i) for i in module.netnames[config_name].bits]), 2
                )
                print(config_name, value)
            else:
                config_name = file_path.stem
                value = 0  # Default value if no CONFIG_BIT found

            config_option = MemoryConfigurationOption(
                name=config_name,
                value=value,
                init_value=init_value,
                cost=cost,
                port_options=ports,
                data_width=data_width,
                yosys_json=yosys_json,
                _parameters=parameters,
                _connections=connections,
                _address_bits=address_bits,
            )

            # Generate signal mapping for this configuration
            config_option.generate_signal_mapping()
            # Store per-config dimensions

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
        self.init_value = init_value
        self.cost = max(config.cost for config in self.cell_config_options)
        self.signal_mapping = first_config.signal_mapping
        self.bel = bel
        self.parameters = {}  # Will be populated from reference module if needed

        # Store reference module from first configuration for port mapping
        if cell_files:
            first_file = cell_files[0]
            yosys_json = YosysJson(first_file)
            self.module = yosys_json.modules[next(iter(yosys_json.modules))]
        else:
            self.module = None

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

        lines.append(f"    init {self.init_value};")
        lines.append("")

        if len(self.cell_config_options) == 1:
            # Single option - skip the option wrapper
            option = self.cell_config_options[0]
            lines.append(f"    cost {option.cost};")

            # Add width-specific information if this config has different width
            if len(self.data_widths) > 1:
                lines.append(f"    width {option.data_width};")

            lines.append("")
            lines.append(textwrap.indent(option.get_port_options_str(), " " * 4))
        else:
            # Multiple options - use option wrapper
            for option in self.cell_config_options:
                lines.append(f'    option "{option.name}" {option.value} {{')
                lines.append(f"        cost {option.cost};")

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

    def generate_verilog_mapping(self) -> None:
        """Generate sophisticated Verilog mapping with conditional configuration
        logic."""
        cg = CodeGenerator(
            Path(
                f"{self.bel.src.parent}/metadata/{self.bel.name}/map_{self.bel.name}.v"
            ),
            codeGenWriterType.VERILOG,
            writeMode="a",
        )

        # Generate a main techmap module that uses conditional logic
        with cg.Module(self.module_name) as m:
            with m.ParameterRegion() as pr:
                pr.Parameter("INIT", self.parameters.get("INIT", "0"))
                # Add option parameters
                for option in self.cell_config_options:
                    # Add RAM-level option parameter
                    pr.Parameter(f"OPTION_{option.name}", str(option.value))

                    # Add config-level dimensions
                    pr.Parameter(
                        f"OPTION_{option.name}_ADDRESS_BITS", str(self.address_bits)
                    )
                    pr.Parameter(
                        f"OPTION_{option.name}_DATA_WIDTH", str(option.data_width)
                    )
                # Add port-based parameters for techmap
                for option in self.cell_config_options:
                    for port in option.port_options:
                        port_configs = port.get_port_configurations()
                        for config_name, config in port_configs.items():
                            if config.is_parameter:
                                pr.Parameter(config_name, config.parameter_value or "0")

            # Create all possible ports from all configurations
            portDict = {}
            with m.PortRegion() as pr:
                for option in self.cell_config_options:
                    for port in option.port_options:
                        port_configs = port.get_port_configurations()
                        for port_name, config in port_configs.items():
                            if not config.is_parameter and port_name not in portDict:
                                portDict[port_name] = pr.Port(
                                    port_name, config.direction, config.width
                                )

            with m.LogicRegion() as lr:
                # Generate conditional configuration logic using wire assignments

                # Collect all parameters for internal cell matching (techmap module signature)
                params = []
                params.append(lr.ConnectPair("INIT", self.parameters.get("INIT", "0")))

                # Use a set to track unique parameters and avoid duplicates
                unique_params = set()
                unique_params.add("INIT")

                # Add parameters from each configuration for internal cell matching
                for option in self.cell_config_options:
                    for param_name, param_value in option.get_techmap_parameters(
                        self.address_bits
                    ):
                        if param_name not in unique_params:
                            params.append(lr.ConnectPair(param_name, param_value))
                            unique_params.add(param_name)

                # Add configuration bit parameters from each configuration for internal cell matching
                for option in self.cell_config_options:
                    for (
                        config_name,
                        default_value,
                    ) in option.get_config_bit_parameters():
                        if config_name not in unique_params:
                            params.append(lr.ConnectPair(config_name, default_value))
                            unique_params.add(config_name)

                # Create port connections - handle multiple configurations
                portConnect = []

                # Generate connections for each configuration
                if len(self.cell_config_options) == 1:
                    # Single configuration - direct connection
                    config = self.cell_config_options[0]
                    connections = config.get_port_connections(portDict)
                    for bel_port, port_obj in connections:
                        portConnect.append(lr.ConnectPair(bel_port, port_obj))
                else:
                    # Multiple configurations - use conditional logic
                    # For each unique port that appears in any configuration
                    all_ports = set()
                    for config in self.cell_config_options:
                        all_ports.update(config.signal_mapping.keys())

                    for port_name in all_ports:
                        if port_name in portDict:
                            # Find which configurations use this port
                            config_connections = []
                            for config in self.cell_config_options:
                                if port_name in config.signal_mapping:
                                    connections = config.get_port_connections(
                                        {port_name: portDict[port_name]}
                                    )
                                    if connections:
                                        config_connections.append(
                                            (config, connections[0])
                                        )

                            # Use the first available connection for now
                            # TODO: Implement proper conditional multiplexing based on configuration bits
                            if config_connections:
                                bel_port, port_obj = config_connections[0][1]
                                portConnect.append(lr.ConnectPair(bel_port, port_obj))

                # Create primitive parameters for hardware instantiation (only what primitive accepts)
                primitive_params = []

                # Add configuration bit values for primitive instantiation
                for option in self.cell_config_options:
                    for config_name, config_value in option.get_config_bit_values():
                        primitive_params.append(
                            lr.ConnectPair(config_name, config_value)
                        )

                # Initialize the replacement module with primitive parameters
                lr.InitModule(
                    f"{self.bel.name}",
                    "_TECHMAP_REPLACE_",
                    portConnect,
                    primitive_params,
                )


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
