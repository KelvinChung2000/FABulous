"""Generate the FABulous timing model for nextpnr.
This module provides functions to generate the timing model for a FABulous fabric,
including PIP descriptions, BEL descriptions, and constraint strings.
It supports generating timing models for specific tiles or all tiles in the fabric,
with options for deduplicated or duplicated tile usage.

TODO: add check for missing tiles in tile_names when repeat is False.
add warnings and errors for invalid tile names and missing files.
Dont overwrite existing timing model files without confirmation.
"""

import string
import pickle
from pathlib import Path
from loguru import logger

from FABulous.custom_exception import InvalidFileType, InvalidState
from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.parser.parse_switchmatrix import parseList, parseMatrix
from timing_model.StaConnInterface import TileTimingModelGenerator, DedublicatedNextpnrModel


# Utility functions for serializing and deserializing objects
# Save an object to a file using pickle
def load_obj(path: Path):
    with open(path, "rb") as f:
        return pickle.load(f)


def genNextpnrModel(fabric: Fabric, tile_names: str = "", repeat: bool = False, 
                    delay_model: DedublicatedNextpnrModel = None) -> tuple[str, str, str, str]:
    """
    Generate the nextpnr timing model for the given fabric.
    
    Parameters
    ----------
    fabric : Fabric
        The fabric object containing tile information.
    tile_names : str, optional
        Comma-separated names of tiles to include. If empty, include all tiles.
        E.g., "Tile_A,Tile_B". Default is "".
    repeat : bool, optional
        Whether to allow repeating tile names. Default is False.
        False means each tile name is used only once which is the deduplicated mode.
        True means tile names can be used multiple times which is the duplicated mode (standard).
    delay_model : DedublicatedNextpnrModel, optional
        An optional delay model to get delay values from.
        If None, default delay values are used. Default is None.
    
    Returns
    -------
    tuple[str, str, str, str]
        A tuple containing:
        - pipStr: The PIP descriptions as a string.
        - belStr: The BEL descriptions (old style) as a string.
        - belv2Str: The BEL descriptions (new style) as a string.
        - constrainStr: The constraint strings as a string.
    """
    
    pipStr = []
    belStr = []
    belv2Str = []
    belStr.append(
        f"# BEL descriptions: top left corner Tile_X0Y0,"
        f" bottom right Tile_X{fabric.numberOfColumns}Y{fabric.numberOfRows}"
    )
    belv2Str.append(
        f"# BEL descriptions: top left corner Tile_X0Y0, "
        f"bottom right Tile_X{fabric.numberOfColumns}Y{fabric.numberOfRows}"
    )
    constrainStr = []

    for y, row in enumerate(fabric.tile):
        for x, tile in enumerate(row):
            if tile is None:
                continue
            
            # Mechanism to only include specified tile names
            # If tile_names is not empty, only include tiles whose names are in tile_names
            # If repeat is False, mark found tile names to avoid duplicates
            # e.g., tile_names = "Tile_A,Tile_B"
            if tile_names != "":
                if tile.name not in tile_names:
                    continue
                if not repeat:
                    # mark as found
                    tile_names = tile_names.replace(tile.name, "found")  
            
            pipStr.append(f"#Tile-internal pips on tile X{x}Y{y}:")
            if tile.matrixDir.suffix == ".csv":
                connection = parseMatrix(tile.matrixDir, tile.name)
                for source, sinkList in connection.items():
                    for sink in sinkList:
                        
                        #############################################################
                        delay: float = 8
                        if delay_model is not None:
                            delay = delay_model.get_delay_value(tile.name, 
                            f"X{x}Y{y},{sink},X{x}Y{y},{source},{8},{sink}.{source}")  
                        #############################################################  
                            
                        pipStr.append(
                            f"X{x}Y{y},{sink},X{x}Y{y},{source},{delay},{sink}.{source}"
                        )
            elif tile.matrixDir.suffix == ".list":
                connection = parseList(tile.matrixDir)
                for sink, source in connection:
                    
                    #################################################################
                    delay: float = 8
                    if delay_model is not None:
                        delay = delay_model.get_delay_value(tile.name,
                        f"X{x}Y{y},{source},X{x}Y{y},{sink},{8},{source}.{sink}")
                    #################################################################
                        
                    pipStr.append(
                        f"X{x}Y{y},{source},X{x}Y{y},{sink},{delay},{source}.{sink}"
                    )
            else:
                raise InvalidFileType(
                    f"File {tile.matrixDir} is not a .csv or .list file"
                )

            pipStr.append(f"#Tile-external pips on tile X{x}Y{y}:")
            for wire in tile.wireList:
                xDst = x + wire.xOffset
                yDst = y + wire.yOffset
                if (not (0 <= xDst <= fabric.numberOfColumns)) or (
                    not (0 <= yDst <= fabric.numberOfRows)
                ):
                    raise InvalidState(
                        f"Wire {wire} in tile X{x}Y{y} points to an invalid tile "
                        f"X{xDst}Y{yDst}. "
                        "Please check your tile CSV file for unmatching wires/offsets!"
                    )
                
                #################################################################
                delay: float = 8
                if delay_model is not None:
                    delay = delay_model.get_delay_value(tile.name,
                    f"X{x}Y{y},{wire.source},"
                    f"X{x + wire.xOffset}Y{y + wire.yOffset},{wire.destination},"
                    f"{8},"
                    f"{wire.source}.{wire.destination}")
                #################################################################
                
                pipStr.append(
                    f"X{x}Y{y},{wire.source},"
                    f"X{x + wire.xOffset}Y{y + wire.yOffset},{wire.destination},"
                    f"{delay},"
                    f"{wire.source}.{wire.destination}"
                )

            # Old style bel definition
            belStr.append(f"#Tile_X{x}Y{y}")
            for i, bel in enumerate(tile.bels):
                belPort = bel.inputs + bel.outputs
                cType = bel.name
                if (
                    bel.name == "LUT4c_frame_config"
                    or bel.name == "LUT4c_frame_config_dffesr"
                ):
                    cType = "FABULOUS_LC"
                letter = string.ascii_uppercase[i]
                belStr.append(
                    f"X{x}Y{y},X{x},Y{y},{letter},{cType},{','.join(belPort)}"
                )

                if bel.name in [
                    "IO_1_bidirectional_frame_config_pass",
                    "InPass4_frame_config",
                    "OutPass4_frame_config",
                    "InPass4_frame_config_mux",
                    "OutPass4_frame_config_mux",
                ]:
                    constrainStr.append(
                        f"set_io Tile_X{x}Y{y}_{letter} Tile_X{x}Y{y}.{letter}"
                    )
            # New style bel definition
            belv2Str.append(f"#Tile_X{x}Y{y}")
            for i, bel in enumerate(tile.bels):
                cType = bel.name
                if (
                    bel.name == "LUT4c_frame_config"
                    or bel.name == "LUT4c_frame_config_dffesr"
                ):
                    cType = "FABULOUS_LC"
                letter = string.ascii_uppercase[i]
                belv2Str.append(f"BelBegin,X{x}Y{y},{letter},{cType},{bel.prefix}")

                for inp in bel.inputs:
                    belv2Str.append(
                        f"I,{inp.removeprefix(bel.prefix)},X{x}Y{y}.{inp}"
                    )  # I,<port>,<wire>
                for outp in bel.outputs:
                    belv2Str.append(
                        f"O,{outp.removeprefix(bel.prefix)},X{x}Y{y}.{outp}"
                    )  # O,<port>,<wire>
                for feat, _cfg in sorted(bel.belFeatureMap.items(), key=lambda x: x[0]):
                    belv2Str.append(f"CFG,{feat}")
                if bel.withUserCLK:
                    belv2Str.append("GlobalClk")
                belv2Str.append("BelEnd")
    return (
        "\n".join(pipStr),
        "\n".join(belStr),
        "\n".join(belv2Str),
        "\n".join(constrainStr),
    )

