"""Parse fabric and tile CSV files into the fabric model.

The CSV files form a line-oriented language whose grammar is `fabric_csv.lark`.
Lark parses a file into a tree, and `_Lowering` transforms that tree bottom-up
straight into `TilePort`, `Bel`, `Gen_IO`, `Tile` and `SuperTile` objects. A cell
the grammar does not describe is a syntax error that names the file, line and
column, so no row is ever skipped or defaulted silently.

Only references that cross a block stay unresolved until the whole file is read.
Fabric grid cells and SuperTILE rows name tiles lowered from other files, and
`Tile`/`Supertile` parameters are lowered after `PreserveListOrder` is known,
since that setting may follow them in the Parameters block.
"""

from copy import deepcopy
from dataclasses import dataclass
from pathlib import Path
from typing import NamedTuple

from lark import Discard, Lark, Token, Transformer, Tree, UnexpectedInput, v_args
from lark.exceptions import UnexpectedCharacters, UnexpectedToken, VisitError
from lark.lexer import PatternStr
from lark.tree import Meta
from loguru import logger

from fabulous.custom_exception import (
    InvalidCSVSyntax,
    InvalidFabricDefinition,
    InvalidFabricParameter,
    InvalidFileType,
    InvalidPortType,
    InvalidSupertileDefinition,
    InvalidSwitchMatrixDefinition,
    InvalidTileDefinition,
)
from fabulous.fabric_definition.bel import Bel
from fabulous.fabric_definition.define import (
    IO,
    SWITCH_MATRIX_CONSTANTS,
    ConfigBitMode,
    Direction,
    MultiplexerStyle,
    Side,
)
from fabulous.fabric_definition.fabric import Fabric
from fabulous.fabric_definition.gen_io import Gen_IO
from fabulous.fabric_definition.port import NULL_PORT_NAME, TilePort
from fabulous.fabric_definition.supertile import SuperTile
from fabulous.fabric_definition.switch_matrix import SwitchMatrix
from fabulous.fabric_definition.tile import Tile
from fabulous.fabric_generator.gen_fabric.fabric_automation import (
    addBelsToPrim,
    generateCustomTileConfig,
    generateSwitchmatrixList,
)
from fabulous.fabric_generator.parser.parse_hdl import parseBelFile
from fabulous.fabulous_settings import get_context

GRAMMAR_PATH = Path(__file__).with_name("fabric_csv.lark")

_PARSER = Lark(
    GRAMMAR_PATH.read_text(encoding="utf-8"),
    parser="lalr",
    propagate_positions=True,
    start=["csv_file", "fabric_file", "port_file", "port_line"],
)

# fabric.csv `UserCLKDirection` value -> side the clock enters each tile.
USER_CLK_DIRECTIONS: dict[str, Side] = {
    "S2N": Side.SOUTH,
    "N2S": Side.NORTH,
    "W2E": Side.WEST,
    "E2W": Side.EAST,
}

_CONFIG_BIT_MODES: dict[str, ConfigBitMode] = {
    "frame_based": ConfigBitMode.FRAME_BASED,
    "FlipFlopChain": ConfigBitMode.FLIPFLOP_CHAIN,
}

_MULTIPLEXER_STYLES: dict[str, MultiplexerStyle] = {
    "custom": MultiplexerStyle.CUSTOM,
    "generic": MultiplexerStyle.GENERIC,
}

# Grid cells that mark an empty position in a fabric or supertile.
_EMPTY_CELLS = frozenset({"Null", "NULL", "None"})

_DEFAULT_CARRY_PREFIX = "FABulous_default"

_TERMINAL_NAMES: dict[str, str] = {
    "$END": "end of file",
    "_SEP": "','",
    "_NL": "end of line",
    "NAME": "name",
    "PATH": "path",
    "INT": "integer",
    "SIGNED_INT": "integer",
    "ESCAPED_STRING": "quoted string",
}


def _describe_terminal(name: str) -> str:
    """Return the user-facing spelling of a grammar terminal."""
    if name in _TERMINAL_NAMES:
        return _TERMINAL_NAMES[name]
    pattern = _PARSER.get_terminal(name).pattern
    if isinstance(pattern, PatternStr):
        return pattern.value
    # Alternations of literals compile to `(?:A|B)`; show them as `A | B`.
    return pattern.value.removeprefix("(?:").removesuffix(")").replace("|", " | ")


def _syntax_message(exc: UnexpectedInput, text: str, source: str) -> str:
    """Format a Lark parse failure as `file:line:column` plus a caret line."""
    match exc:
        case UnexpectedToken(token=token) if token.type == "$END":
            found = "end of file"
            expected: set[str] = exc.expected
        case UnexpectedToken(token=token):
            found = repr(str(token))
            expected = exc.expected
        case UnexpectedCharacters(char=char):
            found = repr(char)
            expected = exc.allowed or set()
        case _:
            found = "input"
            expected = set()
    options = ", ".join(sorted({_describe_terminal(name) for name in expected}))
    return (
        f"{source}:{exc.line}:{exc.column}: unexpected {found}, "
        f"expected one of: {options}\n{exc.get_context(text)}"
    )


