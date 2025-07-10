"""Concrete memory port implementations."""

import textwrap
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import StrEnum
from typing import Optional

from typing_extensions import Literal

from FABulous.fabric_definition.define import IO


@dataclass
class MemoryConfig:
    """Memory-level configuration for Yosys memlib."""

    # Memory dimensions
    abits: int
    width: int
    widths: list[int] | None = None

    # Memory initialization
    init: Literal["none", "zero", "any", "no_undef"] = "none"

    # Memory configuration
    byte: int | None = None
    cost: int = 1
    style: str | None = None
    prune_rom: bool = False

    def __post_init__(self):
        """Validate memory configuration."""
        if self.abits <= 0:
            raise ValueError("abits must be positive")
        if self.width <= 0:
            raise ValueError("width must be positive")
        if self.widths and not all(w > 0 for w in self.widths):
            raise ValueError("All widths must be positive")
        if self.byte and self.byte <= 0:
            raise ValueError("byte must be positive")
        if self.cost < 0:
            raise ValueError("cost must be non-negative")


@dataclass
class VerilogPortConfig:
    """Configuration for a single Verilog port."""

    name: str
    direction: IO
    width: int
    is_parameter: bool = False
    parameter_value: Optional[str] = None


class MemoryPortType(StrEnum):
    """Memory port types as defined in Yosys memory library documentation."""

    AR = "ar"  # Asynchronous read
    SR = "sr"  # Synchronous read
    SW = "sw"  # Synchronous write
    ARSW = "arsw"  # Asynchronous read + synchronous write
    SRSW = "srsw"  # Synchronous read + synchronous write


@dataclass
class MemoryPortBase(ABC):
    """Abstract base class for all memory ports."""

    name: str
    address_bits: int
    data_width: int

    option_name: str | None = None  # Optional name for the port option

    clock_edge: Literal["posedge", "negedge", "anyedge"] = "anyedge"
    clock_enable: bool = False

    # Width configuration
    width_mode: Literal["tied", "mix"] | None = None
    width_values: list[int] | None = None
    rd_width_values: list[int] | None = None
    wr_width_values: list[int] | None = None

    signal_mapping: dict[str, tuple] = field(default_factory=dict)

    @property
    @abstractmethod
    def port_type(self) -> MemoryPortType:
        """Return the port type."""
        pass

    @abstractmethod
    def to_configs_list(self) -> list[str]:
        """Generate the port configuration string for memory mapping file."""
        port_config = []

        if isinstance(self, (SRPort, SWPort)):
            port_config.append(f"clock {self.clock_edge}")
            if self.clock_enable:
                port_config.append("clken")

        return port_config

    @abstractmethod
    def get_port_configurations(self) -> dict[str, VerilogPortConfig]:
        """Return common port configurations based on port type."""
        configs = {
            f"PORT_{self.name}_ADDR": VerilogPortConfig(
                f"PORT_{self.name}_ADDR", IO.INPUT, self.address_bits
            ),
        }
        if isinstance(self, (SRPort, SWPort, ARSWPort, SRSWPort)):
            configs[f"PORT_{self.name}_CLK"] = VerilogPortConfig(
                f"PORT_{self.name}_CLK", IO.INPUT, 1
            )

        # Add write data port for write-capable ports (sw, arsw, srsw)
        if isinstance(self, (SWPort, ARSWPort, SRSWPort)):
            configs[f"PORT_{self.name}_WR_DATA"] = VerilogPortConfig(
                f"PORT_{self.name}_WR_DATA", IO.INPUT, self.data_width
            )

        # Add WIDTH parameter only for tied ports or when width_mode is specified
        if self.width_mode == "tied" or (
            self.width_mode is None and not self.width_values
        ):
            configs[f"PORT_{self.name}_WIDTH"] = VerilogPortConfig(
                f"PORT_{self.name}_WIDTH",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value=str(self.data_width),
            )

        return configs

    def __str__(self) -> str:
        """Generate the complete port string for memory mapping file."""
        port_header = f'    port {self.port_type.value} "{self.name}" {{'
        port_config = []

        port_config.extend(self.to_configs_list())

        if not port_config:
            raise ValueError(
                f"{self.port_type} must have at least one configuration option set."
            )

        lines = [port_header]
        lines.append(textwrap.indent(";\n".join(port_config) + ";", "        "))
        lines.append("    }")
        return "\n".join(lines)


