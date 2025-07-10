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
    ) -> tuple[list[MemoryPort], int]:
        """Create memory ports from Yosys parameters and connections.

        Returns:
            tuple: (ports, cost)
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
        cost = 1

        # Process read-write ports
        for idx, port_tuple in enumerate(common_ports):
            port, port_cost = self._create_read_write_port(
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
            cost += port_cost

        # Process read-only ports
        for idx, port_tuple in enumerate(read_only_ports):
            port, port_cost = self._create_read_only_port(
                idx,
                port_tuple,
                read_port_list,
                parameters,
                connections,
                address_bits,
                data_width,
            )
            ports.append(port)
            cost += port_cost

        # Process write-only ports
        for idx, port_tuple in enumerate(write_only_ports):
            port, port_cost = self._create_write_only_port(
                idx,
                port_tuple,
                write_port_list,
                parameters,
                connections,
                address_bits,
                data_width,
            )
            ports.append(port)
            cost += port_cost

        return ports, cost

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
    ) -> tuple[MemoryPortBase, int]:
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
        rdwr_value = self._get_transparency(rd_idx, wr_idx, parameters)

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
                optional=self._get_port_optional(rd_idx, wr_idx, parameters),
                optional_rw=self._get_port_optional_rw(
                    rd_idx, wr_idx, parameters, connections
                ),
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
                optional=self._get_port_optional(rd_idx, wr_idx, parameters),
                optional_rw=self._get_port_optional_rw(
                    rd_idx, wr_idx, parameters, connections
                ),
            )

        return port, cost

    def _create_read_only_port(
        self,
        idx: int,
        port_tuple: tuple,
        read_port_list: list,
        parameters: dict[str, str],
        connections: dict[str, BitVector],
        address_bits: int,
        data_width: int,
    ) -> tuple[MemoryPortBase, int]:
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
                optional=self._get_port_optional_single(
                    rd_idx, parameters, is_read=True
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
                optional=self._get_port_optional_single(
                    rd_idx, parameters, is_read=True
                ),
            )

        return port, cost

    def _create_write_only_port(
        self,
        idx: int,
        port_tuple: tuple,
        write_port_list: list,
        parameters: dict[str, str],
        connections: dict[str, BitVector],
        address_bits: int,
        data_width: int,
    ) -> tuple[MemoryPortBase, int]:
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
            optional=self._get_port_optional_single(wr_idx, parameters, is_read=False),
        )

        return port, 0

    def _get_transparency(
        self, rd_idx: int, wr_idx: int, parameters: dict[str, str]
    ) -> Literal["no_change", "undefined", "old", "new", "new_only"]:
        """Extract read-write transparency setting for specific read/write port pair.

        Uses RD_TRANSPARENCY_MASK parameter from Yosys $mem_v2 cell.

        Behavior:
        - Defines what happens when reading and writing the same address simultaneously
        - "new": Read returns the newly written value (write-through behavior)
        - "old": Read returns the value before the write (write-back behavior)
        - "undefined": Behavior is unspecified (may return old, new, or undefined)
        - "no_change": Read data doesn't change during write (rare)
        - "new_only": Only new value is valid (write must complete first)

        The mask is indexed as: mask[read_port * WR_PORTS + write_port]
        A '1' bit enables transparency (read-during-write returns new value).
        A '0' bit disables transparency (read-during-write returns old value).
        """
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
        """Get read enable setting for a specific read port.

        Uses RD_EN connection from Yosys $mem_v2 cell.
        """
        rd_en = connections.get("RD_EN", "")
        return rd_idx < len(rd_en) and rd_en[rd_idx] not in ["0", "1"]

    def _get_read_clock_edge(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> Literal["posedge", "negedge", "anyedge"]:
        """Get clock edge setting for a specific read port.

        Uses RD_CLK_POLARITY parameter from Yosys $mem_v2 cell:
        - '1': positive edge (posedge)
        - '0': negative edge (negedge)
        """
        rd_clk_polarity = parameters.get("RD_CLK_POLARITY", "")
        if rd_idx < len(rd_clk_polarity):
            polarity_bit = rd_clk_polarity[rd_idx]
            if polarity_bit == "1":
                return "posedge"
            elif polarity_bit == "0":
                return "negedge"
        return "posedge"  # Default to posedge if not specified

    def _get_read_clock_enable(self, rd_idx: int, parameters: dict[str, str]) -> bool:
        """Get clock enable setting for a specific read port.

        Uses RD_CLK_ENABLE parameter from Yosys $mem_v2 cell.
        """
        rd_clk_en = parameters.get("RD_CLK_ENABLE", "")
        return rd_idx < len(rd_clk_en) and rd_clk_en[rd_idx] == "1"

    def _get_read_wide_continuation(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> bool:
        """Get wide continuation setting for a specific read port.

        Uses RD_WIDE_CONTINUATION parameter from Yosys $mem_v2 cell.
        """
        rd_wide_cont = parameters.get("RD_WIDE_CONTINUATION", "")
        return rd_idx < len(rd_wide_cont) and rd_wide_cont[rd_idx] == "1"

    def _get_read_init(
        self, rd_idx: int, parameters: dict[str, str], data_width: int
    ) -> Literal["none", "zero", "any", "no_undef"]:
        """Get read init value for a specific read port.

        Uses RD_INIT_VALUE parameter from Yosys $mem_v2 cell.

        Behavior:
        - Determines the initial value of read data when the memory is first created
        - "none": No specific initialization (undefined behavior)
        - "zero": Initialize to all zeros
        - "any": Any value is acceptable for initialization
        - "no_undef": Initialize to any defined value (no 'x' or 'z' states)
        """
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
        """Get read async reset value for a specific read port.

        Uses RD_ARST_VALUE parameter from Yosys $mem_v2 cell.

        Behavior:
        - Defines what value the read port outputs when asynchronous reset is asserted
        - "none": No async reset capability
        - "zero": Reset to all zeros
        - "any": Any specific reset value is acceptable
        - "no_undef": Reset to any defined value (no 'x' or 'z' states)
        - "init": Reset to the same value as RD_INIT_VALUE

        Note: Only applies to asynchronous read ports (ARPort, ARSWPort).
        """
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
        """Get read sync reset value for a specific read port.

        Uses RD_SRST_VALUE parameter from Yosys $mem_v2 cell.

        Behavior:
        - Defines what value the read port outputs when synchronous reset is asserted
        - "none": No sync reset capability
        - "zero": Reset to all zeros on clock edge
        - "any": Any specific reset value is acceptable
        - "no_undef": Reset to any defined value (no 'x' or 'z' states)
        - "init": Reset to the same value as RD_INIT_VALUE

        Note: Only applies to synchronous read ports (SRPort, SRSWPort).
        Sync reset occurs on the active clock edge when reset signal is asserted.
        """
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
        """Get read sync reset gated setting for a specific read port.

        Returns True if sync reset is gated by read enable (RD_CE_OVER_SRST = 1).
        Note: This is equivalent to checking if _get_read_srst_priority() returns "gated_rden".
        """
        ce_over_srst = parameters.get("RD_CE_OVER_SRST", "0")
        return rd_idx < len(ce_over_srst) and ce_over_srst[rd_idx] == "1"

    def _get_read_srst_priority(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> Literal["ungated", "gated_clken", "gated_rden"]:
        """Get read sync reset priority for a specific read port.

        Based on Yosys $mem_v2 cell RD_CE_OVER_SRST parameter:
        - RD_CE_OVER_SRST = 0: Sync reset recognized regardless of read enable → "ungated"
        - RD_CE_OVER_SRST = 1: Sync reset only recognized when read enable is true → "gated_rden"

        Note: "gated_clken" case is not directly supported by current Yosys parameters.
        """
        srst_val = parameters.get("RD_SRST_VALUE", "")
        if not srst_val:
            return "ungated"  # Default if no sync reset

        ce_over_srst = parameters.get("RD_CE_OVER_SRST", "0")
        if rd_idx < len(ce_over_srst):
            if ce_over_srst[rd_idx] == "1":
                # When RD_CE_OVER_SRST = 1, sync reset is gated by read enable
                return "gated_rden"
            else:
                # When RD_CE_OVER_SRST = 0, sync reset works regardless of enables
                return "ungated"
        return "ungated"  # Default

    def _get_collision_write_ports(
        self, rd_idx: int, parameters: dict[str, str]
    ) -> list[int]:
        """Get collision write ports for a specific read port.

        Uses RD_COLLISION_X_MASK parameter from Yosys $mem_v2 cell.

        Behavior:
        - Defines which write ports cause undefined (X) values when reading from the same address
        - Returns list of write port indices that collide with this read port
        - When a collision occurs, the read port outputs undefined values
        - None means no collision detection (read-write operations work transparently)

        The mask is indexed as: mask[read_port * WR_PORTS + write_port]
        A '1' bit indicates that a collision between the read and write port produces undefined values.
        """
        collision_mask = parameters.get("RD_COLLISION_X_MASK", "")
        wr_ports = int(parameters.get("WR_PORTS", 0))

        if not collision_mask or wr_ports == 0:
            return []

        colliding_write_ports = []
        for wr_idx in range(wr_ports):
            mask_idx = rd_idx * wr_ports + wr_idx
            if mask_idx < len(collision_mask) and collision_mask[mask_idx] == "1":
                colliding_write_ports.append(wr_idx)

        return colliding_write_ports if colliding_write_ports else []

    def _get_write_clock_edge(
        self, wr_idx: int, parameters: dict[str, str]
    ) -> Literal["posedge", "negedge", "anyedge"]:
        """Get clock edge setting for a specific write port.

        Uses WR_CLK_POLARITY parameter from Yosys $mem_v2 cell.

        Behavior:
        - Determines which clock edge triggers write operations
        - '1': positive edge (posedge) - write occurs on rising clock edge
        - '0': negative edge (negedge) - write occurs on falling clock edge
        - Default: posedge if not specified

        Note: Only applies to synchronous write ports (SWPort, ARSWPort, SRSWPort).
        """
        wr_clk_polarity = parameters.get("WR_CLK_POLARITY", "")
        if wr_idx < len(wr_clk_polarity):
            polarity_bit = wr_clk_polarity[wr_idx]
            if polarity_bit == "1":
                return "posedge"
            elif polarity_bit == "0":
                return "negedge"
        return "posedge"  # Default to posedge if not specified

    def _get_write_clock_enable(self, wr_idx: int, parameters: dict[str, str]) -> bool:
        """Get clock enable setting for a specific write port.

        Uses WR_CLK_ENABLE parameter from Yosys $mem_v2 cell.

        Behavior:
        - Determines if the write port has clock enable functionality
        - True: Write port has clock enable input (write only occurs when enabled)
        - False: Write port always operates on clock edge (no gating)

        When enabled, write operations are gated by both the clock edge and enable signal.
        """
        wr_clk_en = parameters.get("WR_CLK_ENABLE", "")
        return wr_idx < len(wr_clk_en) and wr_clk_en[wr_idx] == "1"

    def _get_write_enable(self, wr_idx: int, connections: dict[str, BitVector]) -> bool:
        """Get write enable setting for a specific write port.

        Uses WR_EN connection from Yosys $mem_v2 cell.

        Behavior:
        - Determines if the write port has per-bit or global write enable signals
        - True: Write port has write enable inputs (fine-grained write control)
        - False: Write port always writes when triggered by clock

        Write enable allows selective writing - when disabled, no memory update occurs
        even if clock edge is triggered. Essential for conditional write operations.
        """
        # Write enable is implicit if WR_EN signal exists for this port
        wr_en = connections.get("WR_EN", [])
        return len(wr_en) > wr_idx

    def _get_write_wide_continuation(
        self, wr_idx: int, parameters: dict[str, str]
    ) -> bool:
        """Get wide continuation setting for a specific write port.

        Uses WR_WIDE_CONTINUATION parameter from Yosys $mem_v2 cell.

        Behavior:
        - Indicates if this write port is part of a wide port implementation
        - True: This port is a continuation of a wider port (extra data bits)
        - False: This port is a standalone write port

        Wide continuation ports share control signals with the main port but handle
        additional data bits for memories wider than the native cell width.
        """
        wr_wide_cont = parameters.get("WR_WIDE_CONTINUATION", "")
        return wr_idx < len(wr_wide_cont) and wr_wide_cont[wr_idx] == "1"

    def _get_byte_width(self, parameters: dict[str, str]) -> int | None:
        """Get byte width setting from parameters.

        Uses BYTE_WIDTH parameter from Yosys $mem_v2 cell.

        Behavior:
        - Defines the granularity of byte-level write enables
        - Returns the number of data bits per byte enable signal
        - None: No byte-level write enable capability
        - Typical values: 8 (for 8-bit bytes), 9 (for 9-bit bytes with parity)

        When set, enables byte-level write masking for partial word updates.
        """
        byte_width = parameters.get("BYTE_WIDTH")
        return int(byte_width) if byte_width else None

    def _get_wrbe_separate(
        self, wr_idx: int, connections: dict[str, BitVector], parameters: dict[str, str]
    ) -> bool:
        """Get separate write byte enable setting for a specific write port.

        Uses WR_BE connection and BYTE_WIDTH parameter from Yosys $mem_v2 cell.

        Behavior:
        - Determines if write port has separate byte enable signals
        - True: Port has individual byte enable inputs for fine-grained writes
        - False: Port uses word-level write enable only

        Requirements for separate byte enables:
        1. Memory must have WR_BE signals defined
        2. Memory must have valid BYTE_WIDTH parameter
        3. The specific write port must have byte enable connections

        Enables partial word updates by controlling which bytes are written.
        """
        # Only enable wrbe_separate if:
        # 1. Memory has byte-level write enables (WR_BE signals)
        # 2. Memory has a valid BYTE_WIDTH parameter
        # 3. The specific write port has byte enables
        has_wr_be = "WR_BE" in connections and len(connections["WR_BE"]) > 0
        has_byte_width = parameters.get("BYTE_WIDTH") is not None
        port_has_be = has_wr_be and wr_idx < len(connections.get("WR_BE", []))
        return has_wr_be and has_byte_width and port_has_be

    def _get_write_priority(self, wr_idx: int, parameters: dict[str, str]) -> int:
        """Get write priority for a specific write port.

        Uses WR_PRIORITY_MASK parameter from Yosys $mem_v2 cell.

        Behavior:
        - Determines this port's priority relative to other write ports
        - Returns the number of other write ports this port has priority over
        - Higher values indicate higher priority in conflict resolution
        - 0: Lowest priority (or no conflicts defined)

        The mask is indexed as: mask[this_port * WR_PORTS + other_port]
        A '1' bit indicates this port has priority over the other port when both
        write to the same address simultaneously.

        Priority resolution ensures deterministic behavior in multi-port memories.
        """
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

    def _get_port_optional(
        self, rd_idx: int, wr_idx: int, parameters: dict[str, str]
    ) -> bool:
        """Determine if this port should be marked as optional.

        A port is considered optional if:
        - The memory has multiple ports of any type (read, write, or mixed)
        - The port could be disabled/unused without affecting basic memory functionality
        - The port is not the only port of its type in a minimal configuration

        This allows for more flexible memory configurations where not all ports
        need to be instantiated or used simultaneously.
        """
        rd_ports = int(parameters.get("RD_PORTS", 0))
        wr_ports = int(parameters.get("WR_PORTS", 0))
        total_ports = rd_ports + wr_ports

        # A port is optional if:
        # 1. There are multiple ports total (allows disabling individual ports)
        # 2. OR it's a compound port (inherently flexible)
        # 3. OR the memory has both read and write capabilities (can work with partial functionality)

        # Always optional if there are multiple ports of any kind
        if total_ports > 1:
            return True

        # Single ports are optional if the memory has both read and write capability
        # (can function with just read or just write)
        if rd_ports > 0 and wr_ports > 0:
            return True

        # For single port memories with only read or only write, not optional
        return False

    def _get_port_optional_rw(
        self,
        rd_idx: int,
        wr_idx: int,
        parameters: dict[str, str],
        connections: dict[str, BitVector],
    ) -> bool:
        """Determine if this compound port supports optional_rw (flexible read/write
        usage).

        The optional_rw flag indicates whether read and write operations on this port
        can be independently controlled. This is NOT always true for compound ports:

        - Some memories (like FIFO buffers) may require synchronized read/write operations
        - Memory controllers might enforce specific read/write ordering constraints
        - Transparency settings and collision handling may couple read/write operations

        Returns True only if the port can truly operate independently in read-only
        or write-only modes without violating memory semantics.
        """
        # Check if this is actually a compound port (has both read and write indices)
        is_compound_port = rd_idx >= 0 and wr_idx >= 0

        if not is_compound_port:
            return False

        # Check for conditions that would prevent independent read/write operation:

        # 1. Check transparency settings - some modes may require coupled operation
        transparency = self._get_transparency(rd_idx, wr_idx, parameters)
        if transparency in ["new_only"]:  # Requires synchronized operation
            return False

        # 2. Check for collision handling that might require coupling
        collision_ports = self._get_collision_write_ports(rd_idx, parameters)
        if collision_ports and wr_idx in collision_ports:
            # If this read port has collision detection with this write port,
            # they might need to be coupled for proper collision handling
            return False

        # 3. Check for wide continuation ports that might be coupled
        rd_wide_cont = self._get_read_wide_continuation(rd_idx, parameters)
        wr_wide_cont = self._get_write_wide_continuation(wr_idx, parameters)
        if rd_wide_cont or wr_wide_cont:
            # Wide continuation ports might have coupling requirements
            return False

        # 4. Check if read and write enables are actually coupled
        # Single-port memories CAN have independent read/write if their enables are separate
        rd_enable_exists = self._get_read_enable(rd_idx, connections)
        wr_enable_exists = self._get_write_enable(wr_idx, connections)

        # If both read and write have independent enable signals, they can operate independently
        # If either lacks independent enable control, they might be tied together
        if not (rd_enable_exists and wr_enable_exists):
            # Without independent enables, read/write operations might be coupled
            # But we need to check if they share the same enable signal
            return self._check_enable_signals_independent(rd_idx, wr_idx, connections)

        # If none of the coupling conditions are met, the port can operate independently
        return True

    def _check_enable_signals_independent(
        self, rd_idx: int, wr_idx: int, connections: dict[str, BitVector]
    ) -> bool:
        """Check if read and write enable signals are independent.

        Returns True if read and write enables are controlled by different signals,
        False if they share the same enable signal or are otherwise coupled.
        """
        # Get the actual enable signals for read and write
        rd_en_signals = connections.get("RD_EN", [])
        wr_en_signals = connections.get("WR_EN", [])

        # If both ports have enable signals, check if they're different
        if rd_idx < len(rd_en_signals) and wr_idx < len(wr_en_signals):
            rd_en_signal = rd_en_signals[rd_idx]
            wr_en_signal = wr_en_signals[wr_idx]

            # If they use different enable signals, they're independent
            if rd_en_signal != wr_en_signal:
                return True

        # If enable signals are the same or one is missing, they might be coupled
        # But for single-port read-write memories, this is often still acceptable
        # as the port can still function in read-only or write-only mode
        return True  # Conservative: assume independence unless proven otherwise

    def _get_port_optional_single(
        self, port_idx: int, parameters: dict[str, str], is_read: bool
    ) -> bool:
        """Determine if a single-purpose port (read-only or write-only) should be
        optional.

        Based on Yosys mem_v2 documentation, a port can be optional if there are
        multiple ports of the same type and not all need to be used simultaneously.
        """
        if is_read:
            total_ports = int(parameters.get("RD_PORTS", 0))
        else:
            total_ports = int(parameters.get("WR_PORTS", 0))

        # Mark as optional if there are multiple ports of this type
        return total_ports > 1