def _parse(text: str, source: str, start: str) -> Tree:
    """Parse `text` from grammar rule `start`.

    Parameters
    ----------
    text : str
        CSV source text.
    source : str
        Name of the source used in error messages, usually the file path.
    start : str
        Grammar start rule: `csv_file`, `port_file` or `port_line`.

    Returns
    -------
    Tree
        The parse tree.

    Raises
    ------
    InvalidCSVSyntax
        If `text` does not match the grammar.
    """
    # `_NL` requires a line end, so a last line without one gets it.
    text = text + "\n"
    try:
        return _PARSER.parse(text, start=start)
    except UnexpectedInput as exc:
        raise InvalidCSVSyntax(_syntax_message(exc, text, source)) from None


def _parse_file(path: Path, start: str = "csv_file") -> Tree:
    """Parse the CSV file at `path` from grammar rule `start`."""
    return _parse(path.read_text(encoding="utf-8"), str(path), start)


def _check_csv_path(path: Path) -> None:
    """Reject a path that is not an existing `.csv` file.

    Parameters
    ----------
    path : Path
        Path to check.

    Raises
    ------
    InvalidFileType
        If `path` does not end in `.csv`.
    FileNotFoundError
        If `path` does not exist.
    """
    if path.suffix != ".csv":
        raise InvalidFileType(f"File {path} must be a CSV file.")
    if not path.exists():
        raise FileNotFoundError(f"File {path} does not exist.")


def _blocks(tree: Tree, kind: str) -> list[Tree]:
    """Return the top-level blocks of grammar rule `kind` in document order."""
    return [
        block
        for block in tree.children
        if isinstance(block, Tree) and block.data == kind
    ]


@dataclass(frozen=True)
class _Carry:
    """A `CARRY` port attribute with its chain prefix resolved."""

    prefix: str


class _PortRow(NamedTuple):
    """One lowered port row plus the attribute the enclosing tile consumes."""

    ports: list[TilePort]
    common_wire_pair: tuple[str, str] | None
    attribute: _Carry | Token | None
    line: int


@dataclass(frozen=True)
class _MatrixLine:
    """A tile `MATRIX` row; resolving it needs the tile name."""

    path: str | None
    generate: bool
    line: int


@dataclass(frozen=True)
class _TileRef:
    """A `Tile` parameter, lowered once every setting is known."""

    path: str
    generate: bool


@dataclass(frozen=True)
class _SupertileRef:
    """A `Supertile` parameter, lowered after the tiles it names."""

    path: str


@dataclass
class _FabricSettings:
    """Parameters block settings, holding the defaults for any not given."""

    config_bit_mode: ConfigBitMode = ConfigBitMode.FRAME_BASED
    frame_bits_per_row: int = 32
    max_frames_per_col: int = 20
    package: str = "use work.my_package.all;"
    generate_delay_in_switch_matrix: int = 80
    multiplexer_style: MultiplexerStyle = MultiplexerStyle.CUSTOM
    super_tile_enable: bool = True
    disable_user_clk: bool = False
    user_clk_side: Side = Side.SOUTH
    multi_clk_domains: bool = False
    preserve_list_order: bool = False


def _lower[T](lowering: Transformer, tree: Tree) -> T:
    """Transform `tree`, re-raising the lowering's error instead of `VisitError`."""
    try:
        return lowering.transform(tree)
    except VisitError as exc:
        raise exc.orig_exc from None