@dataclass
class ARPort(MemoryPortBase):
    """Asynchronous read port."""

    # Read enable signal
    read_enable: bool = False
    # Reset/initialization configurations
    read_init: Literal["none", "zero", "any", "no_undef"] = "none"
    read_arst: Literal["none", "zero", "any", "no_undef", "init"] = "none"
    optional: bool = False

    def __post_init__(self):
        """Validate ARPort configuration."""

    @property
    def port_type(self) -> MemoryPortType:
        return MemoryPortType.AR

    def to_configs_list(self) -> list[str]:
        """Generate the port configuration string for memory mapping file."""
        config: list[str] = []
        config.extend(super().to_configs_list())

        # Width configuration
        if self.width_mode:
            config.append(f"width {self.width_mode}")
        elif self.width_values:
            config.append(f"width {' '.join(map(str, self.width_values))}")
        elif self.rd_width_values:
            config.append(f"width rd {' '.join(map(str, self.rd_width_values))}")

        # Read enable is not supported for asynchronous read ports per memlib spec
        # if self.read_enable:
        #     config.append("rden")

        # Optional configuration
        if self.optional:
            config.append("optional")

        return config

    def get_port_configurations(self) -> dict[str, VerilogPortConfig]:
        """Return port configurations with width, direction, and special attributes."""
        configs = super().get_port_configurations()

        # Note: RD_DATA port is now handled in base class

        configs[f"PORT_{self.name}_RD_DATA"] = VerilogPortConfig(
            f"PORT_{self.name}_RD_DATA", IO.OUTPUT, self.data_width
        )

        # Add separate read/write widths for mix mode
        if self.width_mode == "mix":
            if self.rd_width_values:
                configs[f"PORT_{self.name}_RD_WIDTH"] = VerilogPortConfig(
                    f"PORT_{self.name}_RD_WIDTH",
                    IO.INPUT,
                    1,
                    is_parameter=True,
                    parameter_value=str(self.rd_width_values[0]),
                )

        # RD_USED is only for optional_rw ports (ARSWPort/SRSWPort), not regular optional ARPort
        # if self.optional:
        #     configs[f"PORT_{self.name}_RD_USED"] = VerilogPortConfig(
        #         f"PORT_{self.name}_RD_USED",
        #         IO.INPUT,
        #         1,
        #         is_parameter=True,
        #         parameter_value="1",
        #     )

        # Add RD_INIT_VALUE parameter if needed
        if self.read_init in ["any", "no_undef"]:
            configs[f"PORT_{self.name}_RD_INIT_VALUE"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_INIT_VALUE",
                IO.INPUT,
                self.data_width,
                is_parameter=True,
                parameter_value="0",
            )

        # Add RD_ARST_VALUE parameter if needed
        if self.read_arst in ["any", "no_undef"]:
            configs[f"PORT_{self.name}_RD_ARST_VALUE"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_ARST_VALUE",
                IO.INPUT,
                self.data_width,
                is_parameter=True,
                parameter_value="0",
            )

        # Read enable is not supported for asynchronous read ports per memlib spec
        # if self.read_enable:
        #     configs[f"PORT_{self.name}_RD_EN"] = VerilogPortConfig(f"PORT_{self.name}_RD_EN", IO.INPUT, 1)

        if self.read_arst != "none":
            configs[f"PORT_{self.name}_RD_ARST"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_ARST", IO.INPUT, 1
            )

        # Add USED parameter only if optional flag is set
        if self.optional:
            configs[f"PORT_{self.name}_USED"] = VerilogPortConfig(
                f"PORT_{self.name}_USED",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",
            )

        return configs


