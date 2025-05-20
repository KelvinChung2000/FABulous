from pathlib import Path
from time import sleep

from hdlgen.code_gen import CodeGenerator
from hdlgen.define import WriterType as CodeGenWriterType
from loguru import logger

import FABulous.fabric_cad.model_generation_npnr as model_gen_npnr
from FABulous.fabric_cad.bitstreamSpec_generator import generateBitsStreamSpec
from FABulous.fabric_cad.chip_database_generator import generateChipDatabase
from FABulous.fabric_cad.helper import mergeFiles
from FABulous.fabric_cad.synth_file_generator import (
    genCellsAndMaps,
    genPrims,
    genSynthScript,
)

# Importing Modules from FABulous Framework.
from FABulous.fabric_definition.Bel import Bel
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_definition.SuperTile import SuperTile
from FABulous.fabric_definition.Tile import Tile
from FABulous.fabric_definition.define import Loc
from FABulous.fabric_generator.ConfigMem_genenrator import generateConfigMem
from FABulous.fabric_generator.define import WriterType
from FABulous.fabric_generator.fabric_generator import generateFabric
from FABulous.fabric_generator.fabricWrapper_generator import generateFabricTopWrapper
from FABulous.fabric_generator.Tile_generator import generateTile
from FABulous.fabric_generator.TileSwitchMatrix_generator import (
    generateTileSwitchMatrix,
)
from FABulous.file_parser.file_parser_csv import parseFabricCSV
from FABulous.file_parser.file_parser_yaml import parseFabricYAML
from FABulous.file_parser.parse_py_mux import setupPortData
from FABulous.geometry_generator.geometry_gen import GeometryGenerator