@v_args(inline=True)
class _Lowering(Transformer):
    """Lower a CSV parse tree to fabric model objects.

    One instance serves one file, because relative paths and error locations
    come from `csv_path`, and settings accumulate across a Parameters block.

    Parameters
    ----------
    csv_path : Path
        The file being lowered. Relative paths resolve against its directory.
    preserve_list_order : bool
        Passed to each tile's switch matrix. Defaults to False.
    tile_dic : dict[str, Tile] | None
        Tiles that SuperTILE rows may name. Defaults to None, meaning no tiles.
    """

    def __init__(
        self,
        csv_path: Path,
        preserve_list_order: bool = False,
        tile_dic: dict[str, Tile] | None = None,
    ) -> None:
        super().__init__()
        self.csv_path = csv_path
        self.preserve_list_order = preserve_list_order
        self.tile_dic = {} if tile_dic is None else tile_dic
        self.common_wire_pairs: list[tuple[str, str]] = []
        self.settings = _FabricSettings()
        self._seen_settings: set[str] = set()

    def _at(self, line: int | None) -> str:
        """Return the `file:line` prefix for an error message."""
        return f"{self.csv_path}:{line}"

    # Ports -------------------------------------------------------------------

    @v_args(meta=True, inline=True)
    def port(
        self,
        meta: Meta,
        direction: Token,
        source_name: Token,
        x_offset: Token,
        y_offset: Token,
        destination_name: Token,
        wire_count: Token,
        attribute: _Carry | Token | None,
    ) -> _PortRow:
        """Lower a port row to its output and input `TilePort`s."""
        at = self._at(meta.line)
        src, dst = str(source_name), str(destination_name)
        x, y, count = int(x_offset), int(y_offset), int(wire_count)
        wire_direction = Direction[direction]

        # The trailing digits are read back as that index. A name that ends in a
        # digit is ambiguous once expanded.
        for wire_name in (src, dst):
            if wire_name != NULL_PORT_NAME and wire_name[-1:].isdigit():
                raise InvalidPortType(
                    f"{at}: Wire name '{wire_name}' ends in a digit, which is "
                    "ambiguous: wire expansion appends the index as a trailing "
                    "digit, so a name ending in a digit cannot be distinguished "
                    "from an indexed wire. Rename the wire so it does not end in "
                    "a digit."
                )

        def make(name: str, io: IO, side: Side) -> TilePort:
            return TilePort(
                name=name,
                io_direction=io,
                width=count,
                side_of_tile=side,
                wire_direction=wire_direction,
                source_name=src,
                x_offset=x,
                y_offset=y,
                destination_name=dst,
                wire_count=count,
            )

        match wire_direction:
            case Direction.NORTH | Direction.EAST | Direction.SOUTH | Direction.WEST:
                side = Side[wire_direction.name]
                ports = [
                    make(src, IO.OUTPUT, side),
                    make(dst, IO.INPUT, side.opposite),
                ]
                return _PortRow(ports, (src, dst), attribute, meta.line)
            case Direction.JUMP:
                ports = [make(src, IO.OUTPUT, Side.ANY), make(dst, IO.INPUT, Side.ANY)]
                return _PortRow(ports, None, attribute, meta.line)
            case Direction.SJUMP:
                # An SJUMP row is one-way: `SJUMP,src,0,0,NULL,n` leaves the tile
                # toward the supertile switch matrix, `SJUMP,NULL,0,0,dst,n`
                # enters from it.
                if (src == NULL_PORT_NAME) == (dst == NULL_PORT_NAME):
                    raise InvalidPortType(
                        f"{at}: Invalid SJUMP line: exactly one of source and "
                        "destination must be NULL (use 'SJUMP,src,0,0,NULL,n' for an "
                        "output or 'SJUMP,NULL,0,0,dst,n' for an input)."
                    )
                # SJUMP wires terminate at the supertile switch matrix and carry
                # no spatial offset.
                if x != 0 or y != 0:
                    raise InvalidPortType(
                        f"{at}: Invalid SJUMP line: X/Y offset must be 0,0 "
                        f"(got {x},{y})."
                    )
                if src != NULL_PORT_NAME:
                    port = make(src, IO.OUTPUT, Side.ANY)
                else:
                    port = make(dst, IO.INPUT, Side.ANY)
                return _PortRow([port], None, attribute, meta.line)

    def carry(self, prefix: Token | None) -> _Carry:
        """Lower a `CARRY` attribute, defaulting the chain prefix."""
        if prefix is None:
            logger.info(
                f"CARRY port without prefix, using default prefix "
                f"{_DEFAULT_CARRY_PREFIX}"
            )
            return _Carry(_DEFAULT_CARRY_PREFIX)
        name = prefix[1:-1]
        if not name:
            raise InvalidPortType(f"{self._at(prefix.line)}: CARRY prefix is empty.")
        return _Carry(name)

    def port_file(self, *rows: _PortRow) -> list[_PortRow]:
        """Return every port row of an INCLUDE file."""
        for row in rows:
            if row.attribute is not None:
                raise InvalidTileDefinition(
                    f"{self._at(row.line)}: an INCLUDE file cannot carry a CARRY or "
                    "SHARED_ attribute; declare that port in the tile CSV."
                )
        return list(rows)

    @v_args(meta=True, inline=True)
    def include(self, meta: Meta, path: Token) -> list[_PortRow]:
        """Lower an INCLUDE row to the port rows of the included file."""
        include_path = self.csv_path.parent.joinpath(path.strip())
        if not include_path.exists():
            raise InvalidTileDefinition(
                f"{self._at(meta.line)}: Cannot find {include_path}"
            )
        return _lower(
            _Lowering(include_path), _parse_file(include_path, start="port_file")
        )

    # BELs and GEN_IOs ----------------------------------------------------------

    @v_args(meta=True, inline=True)
    def bel(self, meta: Meta, path: Token, prefix: Token | None, *flags: Token) -> Bel:
        """Lower a BEL row by parsing its HDL file."""
        bel_path = self.csv_path.parent.joinpath(path.strip())
        if bel_path.suffix not in (".vhdl", ".v", ".sv"):
            raise InvalidFileType(
                f"{self._at(meta.line)}: File {bel_path} is not a .vhdl, .v, or .sv "
                "file. Please check the BEL file."
            )
        bel = parseBelFile(bel_path, "" if prefix is None else str(prefix))
        if flags:
            prims_file = get_context().proj_dir.joinpath("user_design/custom_prims.v")
            logger.info(f"Adding bels to custom prims file: {prims_file}")
            addBelsToPrim(prims_file, [bel])
        return bel

    @v_args(meta=True, inline=True)
    def gen_io(
        self,
        meta: Meta,
        pins: Token,
        io: Token,
        prefix: Token,
        *flags: Token | None,
    ) -> Gen_IO:
        """Lower a GEN_IO row, checking its flag combination."""
        at = self._at(meta.line)
        pin_count = int(pins)
        if pin_count <= 0:
            raise InvalidTileDefinition(
                f"{at}: GEN_IO pins must be greater than 0, but is {pin_count}"
            )
        direction = IO[io]
        names = {flag.upper() for flag in flags if flag is not None}
        config_access = "CONFIGACCESS" in names
        clocked = "CLOCKED" in names
        clocked_comb = "CLOCKED_COMB" in names
        clocked_mux = "CLOCKED_MUX" in names

        if config_access and direction is not IO.OUTPUT:
            raise InvalidTileDefinition(
                f"{at}: CONFIGACCESS GEN_IO can only be used with OUTPUT, "
                f"but is {direction.value}"
            )
        if config_access and (clocked or clocked_comb or clocked_mux):
            raise InvalidTileDefinition(f"{at}: CONFIGACCESS GEN_IO can not be clocked")
        if sum([clocked, clocked_comb, clocked_mux]) > 1:
            raise InvalidTileDefinition(
                f"{at}: CLOCKED, CLOCKED_COMB or CLOCKED_MUX can not be combined "
                "for one GEN_IO"
            )

        return Gen_IO(
            prefix=str(prefix),
            pins=pin_count,
            IO=direction,
            configBit=pin_count if config_access or clocked_mux else 0,
            configAccess=config_access,
            inverted="INVERTED" in names,
            clocked=clocked,
            clockedComb=clocked_comb,
            clockedMux=clocked_mux,
        )

    # TILE ----------------------------------------------------------------------

    @v_args(meta=True, inline=True)
    def matrix_file(self, meta: Meta, path: Token) -> _MatrixLine:
        """Lower `MATRIX,<path>`."""
        return _MatrixLine(path.strip(), generate=False, line=meta.line)

    @v_args(meta=True, inline=True)
    def matrix_generate(self, meta: Meta, path: Token | None) -> _MatrixLine:
        """Lower `MATRIX,GENERATE[,<path>]`."""
        return _MatrixLine(
            None if path is None else path.strip(), generate=True, line=meta.line
        )

    def _generated_matrix_path(self, tile_name: str, matrix: _MatrixLine) -> Path:
        """Resolve where `MATRIX,GENERATE` writes the tile's `.list` file."""
        proj_dir = get_context().proj_dir
        target = self.csv_path.parent
        if matrix.path is not None:
            target = target.joinpath(matrix.path)
        file_name = f"{tile_name}_generated_switch_matrix.list"
        if target.is_file() and target.suffix == ".list":
            logger.warning(
                f"Matrix file {target} already exists and will be overwritten."
            )
            return target
        if target.parent == proj_dir.joinpath("Tile"):
            target = target.joinpath(file_name)
            logger.info(f"Generating matrix file {target}")
            return target
        target = proj_dir.joinpath(f"./Tile/{tile_name}/{file_name}")
        logger.warning(
            "No destination directory for matrix file specified, "
            f"using default path {target}."
        )
        if not target.parent.exists():
            target.parent.mkdir(parents=True)
            logger.warning(f"Creating directory {target.parent}.")
        return target

    @v_args(meta=True, inline=True)
    def tile(
        self,
        meta: Meta,
        name: Token,
        *lines: _PortRow | list[_PortRow] | Bel | Gen_IO | _MatrixLine,
    ) -> Tile:
        """Lower a TILE block to a `Tile`."""
        tile_name = str(name)
        if self.csv_path.parent.name != tile_name:
            logger.warning(
                f"Tile name '{tile_name}' does not match folder name "
                f"'{self.csv_path.parent.name}' in {self.csv_path}."
            )
        ports: list[TilePort] = []
        bels: list[Bel] = []
        gen_ios: list[Gen_IO] = []
        matrix: _MatrixLine | None = None
        carry_ports: dict[str, dict[IO, str]] = {}
        shared_ports: dict[str, list[TilePort]] = {}

        for line in lines:
            match line:
                case _PortRow():
                    self._add_port_attribute(line, carry_ports, shared_ports)
                    self._add_port_rows(ports, [line])
                case list():
                    self._add_port_rows(ports, line)
                case Bel():
                    bels.append(line)
                case Gen_IO():
                    if any(gen_io.prefix == line.prefix for gen_io in gen_ios):
                        raise InvalidTileDefinition(
                            f"{self._at(meta.line)}: GEN_IO with prefix {line.prefix} "
                            f"already exists in tile {tile_name}."
                        )
                    gen_ios.append(line)
                case _MatrixLine():
                    if matrix is not None:
                        raise InvalidTileDefinition(
                            f"{self._at(line.line)}: tile {tile_name!r} has a second "
                            f"MATRIX line; the first is on line {matrix.line}."
                        )
                    matrix = line

        if matrix is None:
            raise InvalidTileDefinition(
                f"{self._at(meta.line)}: Tile {tile_name!r} has no MATRIX line; a "
                "switch matrix (.csv/.list) or hand-written HDL file is required."
            )
        if matrix.generate:
            logger.info(f"Generating switch matrix list for tile {tile_name}")
            matrix_path = self._generated_matrix_path(tile_name, matrix)
            generateSwitchmatrixList(
                tile_name, bels, matrix_path, carry_ports, shared_ports
            )
        else:
            assert matrix.path is not None
            matrix_path = self.csv_path.parent.joinpath(matrix.path).absolute()

        return Tile(
            name=tile_name,
            ports=ports,
            bels=bels,
            tileDir=self.csv_path,
            switch_matrix=SwitchMatrix.from_file(
                matrix_path,
                tile_name,
                ports=ports,
                bels=bels,
                preserve_list_order=self.preserve_list_order,
            ),
            gen_ios=gen_ios,
            userCLK=any(bel.withUserCLK for bel in bels),
        )

    def _add_port_rows(self, ports: list[TilePort], rows: list[_PortRow]) -> None:
        """Append the rows' ports to `ports` and record their wire pairs."""
        for row in rows:
            ports.extend(row.ports)
            if row.common_wire_pair is not None:
                self.common_wire_pairs.append(row.common_wire_pair)

    def _add_port_attribute(
        self,
        row: _PortRow,
        carry_ports: dict[str, dict[IO, str]],
        shared_ports: dict[str, list[TilePort]],
    ) -> None:
        """Record a port row's CARRY or SHARED_ attribute on its tile."""
        at = self._at(row.line)
        first = row.ports[0]
        match row.attribute:
            case None:
                return
            case _Carry(prefix=prefix):
                if prefix in carry_ports:
                    raise InvalidPortType(
                        f"{at}: There is already a carrychain with the prefix {prefix}"
                    )
                carry_ports[prefix] = {
                    IO.OUTPUT: f"{first.source_name}0",
                    IO.INPUT: f"{first.destination_name}0",
                }
            case Token() as shared:
                if first.wire_direction not in (Direction.JUMP, Direction.SJUMP):
                    raise InvalidTileDefinition(
                        f"{at}: LOCAL SHARED_ Ports can only be used with JUMP ports."
                    )
                kind = shared.removeprefix("SHARED_")
                if kind in shared_ports:
                    raise InvalidTileDefinition(
                        f"{at}: LOCAL SHARED_ port {kind} already exists."
                    )
                shared_ports[kind] = row.ports

    # SuperTILE -------------------------------------------------------------------

    @v_args(meta=True, inline=True)
    def supertile_matrix(self, meta: Meta, path: Token) -> Path:
        """Lower a SuperTILE `MATRIX` row to its path."""
        matrix_path = self.csv_path.parent / path.strip()
        if not matrix_path.exists():
            raise InvalidSupertileDefinition(
                f"{self._at(meta.line)}: MATRIX file {matrix_path} does not exist."
            )
        return matrix_path

    def supertile_row(self, *cells: Token) -> list[Token]:
        """Keep a SuperTILE row as cells; `supertile` resolves the names."""
        return list(cells)

    @v_args(meta=True, inline=True)
    def supertile(
        self, meta: Meta, name: Token, *lines: Bel | Path | list[Token]
    ) -> SuperTile:
        """Lower a SuperTILE block to a `SuperTile`."""
        supertile_name = str(name)
        tile_map: list[list[Tile | None]] = []
        tiles: list[Tile] = []
        bels: list[Bel] = []
        master_coords: tuple[int, int] | None = None
        matrix_path: Path | None = None

        for line in lines:
            match line:
                case Bel():
                    bels.append(line)
                case Path():
                    if matrix_path is not None:
                        raise InvalidSupertileDefinition(
                            f"{self._at(meta.line)}: Supertile '{supertile_name}' "
                            "has more than one MATRIX line."
                        )
                    matrix_path = line
                case list():
                    row, master_column = self._supertile_row(supertile_name, line)
                    for tile in row:
                        if tile is not None and tile not in tiles:
                            tiles.append(tile)
                    if master_column is not None:
                        if master_coords is not None:
                            raise InvalidSupertileDefinition(
                                f"{self._at(line[0].line)}: Supertile "
                                f"'{supertile_name}': multiple MASTER tokens found."
                            )
                        master_coords = (master_column, len(tile_map))
                    tile_map.append(row)

        # tileDir is the supertile CSV file path (matching Tile.tileDir), so
        # consumers use `tileDir.parent` for the supertile's directory.
        super_tile = SuperTile(
            supertile_name,
            self.csv_path.absolute(),
            tiles,
            tile_map,
            bels,
            any(bel.withUserCLK for bel in bels),
        )
        super_tile.master_tile_coords = master_coords

        # A supertile without a MATRIX line has no switch matrix; nothing is
        # discovered from the directory.
        if matrix_path is not None:
            switch_matrix = SwitchMatrix.from_file(matrix_path, supertile_name)
            validate_super_tile_matrix(
                super_tile, switch_matrix.connections, matrix_path
            )
            super_tile.switch_matrix = switch_matrix
        return super_tile

    def _supertile_row(
        self, supertile_name: str, cells: list[Token]
    ) -> tuple[list[Tile | None], int | None]:
        """Resolve one SuperTILE row and the column of its MASTER tile, if any."""
        row: list[Tile | None] = []
        has_master = False
        for cell in cells:
            at = self._at(cell.line)
            if cell.type == "MASTER":
                if not row or row[-1] is None:
                    raise InvalidSupertileDefinition(
                        f"{at}: Supertile '{supertile_name}': MASTER must follow a "
                        "valid tile name."
                    )
                has_master = True
            elif cell in self.tile_dic:
                self.tile_dic[cell].partOfSuperTile = True
                row.append(deepcopy(self.tile_dic[cell]))
            elif cell in _EMPTY_CELLS:
                row.append(None)
            else:
                raise InvalidSupertileDefinition(
                    f"{at}: Supertile '{supertile_name}' names {str(cell)!r}, which "
                    "is neither a known tile nor Null."
                )
        if not has_master:
            return row, None
        if len(row) > 1:
            raise InvalidSupertileDefinition(
                f"{self._at(cells[0].line)}: Supertile '{supertile_name}': MASTER "
                "cannot be used on a row with multiple tiles."
            )
        return row, len(row) - 1

    # Fabric and Parameters -----------------------------------------------------

    def fabric_row(self, *cells: Token) -> list[Tile | None]:
        """Resolve a fabric grid row to tile copies, `None` for an empty cell."""
        row: list[Tile | None] = []
        for cell in cells:
            if cell in self.tile_dic:
                row.append(deepcopy(self.tile_dic[cell]))
            elif cell in _EMPTY_CELLS:
                row.append(None)
            else:
                raise InvalidFabricDefinition(
                    f"{self._at(cell.line)}: Unknown tile {cell} in fabric "
                    "description. Please check the tile definitions."
                )
        return row

    def fabric(self, *rows: list[Tile | None]) -> list[list[Tile | None]]:
        """Return the resolved fabric grid."""
        return list(rows)

    def tile_param(self, path: Token, generate: Token | None) -> _TileRef:
        """Lower `Tile,<path>[,GENERATE]`."""
        return _TileRef(path.strip(), generate is not None)

    def supertile_param(self, path: Token) -> _SupertileRef:
        """Lower `Supertile,<path>`."""
        return _SupertileRef(path.strip())

    def _claim_setting(self, key: str, line: int | None) -> None:
        """Reject a setting given twice in one Parameters block."""
        if key in self._seen_settings:
            raise InvalidFabricParameter(
                f"{self._at(line)}: parameter {key} is set more than once."
            )
        self._seen_settings.add(key)

    @v_args(meta=True, inline=True)
    def config_bit_mode(self, meta: Meta, value: Token) -> object:
        """Apply `ConfigBitMode`."""
        self._claim_setting("ConfigBitMode", meta.line)
        self.settings.config_bit_mode = _CONFIG_BIT_MODES[value]
        return Discard

    @v_args(meta=True, inline=True)
    def multiplexer_style(self, meta: Meta, value: Token) -> object:
        """Apply `MultiplexerStyle`."""
        self._claim_setting("MultiplexerStyle", meta.line)
        self.settings.multiplexer_style = _MULTIPLEXER_STYLES[value]
        return Discard

    @v_args(meta=True, inline=True)
    def user_clk_direction(self, meta: Meta, value: Token) -> object:
        """Apply `UserCLKDirection`."""
        self._claim_setting("UserCLKDirection", meta.line)
        self.settings.user_clk_side = USER_CLK_DIRECTIONS[value]
        return Discard

    @v_args(meta=True, inline=True)
    def package(self, meta: Meta, value: Token) -> object:
        """Apply `Package`."""
        self._claim_setting("Package", meta.line)
        self.settings.package = value.strip()
        return Discard

    def int_setting(self, key: Token, value: Token) -> object:
        """Apply an integer setting."""
        self._claim_setting(key, key.line)
        match key:
            case "FrameBitsPerRow":
                self.settings.frame_bits_per_row = int(value)
            case "MaxFramesPerCol":
                self.settings.max_frames_per_col = int(value)
            case "GenerateDelayInSwitchMatrix":
                self.settings.generate_delay_in_switch_matrix = int(value)
        return Discard

    def bool_setting(self, key: Token, value: Token) -> object:
        """Apply a TRUE/FALSE setting."""
        self._claim_setting(key, key.line)
        enabled = value == "TRUE"
        match key:
            case "SuperTileEnable":
                self.settings.super_tile_enable = enabled
            case "DisableUserCLK":
                self.settings.disable_user_clk = enabled
            case "MultiClkDomains":
                self.settings.multi_clk_domains = enabled
            case "PreserveListOrder":
                self.settings.preserve_list_order = enabled
        return Discard

    def parameters(
        self, *refs: _TileRef | _SupertileRef
    ) -> list[_TileRef | _SupertileRef]:
        """Return the tile and supertile references in document order."""
        return list(refs)


