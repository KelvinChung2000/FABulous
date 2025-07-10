from dataclasses import dataclass, field
from pathlib import Path
from typing_extensions import Literal

from FABulous.fabric_cad.synth_file_generator.memory_port_factory import MemoryPort
from FABulous.fabric_definition.define import YosysJson, YosysModule, BitVector


@dataclass
class MemoryConfigurationOption:
    """Represents an option block for unified memory mapping."""

    name: str
    value: int
    init_value: str
    cost: int
    data_width: int
    yosys_json: YosysJson
    port_options: list[MemoryPort]
    signal_mapping: dict[str, tuple] = field(default_factory=dict)
    # Store original factory data for signal mapping generation
    _parameters: dict[str, str] = field(default_factory=dict)
    _connections: dict[str, BitVector] = field(default_factory=dict)
    _address_bits: int = field(default=0)
    _read_port_list: list = field(default_factory=list)
    _write_port_list: list = field(default_factory=list)

    @property
    def module(self) -> YosysModule:
        """Get the YosysModule from the yosys_json object."""
        return self.yosys_json.modules[next(iter(self.yosys_json.modules))]

    def get_ports_settings_str(self) -> str:
        """Get string representation of port options for this configuration."""
        return ", ".join(
            f"{port.name}({port.address_bits}, {port.data_width})"
            for port in self.port_options
        )

    def get_port_options_str(self) -> str:
        """Generate port options string with portoptions for memory mapping file."""
        if not self.port_options:
            return ""

        lines = []

        # Group ports by name and port type (since multiple ports can have the same name with different option_names)
        from collections import defaultdict

        port_groups = defaultdict(list)

        for port in self.port_options:
            key = (port.name, port.port_type.value)
            port_groups[key].append(port)

        # Find shared configuration among all ports
        shared_config = set(self.port_options[0].to_configs_list())
        for port in self.port_options[1:]:
            shared_config &= set(port.to_configs_list())

        # Generate port blocks for each unique port name/type combination
        for (port_name, port_type), ports in port_groups.items():
            lines.append(f'port {port_type} "{port_name}" {{')

            # Add shared configurations
            for config in sorted(shared_config):
                lines.append(f"    {config};")

            # Add portoptions based on the different option names
            if len(ports) > 1:
                lines.append("")
                # Create portoptions for each unique configuration
                unique_configs = {}
                for port in ports:
                    option_name = port.option_name
                    port_specific_configs = set(port.to_configs_list()) - shared_config
                    unique_configs[option_name] = port_specific_configs

                # Generate portoptions
                for option_name, configs in unique_configs.items():
                    lines.append(f'    portoption "{option_name}" {option_name} {{')
                    for config in sorted(configs):
                        lines.append(f"        {config};")
                    lines.append("    }")

            lines.append("}")
            lines.append("")

        return "\n".join(lines[:-1])  # Remove last empty line

    def signals_match(self, signal_bits: tuple, port_bits: list) -> bool:
        """Check if signal bits match port bits for proper mapping."""
        # Convert both to sets for comparison
        signal_set = set(signal_bits)
        port_set = set(port_bits)

        # Check if signal bits are a subset of port bits (allowing for partial matches)
        return signal_set.issubset(port_set) or signal_set == port_set

    def get_port_connections(self, port_dict: dict) -> list:
        """Get port connections for this configuration using signal mapping."""
        port_connections = []

        for mapped_port, signal_bits in self.signal_mapping.items():
            if mapped_port in port_dict:
                # Find corresponding BEL port by matching signal bits
                for bel_port, port_detail in self.module.ports.items():
                    if (
                        bel_port in self.module.netnames
                        and hasattr(self.module.netnames[bel_port], "attributes")
                        and "USER_CLK" in self.module.netnames[bel_port].attributes
                    ):
                        continue

                    # Check if signal bits match
                    if self.signals_match(signal_bits, port_detail.bits):
                        port_connections.append((bel_port, port_dict[mapped_port]))
                        break

        return port_connections

    def get_techmap_parameters(self, address_bits: int) -> list:
        """Get techmap module parameters for internal cell matching."""
        params = []

        # Add option parameters (RAM-level) - for internal cell matching
        params.append((f"OPTION_{self.name}", self.value))
        params.append((f"OPTION_{self.name}_ADDRESS_BITS", address_bits))
        params.append((f"OPTION_{self.name}_DATA_WIDTH", self.data_width))

        # Add port configuration parameters - for internal cell matching
        for port in self.port_options:
            port_configs = port.get_port_configurations()
            for config_name, config in port_configs.items():
                if config.is_parameter:
                    params.append((config_name, config.parameter_value or "0"))

        return params

    def get_primitive_parameters(self) -> list:
        """Get primitive cell parameters for hardware instantiation."""
        params = []

        # Only add parameters that the primitive cell expects
        # For Mem primitive, this is only config_bits parameter
        params.append(("config_bits", self.value))

        return params

    def get_config_bit_parameters(self) -> list:
        """Get configuration bit parameters for techmap module signature."""
        config_params = []

        for idx, netname in self.module.netnames.items():
            if hasattr(netname, "attributes") and "CONFIG_BIT" in netname.attributes:
                # For techmap module parameters, use default value "0"
                # The actual value will be determined during synthesis
                config_params.append((idx, "0"))

        return config_params

    def get_config_bit_values(self) -> list:
        """Get configuration bit values for primitive instantiation."""
        config_values = []

        for idx, netname in self.module.netnames.items():
            if hasattr(netname, "attributes") and "CONFIG_BIT" in netname.attributes:
                v = int("".join([str(i) for i in netname.bits]), 2)
                config_values.append((idx, v))

        return config_values

    def generate_signal_mapping(self) -> None:
        """Generate signal mapping for this configuration's ports."""
        if not self.port_options or not self._parameters or not self._connections:
            return

        self.signal_mapping = {}

        # Group address signals by port
        read_addr_signals = self._connections.get("RD_ADDR", [])
        write_addr_signals = self._connections.get("WR_ADDR", [])

        read_port_list = (
            self._group_list(read_addr_signals, self._address_bits)
            if len(read_addr_signals) > 0 and self._address_bits > 0
            else []
        )
        write_port_list = (
            self._group_list(write_addr_signals, self._address_bits)
            if len(write_addr_signals) > 0 and self._address_bits > 0
            else []
        )

        # Convert to sets for easier operations
        rd_port_set = set(tuple(item) for item in read_port_list if item)
        wr_port_set = set(tuple(item) for item in write_port_list if item)

        # Identify port types
        common_ports = rd_port_set.intersection(wr_port_set)
        read_only_ports = rd_port_set.difference(wr_port_set)
        write_only_ports = wr_port_set.difference(rd_port_set)

        # Process read-write ports
        for idx, port_tuple in enumerate(common_ports):
            rd_idx = next(
                (i for i, x in enumerate(read_port_list) if tuple(x) == port_tuple), -1
            )
            wr_idx = next(
                (i for i, x in enumerate(write_port_list) if tuple(x) == port_tuple), -1
            )

            is_async_read = self._connections.get("RD_CLK", [""])[0] == "x"
            mapping = self._create_unified_signal_mapping(
                idx,
                port_tuple,
                rd_idx,
                wr_idx,
                self._connections,
                self.data_width,
                is_async_read,
            )
            self.signal_mapping.update(mapping)

        # Process read-only ports
        for idx, port_tuple in enumerate(read_only_ports):
            rd_idx = next(
                (i for i, x in enumerate(read_port_list) if tuple(x) == port_tuple), -1
            )

            is_async_read = self._connections.get("RD_CLK", [""])[0] == "x"
            mapping = self._create_unified_signal_mapping(
                idx,
                port_tuple,
                rd_idx,
                -1,
                self._connections,
                self.data_width,
                is_async_read,
            )
            self.signal_mapping.update(mapping)

        # Process write-only ports
        for idx, port_tuple in enumerate(write_only_ports):
            wr_idx = next(
                (i for i, x in enumerate(write_port_list) if tuple(x) == port_tuple), -1
            )

            mapping = self._create_unified_signal_mapping(
                idx, port_tuple, -1, wr_idx, self._connections, self.data_width, False
            )
            self.signal_mapping.update(mapping)

    def _create_unified_signal_mapping(
        self,
        idx: int,
        port_tuple: tuple,
        rd_idx: int,
        wr_idx: int,
        connections: dict[str, BitVector],
        data_width: int,
        is_async_read: bool,
    ) -> dict[str, tuple]:
        """Create unified signal mapping for all port types."""
        mapping = {}

        # Determine port type and prefix based on which indices are valid
        if rd_idx != -1 and wr_idx != -1:
            port_prefix = f"PORT_RW{idx}"
        elif rd_idx != -1:
            port_prefix = f"PORT_R{idx}"
        elif wr_idx != -1:
            port_prefix = f"PORT_W{idx}"
        else:
            raise ValueError("Either rd_idx or wr_idx must be valid (not -1)")

        # Address mapping (common to all port types)
        mapping[f"{port_prefix}_ADDR"] = port_tuple

        # Data signal mappings
        self._map_data_signals(
            mapping, port_prefix, rd_idx, wr_idx, connections, data_width
        )

        # Clock signal mappings
        self._map_clock_signals(
            mapping, port_prefix, rd_idx, wr_idx, connections, is_async_read
        )

        # Enable signal mappings
        self._map_enable_signals(mapping, port_prefix, rd_idx, wr_idx, connections)

        # Reset signal mappings (read ports only)
        if rd_idx != -1:
            self._map_reset_signals(mapping, port_prefix, rd_idx, connections)

        # Byte-level write enables (write ports only)
        if wr_idx != -1:
            self._map_byte_enables(
                mapping, port_prefix, wr_idx, connections, data_width
            )

        return mapping

    def _map_data_signals(
        self,
        mapping: dict[str, tuple],
        port_prefix: str,
        rd_idx: int,
        wr_idx: int,
        connections: dict[str, BitVector],
        data_width: int,
    ) -> None:
        """Map data signals for the port."""
        # Write data signals
        if wr_idx != -1 and "WR_DATA" in connections:
            wr_data_groups = self._group_list(connections["WR_DATA"], data_width)
            if wr_idx < len(wr_data_groups):
                mapping[f"{port_prefix}_WR_DATA"] = wr_data_groups[wr_idx]

        # Read data signals
        if rd_idx != -1 and "RD_DATA" in connections:
            rd_data_groups = self._group_list(connections["RD_DATA"], data_width)
            if rd_idx < len(rd_data_groups):
                mapping[f"{port_prefix}_RD_DATA"] = rd_data_groups[rd_idx]

    def _map_clock_signals(
        self,
        mapping: dict[str, tuple],
        port_prefix: str,
        rd_idx: int,
        wr_idx: int,
        connections: dict[str, BitVector],
        is_async_read: bool,
    ) -> None:
        """Map clock signals for the port."""
        if rd_idx != -1:
            # Read-only port: use read clock (if synchronous)
            if not is_async_read and "RD_CLK" in connections:
                mapping[f"{port_prefix}_CLK"] = tuple(connections["RD_CLK"])
        if wr_idx != -1:
            # Write-only port: use write clock
            if "WR_CLK" in connections:
                mapping[f"{port_prefix}_CLK"] = tuple(connections["WR_CLK"])

    def _map_enable_signals(
        self,
        mapping: dict[str, tuple],
        port_prefix: str,
        rd_idx: int,
        wr_idx: int,
        connections: dict[str, BitVector],
    ) -> None:
        """Map enable signals for the port."""
        # Read enable signals
        if rd_idx != -1 and "RD_EN" in connections:
            rd_en_groups = self._group_list(connections["RD_EN"], 1)
            if rd_idx < len(rd_en_groups):
                mapping[f"{port_prefix}_RD_EN"] = rd_en_groups[rd_idx]

        # Write enable signals
        if wr_idx != -1 and "WR_EN" in connections:
            wr_en_groups = self._group_list(connections["WR_EN"], self.data_width)
            if wr_idx < len(wr_en_groups):
                mapping[f"{port_prefix}_WR_EN"] = wr_en_groups[wr_idx]

        # Clock enable signals
        self._map_clock_enable_signals(
            mapping, port_prefix, rd_idx, wr_idx, connections
        )

    def _map_clock_enable_signals(
        self,
        mapping: dict[str, tuple],
        port_prefix: str,
        rd_idx: int,
        wr_idx: int,
        connections: dict[str, BitVector],
    ) -> None:
        """Map clock enable signals for the port."""
        clk_en_key = None
        target_idx = -1

        if rd_idx != -1:
            # Read-only port: prefer read clock enable
            if "RD_CLK_ENABLE" in connections:
                clk_en_key = "RD_CLK_ENABLE"
                target_idx = rd_idx
            elif "CLK_ENABLE" in connections:
                clk_en_key = "CLK_ENABLE"
                target_idx = rd_idx
        if wr_idx != -1:
            # Write-only port: prefer write clock enable
            if "WR_CLK_ENABLE" in connections:
                clk_en_key = "WR_CLK_ENABLE"
                target_idx = wr_idx
            elif "CLK_ENABLE" in connections:
                clk_en_key = "CLK_ENABLE"
                target_idx = wr_idx

        if clk_en_key and target_idx != -1:
            clk_en_groups = self._group_list(connections[clk_en_key], 1)
            if target_idx < len(clk_en_groups):
                mapping[f"{port_prefix}_CLK_EN"] = clk_en_groups[target_idx]

    def _map_reset_signals(
        self,
        mapping: dict[str, tuple],
        port_prefix: str,
        rd_idx: int,
        connections: dict[str, BitVector],
    ) -> None:
        """Map reset signals for read ports."""
        # Async reset signal
        if "RD_ARST" in connections:
            arst_groups = self._group_list(connections["RD_ARST"], 1)
            if rd_idx < len(arst_groups):
                mapping[f"{port_prefix}_RD_ARST"] = arst_groups[rd_idx]

        # Sync reset signal
        if "RD_SRST" in connections:
            srst_groups = self._group_list(connections["RD_SRST"], 1)
            if rd_idx < len(srst_groups):
                mapping[f"{port_prefix}_RD_SRST"] = srst_groups[rd_idx]

    def _map_byte_enables(
        self,
        mapping: dict[str, tuple],
        port_prefix: str,
        wr_idx: int,
        connections: dict[str, BitVector],
        data_width: int,
    ) -> None:
        """Map byte-level write enables for write ports."""
        if "WR_BE" in connections and wr_idx >= 0:
            be_groups = self._group_list(connections["WR_BE"], (data_width + 7) // 8)
            if wr_idx < len(be_groups):
                mapping[f"{port_prefix}_WR_BE"] = be_groups[wr_idx]

    def _group_list(self, data: list, n: int) -> list[tuple]:
        """Group a list into tuples of size n."""
        return [tuple(data[i : i + n]) for i in range(0, len(data), n)]