@dataclass
class SRPort(MemoryPortBase):
    """Synchronous read port."""

    # Read enable signal
    read_enable: bool = False
    # Reset/initialization configurations
    read_init: Literal["none", "zero", "any", "no_undef"] = "none"
    read_srst: Literal["none", "zero", "any", "no_undef", "init"] = "none"
    read_srst_gated: bool = False  # Whether sync reset is gated by read enable
    read_srst_priority: Literal["ungated", "gated_clken", "gated_rden"] = "ungated"
    optional: bool = False  # Optional port configuration

    def __post_init__(self):
        """Validate SRPort configuration."""

    @property
    def port_type(self) -> MemoryPortType:
        return MemoryPortType.SR

    def to_configs_list(self) -> list[str]:
        """Generate the port configuration string for memory mapping file."""
        config: list[str] = []

        config.extend(super().to_configs_list())

        # Width configuration
        if self.width_mode:
            config.append(f"width {self.width_mode}")
        elif self.width_values:
            config.append(f"width {' '.join(map(str, self.width_values))}")
        elif self.rd_width_values:
            config.append(f"width rd {' '.join(map(str, self.rd_width_values))}")

        if self.read_enable:
            config.append("rden")

        if self.read_init:
            config.append(f"rdinit {self.read_init}")

        if self.read_srst != "none":
            config.append(f"rdsrst {self.read_srst} {self.read_srst_priority}")

        # Optional configuration
        if self.optional:
            config.append("optional")

        return config

    def get_port_configurations(self) -> dict[str, VerilogPortConfig]:
        """Return port configurations with width, direction, and special attributes."""
        configs = super().get_port_configurations()

        configs[f"PORT_{self.name}_RD_DATA"] = VerilogPortConfig(
            f"PORT_{self.name}_RD_DATA", IO.OUTPUT, self.data_width
        )

        # Add separate read/write widths for mix mode
        if self.width_mode == "mix":
            if self.rd_width_values:
                configs[f"PORT_{self.name}_RD_WIDTH"] = VerilogPortConfig(
                    f"PORT_{self.name}_RD_WIDTH",
                    IO.INPUT,
                    1,
                    is_parameter=True,
                    parameter_value=str(self.rd_width_values[0]),
                )

        # RD_USED is only for optional_rw ports (ARSWPort/SRSWPort), not regular optional ARPort
        # if self.optional:
        #     configs[f"PORT_{self.name}_RD_USED"] = VerilogPortConfig(
        #         f"PORT_{self.name}_RD_USED",
        #         IO.INPUT,
        #         1,
        #         is_parameter=True,
        #         parameter_value="1",
        #     )

        # Add RD_INIT_VALUE parameter if needed
        if self.read_init in ["any", "no_undef"]:
            configs[f"PORT_{self.name}_RD_INIT_VALUE"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_INIT_VALUE",
                IO.INPUT,
                self.data_width,
                is_parameter=True,
                parameter_value="0",
            )

        # Add RD_SRST_VALUE parameter if needed
        if self.read_srst in ["any", "no_undef"]:
            configs[f"PORT_{self.name}_RD_SRST_VALUE"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_SRST_VALUE",
                IO.INPUT,
                self.data_width,
                is_parameter=True,
                parameter_value="0",
            )

        if self.clock_edge == "anyedge":
            configs[f"PORT_{self.name}_CLK_POL"] = VerilogPortConfig(
                f"PORT_{self.name}_CLK_POL",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",  # Default to posedge for anyedge clocks
            )

        if self.clock_enable:
            configs[f"PORT_{self.name}_CLK_EN"] = VerilogPortConfig(
                f"PORT_{self.name}_CLK_EN", IO.INPUT, 1
            )

        if self.read_enable:
            configs[f"PORT_{self.name}_RD_EN"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_EN", IO.INPUT, 1
            )

        if self.read_srst != "none":
            configs[f"PORT_{self.name}_RD_SRST"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_SRST", IO.INPUT, 1
            )

        # Add USED parameter only if optional flag is set
        if self.optional:
            configs[f"PORT_{self.name}_USED"] = VerilogPortConfig(
                f"PORT_{self.name}_USED",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",
            )

        return configs


