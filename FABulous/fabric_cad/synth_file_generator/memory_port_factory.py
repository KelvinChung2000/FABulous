"""Factory for creating memory ports with embedded configuration logic."""

from typing_extensions import Literal

from FABulous.fabric_cad.synth_file_generator.memory_port import (
    ARPort,
    ARSWPort,
    MemoryPortBase,
    SRPort,
    SRSWPort,
    SWPort,
)
from FABulous.fabric_definition.define import BitVector

MemoryPort = ARPort | SRPort | SWPort | ARSWPort | SRSWPort


class MemoryPortFactory:
    """Factory for creating memory ports from Yosys parameters and connections."""

    def create_memory_ports(
        self,
        parameters: dict[str, str],
        connections: dict[str, BitVector],
        address_bits: int,
        data_width: int,
    ) -> tuple[list[MemoryPort], dict[str, tuple], int]:
        """Create memory ports from Yosys parameters and connections.

        Returns:
            tuple: (ports, signal_mapping, cost)
        """
        read_ports = int(parameters.get("RD_PORTS", 0))
        write_ports = int(parameters.get("WR_PORTS", 0))

        # Group address signals by port
        read_addr_signals = connections.get("RD_ADDR", [])
        write_addr_signals = connections.get("WR_ADDR", [])

        read_port_list = (
            self._group_list(read_addr_signals, address_bits)
            if read_ports > 0 and address_bits > 0
            else []
        )
        write_port_list = (
            self._group_list(write_addr_signals, address_bits)
            if write_ports > 0 and address_bits > 0
            else []
        )

        # Convert to sets for easier operations
        rd_port_set = set(tuple(item) for item in read_port_list if item)
        wr_port_set = set(tuple(item) for item in write_port_list if item)

        # Identify port types
        common_ports = rd_port_set.intersection(wr_port_set)
        read_only_ports = rd_port_set.difference(wr_port_set)
        write_only_ports = wr_port_set.difference(rd_port_set)

        ports = []
        signal_mapping = {}
        cost = 1

        # Process read-write ports
        for idx, port_tuple in enumerate(common_ports):
            port, mapping, port_cost = self._create_read_write_port(
                idx,
                port_tuple,
                read_port_list,
                write_port_list,
                parameters,
                connections,
                address_bits,
                data_width,
            )
            ports.append(port)
            signal_mapping.update(mapping)
            cost += port_cost

        # Process read-only ports
        for idx, port_tuple in enumerate(read_only_ports):
            port, mapping, port_cost = self._create_read_only_port(
                idx,
                port_tuple,
                read_port_list,
                parameters,
                connections,
                address_bits,
                data_width,
            )
            ports.append(port)
            signal_mapping.update(mapping)
            cost += port_cost

        # Process write-only ports
        for idx, port_tuple in enumerate(write_only_ports):
            port, mapping, port_cost = self._create_write_only_port(
                idx,
                port_tuple,
                write_port_list,
                parameters,
                connections,
                address_bits,
                data_width,
            )
            ports.append(port)
            signal_mapping.update(mapping)
            cost += port_cost

        return ports, signal_mapping, cost

    def _create_read_write_port(
        self,
        idx: int,
        port_tuple: tuple,
        read_port_list: list,
        write_port_list: list,
        parameters: dict[str, str],
        connections: dict[str, BitVector],
        address_bits: int,
        data_width: int,
    ) -> tuple[MemoryPortBase, dict[str, tuple], int]:
        """Create a read-write port (ARSW or SRSW)."""
        rd_idx = next(
            (i for i, x in enumerate(read_port_list) if tuple(x) == port_tuple), -1
        )
        wr_idx = next(
            (i for i, x in enumerate(write_port_list) if tuple(x) == port_tuple), -1
        )

        # Determine if read is asynchronous
        is_async_read = connections.get("RD_CLK", [""])[0] == "x"
        cost = 1 if is_async_read else 0

        # Extract transparency between this read and write port
        rdwr_value = self._extract_transparency(rd_idx, wr_idx, parameters)

        if is_async_read:
            port = ARSWPort(
                name=f"RW{idx}",
                address_bits=address_bits,
                data_width=data_width,
                read_enable=self._get_read_enable(rd_idx, connections),
                read_init=self._get_read_init(rd_idx, parameters, data_width),
                read_arst=self._get_read_arst(rd_idx, parameters, data_width),
                wide_continuation=self._get_read_wide_continuation(rd_idx, parameters),
                collision_write_ports=self._get_collision_write_ports(
                    rd_idx, parameters
                ),
                clock_edge=self._get_write_clock_edge(wr_idx, parameters),
                clock_enable=self._get_write_clock_enable(wr_idx, parameters),
                write_enable=self._get_write_enable(wr_idx, connections),
                byte_width=self._get_byte_width(parameters),
                wrbe_separate=self._get_wrbe_separate(wr_idx, connections, parameters),
                write_priority=self._get_write_priority(wr_idx, parameters),
            )
        else:
            port = SRSWPort(
                name=f"RW{idx}",
                address_bits=address_bits,
                data_width=data_width,
                clock_edge=self._get_write_clock_edge(wr_idx, parameters)
                or self._get_read_clock_edge(rd_idx, parameters),
                clock_enable=self._get_write_clock_enable(wr_idx, parameters)
                or self._get_read_clock_enable(rd_idx, parameters),
                read_enable=self._get_read_enable(rd_idx, connections),
                read_init=self._get_read_init(rd_idx, parameters, data_width),
                read_srst=self._get_read_srst(rd_idx, parameters, data_width),
                read_srst_gated=self._get_read_srst_gated(rd_idx, parameters),
                read_srst_priority=self._get_read_srst_priority(rd_idx, parameters),
                wide_continuation=self._get_read_wide_continuation(rd_idx, parameters),
                collision_write_ports=self._get_collision_write_ports(
                    rd_idx, parameters
                ),
                write_enable=self._get_write_enable(wr_idx, connections),
                byte_width=self._get_byte_width(parameters),
                wrbe_separate=self._get_wrbe_separate(wr_idx, connections, parameters),
                write_priority=self._get_write_priority(wr_idx, parameters),
                rdwr=rdwr_value,
            )

        # Create signal mapping
        signal_mapping = self._create_read_write_signal_mapping(
            idx, port_tuple, rd_idx, wr_idx, connections, data_width, is_async_read
        )

        return port, signal_mapping, cost

    def _create_read_only_port(
        self,
        idx: int,
        port_tuple: tuple,
        read_port_list: list,
        parameters: dict[str, str],
        connections: dict[str, BitVector],
        address_bits: int,
        data_width: int,
    ) -> tuple[MemoryPortBase, dict[str, tuple], int]:
        """Create a read-only port (AR or SR)."""
        rd_idx = next(
            (i for i, x in enumerate(read_port_list) if tuple(x) == port_tuple), -1
        )

        is_async_read = connections.get("RD_CLK", [""])[0] == "x"
        cost = 1 if is_async_read else 0

        if is_async_read:
            port = ARPort(
                name=f"R{idx}",
                address_bits=address_bits,
                data_width=data_width,
                read_enable=self._get_read_enable(rd_idx, connections),
                read_init=self._get_read_init(rd_idx, parameters, data_width),
                read_arst=self._get_read_arst(rd_idx, parameters, data_width),
                wide_continuation=self._get_read_wide_continuation(rd_idx, parameters),
                collision_write_ports=self._get_collision_write_ports(
                    rd_idx, parameters
                ),
            )
        else:
            port = SRPort(
                name=f"R{idx}",
                address_bits=address_bits,
                data_width=data_width,
                clock_edge=self._get_read_clock_edge(rd_idx, parameters),
                clock_enable=self._get_read_clock_enable(rd_idx, parameters),
                read_enable=self._get_read_enable(rd_idx, connections),
                read_init=self._get_read_init(rd_idx, parameters, data_width),
                read_srst=self._get_read_srst(rd_idx, parameters, data_width),
                read_srst_gated=self._get_read_srst_gated(rd_idx, parameters),
                read_srst_priority=self._get_read_srst_priority(rd_idx, parameters),
                wide_continuation=self._get_read_wide_continuation(rd_idx, parameters),
                collision_write_ports=self._get_collision_write_ports(
                    rd_idx, parameters
                ),
            )

        # Create signal mapping
        signal_mapping = self._create_read_only_signal_mapping(
            idx, port_tuple, rd_idx, connections, data_width, is_async_read
        )

        return port, signal_mapping, cost

    def _create_write_only_port(
        self,
        idx: int,
        port_tuple: tuple,
        write_port_list: list,
        parameters: dict[str, str],
        connections: dict[str, BitVector],
        address_bits: int,
        data_width: int,
    ) -> tuple[MemoryPortBase, dict[str, tuple], int]:
        """Create a write-only port (SW)."""
        wr_idx = next(
            (i for i, x in enumerate(write_port_list) if tuple(x) == port_tuple), -1
        )

        port = SWPort(
            name=f"W{idx}",
            address_bits=address_bits,
            data_width=data_width,
            clock_edge=self._get_write_clock_edge(wr_idx, parameters),
            clock_enable=self._get_write_clock_enable(wr_idx, parameters),
            write_enable=self._get_write_enable(wr_idx, connections),
            byte_width=self._get_byte_width(parameters),
            wrbe_separate=self._get_wrbe_separate(wr_idx, connections, parameters),
            write_priority=self._get_write_priority(wr_idx, parameters),
            wide_continuation=self._get_write_wide_continuation(wr_idx, parameters),
        )

        # Create signal mapping
        signal_mapping = self._create_write_only_signal_mapping(
            idx, port_tuple, wr_idx, connections, data_width
        )

        return port, signal_mapping, 0

    def _extract_transparency(
        self, rd_idx: int, wr_idx: int, parameters: dict[str, str]
    ) -> Literal["no_change", "undefined", "old", "new", "new_only"]:
        """Extract read-write transparency setting for specific read/write port pair."""
        transparency_mask = parameters.get("RD_TRANSPARENCY_MASK", "")
        wr_ports = int(parameters.get("WR_PORTS", 0))

        if not transparency_mask or wr_ports == 0:
            return "undefined"

        # RD_TRANSPARENCY_MASK is indexed as [read_port * WR_PORTS + write_port]
        mask_idx = rd_idx * wr_ports + wr_idx

        if mask_idx < len(transparency_mask):
            transparency_bit = transparency_mask[mask_idx]
            if transparency_bit == "1":
                # Transparent - read returns new written value
                return "new"
            else:
                # Non-transparent - read returns old value
                return "old"

        return "undefined"

    def _create_read_write_signal_mapping(
        self,
        idx: int,
        port_tuple: tuple,
        rd_idx: int,
        wr_idx: int,
        connections: dict[str, BitVector],
        data_width: int,
        is_async_read: bool,
    ) -> dict[str, tuple]:
        """Create signal mapping for read-write ports."""
        mapping = {}
        mapping[f"PORT_RW{idx}_ADDR"] = port_tuple

        wr_data_groups = self._group_list(connections["WR_DATA"], data_width)
        rd_data_groups = self._group_list(connections["RD_DATA"], data_width)
        wr_en_groups = (
            self._group_list(connections["WR_EN"], data_width)
            if connections.get("WR_EN")
            else [tuple()]
        )

        if wr_idx < len(wr_data_groups):
            mapping[f"PORT_RW{idx}_WR_DATA"] = wr_data_groups[wr_idx]
        if rd_idx < len(rd_data_groups):
            mapping[f"PORT_RW{idx}_RD_DATA"] = rd_data_groups[rd_idx]
        if wr_idx < len(wr_en_groups):
            mapping[f"PORT_RW{idx}_WR_EN"] = wr_en_groups[wr_idx]

        # Clock signal (use write clock for synchronous ports)
        mapping[f"PORT_RW{idx}_CLK"] = tuple(connections["WR_CLK"])

        # Read enable signal
        if "RD_EN" in connections:
            rd_en_groups = self._group_list(connections["RD_EN"], 1)
            if rd_idx < len(rd_en_groups):
                mapping[f"PORT_RW{idx}_RD_EN"] = rd_en_groups[rd_idx]

        # Clock enable signal
        if "WR_CLK_ENABLE" in connections or "CLK_ENABLE" in connections:
            clk_en_key = (
                "WR_CLK_ENABLE" if "WR_CLK_ENABLE" in connections else "CLK_ENABLE"
            )
            clk_en_groups = self._group_list(connections[clk_en_key], 1)
            if wr_idx < len(clk_en_groups):
                mapping[f"PORT_RW{idx}_CLK_EN"] = clk_en_groups[wr_idx]

        # Async reset signal for read
        if "RD_ARST" in connections:
            arst_groups = self._group_list(connections["RD_ARST"], 1)
            if rd_idx < len(arst_groups):
                mapping[f"PORT_RW{idx}_RD_ARST"] = arst_groups[rd_idx]

        # Sync reset signal for read
        if "RD_SRST" in connections:
            srst_groups = self._group_list(connections["RD_SRST"], 1)
            if rd_idx < len(srst_groups):
                mapping[f"PORT_RW{idx}_RD_SRST"] = srst_groups[rd_idx]

        # Byte-level write enables
        if "WR_BE" in connections:
            be_groups = self._group_list(connections["WR_BE"], (data_width + 7) // 8)
            if wr_idx < len(be_groups):
                mapping[f"PORT_RW{idx}_WR_BE"] = be_groups[wr_idx]

        return mapping

    def _create_read_only_signal_mapping(
        self,
        idx: int,
        port_tuple: tuple,
        rd_idx: int,
        connections: dict[str, BitVector],
        data_width: int,
        is_async_read: bool,
    ) -> dict[str, tuple]:
        """Create signal mapping for read-only ports."""
        mapping = {}
        mapping[f"PORT_R{idx}_ADDR"] = port_tuple

        rd_data_groups = self._group_list(connections["RD_DATA"], data_width)
        if rd_idx < len(rd_data_groups):
            mapping[f"PORT_R{idx}_RD_DATA"] = rd_data_groups[rd_idx]

        # Clock signal for synchronous reads
        if not is_async_read:
            mapping[f"PORT_R{idx}_CLK"] = tuple(connections["RD_CLK"])

        # Read enable signal
        if "RD_EN" in connections:
            rd_en_groups = self._group_list(connections["RD_EN"], 1)
            if rd_idx < len(rd_en_groups):
                mapping[f"PORT_R{idx}_RD_EN"] = rd_en_groups[rd_idx]

        # Clock enable signal
        if "RD_CLK_ENABLE" in connections or "CLK_ENABLE" in connections:
            clk_en_key = (
                "RD_CLK_ENABLE" if "RD_CLK_ENABLE" in connections else "CLK_ENABLE"
            )
            clk_en_groups = self._group_list(connections[clk_en_key], 1)
            if rd_idx < len(clk_en_groups):
                mapping[f"PORT_R{idx}_CLK_EN"] = clk_en_groups[rd_idx]

        # Async reset signal
        if "RD_ARST" in connections:
            arst_groups = self._group_list(connections["RD_ARST"], 1)
            if rd_idx < len(arst_groups):
                mapping[f"PORT_R{idx}_RD_ARST"] = arst_groups[rd_idx]

        # Sync reset signal
        if "RD_SRST" in connections:
            srst_groups = self._group_list(connections["RD_SRST"], 1)
            if rd_idx < len(srst_groups):
                mapping[f"PORT_R{idx}_RD_SRST"] = srst_groups[rd_idx]

        return mapping

    def _create_write_only_signal_mapping(
        self,
        idx: int,
        port_tuple: tuple,
        wr_idx: int,
        connections: dict[str, BitVector],
        data_width: int,
    ) -> dict[str, tuple]:
        """Create signal mapping for write-only ports."""
        mapping = {}
        mapping[f"PORT_W{idx}_ADDR"] = port_tuple

        wr_data_groups = self._group_list(connections["WR_DATA"], data_width)
        wr_en_groups = (
            self._group_list(connections["WR_EN"], data_width)
            if connections.get("WR_EN")
            else [tuple()]
        )

        if wr_idx < len(wr_data_groups):
            mapping[f"PORT_W{idx}_WR_DATA"] = wr_data_groups[wr_idx]
        if wr_idx < len(wr_en_groups):
            mapping[f"PORT_W{idx}_WR_EN"] = wr_en_groups[wr_idx]

        # Clock signal
        mapping[f"PORT_W{idx}_CLK"] = tuple(connections["WR_CLK"])

        # Clock enable signal
        if "WR_CLK_ENABLE" in connections or "CLK_ENABLE" in connections:
            clk_en_key = (
                "WR_CLK_ENABLE" if "WR_CLK_ENABLE" in connections else "CLK_ENABLE"
            )
            clk_en_groups = self._group_list(connections[clk_en_key], 1)
            if wr_idx < len(clk_en_groups):
                mapping[f"PORT_W{idx}_CLK_EN"] = clk_en_groups[wr_idx]

        # Byte-level write enables
        if "WR_BE" in connections:
            be_groups = self._group_list(connections["WR_BE"], (data_width + 7) // 8)
            if wr_idx < len(be_groups):
                mapping[f"PORT_W{idx}_WR_BE"] = be_groups[wr_idx]

        return mapping

    def _group_list(self, data: list, n: int) -> list[tuple]:
        """Group a list into tuples of size n."""
        return [tuple(data[i : i + n]) for i in range(0, len(data), n)]

    def _get_mem_value_string(
        self, value: str, data_width: int, port_idx: int, init_value: str | None = None
    ) -> str:
        """Convert memory value to string representation for a specific port.

        Args:
            value: The parameter value string from Yosys (may be bit string for multi-port)
            data_width: Width of data for this memory
            port_idx: Index of the port (for extracting from multi-port bit strings)
            init_value: Initial value parameter for comparison
        """
        # For single-port memories, value might be the direct bit pattern
        # For multi-port memories, extract the bits for this port

        # If value length suggests it's a concatenated multi-port value
        if len(value) > data_width and (len(value) % data_width == 0):
            # Extract the portion for this port
            port_offset = port_idx * data_width
            if port_offset + data_width <= len(value):
                port_value = value[port_offset : port_offset + data_width]
            else:
                port_value = value  # Fallback to full value
        else:
            port_value = value

        # Check for standard patterns
        if port_value == "x" * len(port_value):
            return "none"
        if port_value == "0" * len(port_value):
            return "zero"
        if port_value == "1" * len(port_value):
            return "any"

        # Check for no_undef pattern (no undefined values)
        if "x" not in port_value and "z" not in port_value:
            return "no_undef"

        # Check against init value if provided
        if init_value:
            if len(init_value) > data_width and (len(init_value) % data_width == 0):
                # Extract init value for this port
                init_offset = port_idx * data_width
                if init_offset + data_width <= len(init_value):
                    port_init = init_value[init_offset : init_offset + data_width]
                    if port_value == port_init:
                        return "init"
            elif port_value == init_value:
                return "init"

        # For any other pattern, return "any"
        return "any"

    # Individual extraction methods for direct parameter access
    def _get_read_enable(self, rd_idx: int, connections: dict[str, BitVector]) -> bool:
        """Get read enable setting for a specific read port."""
        rd_en = connections.get("RD_EN", "")
        return rd_idx < len(rd_en) and rd_en[rd_idx] not in ["0", "1"]

    def _get_read_clock_edge(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> Literal["posedge", "negedge", "anyedge"]:
        """Get clock edge setting for a specific read port."""
        rd_clk_polarity = parameters.get("RD_CLK_POLARITY", "")
        if rd_idx < len(rd_clk_polarity):
            polarity_bit = rd_clk_polarity[rd_idx]
            if polarity_bit == "1":
                return "posedge"
            elif polarity_bit == "0":
                return "negedge"
        return "posedge"  # Default to posedge if not specified

    def _get_read_clock_enable(self, rd_idx: int, parameters: dict[str, str]) -> bool:
        """Get clock enable setting for a specific read port."""
        rd_clk_en = parameters.get("RD_CLK_ENABLE", "")
        return rd_idx < len(rd_clk_en) and rd_clk_en[rd_idx] == "1"

    def _get_read_wide_continuation(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> bool:
        """Get wide continuation setting for a specific read port."""
        rd_wide_cont = parameters.get("RD_WIDE_CONTINUATION", "")
        return rd_idx < len(rd_wide_cont) and rd_wide_cont[rd_idx] == "1"

    def _get_read_init(
        self, rd_idx: int, parameters: dict[str, str], data_width: int
    ) -> Literal["none", "zero", "any", "no_undef"]:
        """Get read init value for a specific read port."""
        init_val = parameters.get("RD_INIT_VALUE", "")
        if init_val:
            value = self._get_mem_value_string(init_val, data_width, rd_idx)
            # Ensure return value is one of the expected literals
            if value in ["none", "zero", "any", "no_undef"]:
                return value  # type: ignore
            return "any"  # Fallback for unexpected values
        return "none"

    def _get_read_arst(
        self, rd_idx: int, parameters: dict[str, str], data_width: int
    ) -> Literal["none", "zero", "any", "no_undef", "init"]:
        """Get read async reset value for a specific read port."""
        arst_val = parameters.get("RD_ARST_VALUE", "")
        init_val = parameters.get("RD_INIT_VALUE", "")
        if arst_val:
            value = self._get_mem_value_string(arst_val, data_width, rd_idx, init_val)
            # Ensure return value is one of the expected literals
            if value in ["none", "zero", "any", "no_undef", "init"]:
                return value  # type: ignore
            return "any"  # Fallback for unexpected values
        return "none"

    def _get_read_srst(
        self, rd_idx: int, parameters: dict[str, str], data_width: int
    ) -> Literal["none", "zero", "any", "no_undef", "init"]:
        """Get read sync reset value for a specific read port."""
        srst_val = parameters.get("RD_SRST_VALUE", "")
        init_val = parameters.get("RD_INIT_VALUE", "")
        if srst_val:
            value = self._get_mem_value_string(srst_val, data_width, rd_idx, init_val)
            # Ensure return value is one of the expected literals
            if value in ["none", "zero", "any", "no_undef", "init"]:
                return value  # type: ignore
            return "any"  # Fallback for unexpected values
        return "none"

    def _get_read_srst_gated(self, rd_idx: int, parameters: dict[str, str]) -> bool:
        """Get read sync reset gated setting for a specific read port."""
        ce_over_srst = parameters.get("RD_CE_OVER_SRST", "0")
        return rd_idx < len(ce_over_srst) and ce_over_srst[rd_idx] == "1"

    def _get_read_srst_priority(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> Literal["ungated", "gated_clken", "gated_rden"]:
        """Get read sync reset priority for a specific read port."""
        srst_val = parameters.get("RD_SRST_VALUE", "")
        if not srst_val:
            return "ungated"  # Default if no sync reset

        ce_over_srst = parameters.get("RD_CE_OVER_SRST", "0")
        if rd_idx < len(ce_over_srst):
            if ce_over_srst[rd_idx] == "1":
                return "gated_clken"
            else:
                return "ungated"
        return "ungated"  # Default

    def _get_collision_write_ports(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> list[int] | None:
        """Get collision write ports for a specific read port."""
        collision_mask = parameters.get("RD_COLLISION_X_MASK", "")
        wr_ports = int(parameters.get("WR_PORTS", 0))

        if not collision_mask or wr_ports == 0:
            return None

        colliding_write_ports = []
        for wr_idx in range(wr_ports):
            mask_idx = rd_idx * wr_ports + wr_idx
            if mask_idx < len(collision_mask) and collision_mask[mask_idx] == "1":
                colliding_write_ports.append(wr_idx)

        return colliding_write_ports if colliding_write_ports else None

    def _get_write_clock_edge(
        self, wr_idx: int, parameters: dict[str, str]
    ) -> Literal["posedge", "negedge", "anyedge"]:
        """Get clock edge setting for a specific write port."""
        wr_clk_polarity = parameters.get("WR_CLK_POLARITY", "")
        if wr_idx < len(wr_clk_polarity):
            polarity_bit = wr_clk_polarity[wr_idx]
            if polarity_bit == "1":
                return "posedge"
            elif polarity_bit == "0":
                return "negedge"
        return "posedge"  # Default to posedge if not specified

    def _get_write_clock_enable(self, wr_idx: int, parameters: dict[str, str]) -> bool:
        """Get clock enable setting for a specific write port."""
        wr_clk_en = parameters.get("WR_CLK_ENABLE", "")
        return wr_idx < len(wr_clk_en) and wr_clk_en[wr_idx] == "1"

    def _get_write_enable(self, wr_idx: int, connections: dict[str, BitVector]) -> bool:
        """Get write enable setting for a specific write port."""
        # Write enable is implicit if WR_EN signal exists for this port
        wr_en = connections.get("WR_EN", [])
        return len(wr_en) > wr_idx

    def _get_write_wide_continuation(
        self, wr_idx: int, parameters: dict[str, str]
    ) -> bool:
        """Get wide continuation setting for a specific write port."""
        wr_wide_cont = parameters.get("WR_WIDE_CONTINUATION", "")
        return wr_idx < len(wr_wide_cont) and wr_wide_cont[wr_idx] == "1"

    def _get_byte_width(self, parameters: dict[str, str]) -> int | None:
        """Get byte width setting from parameters."""
        byte_width = parameters.get("BYTE_WIDTH")
        return int(byte_width) if byte_width else None

    def _get_wrbe_separate(
        self, wr_idx: int, connections: dict[str, BitVector], parameters: dict[str, str]
    ) -> bool:
        """Get separate write byte enable setting for a specific write port."""
        # Only enable wrbe_separate if:
        # 1. Memory has byte-level write enables (WR_BE signals)
        # 2. Memory has a valid BYTE_WIDTH parameter
        # 3. The specific write port has byte enables
        has_wr_be = "WR_BE" in connections and len(connections["WR_BE"]) > 0
        has_byte_width = parameters.get("BYTE_WIDTH") is not None
        port_has_be = has_wr_be and wr_idx < len(connections.get("WR_BE", []))
        return has_wr_be and has_byte_width and port_has_be

    def _get_write_priority(self, wr_idx: int, parameters: dict[str, str]) -> int:
        """Get write priority for a specific write port."""
        wr_priority_mask = parameters.get("WR_PRIORITY_MASK", "")
        wr_ports = int(parameters.get("WR_PORTS", 0))

        if not wr_priority_mask or wr_ports == 0 or wr_idx >= wr_ports:
            return 0

        priority_count = 0
        for other_wr_idx in range(wr_ports):
            if other_wr_idx != wr_idx:
                mask_idx = wr_idx * wr_ports + other_wr_idx
                if (
                    mask_idx < len(wr_priority_mask)
                    and wr_priority_mask[mask_idx] == "1"
                ):
                    priority_count += 1

        return priority_count
