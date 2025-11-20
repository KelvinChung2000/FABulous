#!/usr/bin/env python3

"""
Interface to generate timing model for a tile and Fabric using Tcl script and Nextpnr output.
This module provides classes to generate timing models for FPGA tiles and FPGA fabrics
using a Tcl script and to deduplicate timing models across multiple tiles.
It can also be used as a standalone script to call the Tcl script with the required parameters.
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

# Determine the directory of this script
# Handle cases where __file__ may not be defined
if '__file__' in globals():
    SCRIPT_DIR = Path(__file__).resolve().parent
else:
    SCRIPT_DIR = Path(sys.argv[0]).resolve().parent

class TileTimingModelGenerator:
    """Generates timing model for a tile using a Tcl script and Nextpnr output. 
    
    Attributes
    ----------
    tcl_script : str
        Path to the Tcl script to execute
    tclsh : str
        Path to tclsh executable
    clk_freq_mhz : str
        Clock frequency in MHz
    tiles_dir : str
        Directory with tiles
    final_nl : str
        Final netlist
    nom_spef : str
        Nominal SPEF
    output_dir : str
        Output directory
    pips_file : str
        PIPs file for a tile
    top_name : str
        Top module name
    extra_verilog : str
        Extra Verilog files directory
    lib_corner_file : str
        Liberty corner file
    techmaps : str
        Techmap files directory
    tiehi_cell_and_port : str
        e.g. TIEHI Y
    tielo_cell_and_port : str
        e.g. TIELO Y
    min_buf_cell_and_ports : str
        e.g. BUF_X1 A Y (A -> in Y -> out)
    """
        
    tcl_script = f"{SCRIPT_DIR}/flow.tcl"
    tclsh = "tclsh"
    clk_freq_mhz = ""         
    tiles_dir = ""             
    final_nl = ""               
    nom_spef = ""               
    output_dir = ""             
    pips_file = ""              
    top_name = ""               
    extra_verilog  = ""         
    lib_corner_file = ""        
    techmaps = ""               
    tiehi_cell_and_port = ""    
    tielo_cell_and_port = ""    
    min_buf_cell_and_ports = ""  
    
    
    def __init__(self, clk_freq_mhz: str, tiles_dir: str, final_nl: str,
                 nom_spef: str, output_dir: str, pips_file: str,
                 top_name: str, extra_verilog: str, lib_corner_file: str,
                 techmaps: str, tiehi_cell_and_port: str,
                 tielo_cell_and_port: str, min_buf_cell_and_ports: str,
                 tcl_script: str = f"{SCRIPT_DIR}/flow.tcl",
                 tclsh: str = "tclsh"):
        self.clk_freq_mhz = clk_freq_mhz
        self.tiles_dir = tiles_dir
        self.final_nl = final_nl
        self.nom_spef = nom_spef
        self.output_dir = output_dir
        self.pips_file = pips_file
        self.top_name = top_name
        self.extra_verilog = extra_verilog
        self.lib_corner_file = lib_corner_file
        self.techmaps = techmaps
        self.tiehi_cell_and_port = tiehi_cell_and_port
        self.tielo_cell_and_port = tielo_cell_and_port
        self.min_buf_cell_and_ports = min_buf_cell_and_ports
        self.tcl_script = tcl_script 
        self.tclsh = tclsh
        
        # if a field is empty, raise an error
        for field_name, value in self.__dict__.items():
            if value == "":
                raise ValueError(f"Missing required field: {field_name}")
        
    def generate(self):
        """Generates the timing model by calling the Tcl script with the provided parameters.
        
        Returns
        -------
        int
            The return code of the Tcl script execution.
        """
        
        tclsh = self.tclsh
        if os.path.sep not in tclsh:
            found = shutil.which(tclsh)
            if not found:
                raise FileNotFoundError(f"tclsh not found in PATH: {tclsh}")
            tclsh = found

        # Order is critical: a0..a12
        ordered = [
            self.clk_freq_mhz,           # a0
            self.tiles_dir,              # a1
            self.final_nl,               # a2
            self.nom_spef,               # a3
            self.output_dir,             # a4
            self.pips_file,              # a5
            self.top_name,               # a6
            self.extra_verilog,          # a7
            self.lib_corner_file,        # a8
            self.techmaps,               # a9
            self.tiehi_cell_and_port,    # a10
            self.tielo_cell_and_port,    # a11
            self.min_buf_cell_and_ports, # a12
        ]

        # Call tclsh: the Tcl script does `lassign $argv a0 ... a12` and then sets env(...)
        cmd = [tclsh, self.tcl_script] + ordered
        try:
            rc = subprocess.call(cmd)
            return rc
        except FileNotFoundError:
            raise FileNotFoundError(f"Tcl script not found: {self.tcl_script}")
    
    @property
    def result_file(self) -> str:
        """Returns the path to the result file containing the timing model.
        
        Returns
        -------
        str
            The path to the result file.
        """
        
        return f"{self.output_dir}/FINAL/{self.top_name}.pips_tm.txt"
    
    @property
    def delay_model(self) -> dict[str, float]:
        """Parses the result file and returns the delay model as a dictionary.
        
        Returns
        -------
        dict[str, float]
            The delay model dictionary.
            
            key: "\<top_name\>_t1,N1END0,[t1 or t2],S1BEG3,N1END0.S1BEG3"
            
            value: delay value in float
            
        Raises
        -------
        FileNotFoundError
            If the result file does not exist.
        """

        delay_model: dict[str, float] = {}
        result_path = self.result_file

        # error if file does not exist
        if not Path(result_path).is_file():
            raise FileNotFoundError(f"Result file not found: {result_path}")

        with open(result_path, "r") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                parts = [p.strip() for p in line.split(",")]
                
                # expect lines like:
                # X1Y0,N1END0,X1Y0,S1BEG3,0.145598,N1END0.S1BEG3
                if len(parts) != 6:
                    continue
                
                # key: "<top_name>_t1,N1END0,[t1 or t2],S1BEG3,N1END0.S1BEG3"
                # We do not care about the tile names, so we replace them with t1 or t2
                # in this way, we can deduplicate the timing model across tiles.
                # Mathematically this is valid since the delay between two PIPs
                # only depends on the source and sink PIPs, not on the tile they are in
                if parts[0] == parts[2]:
                    # same tile, use t1
                    parts[0] = "t1"
                    parts[2] = "t1"
                else:
                    # different tiles, use t2
                    parts[0] = "t1"
                    parts[2] = "t2"
                
                key_parts = [parts[0], parts[1],  parts[2], parts[3],  parts[5]]
                key = f"{self.top_name}_{','.join(key_parts)}"
                
                # Tiles are stitched -> no interconnect delay.
                # So if delay is "NONE", we set it to a small noise value.
                value: float = 0.000040 if parts[4] == "NONE" else float(parts[4])
                delay_model[key] = value

        return delay_model


class DedublicatedNextpnrModel:
    """
    Represents a deduplicated timing model for Nextpnr tiles.
    
    Attributes
    ----------
    tile_delay_dic : dict[str, float]
        A dictionary mapping deduplicated pip keys to their delay values.
    tiles: list[str]
        A list of tile names included in the model.
    tiles_str: str
        A comma-separated string of tile names.
    
    Methods
    -------
    deduplicate_pip(tile_name: str, pipStr: str) -> str
        Deduplicates the tile names in a pip string.   
    add_tile_delay(tile_name: str, tile_delay_model: dict[str, float])
        Adds a tile delay model to the overall model. 
    get_delay_value(tile_name: str, pipStr: str) -> float
        Retrieves the delay value for a given pip string in a specific tile.
    
    Properties
    ----------
    get_tiles : list[str]
        Returns the list of tile names.
    get_delay_model : dict[str, float]
        Returns the complete delay model dictionary.
    get_delay_model_size : int
        Returns the size of the delay model dictionary.
    get_tiles_str : str
        Returns the comma-separated string of tile names.
    """
    
    tile_delay_dic : dict[str, float]
    tiles: list[str]
    tiles_str: str
    
    def __init__(self):
        self.tile_delay_dic = {}
        self.tiles = []
        self.tiles_str = ""
    
    def deduplicate_pip(self, tile_name: str, pipStr: str) -> str:
        """
        Deduplicates the tile names in a pip string.
        
        Parameters
        ----------
        tile_name : str
            The name of the tile.
        pipStr : str
            The pip string in the format "TileName1,SourcePIP,TileName2,SinkPIP,Delay,SourcePIP.SinkPIP".
            Note: the Delay part is ignored in deduplication.
        
        Returns
        -------
        str
            The deduplicated pip key in the format "\<tile_name\>_t1,SourcePIP,[t1 or t2],SinkPIP,SourcePIP.SinkPIP".
        
        Raises
        -------
        ValueError
            If the pip string is not in the expected format.
        """
        
        # deduplicate tile name in pipStr
        parts = pipStr.split(",")
        if len(parts) != 6:
            raise ValueError(f"Invalid pip string: {pipStr}")
        if parts[0] == parts[2]:
            # same tile, use t1
            parts[0] = "t1"
            parts[2] = "t1"
        else:
            # different tiles, use t2
            parts[0] = "t1"
            parts[2] = "t2"
        
        key_parts = [parts[0], parts[1],  parts[2], parts[3],  parts[5]]
        key = f"{tile_name}_{','.join(key_parts)}"
        return key
    
    
    def add_tile_delay(self, tile_name: str, tile_delay_model: dict[str, float]):
        """
        Adds a tile delay model to the overall model.
        
        Parameters
        ----------
        tile_name : str
            The name of the tile.
        tile_delay_model : dict[str, float]
            The delay model dictionary for the tile.
        """
        
        # We are using a flat dictionary to store the deduplicated delay model
        # so we can simply update the main dictionary.
        self.tile_delay_dic.update(tile_delay_model)
        self.tiles.append(tile_name)
        self.tiles_str = ",".join(self.tiles)
    
    def get_delay_value(self, tile_name: str, pipStr: str) -> float:
        """
        Retrieves the delay value for a given pip string in a specific tile.
        
        Parameters
        ----------
        tile_name : str
            The name of the tile.
        pipStr : str
            The pip string in the format "TileName1,SourcePIP,TileName2,SinkPIP,Delay,SourcePIP.SinkPIP".
            Note: the Delay part is ignored in lookup.
        
        Returns
        -------
        float
            The delay value for the given pip string.
        """
        
        # Here we deduplicate the pip string to form the key
        # and look it up in the delay dictionary.
        # Later we can again duplicate the model again with this key.
        key = self.deduplicate_pip(tile_name, pipStr)
        if key not in self.tile_delay_dic:
            raise KeyError(f"Key not found in delay model: {key}")
        return self.tile_delay_dic[key]
    
    @property
    def get_tiles(self) -> list[str]:
        """
        Returns the list of tile names.
        
        Returns
        -------
        list[str]
            The list of tile names.
        """
        
        return self.tiles
    
    @property
    def get_delay_model(self) -> dict[str, float]:
        """
        Returns the complete delay model dictionary.
        
        Returns
        -------
        dict[str, float]
            The delay model dictionary.
        """
        
        return self.tile_delay_dic
    
    @property
    def get_delay_model_size(self) -> int:
        """
        Returns the size of the delay model dictionary.
        
        Returns
        -------
        int
            The size of the delay model dictionary.
        """
        
        return len(self.tile_delay_dic)
    
    @property
    def get_tiles_str(self) -> str:
        """
        Returns the comma-separated string of tile names.
        Returns
        -------
        str
            The comma-separated string of tile names.
            e.g. "TileA,TileB,TileC"
        """
        
        return self.tiles_str

# Can also be used as a standalone script to call tclsh with args.
# Usage: python StaConnInterface.py --clk_freq_mhz 40 ... (other args)   
def main():
    p = argparse.ArgumentParser(
        description="Parse options and call tclsh with 13 ordered args (a0..a12)."
    )
    # Where to find/what to run
    p.add_argument("--tcl_script", default=f"{SCRIPT_DIR}/flow.tcl", help="Path to the Tcl script to execute")
    p.add_argument("--tclsh", default="tclsh", help="Path to tclsh executable (default: tclsh)")

    # ---- options mapped to a0..a12 ----
    p.add_argument("--clk_freq_mhz", required=True, help="clock frequency in MHz")
    p.add_argument("--tiles_dir", required=True, help="directory with tiles")
    p.add_argument("--final_nl", required=True, help="final netlist")
    p.add_argument("--nom_spef", required=True, help="nominal SPEF")
    p.add_argument("--output_dir", required=True, help="output directory")
    p.add_argument("--pips_file", required=True, help="PIPs file for a tile")
    p.add_argument("--top_name", required=True, help="top module name")
    p.add_argument("--extra_verilog_files", action="append", default=[], help="extra Verilog files directory")
    p.add_argument("--lib_corner_file", required=True, help="Liberty corner file")
    p.add_argument("--techmap_files", action="append", default=[], help="techmap files directory")
    p.add_argument("--tiehi_cell_and_port", required=True, help="e.g. TIEHI Y")
    p.add_argument("--tielo_cell_and_port", required=True, help="e.g. TIELO Y")
    p.add_argument("--min_buf_cell_and_ports", required=True, help="e.g. BUF_X1 A Y (A -> in Y -> out)")

    args = p.parse_args()

    # Resolve tclsh
    tclsh = args.tclsh
    if os.path.sep not in tclsh:
        found = shutil.which(tclsh)
        if not found:
            p.error(f"tclsh not found in PATH: {tclsh}")
        tclsh = found

    # Normalize multi-value options into a single string argument
    pathsep = os.pathsep
    extra_verilog = pathsep.join(args.extra_verilog_files) if args.extra_verilog_files else ""
    techmaps = pathsep.join(args.techmap_files) if args.techmap_files else ""

    # Order is critical: a0..a12
    ordered = [
        args.clk_freq_mhz,           # a0
        args.tiles_dir,              # a1
        args.final_nl,               # a2
        args.nom_spef,               # a3
        args.output_dir,             # a4
        args.pips_file,              # a5
        args.top_name,               # a6
        extra_verilog,               # a7
        args.lib_corner_file,        # a8
        techmaps,                    # a9
        args.tiehi_cell_and_port,    # a10
        args.tielo_cell_and_port,    # a11
        args.min_buf_cell_and_ports, # a12
    ]

    # Call tclsh: the Tcl script does `lassign $argv a0 ... a12` and then sets env(...)
    cmd = [tclsh, args.tcl_script] + ordered
    try:
        rc = subprocess.call(cmd)
        sys.exit(rc)
    except FileNotFoundError:
        p.error(f"Tcl script not found: {args.tcl_script}")

if __name__ == "__main__":
    main()