class FABulous_API:
    """Class for managing fabric and geometry generation.

    This class parses fabric data from 'fabric.csv', generates fabric layouts,
    geometries, models for nextpnr, as well as
    other fabric-related functions.

    Attributes
    ----------
    fabricGenerator : FabricGenerator
        Object responsible for generating fabric-related outputs.
    geometryGenerator : GeometryGenerator
        Object responsible for generating geometry-related outputs.
    fabric : Fabric
        Represents the parsed fabric data.
    """

    writerType: CodeGenWriterType
    geometryGenerator: GeometryGenerator
    fabric: Fabric

    def __init__(
        self, fabricFile: Path = Path(), writeType: WriterType = WriterType.VERILOG
    ):
        """Initialises FABulous object.

        If 'fabricCSV' is provided, parses fabric data and initialises
        'fabricGenerator' and 'geometryGenerator' with parsed data.

        If using VHDL, changes the extension from '.v' to'.vhdl'.

        Parameters
        ----------
        writer : codeGen.codeGenerator
            Object responsible for generating code from code_generator.py
        fabricCSV : str, optional
            Path to the CSV file containing fabric data, by default ""
        """
        if fabricFile != Path():
            if fabricFile.suffix == ".csv":
                self.fabric = parseFabricCSV(fabricFile)
            elif fabricFile.suffix == ".yaml":
                self.fabric = parseFabricYAML(fabricFile)
            else:
                logger.error(
                    "Only .csv and .yaml files are supported for fabric loading"
                )
                raise ValueError
            self.geometryGenerator = GeometryGenerator(self.fabric)

        self.writerType = CodeGenWriterType[str(writeType).upper()]

        # self.fabricGenerator = FabricGenerator(fabric, writer)

    def loadFabric(self, dir: Path):
        """Loads fabric data from 'fabric.csv'.

        Parameters
        ----------
        dir : str
            Path to fabric file containing fabric data.

        Raises
        ----------
        ValueError
            If 'dir' does not end with '.csv'
        """

        if dir.suffix == ".csv":
            self.fabric = parseFabricCSV(dir)
        elif dir.suffix == ".yaml":
            self.fabric = parseFabricYAML(dir)
        else:
            logger.error("Only .csv and .yaml files are supported for fabric loading")
            raise ValueError
        self.geometryGenerator = GeometryGenerator(self.fabric)

    def bootstrapSwitchMatrix(self, tileName: str, outputDir: str):
        """Bootstraps the switch matrix for the specified tile via
        'bootstrapSwitchMatrix' defined in 'fabric_gen.py'.

        Parameters
        ----------
        tileName : str
            Name of the tile for which the switch matrix will be bootstrapped.
        outputDir : str
            Directory path where the switch matrix will be generated.
        """
        tile = self.fabric.getTileByName(tileName)
        self.fabricGenerator.bootstrapSwitchMatrix(tile, outputDir)

    def addList2Matrix(self, list: str, matrix: str):
        """Converts list into CSV matrix via 'list2CSV' defined in 'fabric_gen.py' and
        saves it.

        Parameters
        ----------
        list : str
            List data to be converted.
        matrix : str
            File path where the matrix data will be saved.
        """
        self.fabricGenerator.list2CSV(list, matrix)

    def genConfigMem(self, tileName: str, dest: Path):
        """Generate configuration memory for specified tile.

        Parameters
        ----------
        tileName : str
            Name of the tile for which configuration memory will be generated.
        configMem : str
            File path where the configuration memory will be saved.
        """
        cg = CodeGenerator(dest, self.writerType)
        if tile := self.fabric.getTileByName(tileName):
            generateConfigMem(cg, self.fabric, tile)
        else:
            raise ValueError(f"Tile {tileName} not found")

    def genSwitchMatrix(self, tileName: str, dest: Path):
        """Generates switch matrix for specified tile via 'genTileSwitchMatrix' defined
        in 'fabric_gen.py'.

        Parameters
        ----------
        tileName : str
            Name of the tile for which the switch matrix will be generated.
        """
        cg = CodeGenerator(dest, self.writerType)
        if tile := self.fabric.getTileByName(tileName):
            generateTileSwitchMatrix(cg, self.fabric, tile)
        else:
            raise ValueError(f"Tile {tileName} not found")

    def genTile(self, tileName: str, dest: Path):
        """Generates a tile based on its name via 'generateTile' defined in
        'fabric_gen.py'.

        Parameters
        ----------
        tileName : str
            Name of the tile generated.
        """
        cg = CodeGenerator(dest, self.writerType)
        if tile := self.fabric.getTileByName(tileName):
            generateTile(cg, self.fabric, tile)
        else:
            raise ValueError(f"Tile {tileName} not found")

    def genSuperTile(self, tileName: str, dest: Path):
        """Generates a super tile based on its name via 'generateSuperTile' defined in
        'fabric_gen.py'.

        Parameters
        ----------
        tileName : str
            Name of the super tile generated.
        """
        logger.warning("NOTE: SuperTile generation is not yet implemented")
        return
        if tile := self.fabric.getSuperTileByName(tileName):
            self.fabricGenerator.generateSuperTile(tile)
        else:
            raise ValueError(f"Tile {tileName} not found")

    def genFabric(self, dest: Path):
        """Generates the entire fabric layout via 'generatreFabric' defined in
        'fabric_gen.py'."""
        cg = CodeGenerator(dest, self.writerType)
        generateFabric(cg, self.fabric)

    def genGeometry(self, path: Path, geomPadding: int = 8):
        """Generates geometry based on the fabric data and saves it to CSV.

        Parameters
        ----------
        geomPadding : int, optional
            Padding value for geometry generation, by default 8.
        """
        self.geometryGenerator.generateGeometry(geomPadding)
        self.geometryGenerator.saveToCSV(path)

    def genTopWrapper(self, dest: Path):
        """Generates the top wrapper for the fabric via 'generateTopWrapper' defined in
        'fabric_gen.py'."""
        cg = CodeGenerator(dest, self.writerType)
        generateFabricTopWrapper(cg, self.fabric)

    def genBitStreamSpec(self):
        """Generates the bitsream specification object.

        Returns
        -------
        Object
            Bitstream specification object generated by 'fabricGenerator'.
        """
        specObject = generateBitsStreamSpec(self.fabric)
        return specObject

    def genRoutingModel(self):
        """Generates model for Nextpnr based on fabric data.

        Returns
        -------
        Object
            Model generated by 'model_gen_npnr.genNextpnrModel'.
        """
        return model_gen_npnr.genNextpnrModel(self.fabric)

    def getBels(self) -> list[Bel]:
        """Returns all unique Bels within a fabric.

        Returns
        -------
        Bel
            Bel object based on bel name.
        """
        return self.fabric.getAllUniqueBels()

    def getTile(self, tileName: str) -> Tile | None:
        """Returns Tile object based on tile name.

        Parameters
        ----------
            tileName : str
                Name of the Tile.

        Returns
        -------
        Tile
            Tile object based on tile name.
        """

        return self.fabric.getTileByName(tileName)

    def getTiles(self) -> list[Tile]:
        """Returns all Tiles within a fabric.

        Returns
        -------
        Tile
            Tile object based on tile name.
        """
        return list(self.fabric.tileDict.values())

    def getTilesNames(self) -> list[str]:
        """Returns all Tiles names within a fabric.

        Returns
        -------
        str
            Tile name.
        """
        return list(self.fabric.tileDict.keys())

    def getSuperTile(self, tileName: str) -> SuperTile | None:
        """Returns SuperTile object based on tile name.

        Parameters
        ----------
            tileName : str
                Name of the SuperTile.

        Returns
        -------
        SuperTile
            SuperTile object based on tile name.
        """

        return self.fabric.getSuperTileByName(tileName)

    def getSuperTiles(self):
        """Returns all SuperTiles within a fabric.

        Returns
        -------
        SuperTile
            SuperTile object based on tile name.
        """
        return self.fabric.superTileDict.values()

    def genChipDatabase(
        self,
        resultDir: Path,
        baseConstids: Path,
        dotDir: Path = Path(),
        selectTile: list[Loc] = [],
    ):
        """Generates a chip database using the provided result directory and base
        constant IDs.

        Args:
            resultDir (Path): The directory where the results will be stored.
            baseConstids (Path): The path to the base constant IDs.

        Returns:
            None
        """
        generateChipDatabase(self.fabric, resultDir, baseConstids, dotDir, selectTile)

    def genPrimsLib(self, result: Path):
        """Generates primitives library using the provided result path.

        Args:
            result (Path): The path where the generated primitives library will be saved.

        Returns:
            None
        """
        prims_gen(result, self.fabric)

    def gen_port_data(self):
        for i in self.fabric.tileDict.values():
            setupPortData(i.name, i.tileDir, i.ports, i.bels)

    def gen_synthFile(self, dest: Path):
        maps = set()
        libs = set()

        for b in self.fabric.getAllUniqueBels():
            destPath = Path(f"{b.src.parent}/metadata")
            if destPath.exists():
                for file in destPath.glob("cell_*.json"):
                    if file.is_file():
                        file.unlink()
            else:
                destPath.mkdir(parents=True, exist_ok=True)

        for b in self.fabric.getAllUniqueBels():
            destPath = Path(f"{b.src.parent}/metadata")
            genCellsAndMaps(b)
            genPrims(b, destPath / f"{b.name}/prim_{b.name}{b.src.suffix}")
            maps.update(Path(f"{b.src.parent}/metadata/{b.name}").glob("map_*.v"))
            libs.update(Path(f"{b.src.parent}/metadata/{b.name}").glob("prim_*.v"))

        genSynthScript(self.fabric, Path(f"{dest}/arch_synth.tcl"))
        mergeFiles(sorted(list(maps)), Path(f"{dest}/techmaps.v"))
        mergeFiles(sorted(list(libs)), Path(f"{dest}/libs.v"))