def parse_port_line(line: str) -> tuple[list[TilePort], tuple[str, str] | None]:
    """Parse a single port row such as `NORTH,N1BEG,0,-1,N1END,4`.

    Parameters
    ----------
    line : str
        One port row. A trailing attribute cell (CARRY, SHARED_) is accepted
        and ignored, since only a tile can record it.

    Returns
    -------
    tuple[list[TilePort], tuple[str, str] | None]
        The output and input ports, and the (source, destination) wire pair for
        NORTH/EAST/SOUTH/WEST rows.

    Notes
    -----
    `InvalidCSVSyntax` is raised if `line` is not a port row, and `InvalidPortType`
    if a wire name ends in a digit or an SJUMP row is malformed.
    """
    tree = _parse(line, "<port line>", start="port_line")
    row: _PortRow = _lower(_Lowering(Path("<port line>")), tree)
    return row.ports, row.common_wire_pair


def parseTilesCSV(
    fileName: Path, preserve_list_order: bool = False
) -> tuple[list[Tile], list[tuple[str, str]]]:
    """Parse every TILE block in a CSV file.

    Parameters
    ----------
    fileName : Path
        The path to the CSV file.
    preserve_list_order : bool
        Passed to each tile's switch matrix so a `.list` keeps its file order
        (MSB-first) instead of the canonical dest-column order. Defaults to False.

    Returns
    -------
    tuple[list[Tile], list[tuple[str, str]]]
        The tiles and the (source, destination) wire pairs of their
        NORTH/EAST/SOUTH/WEST ports, INCLUDE files included.

    Notes
    -----
    `InvalidCSVSyntax` is raised, naming file, line and column, if the file does
    not match the CSV grammar.
    """
    _check_csv_path(fileName)
    logger.info(f"Reading tile configuration: {fileName}")
    tree = _parse_file(fileName)
    lowering = _Lowering(fileName, preserve_list_order=preserve_list_order)
    tiles: list[Tile] = [_lower(lowering, block) for block in _blocks(tree, "tile")]
    return tiles, lowering.common_wire_pairs