def write_tile_pips(project_dir: Path,
                    out_file: Path,
                    lib_corner_file: str,
                    techmaps: str,
                    tiehi_cell_and_port: str,
                    tielo_cell_and_port: str,
                    min_buf_cell_and_ports: str,
                    clk_freq_mhz: str ="40",
                    tiles: str = "All"):
    """
    Generate and write the timing models for specified tiles or all tiles in the fabric.
    
    Parameters
    ----------
    project_dir : Path
        The project directory containing the fabric.pkl file.
    out_file : Path
        The output file path to write the final PIP model.
    lib_corner_file : str
        The library corner file for timing analysis.
    techmaps : str
        The technology mapping files.
    tiehi_cell_and_port : str
        The tie-high cell and port information.
    tielo_cell_and_port : str
        The tie-low cell and port information.
    min_buf_cell_and_ports : str
        The minimum buffer cell and port information.
    clk_freq_mhz : str, optional
        The clock frequency in MHz. Default is "40".
    tiles : str, optional
        Comma-separated names of tiles or "All" for all tiles. Default is "All".
    """
    
    # Load the fabric object from the pickle file
    # This avoids re-parsing the fabric CSV file
    fabric: Fabric = load_obj(project_dir/"fabric.pkl")
    
    # Create a deduplicated nextpnr model to aggregate tile delays
    # This will be used to generate the final PIP model
    ddnpnr_model = DedublicatedNextpnrModel()
    
    # Get tile and supertile dictionaries
    tt = fabric.tileDic
    st = fabric.superTileDic
    
    # Remove tiles that are part of supertiles from the tile dictionary
    for t, v in st.items():
        for tile in v.tiles:
            tt.pop(tile.name, None)
    
    # Determine which tiles to process
    # If "All", process all tiles and supertiles
    if tiles == "All":
        tiles = ",".join(list(tt.keys()) + list(st.keys()))
    print(f"Generating timing models for tiles/supertile: {tiles}")

    for specified_tile in tiles.split(","):  
        # Check if the specified tile is a tile or a supertile
        if specified_tile in tt:
            tile = tt[specified_tile]
            
            # Generate timing model for the tile
            # Create timing model directory
            tm_dir = tile.tileDir.parent/"timing_model"
            tm_dir.mkdir(parents=True, exist_ok=True)
            
            # Generate PIP template for the tile
            # This is needed for the TileTimingModelGenerator
            pipStr, _, _, _ = genNextpnrModel(fabric, tile_names=tile.name)
            with open(tm_dir/"pips_template.txt", "w") as f:
                f.write(pipStr)
                
            ttmg = TileTimingModelGenerator(
                clk_freq_mhz=clk_freq_mhz,
                tiles_dir=f"{tile.tileDir.parent}",
                final_nl=f"{tile.tileDir.parent}/macro/final_views/nl/{tile.name}.nl.v",
                nom_spef=f"{tile.tileDir.parent}/macro/final_views/spef/nom/{tile.name}.nom.spef",
                output_dir=f"{tm_dir}",
                pips_file=f"{tm_dir}/pips_template.txt",
                top_name=f"{tile.name}",
                extra_verilog=f"{project_dir}/Fabric/*.v",
                lib_corner_file=lib_corner_file,
                techmaps=techmaps,
                tiehi_cell_and_port=tiehi_cell_and_port,
                tielo_cell_and_port=tielo_cell_and_port,
                min_buf_cell_and_ports=min_buf_cell_and_ports,
            )
            
            # Generate the timing model for the tile
            ttmg.generate()
            
            # Add the tile delay model to the deduplicated nextpnr model
            # This will be used to generate the final PIP model
            ddnpnr_model.add_tile_delay(tile.name, ttmg.delay_model)
        
        elif specified_tile in st:
            supertile = st[specified_tile]
            print(f"{supertile.name}:")
            for tile in supertile.tiles:
                print(f"  - {tile.name}: {tile.tileDir.parent.parent}")
                
                tm_dir = tile.tileDir.parent/"timing_model"
                tm_dir.mkdir(parents=True, exist_ok=True)
                pipStr, _, _, _ = genNextpnrModel(fabric, tile_names=tile.name)
                with open(tm_dir/"pips_template.txt", "w") as f:
                    f.write(pipStr)
                
                ttmg = TileTimingModelGenerator(
                clk_freq_mhz=clk_freq_mhz,
                tiles_dir=f"{tile.tileDir.parent.parent}",
                final_nl=f"{tile.tileDir.parent.parent}/macro/final_views/nl/{supertile.name}.nl.v",
                nom_spef=f"{tile.tileDir.parent.parent}/macro/final_views/spef/nom/{supertile.name}.nom.spef",
                output_dir=f"{tm_dir}",
                pips_file=f"{tm_dir}/pips_template.txt",
                top_name=f"{supertile.name}",
                extra_verilog=f"{project_dir}/Fabric/*.v",
                lib_corner_file=lib_corner_file,
                techmaps=techmaps,
                tiehi_cell_and_port=tiehi_cell_and_port,
                tielo_cell_and_port=tielo_cell_and_port,
                min_buf_cell_and_ports=min_buf_cell_and_ports,
            )   
            ttmg.generate()
            ddnpnr_model.add_tile_delay(tile.name, ttmg.delay_model)
                
        else:
            logger.warning(f"Tile or SuperTile '{specified_tile}' not found in fabric.")
            
    # Generate the final PIP model using the deduplicated nextpnr model
    # This will include delay values from the aggregated tile delays
    # Write the final PIP model to the specified output file
    final_pips, _, _, _ = genNextpnrModel(fabric, tile_names=ddnpnr_model.get_tiles_str, 
                                      repeat=True, delay_model=ddnpnr_model)
    
    with open(out_file, "w") as f:
        f.write(final_pips)