@dataclass
class SWPort(MemoryPortBase):
    """Synchronous write port."""

    # Write configurations
    write_enable: bool = False
    byte_width: int | None = None
    wrbe_separate: bool = False  # Separate byte enables
    write_priority: int = 0
    # Write priority configuration
    write_priority_names: list[str] = field(default_factory=list)
    optional: bool = False  # Optional port configuration

    def __post_init__(self):
        """Validate SWPort configuration."""
        # Validate write priority configuration
        if self.write_priority < 0:
            raise ValueError(f"Port {self.name}: write_priority must be non-negative")

        # Validate write priority names match the priority value
        if (
            self.write_priority_names
            and len(self.write_priority_names) != self.write_priority
        ):
            raise ValueError(
                f"Port {self.name}: write_priority_names count must match write_priority value"
            )

        # Validate byte width configuration
        if self.wrbe_separate and not self.byte_width:
            raise ValueError(
                f"Port {self.name}: wrbe_separate requires byte_width to be set"
            )

    @property
    def port_type(self) -> MemoryPortType:
        return MemoryPortType.SW

    def to_configs_list(self) -> list[str]:
        """Generate the port configuration string for memory mapping file."""
        config = []

        config.extend(super().to_configs_list())

        # Width configuration
        if self.width_mode:
            config.append(f"width {self.width_mode}")
        elif self.width_values:
            config.append(f"width {' '.join(map(str, self.width_values))}")
        elif self.wr_width_values:
            config.append(f"width wr {' '.join(map(str, self.wr_width_values))}")

        if self.byte_width:
            config.append(f"byte {self.byte_width}")

        if self.wrbe_separate:
            if not self.byte_width:
                raise ValueError(
                    f"Port {self.name}: wrbe_separate requires byte_width to be set"
                )
            config.append("wrbe_separate")

        if self.write_priority > 0:
            config.append(f"priority {self.write_priority}")

        # Write priority names with validation
        if self.write_priority_names:
            priority_names = " ".join(f'"{name}"' for name in self.write_priority_names)
            config.append(f"wrprio {priority_names}")

        # Optional configuration
        if self.optional:
            config.append("optional")

        return config

    def get_port_configurations(self) -> dict[str, VerilogPortConfig]:
        """Return port configurations with width, direction, and special attributes."""
        configs = super().get_port_configurations()

        wr_en_width = 1
        if self.byte_width and not self.wrbe_separate:
            # When byte_width is specified but wrbe_separate is not, WR_EN has one bit per byte
            wr_en_width = (self.data_width + self.byte_width - 1) // self.byte_width

        configs[f"PORT_{self.name}_WR_EN"] = VerilogPortConfig(
            f"PORT_{self.name}_WR_EN", IO.INPUT, wr_en_width
        )

        # Add WR_EN_WIDTH parameter for multiple-width cells with byte enables
        if (
            self.byte_width
            and not self.wrbe_separate
            and (self.width_mode is not None or self.width_values)
        ):
            configs[f"PORT_{self.name}_WR_EN_WIDTH"] = VerilogPortConfig(
                f"PORT_{self.name}_WR_EN_WIDTH",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value=str(wr_en_width),
            )

        # Add separate read/write widths for mix mode
        if self.width_mode == "mix":
            if self.wr_width_values:
                configs[f"PORT_{self.name}_WR_WIDTH"] = VerilogPortConfig(
                    f"PORT_{self.name}_WR_WIDTH",
                    IO.INPUT,
                    1,
                    is_parameter=True,
                    parameter_value=str(self.wr_width_values[0]),
                )

        if self.clock_edge == "anyedge":
            configs[f"PORT_{self.name}_CLK_POL"] = VerilogPortConfig(
                f"PORT_{self.name}_CLK_POL",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",  # Default to posedge for anyedge clocks
            )

        if self.clock_enable:
            configs[f"PORT_{self.name}_CLK_EN"] = VerilogPortConfig(
                f"PORT_{self.name}_CLK_EN", IO.INPUT, 1
            )

        if self.wrbe_separate:
            # Validate byte enable width against byte_width
            if self.byte_width:
                be_width = (self.data_width + self.byte_width - 1) // self.byte_width
            else:
                be_width = (self.data_width + 7) // 8  # Default to 8-bit bytes

            configs[f"PORT_{self.name}_WR_BE"] = VerilogPortConfig(
                f"PORT_{self.name}_WR_BE", IO.INPUT, be_width
            )
            # Add byte enable width parameter for multiple-width cells
            if self.width_mode is not None or self.width_values:
                configs[f"PORT_{self.name}_WR_BE_WIDTH"] = VerilogPortConfig(
                    f"PORT_{self.name}_WR_BE_WIDTH",
                    IO.INPUT,
                    1,
                    is_parameter=True,
                    parameter_value=str(be_width),
                )

        # Add USED parameter only if optional flag is set
        if self.optional:
            configs[f"PORT_{self.name}_USED"] = VerilogPortConfig(
                f"PORT_{self.name}_USED",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",
            )

        return configs