def validate_super_tile_matrix(
    super_tile: SuperTile,
    connections: dict[str, list[str]],
    matrix_path: Path,
) -> None:
    """Check that a supertile switch matrix only references known names.

    Every mux output (sink) must be a BEL input or a child-tile INPUT SJUMP wire,
    and every mux input (source) must be a BEL output, a child-tile OUTPUT SJUMP
    wire, or a switch-matrix constant. An unknown name is almost always a typo and
    would otherwise emit RTL referencing an undeclared signal.

    Parameters
    ----------
    super_tile : SuperTile
        The supertile whose ports and BELs define the legal names.
    connections : dict[str, list[str]]
        Parsed matrix, mapping each sink (destination) to its sources.
    matrix_path : Path
        Path to the matrix file, used in the error message.

    Raises
    ------
    InvalidSwitchMatrixDefinition
        If any sink or source is not a known port, BEL pin, or constant.
    """
    valid_sources, valid_sinks = super_tile.get_matrix_port_names()
    valid_sources |= set(SWITCH_MATRIX_CONSTANTS)

    unknown_sinks = sorted(s for s in connections if s not in valid_sinks)
    unknown_sources = sorted(
        {src for sources in connections.values() for src in sources} - valid_sources
    )

    if unknown_sinks or unknown_sources:
        raise InvalidSwitchMatrixDefinition(
            f"Supertile '{super_tile.name}' switch matrix {matrix_path} references "
            f"undefined names: sinks={unknown_sinks}, sources={unknown_sources}.\n"
            "Sinks must be BEL inputs or child-tile INPUT SJUMP wires; sources "
            "must be BEL outputs, child-tile OUTPUT SJUMP wires, or a constant.\n"
            f"Available sinks: {sorted(valid_sinks)}\n"
            f"Available sources: {sorted(valid_sources)}"
        )


