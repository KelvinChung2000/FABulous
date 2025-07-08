from dataclasses import dataclass, field

from FABulous.fabric_cad.synth_file_generator.memory_port_factory import MemoryPort


@dataclass
class MemoryConfigurationOption:
    """Represents an option block for unified memory mapping."""

    name: str
    value: int
    init_value: str
    cost: int
    data_width: int
    port_options: list[MemoryPort]
    signal_mapping: dict[str, tuple]

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