@dataclass
class ARSWPort(ARPort, SWPort):
    """Asynchronous read + synchronous write port."""

    optional_rw: bool = False  # Optional read/write functionality
    wide_continuation: bool = False  # Wide continuation for ARSW ports
    collision_write_ports: list[str] = field(default_factory=list)

    @property
    def port_type(self) -> MemoryPortType:
        return MemoryPortType.ARSW

    def to_configs_list(self) -> list[str]:
        """Generate the port configuration string for memory mapping file without
        duplicates."""
        config: list[str] = []
        seen: set[str] = set()
        for entry in ARPort.to_configs_list(self) + SWPort.to_configs_list(self):
            if entry == "optional":
                continue
            if entry not in seen:
                config.append(entry)
                seen.add(entry)

        if self.optional_rw:
            config.append("optional_rw")
        return config

    def get_port_configurations(self) -> dict[str, VerilogPortConfig]:
        """Return port configurations with width, direction, and special attributes."""
        ar_configs = ARPort.get_port_configurations(self)
        sw_configs = SWPort.get_port_configurations(self)
        # Merge configurations, SW takes precedence for overlapping keys
        configs = {**ar_configs, **sw_configs}
        configs.pop(f"PORT_{self.name}_USED", None)
        if self.optional_rw:
            configs[f"PORT_{self.name}_RD_USED"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_USED",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",
            )
            configs[f"PORT_{self.name}_WR_USED"] = VerilogPortConfig(
                f"PORT_{self.name}_WR_USED",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",
            )
        return configs


@dataclass
class SRSWPort(SRPort, SWPort):
    """Synchronous read + synchronous write port."""

    # Combined port requires rdwr specification for read-write interactions
    rdwr: Literal["no_change", "undefined", "old", "new", "new_only"] = "undefined"
    # Write transparency configuration (specific to SRSW ports)
    write_transparency: dict[str, Literal["old", "new"]] = field(default_factory=dict)
    optional_rw: bool = False
    wide_continuation: bool = False  # Wide continuation for ARSW ports
    collision_write_ports: list[str] = field(default_factory=list)

    def __post_init__(self):
        """Validate SRSW port configuration."""
        # Validate rdwr property
        valid_rdwr_values = ["no_change", "undefined", "old", "new", "new_only"]
        if self.rdwr not in valid_rdwr_values:
            raise ValueError(
                f"Invalid rdwr '{self.rdwr}'. Must be one of {valid_rdwr_values}"
            )

    @property
    def port_type(self) -> MemoryPortType:
        return MemoryPortType.SRSW

    def to_configs_list(self) -> list[str]:
        """Generate the port configuration string for memory mapping file."""
        config: list[str] = []
        seen: set[str] = set()
        for entry in SRPort.to_configs_list(self) + SWPort.to_configs_list(self):
            if entry == "optional":
                continue
            if entry not in seen:
                config.append(entry)
                seen.add(entry)

        # Add rdwr configuration
        if self.rdwr != "undefined":
            config.append(f"rdwr {self.rdwr}")

        # Add write transparency configuration (specific to SRSW ports)
        for port_name, transparency in self.write_transparency.items():
            config.append(f'wrtrans "{port_name}" {transparency}')

        if self.optional_rw:
            config.append("optional_rw")

        return config

    def get_port_configurations(self) -> dict[str, VerilogPortConfig]:
        """Return port configurations with width, direction, and special attributes."""
        sr_configs = SRPort.get_port_configurations(self)
        sw_configs = SWPort.get_port_configurations(self)
        # Merge configurations, combining read and write widths
        configs = {**sr_configs, **sw_configs}
        configs.pop(f"PORT_{self.name}_USED", None)
        if self.optional_rw:
            configs[f"PORT_{self.name}_RD_USED"] = VerilogPortConfig(
                f"PORT_{self.name}_RD_USED",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",
            )
            configs[f"PORT_{self.name}_WR_USED"] = VerilogPortConfig(
                f"PORT_{self.name}_WR_USED",
                IO.INPUT,
                1,
                is_parameter=True,
                parameter_value="1",
            )
        return configs