def parseSupertilesCSV(fileName: Path, tileDic: dict[str, Tile]) -> list[SuperTile]:
    """Parse every SuperTILE block in a CSV file.

    Parameters
    ----------
    fileName : Path
        The path to the CSV file.
    tileDic : dict[str, Tile]
        Tiles the SuperTILE rows may name. Each named tile is marked
        `partOfSuperTile`.

    Returns
    -------
    list[SuperTile]
        The supertiles in file order.

    Notes
    -----
    `InvalidCSVSyntax` is raised, naming file, line and column, if the file does
    not match the CSV grammar.
    """
    _check_csv_path(fileName)
    logger.info(f"Reading supertile configuration: {fileName}")
    tree = _parse_file(fileName)
    lowering = _Lowering(fileName, tile_dic=tileDic)
    return [_lower(lowering, block) for block in _blocks(tree, "supertile")]


def parse_tile_from_dir(
    tile_dir: Path, tile_name: str, is_supertile: bool
) -> Tile | SuperTile:
    """Parse a single tile or supertile from its own directory.

    Reads `<tile_dir>/<tile_name>.csv` in isolation, without constructing a
    surrounding `Fabric`. For a supertile, the subtile CSVs are read first (each
    from `<tile_dir>/<subtile>/<subtile>.csv`) to build the tile dictionary the
    supertile definition references.

    Parameters
    ----------
    tile_dir : Path
        Directory containing the tile CSV and, for supertiles, the subtile
        subdirectories.
    tile_name : str
        Name of the tile or supertile to return. Also the CSV file stem.
    is_supertile : bool
        Whether the target is a supertile.

    Raises
    ------
    FileNotFoundError
        If `<tile_dir>/<tile_name>.csv` does not exist.
    InvalidTileDefinition
        If a non-supertile named `tile_name` is not present in the CSV.
    InvalidSupertileDefinition
        If a supertile named `tile_name` is not present in the CSV.

    Returns
    -------
    Tile | SuperTile
        The parsed tile or supertile.
    """
    tile_csv = tile_dir / f"{tile_name}.csv"
    if not tile_csv.exists():
        raise FileNotFoundError(f"Tile CSV {tile_csv} does not exist")

    if not is_supertile:
        tiles, _ = parseTilesCSV(tile_csv)
        for tile in tiles:
            if tile.name == tile_name:
                return tile
        raise InvalidTileDefinition(f"Tile {tile_name!r} not found in {tile_csv}")

    subtile_names: list[str] = []
    for row in _parse_file(tile_csv).iter_subtrees_topdown():
        if row.data != "supertile_row":
            continue
        for cell in row.children:
            if (
                isinstance(cell, Token)
                and cell.type == "NAME"
                and cell not in _EMPTY_CELLS
                and cell not in subtile_names
            ):
                subtile_names.append(str(cell))

    tile_dic: dict[str, Tile] = {}
    for subtile_name in subtile_names:
        subtile_csv = tile_dir / subtile_name / f"{subtile_name}.csv"
        tiles, _ = parseTilesCSV(subtile_csv)
        tile_dic.update({tile.name: tile for tile in tiles})

    for supertile in parseSupertilesCSV(tile_csv, tile_dic):
        if supertile.name == tile_name:
            return supertile
    raise InvalidSupertileDefinition(f"SuperTile {tile_name!r} not found in {tile_csv}")


def parseFabricCSV(fileName: str) -> Fabric:
    """Parse a fabric CSV file and every tile and supertile CSV it names.

    Parameters
    ----------
    fileName : str
        Path to the fabric CSV file.

    Returns
    -------
    Fabric
        The fabric object.

    Notes
    -----
    `InvalidCSVSyntax` is raised, naming file, line and column, if any CSV file
    does not match the CSV grammar, including a fabric file without exactly one
    grid and one Parameters block. `InvalidFabricDefinition` is raised if the
    grid names an unknown tile, and `InvalidFabricParameter` if a parameter is
    set twice.
    """
    fabric_path = Path(fileName).absolute()
    _check_csv_path(fabric_path)
    fabric_dir = fabric_path.parent
    tree = _parse_file(fabric_path, start="fabric_file")
    # The grammar admits exactly one of each.
    (grid_block,) = _blocks(tree, "fabric")
    (parameter_block,) = _blocks(tree, "parameters")

    parameter_lowering = _Lowering(fabric_path)
    refs: list[_TileRef | _SupertileRef] = _lower(parameter_lowering, parameter_block)
    settings = parameter_lowering.settings
    preserve = settings.preserve_list_order

    # TILE and SuperTILE blocks inside the fabric CSV are still honoured.
    local_lowering = _Lowering(fabric_path, preserve_list_order=preserve)
    local_tiles: list[Tile] = [
        _lower(local_lowering, block) for block in _blocks(tree, "tile")
    ]
    tile_dic = {tile.name: tile for tile in local_tiles}
    common_wire_pairs = list(local_lowering.common_wire_pairs)
    supertile_lowering = _Lowering(fabric_path, tile_dic=tile_dic)
    local_supertiles: list[SuperTile] = [
        _lower(supertile_lowering, block) for block in _blocks(tree, "supertile")
    ]
    supertile_dic = {supertile.name: supertile for supertile in local_supertiles}
    if local_tiles or local_supertiles:
        logger.warning(
            f"Deprecation warning: {fabric_path} should not contain tile descriptions."
        )

    for ref in refs:
        match ref:
            case _TileRef(path=path, generate=generate):
                tile_csv = fabric_dir.joinpath(path)
                if generate:
                    tile_csv = generateCustomTileConfig(tile_csv)
                tiles, pairs = parseTilesCSV(tile_csv, preserve)
                tile_dic.update({tile.name: tile for tile in tiles})
                common_wire_pairs += pairs
            case _SupertileRef(path=path):
                for supertile in parseSupertilesCSV(
                    fabric_dir.joinpath(path), tile_dic
                ):
                    supertile_dic[supertile.name] = supertile

    fabric_tiles: list[list[Tile | None]] = _lower(
        _Lowering(fabric_path, tile_dic=tile_dic), grid_block
    )
    used_tiles = {tile.name for row in fabric_tiles for tile in row if tile is not None}

    unused_tile_dic: dict[str, Tile] = {}
    for name in list(tile_dic):
        if name not in used_tiles:
            logger.info(
                f"Tile {name} is not used in the fabric. Removing from tile dictionary."
            )
            unused_tile_dic[name] = tile_dic.pop(name)
    unused_supertile_dic: dict[str, SuperTile] = {}
    for name in list(supertile_dic):
        if any(tile.name not in used_tiles for tile in supertile_dic[name].tiles):
            logger.info(
                f"Supertile {name} is not used in the fabric. "
                "Removing from tile dictionary."
            )
            unused_supertile_dic[name] = supertile_dic.pop(name)

    height = len(fabric_tiles)
    unique_pairs = list(dict.fromkeys(common_wire_pairs))
    return Fabric(
        fabric_dir=fabric_path,
        tile=fabric_tiles,
        numberOfColumns=len(fabric_tiles[0]),
        numberOfRows=height,
        configBitMode=settings.config_bit_mode,
        frameBitsPerRow=settings.frame_bits_per_row,
        maxFramesPerCol=settings.max_frames_per_col,
        package=settings.package,
        generateDelayInSwitchMatrix=settings.generate_delay_in_switch_matrix,
        multiplexerStyle=settings.multiplexer_style,
        numberOfBRAMs=int(height / 2),
        superTileEnable=settings.super_tile_enable,
        disableUserCLK=settings.disable_user_clk,
        userCLKSide=settings.user_clk_side,
        multiClkDomains=settings.multi_clk_domains,
        tileDic=tile_dic,
        superTileDic=supertile_dic,
        unusedTileDic=unused_tile_dic,
        unusedSuperTileDic=unused_supertile_dic,
        commonWirePair=[
            (source, destination)
            for (source, destination) in unique_pairs
            if "NULL" not in source and "NULL" not in destination
        ],
    )
