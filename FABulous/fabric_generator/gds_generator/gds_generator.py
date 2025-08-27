# NEW: ORTOOLS installation needed (python -m pip install ortools)
#      matplotlib installation needed (python -m pip install -U pip; python -m pip install -U matplotlib)
# delete fab module in testbench (clk definition needed)

from FABulous.FABulous_API import FABulous_API
from FABulous.fabric_definition.define import IO
import FABulous.fabric_generator.gds_generator.netlist_rearrange as netListOpt
import FABulous.fabric_generator.gds_generator.pin_rearrange as pinOpt
import FABulous.fabric_generator.gds_generator.config as genConfig
import FABulous.fabric_generator.gds_generator.general as generalFunctions
from FABulous.fabric_definition.define import Side
from dataclasses import dataclass
from operator import attrgetter
from collections import Counter
from typing import List
from pathlib import Path
import subprocess as sp
import logging
import os
import re
import shutil
import configparser


# storing tiles to generate
@ dataclass
class tileOpenLane():
    name: str
    height: int
    width: int
    locationX: int
    locationY: int
    isSuperTile: bool
    subTiles: list


# logger
logger = logging.getLogger(__name__)
logging.basicConfig(
    format="[%(levelname)s]-%(asctime)s - %(message)s", level=logging.INFO)


class gdsGenerator():
    # flow config variables
    macroConfig = {}
    coreConfig = []
    ol_run_name = "auto_run"
    fabulousRunName = "eFPGA"
    ramName = "BlockRAM_1KB"
    configPath = 'automated_config.ini'
    openlaneDir = ""
    starterTile = ""
    mostCommonTile = ""
    projectDir = ""
    pdkPath = ""
    ramGenerate = False
    optFlag = False
    generateRTL = False
    coreOnly = False
    iterations = 1
    standardTileSize = 37
    terminateTilesHeight = 200
    targetDensity = 80
    densitySteps = 2
    marginFab = 100
    marginTiles = 40
    marginFabCore = 10
    marginRAM = 100
    ramHeight = 446.23  # demo RAM (1KB)
    ramWidth = 600      # demo RAM (1KB)
    densityChange = False

    gridSizeMet2 = 0.46 
    gridSizeMet3 = 0.68 
    marginMet2 =  0.23
    marginMet3 = 0.34
    pinWidth = 0.3
    pinDepth = 1.5

    # CSV map
    fabricGen: FABulous_API
    allTile = []
    tilesToGenerateOL = []
    fabricTileMap = []
    tilePinOrderPos = {}
    fixedTiles = []

    def getSupertileName(self, tileName):
        name = ""
        for superTile in self.fabricGen.fabric.superTileDic:
            for subTile in self.fabricGen.fabric.superTileDic[superTile].tiles:
                if subTile.name == tileName:
                    name = superTile
        return name
    
    def getSubTileNames(self, tileName):
        names = []
        for subTile in self.fabricGen.fabric.superTileDic[tileName].tiles:
            names.append(subTile.name)
        return names



    def __init__(self, shell, args, fabricGen, allTile, csvFile, projectDir):
        self.fabricGen = fabricGen
        self.allTile = allTile
        self.projectDir = projectDir
        fabricDims = []
        fabricDims = [[], []]

        with open(csvFile, 'r') as f:
            file = f.read()
            file = re.sub(r"#", "", file)
            f.close()
        if fabricDescription := re.search(
                r"FabricBegin(.*?)FabricEnd", file, re.MULTILINE | re.DOTALL):
            fabricDescription = fabricDescription.group(1)
        else:
            raise ValueError('Cannot find FabricBegin and FabricEnd in csv file')

        # check if config file exists
        if not Path(self.configPath).is_file():
            genConfig.generateAutoConfig(self.configPath)
            raise ValueError('Configuration file for automated flow was not generated. It is now generated automatically. Please check the configuration file and rerun again.')

        # Automated flow configuration
        config = configparser.ConfigParser()
        config.optionxform = str
        config.read(self.configPath)

        # check for sections, their necessary options and read configuration
        if not config.has_section("General"):
            raise ValueError(f"Define [General] section in {self.configPath}")
        if not config.has_section("OpenLaneMacro_DEFAULT"):
            raise ValueError(f"Define [OpenLaneMacro_DEFAULT] section in {self.configPath}")
        if not config.has_section("OpenLaneCore"):
            raise ValueError(f"Define [OpenLaneCore] section in {self.configPath}")
        if not config.has_section("Dimensions"):
            raise ValueError(f"Define [Dimensions] section in {self.configPath}")
        if not config.has_option("General", "OpenLane_path"):
            raise ValueError(f"Define OpenLane_path in [General] section in {self.configPath}")
        self.openlaneDir = config['General']['OpenLane_path']
        if not config.has_option("General", "PDKPath"):
            raise ValueError(f"Define PDKPath in [General] section in {self.configPath}, for demo RAM placement")
        if not config.has_option("General", "TargetDensityStart"):
            logger.warning(f"You can define TargetDensityStart in [General] section in {self.configPath}")
        else:
            self.targetDensity = float(config['General']['TargetDensityStart'])
        if not config.has_option("General", "TerminateTilesStartHeight"):
            logger.warning(f"You can define TerminateTilesStartHeight in [General] section in {self.configPath}")
        else:
            self.terminateTilesHeight = int(config['General']['TerminateTilesStartHeight'])
        if config.has_option("General", "RAMEnable"):
            self.ramGenerate = config['General'].getboolean('RAMEnable')
        if config.has_option("General", "MarginRAM"):
            self.marginRAM = int(config['General']['MarginRAM'])
        if config.has_option("General", "DensityStepsPercent"):
            self.densitySteps = int(config['General']['DensityStepsPercent']) 
        if config.has_option("General", "ResizeDensity"):
            self.densityChange = config['General'].getboolean('ResizeDensity')
        self.pdkPath = config['General']['PDKPath']
        if config.has_option("General", "GridSizeMet2"):
            self.gridSizeMet2 = float(config['General']['GridSizeMet2'])
        if config.has_option("General", "GridSizeMet3"):
            self.gridSizeMet3 = float(config['General']['GridSizeMet3'])
        if config.has_option("General", "MarginMet2"):
            self.marginMet2 = float(config['General']['MarginMet2'])
        if config.has_option("General", "MarginMet3"):
            self.marginMet3 = float(config['General']['MarginMet3'])
        if config.has_option("General", "PinWidth"):
            self.pinWidth = float(config['General']['PinWidth'])
        if config.has_option("General", "PinDepth"):
            self.pinDepth = float(config['General']['PinDepth'])

        # Parse tilemap and fill dimension with standard values
        fabricDescription = fabricDescription.split("\n")
        for f in fabricDescription:
            lineTemp = f.split(",")
            lineTemp = ' '.join(lineTemp).split()
            if lineTemp:
                self.fabricTileMap.append(lineTemp)

        for tileRow in self.fabricTileMap:
            for tileColumn in tileRow:
                # fabricDims[0]: X-Axis; fabricDims[1]: Y-Axis
                fabricDims[0].append(self.standardTileSize)
                fabricDims[1].append(self.standardTileSize)
        fabricDims = list(list(map(int, fabricDims[0]))), list(list(map(int, fabricDims[1])))

        # tiles to generate and add info
        tilesToGenerateOL = []
        tileNameBuffer = []
        for rowCount, tileRow in enumerate(self.fabricTileMap):
            for columnCount, tileColumn in enumerate(tileRow):
                superTileName = self.getSupertileName(tileColumn)
                if superTileName:
                    if superTileName not in tileNameBuffer:
                        tilesToGenerateOL.append(tileOpenLane(superTileName, fabricDims[1][rowCount], fabricDims[0][columnCount], columnCount, rowCount, True, self.getSubTileNames(superTileName)))
                        tileNameBuffer.append(superTileName)
                elif tileColumn not in tileNameBuffer:
                    tilesToGenerateOL.append(tileOpenLane(tileColumn, fabricDims[1][rowCount], fabricDims[0][columnCount], columnCount, rowCount, False, []))
                    tileNameBuffer.append(tileColumn)
        self.tilesToGenerateOL = tilesToGenerateOL

        # find and place starter tile on top of generate tile list
        mostCommonTile = Counter(tileNameBuffer)
        self.mostCommonTile = mostCommonTile.most_common(1)[0][0]

        if config.has_option("General", "StarterTile"):
            self.starterTile = config['General']['StarterTile']
        else:
            self.starterTile = self.mostCommonTile
            logger.warning("Starter Tile for resizing not defined. This could lead to a significant computing time increase. The most occuring tile will be taken.")

        starterTileFound = False
        foundAt = int
        for index, tile in enumerate(self.tilesToGenerateOL):
            if tile.name == self.starterTile:
                starterTileFound = True
                foundAt = index
        if starterTileFound:
            self.tilesToGenerateOL[0], self.tilesToGenerateOL[foundAt] = self.tilesToGenerateOL[foundAt], self.tilesToGenerateOL[0]
        else:
            logger.error(f"Starter tile {self.starterTile} does not exist. Check spelling.")

        # resize flow config
        if config.has_option("General", "ResizeTilesOptimizations"):
            self.optFlag = config['General'].getboolean('ResizeTilesOptimizations')
            if self.optFlag: 
                logger.info("Automatic resizing optimization flow of the tiles enabled")

        # Dimensions Config
        if config.has_option("Dimensions", "StarterTileWidth"):
            self.tilesToGenerateOL[0].width = int(config['Dimensions']["StarterTileWidth"])
        if config.has_option("Dimensions", "StarterTileHeight"):
            self.tilesToGenerateOL[0].height = int(config['Dimensions']["StarterTileHeight"])
        tileFound = False
        for dim in config["Dimensions"]:
            if "_Width" in dim:
                dimName = dim.removesuffix('_Width')
                for index, tile in enumerate(self.tilesToGenerateOL):
                    if tile.name == dimName:
                        tileFound = True
                        foundAt = index
                    if tileFound:
                        self.tilesToGenerateOL[foundAt].width = int(config['Dimensions'][dim])
                        tileFound = False

        # Config margins core
        if config.has_option("General", "ResizeOptimizationsIterations"):
            self.iterations = int(config['General']['ResizeOptimizationsIterations'])
        if config.has_option("General", "MarginTiles"): 
            self.marginTiles = int(config['General']['MarginTiles'])
        if config.has_option("General", "MarginFab"): 
            self.marginFab = int(config['General']['MarginFab'])
        if config.has_option("General", "MarginFabCore"): 
            self.marginFabCore = int(config['General']['MarginFabCore'])
        if config.has_option("General", "OpenLaneRunName"):
            self.ol_run_name = config['General']['OpenLaneRunName'] 
        if config.has_option("General", "FABulousRunName"):
            self.fabulousRunName = config['General']['FABulousRunName'] 
        if config.has_option("General", "GenerateRTL"): 
            self.generateRTL = config['General'].getboolean('GenerateRTL') 
        if config.has_option("General", "CoreOnly"): 
            self.coreOnly = config['General'].getboolean('CoreOnly') 
        
        # OpenLane macro Specified and DEFAULT Config
        tilesConfig = config.sections()
        for tileConfig in tilesConfig:
            if "OpenLaneMacro_" in tileConfig:
                self.macroConfig[tileConfig.removeprefix("OpenLaneMacro_")] = config[tileConfig]
        # OpenLane Core Config
        self.coreConfig = config["OpenLaneCore"]

        # execute FABulous flow for RTL generation
        if self.generateRTL:
            shell.do_load_fabric()
            shell.do_gen_all_tile()
            shell.do_gen_fabric()
            shell.do_gen_top_wrapper()

    def getSupertileClock(self, tileName):
        clock = False
        clock = self.fabricGen.fabric.superTileDic[tileName].withUserCLK
        if not clock:
            for tile in self.fabricGen.fabric.superTileDic[tileName].tiles:
                if not clock:
                    clock = self.fabricGen.fabric.getTileByName(tile.name).getUserCLK()
        return clock

    # generate pin_order.cfg
    def generate_pin_order_config(self, tileName, tileLocationX, tileLocationY, isSuperTile):
        portOrder = {}
        externalPorts = []

        if isSuperTile:
            currentTile = self.fabricGen.fabric.getSuperTileByName(tileName)

            # check for external ports
            ports, withUserCLK = currentTile.getExternalTileIONames()

            # handle tile ports and their cardinal position depending on tile position on tilemap
            for tilePosition in ports:   
                x, y = tilePosition.split(",")
                for port in ports[tilePosition]:
                    if port.sideOfTile == Side.NORTH:
                        portOrder[f"Tile_X{x}Y{y}_" + port.name] = "Top"
                    elif port.sideOfTile == Side.SOUTH:
                        portOrder[f"Tile_X{x}Y{y}_" + port.name] = "Bottom"
                    elif port.sideOfTile == Side.WEST:
                        portOrder[f"Tile_X{x}Y{y}_" + port.name] = "Left"
                    elif port.sideOfTile == Side.EAST:
                        portOrder[f"Tile_X{x}Y{y}_" + port.name] = "Right"
            
            # User Clock, FrameStrobe
            portOrder[f"Tile_X{0}Y{0}_" + "FrameStrobe_O"] = "Top"
            portOrder[f"Tile_X{0}Y{len(withUserCLK) - 1}_" + "FrameStrobe"] = "Bottom"
            if any(withUserCLK):
                portOrder[f"Tile_X{0}Y{0}_" + "UserCLKo"] = "Top"
                portOrder[f"Tile_X{0}Y{len(withUserCLK) - 1}_" + "UserCLK"] = "Bottom" 
            # Frame Data
            for index, clk in enumerate(withUserCLK):   
                portOrder[f"Tile_X{0}Y{index}_" + "FrameData_O"] = "Right"
                portOrder[f"Tile_X{0}Y{index}_" + "FrameData"] = "Left"
        else:
            withUserCLK = True
            currentTile = self.fabricGen.fabric.getTileByName(tileName)

            # check for external ports
            externalBEL = currentTile.getExternalTileIONames()
            for i in externalBEL:
                externalPorts.extend(i.externalOutput)
                externalPorts.extend(i.externalInput)
            if externalBEL:
                withUserCLK = max(externalBEL, key=attrgetter('withUserCLK')).withUserCLK

            # User Clock
            if not withUserCLK:
                withUserCLK = currentTile.getUserCLK()
            
            # handle tile ports and their cardinal position depending on tile position on tilemap
            portsObj = currentTile.getNorthSidePorts()
            for port in portsObj:
                portOrder[port.name] = "Top"
            portOrder["FrameStrobe_O"] = "Top"
        
            if tileLocationY == 0 and externalPorts and tileLocationX != 0:
                for port in externalPorts:
                    portOrder[port] = "Top"
            if withUserCLK:
                portOrder["UserCLKo"] = "Top"

            portsObj = currentTile.getSouthSidePorts()
            for port in portsObj:
                portOrder[port.name] = "Bottom"
            portOrder["FrameStrobe"] = "Bottom"

            if tileLocationY == max(self.tilesToGenerateOL, key=attrgetter('locationY')).locationY and externalPorts and tileLocationX != max(self.tilesToGenerateOL, key=attrgetter('locationY')).locationY:
                for port in externalPorts:
                    portOrder[port] = "Bottom"
            if withUserCLK:
                portOrder["UserCLK"] = "Bottom"

            portsObj = currentTile.getEastSidePorts()
            for port in portsObj:
                portOrder[port.name] = "Right"
                
            #if not cornerPos and (ioPos not in ["Top", "Bottom"]): 
            portOrder["FrameData_O"] = "Right"
            if tileLocationX == max(self.tilesToGenerateOL, key=attrgetter('locationX')).locationX and externalPorts:
                for port in externalPorts:
                    portOrder[port] = "Right"

            portsObj = currentTile.getWestSidePorts()
            for port in portsObj:
                portOrder[port.name] = "Left"

            #if not cornerPos and (ioPos not in ["Top", "Bottom"]): 
            portOrder["FrameData"] = "Left"
            if tileLocationX == 0 and externalPorts and tileLocationY != 0:
                for port in externalPorts:
                    portOrder[port] = "Left"

        return portOrder, externalPorts

    def parse(self, line: str) -> List[str]:
        return line.split()

    # shrink or enlarge tile area depending on last run / iteration
    def resizeTile(self, tileID: int, tileEnlargePrevious: bool, tileEnlargeCurrent: bool, firstRun: bool, resize: str):  #indexTile, True, False, False, resizeDim
        fixedOrderComplete = False
        if firstRun:
            firstRun = False
            tileEnlargePrevious = tileEnlargeCurrent
            if tileEnlargePrevious:
                # make tile larger
                if resize == 'Both':
                    self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height + 1
                    self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width + 1
                elif resize == 'Width':
                    self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width + 1
                elif resize == 'Height':
                    self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height + 1
            else:
                # make tile smaller
                if resize == 'Both':
                    self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height - 1
                    self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width - 1
                elif resize == 'Width':
                    self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width - 1
                elif resize == 'Height':
                    self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height - 1
        else:
            # revert last changes
            if tileEnlargePrevious != tileEnlargeCurrent:
                fixedOrderComplete = True
                if tileEnlargePrevious:
                    if resize == 'Both':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width       # BIGMARK 
                    elif resize == 'Width':
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width
                    elif resize == 'Height':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height
                else:
                    if resize == 'Both':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height + 1
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width + 1
                    elif resize == 'Width':
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width + 1
                    elif resize == 'Height':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height + 1
                tileEnlargePrevious = False 
            # keep on increasing / decreasing size
            else:
                if tileEnlargePrevious:
                    if resize == 'Both':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height + 1
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width + 1
                    elif resize == 'Width':
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width + 1
                    elif resize == 'Height':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height + 1
                else:
                    if resize == 'Both':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height - 1
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width - 1
                    elif resize == 'Width':
                        self.tilesToGenerateOL[tileID].width = self.tilesToGenerateOL[tileID].width - 1
                    elif resize == 'Height':
                        self.tilesToGenerateOL[tileID].height = self.tilesToGenerateOL[tileID].height - 1
        return fixedOrderComplete, tileEnlargePrevious, firstRun

    # find min size of a tile with optimizations
    def resizeTileOptFlow(self, indexTile, prevPinDistances, resizeDim, ioPos, pinOrderChange, cornerPos, lastTermLoop):
        logger.info("----------------------------------------------------")
        logger.info(f"CURRENT TILE NAME: {self.tilesToGenerateOL[indexTile].name}")
        logger.info("----------------------------------------------------")
        logger.info("Generating tiles in OpenLane flow with tile resizing and start sizes defined in 'automated_config.ini'")
        fixedOrderComplete = False
        tileEnlarge = False
        firstRun = True
        tileName = self.tilesToGenerateOL[indexTile].name
        openlane_nix = f"cd {self.openlaneDir}; nix-shell shell.nix"
        currentTileDensity = self.targetDensity
        densityManipulated = False

        # write logfile for tile
        logFile = f"{self.openlaneDir}/designs/{tileName}/iteration_resize_log.txt"
        generalFunctions.writeLog([f"Resize {tileName} \n"], logFile, "w")

        synthesisFile = f"{self.openlaneDir}/designs/{tileName}/src/{tileName}.v"

        generalFunctions.writeLog(["Start resizing without optimizations \n"], logFile, "a")
        logger.info("Start resizing without optimizations")

        combinDict = {}
        pinDistance = {}
        pinDistanceTemp = {}
        pinOrderChangeTile = {}
        pinOrderChangeTile = pinOrderChange 

        # which side the pins are placed on and fix order based on prev Tile
        pinSides, externUnused = self.generate_pin_order_config(self.tilesToGenerateOL[indexTile].name, self.tilesToGenerateOL[indexTile].locationX, self.tilesToGenerateOL[indexTile].locationY, self.tilesToGenerateOL[indexTile].isSuperTile)
        initCombinDict = generalFunctions.initialRunCombinDict(synthesisFile, self.fabricGen.fabric.frameBitsPerRow, self.fabricGen.fabric.maxFramesPerCol, pinSides, self.tilesToGenerateOL[indexTile].isSuperTile) 
        combinDict, pinOrderChangeRun = generalFunctions.fixUpdateOrder("", initCombinDict, pinOrderChange, resizeDim, ioPos, cornerPos, lastTermLoop)

        # shrink tile as far as possible without optimizations
        while not fixedOrderComplete:
            generalFunctions.writeLog([f"Current Height:{self.tilesToGenerateOL[indexTile].height} ; Current Width:{self.tilesToGenerateOL[indexTile].width} ; Current Density: {currentTileDensity}\n "], logFile, "a")
            logger.info(f"Current Height:{self.tilesToGenerateOL[indexTile].height} --- Current Width:{self.tilesToGenerateOL[indexTile].width} --- Current Density: {currentTileDensity}")
            # config
            logger.info(f"Generate OpenLane config files for tile: {self.tilesToGenerateOL[indexTile].name}")
            genConfig.generate_OpenLane_config(self.openlaneDir, self.tilesToGenerateOL[indexTile], self.macroConfig, True, currentTileDensity)

            # edit ioplacer.tcl
            logger.info("Define pinorder in ioplacer.tcl")
            if resizeDim == "Height" and cornerPos:
                pinDistanceTemp, notEnoughPinArea = genConfig.ioPlace(self.tilesToGenerateOL[indexTile], combinDict, self.openlaneDir, prevPinDistances, resizeDim, cornerPos, self.tilesToGenerateOL[indexTile].isSuperTile, len(self.tilesToGenerateOL[indexTile].subTiles), self.marginTiles, self.gridSizeMet2, self.gridSizeMet3, self.marginMet2, self.marginMet3, self.pinWidth, self.pinDepth)
            else:
                pinDistanceTemp, notEnoughPinArea = genConfig.ioPlace(self.tilesToGenerateOL[indexTile], combinDict, self.openlaneDir, prevPinDistances, resizeDim, ioPos, self.tilesToGenerateOL[indexTile].isSuperTile, len(self.tilesToGenerateOL[indexTile].subTiles), self.marginTiles, self.gridSizeMet2, self.gridSizeMet3, self.marginMet2, self.marginMet3, self.pinWidth, self.pinDepth)

            if notEnoughPinArea:
                tileEnlargeCurrent = True
                densitySuggest = False
            else:
                # run openlane flow on the tiles
                logger.info(f"Start OpenLane flow for tile: {tileName}")
                tile_command = f"openlane {self.openlaneDir}/designs/{tileName}/config.json --run-tag {self.ol_run_name} --overwrite"
                proc = sp.Popen(openlane_nix + " --run \"" + tile_command + "\"", shell=True, stdin=sp.PIPE, stdout=sp.PIPE, encoding='utf8')
                proc.communicate()
                proc.stdout.close()
                proc.terminate()
                logger.info(f"OpenLane flow for {tileName} complete.")

                # check for errors
                tileEnlargeCurrent, densitySuggest = generalFunctions.check_flow(self.openlaneDir, tileName, False, logger, self.ol_run_name)

            if densitySuggest:
                f = open(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/23-openroad-globalplacementskipio/openroad-globalplacementskipio.log")
                data = f.readlines()
                f.close()
                searchLine = "Suggested target density:"
                for line in data:
                    if searchLine in line: 
                        currentTileDensity = float(line[26:])

            if not tileEnlargeCurrent:
                generalFunctions.copyAndOverwrite(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}",
                                                  f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}_temp_success")
                shutil.copyfile(f"{self.openlaneDir}/openlane/scripts/openroad/ioplacer.tcl", f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}_temp_success/ioplacer.tcl")
                pinDistance = pinDistanceTemp
                densityManipulated = False

            # Supertile only basically. Run only one time and no resizing if too small keep increasing
            if not resizeDim:
                fixedOrderComplete = True
            else:
                # shrink / enlarge tile area
                fixedOrderComplete, tileEnlarge, firstRun = self.resizeTile(indexTile, tileEnlarge, tileEnlargeCurrent, firstRun, resizeDim)
            # if fixed order complete increase density and try to rerun
            # TODO
            #if resizeDim and fixedOrderComplete and not densityManipulated and currentTileDensity <= (1 - self.densitySteps) and not tileEnlarge and self.densityChange:
            #    densityManipulated = True
            #    fixedOrderComplete = False
            #    firstRun = True
            #    currentTileDensity += self.densitySteps
            #    currentTileDensity = round(currentTileDensity, 2)
            #    pinDistance = pinDistanceTemp
            #elif (currentTileDensity != self.targetDensity and densityManipulated):
            #    currentTileDensity -= self.densitySteps
            #    currentTileDensity = round(currentTileDensity, 2)
            #    self.resizeTile(indexTile, True, False, False, resizeDim) 
            #    fixedOrderComplete = True
        if resizeDim:
            generalFunctions.copyAndOverwrite(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}_temp_success",
                                              f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}")
            shutil.copyfile(f"{self.openlaneDir}/openlane/scripts/openroad/ioplacer.tcl", f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/ioplacer.tcl")
        logger.info(f"Optimization free resizing for tile {tileName} finished")
        generalFunctions.writeLog([f"Finished Height:{self.tilesToGenerateOL[indexTile].height} ; Finished Width:{self.tilesToGenerateOL[indexTile].width} ; Finished Density:{currentTileDensity}\n",
                                   "----------------------------------------------------------------------------------------------------- \n"], logFile, "a")

        notSuccessRun = False
        logger.info(f"Start optimizing pinorder and netlist for {tileName} for {self.iterations} iterations")
        generalFunctions.writeLog(["Start resizing with optimizations \n"], logFile, "a")

        # shrink tile as far as possible with optimizations (not supported for IO Tiles yet)
        firstRun = True
        superColumn = False
        failCounter = 0
        if self.tilesToGenerateOL[indexTile].isSuperTile:
            superColumn = True
        if resizeDim and not ioPos and self.optFlag:
            try:
                os.makedirs(f"{self.openlaneDir}/designs/{tileName}/statistics")
            except OSError:
                pass

            for i in range(self.iterations):
                logger.info(f"Pin and netlist rearrange iteration: {i+1}")

                # shrink because previous shrink run was successfull
                if not notSuccessRun:
                    failCounter = 0
                    # save previous run
                    generalFunctions.copyAndOverwrite(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}",
                                     f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}_temp_success")
                    shutil.copyfile(f"{self.openlaneDir}/openlane/scripts/openroad/ioplacer.tcl", f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}_temp_success/ioplacer.tcl")
                    pinDistance = pinDistanceTemp
                    pinOrderChangeTile = pinOrderChangeRun

                    # shrink
                    self.resizeTile(indexTile, False, False, False, resizeDim)
                    generalFunctions.writeLog([f"Current Height:{self.tilesToGenerateOL[indexTile].height} ; "
                                               f"Current Width:{self.tilesToGenerateOL[indexTile].width} ;"
                                               f"Current Density:{currentTileDensity}  [Try: shrink] \n"],
                                               logFile, "a")
                    logger.info(f"Current Height:{self.tilesToGenerateOL[indexTile].height} --- Current Width:{self.tilesToGenerateOL[indexTile].width} --- Current Density: {currentTileDensity} [Try: shrink]")

                    # move initial def and synthesis file
                    defFile = f"{self.openlaneDir}/designs/{tileName}/{tileName}.def"
                    synthesisFile = f"{self.openlaneDir}/designs/{tileName}/{tileName}.nl.v"
                    shutil.copyfile(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/final/def/{tileName}.def", defFile)
                    shutil.copyfile(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/final/nl/{tileName}.nl.v", synthesisFile)

                    portPairs, noConnection = generalFunctions.generate_pin_pairs(synthesisFile, self.fabricGen, tileName)

                    # netlist rearrangment 
                    logger.info(f"start rearrange netlist for tile {tileName}")
                    nOpt = netListOpt.netListRearrange(defFile, synthesisFile, f"{self.projectDir}/Tile/{tileName}/{tileName}_ConfigMem")
                    nOpt.plotIteration(f"{self.openlaneDir}/designs/{tileName}/statistics/iteration_{i}")
                    nOpt.ConfigBitoptimizationWithAssignment()
                    nOpt.rewire_tile_netlist()

                    synthesisFile = f"{self.openlaneDir}/designs/{tileName}/{tileName}.synthesis.opt.v"  
                    
                    logger.info(f"start rearrange pins for tile {tileName}")
                    placement = pinOpt.placementRearrange(defFile, synthesisFile, f"{self.openlaneDir}/designs/{tileName}", pinSides, portPairs)
                    swapTable = placement.arrangePinPlacement(noConnection)
                    layerTable = placement.arrangePinLayer(swapTable)

                    # reset to first run state
                    firstRun = True

                    # prepare the pin combination dictionary
                    combinDict = {}
                    side = ["Top", "Bottom", "Left", "Right"]
                    for i in side:
                        l = {}
                        for j in range(1, 6):
                            l[j] = []
                        combinDict[i] = l

                    # put all the data into a single dictionary order by side
                    for p in placement.allPin:
                        layer = 0
                        for i in layerTable:
                            if p in layerTable[i]:
                                layer = i
                                break
                        if placement.allPin[p]["side"] in side:
                            combinDict[placement.allPin[p]["side"]][layer].append(p)

                    # keep initial order for not resized sides and take new calculated ones for resized sides 
                    combinDict, pinOrderChangeRun = generalFunctions.fixUpdateOrder(combinDict, initCombinDict, pinOrderChange, resizeDim, ioPos, "", False)

                    # generate new config file without pinorder.cfg and with synthesis source
                    logger.info("Generate new config file")
                    logger.info(f"Generate OpenLane config files for tile: {self.tilesToGenerateOL[indexTile].name}")
                    genConfig.generate_OpenLane_config(self.openlaneDir, self.tilesToGenerateOL[indexTile], self.macroConfig, False, currentTileDensity)

                    # edit ioplacer.tcl
                    logger.info("Define pinorder in ioplacer.tcl")
                    pinDistanceTemp, notEnoughPinArea = genConfig.ioPlace(self.tilesToGenerateOL[indexTile], combinDict, self.openlaneDir, prevPinDistances, resizeDim, ioPos, self.tilesToGenerateOL[indexTile].isSuperTile, len(self.tilesToGenerateOL[indexTile].subTiles), self.marginTiles, self.gridSizeMet2, self.gridSizeMet3, self.marginMet2, self.marginMet3, self.pinWidth, self.pinDepth)

                    if notEnoughPinArea:
                        notSuccessRun = True
                        densitySuggest = False
                    else:
                        # run openlane flow on the tiles
                        logger.info(f"Start OpenLane flow for tile: {tileName}")
                        tile_command = f"openlane {self.openlaneDir}/designs/{tileName}/config.json --run-tag {self.ol_run_name} --overwrite"
                        proc = sp.Popen(openlane_nix + " --run \"" + tile_command + "\"", shell=True, stdin=sp.PIPE, stdout=sp.PIPE, encoding='utf8')
                        proc.communicate()
                        proc.stdout.close()
                        proc.terminate()
                        logger.info(f"OpenLane flow for {tileName} complete.")
                        # check for errors
                        notSuccessRun, densitySuggest = generalFunctions.check_flow(self.openlaneDir, tileName, False, logger, self.ol_run_name)

                    if densitySuggest:
                        f = open(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/23-openroad-globalplacementskipio/openroad-globalplacementskipio.log")
                        data = f.readlines()
                        f.close()
                        searchLine = "Suggested target density:"
                        for line in data:
                            if searchLine in line: 
                                currentTileDensity = float(line[26:])

                # re-run with same sizes because previous shrink run was unsuccessfull
                else:
                    failCounter += 1
                    if failCounter == 2:
                        currentTileDensity += self.densitySteps
                    # take temporary unfinished flow '.def'
                    defFile = f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/33-openroad-detailedplacement/{tileName}.def"
                    synthesisFile = f"{self.openlaneDir}/designs/{tileName}/{tileName}.synthesis.opt.v"

                    generalFunctions.writeLog([f"Current Height:{self.tilesToGenerateOL[indexTile].height} ; Current Width:{self.tilesToGenerateOL[indexTile].width} ; Current Density:{currentTileDensity} [Try: re-order]\n"], logFile, "a")
                    logger.info(f"Current Height:{self.tilesToGenerateOL[indexTile].height} --- Current Width:{self.tilesToGenerateOL[indexTile].width} --- Current Density: {currentTileDensity} [Try: re-order]")
                    portPairs, noConnection = generalFunctions.generate_pin_pairs(synthesisFile, self.fabricGen, tileName)

                    # netlist rearrangment
                    logger.info(f"start rearrange netlist for tile {tileName}")
                    nOpt = netListOpt.netListRearrange(defFile, synthesisFile, f"{self.projectDir}/Tile/{tileName}/{tileName}_ConfigMem")
                    nOpt.ConfigBitoptimizationWithAssignment()
                    nOpt.rewire_tile_netlist()

                    # pin rearrangment
                    logger.info(f"start rearrange pins for tile {tileName}")
                    placement = pinOpt.placementRearrange(defFile, synthesisFile, f"{self.openlaneDir}/designs/{tileName}", pinSides, portPairs)
                    swapTable = placement.arrangePinPlacement(noConnection)
                    layerTable = placement.arrangePinLayer(swapTable)

                    # prepare the pin combination dictionary
                    combinDict = {}
                    side = ["Top", "Bottom", "Left", "Right"]
                    for i in side:
                        l = {}
                        for j in range(1, 6):
                            l[j] = []
                        combinDict[i] = l

                    # put all the data into a single dictionary order by side
                    for p in placement.allPin:
                        layer = 0
                        for i in layerTable:
                            if p in layerTable[i]:
                                layer = i
                                break
                        if placement.allPin[p]["side"] in side:
                            combinDict[placement.allPin[p]["side"]][layer].append(p)

                    # keep initial order for not resized sides and take new calculated ones for resized sides
                    combinDict, pinOrderChangeRun = generalFunctions.fixUpdateOrder(combinDict, initCombinDict, pinOrderChange, resizeDim, ioPos, "", False)

                    # generate new config file without pinorder.cfg and with synthesis source
                    logger.info("Generate new config file")
                    logger.info(f"Generate OpenLane config files for tile: {self.tilesToGenerateOL[indexTile].name}")
                    genConfig.generate_OpenLane_config(self.openlaneDir, self.tilesToGenerateOL[indexTile], self.macroConfig, False, currentTileDensity)

                    # edit ioplacer.tcl
                    logger.info("Define pinorder in ioplacer.tcl")
                    pinDistanceTemp, notEnoughPinArea = genConfig.ioPlace(self.tilesToGenerateOL[indexTile], combinDict, self.openlaneDir, prevPinDistances, resizeDim, ioPos, self.tilesToGenerateOL[indexTile].isSuperTile, len(self.tilesToGenerateOL[indexTile].subTiles), self.marginTiles, self.gridSizeMet2, self.gridSizeMet3, self.marginMet2, self.marginMet3, self.pinWidth, self.pinDepth)

                    if notEnoughPinArea:
                        notSuccessRun = True
                        densitySuggest = False
                    else:
                        # run openlane flow on the tiles
                        logger.info(f"Start OpenLane flow for tile: {tileName}")
                        tile_command = f"openlane {self.openlaneDir}/designs/{tileName}/config.json --run-tag {self.ol_run_name} --overwrite"
                        proc = sp.Popen(openlane_nix + " --run \"" + tile_command + "\"", shell=True, stdin=sp.PIPE, stdout=sp.PIPE, encoding='utf8')
                        proc.communicate()
                        proc.stdout.close()
                        proc.terminate()
                        logger.info(f"OpenLane flow for {tileName} complete.")
                        # check for errors
                        notSuccessRun, densitySuggest = generalFunctions.check_flow(self.openlaneDir, tileName, False, logger, self.ol_run_name)
                   
                    if densitySuggest:
                        f = open(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/23-openroad-globalplacementskipio/openroad-globalplacementskipio.log")
                        data = f.readlines()
                        f.close()
                        searchLine = "Suggested target density:"
                        for line in data:
                            if searchLine in line: 
                                currentTileDensity = float(line[26:])

            logger.info(f"Resizing with optimizations for tile {tileName} finished")

            if notSuccessRun:  
                generalFunctions.copyAndOverwrite(f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}_temp_success",
                                                  f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}")
                shutil.copyfile(f"{self.openlaneDir}/openlane/scripts/openroad/ioplacer.tcl", f"{self.openlaneDir}/designs/{tileName}/runs/{self.ol_run_name}/ioplacer.tcl")
                pinDistance = pinDistanceTemp
                pinOrderChangeTile = pinOrderChangeRun
                # revert size
                self.resizeTile(indexTile, False, True, False, resizeDim)

            generalFunctions.writeLog([f"Finished Height:{self.tilesToGenerateOL[indexTile].height} ; Finished Width:{self.tilesToGenerateOL[indexTile].width} ; Finished Density: {currentTileDensity} \n",
                                       "----------------------------------------------------------------------------------------------------- \n"], logFile, "a")
            logger.info(f"Finished Height:{self.tilesToGenerateOL[indexTile].height} --- Finished Width:{self.tilesToGenerateOL[indexTile].width} --- Finished Density: {currentTileDensity}")
            nOpt.reset()
            placement.reset()
        else:
            # pinDistance = prevPinDistances  #TODO pin distance correction? -- eigentlich nicht delete
            pinOrderChangeTile = pinOrderChange
            if (cornerPos or ioPos):
                pinOrderChangeTile = pinOrderChangeRun
            else:
                pinOrderChangeTile = pinOrderChange


        return pinDistance, pinOrderChangeTile, currentTileDensity

    # Generate all tiles in one specific column
    def propagateColumnInMap(self, columnIndex, initTileIndex, pinDistancePrevTile, pinOrderChangePrevTile, ioSide):
        fabricColumn = []
        generatedTiles = []
        generatedTilesIndex = []
        ioTiles = {}

        # read in column of fabric
        for tile in self.fabricTileMap:
            fabricColumn.append(tile[columnIndex])
        heightColumn = len(fabricColumn[1:])

        # append first tile in column as generated
        generatedTiles.append(self.tilesToGenerateOL[initTileIndex].name)
        generatedTiles.append("NULL")
        generatedTilesIndex.append(initTileIndex)

        # Super Tile column
        if self.tilesToGenerateOL[initTileIndex].isSuperTile:
            for index, item in enumerate(fabricColumn[1:]):
                index = index + 1
                # part of super tile
                if (self.getSupertileName(item) not in generatedTiles and index != heightColumn):
                    # search for tile
                    tileIndex: int
                    for index, tile in enumerate(self.tilesToGenerateOL):
                        if tile.name == self.getSupertileName(item):
                            tileIndex = index
                            break
                    self.resizeTileOptFlow(tileIndex, pinDistancePrevTile, "", ioSide, pinOrderChangePrevTile, "", False)
                    generatedTiles.append(self.getSupertileName(item))
                # Terminate Tile
                elif index == heightColumn:
                # search for tile
                    tileIndex: int
                    for index, tile in enumerate(self.tilesToGenerateOL):
                        if tile.name == item:
                            tileIndex = index
                            break

                    # change width to init tile and height to config
                    self.tilesToGenerateOL[tileIndex].width = self.tilesToGenerateOL[initTileIndex].width
                    self.tilesToGenerateOL[tileIndex].height = self.terminateTilesHeight

                    # resize height but keep the width
                    if ioSide:
                        ioSidetemp = ioSide
                    else:
                        ioSidetemp = "Bottom"
                    pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(tileIndex, pinDistancePrevTile, "Height", ioSidetemp, pinOrderChangePrevTile, "Bottom", False)
                    generatedTiles.append(item)
                    ioTiles[item] = [pinDistanceTile, pinOrderChangeTile, tileDensity]
                else:
                    # already generated and is subtile of super tile.
                    tileIndex: int
                    for index, tile in enumerate(self.tilesToGenerateOL):
                        if tile.name == self.getSupertileName(item):
                            tileIndex = index
                            break
        # CLB column
        else:
            for index, item in enumerate(fabricColumn[1:]):
                index = index + 1
                # CLB
                if (item not in generatedTiles and index != heightColumn):
                    # search for tile
                    tileIndex: int
                    for index, tile in enumerate(self.tilesToGenerateOL):
                        if tile.name == item:
                            tileIndex = index
                            break

                    # change width and height to init tile in column
                    self.tilesToGenerateOL[tileIndex].width = self.tilesToGenerateOL[initTileIndex].width
                    self.tilesToGenerateOL[tileIndex].height = self.tilesToGenerateOL[initTileIndex].height
                    self.resizeTileOptFlow(tileIndex, pinDistancePrevTile, "", ioSide, pinOrderChangePrevTile, "", False)
                    generatedTiles.append(item)
                # Terminate Tile
                elif item not in generatedTiles:
                    # search for tile
                    tileIndex: int
                    for index, tile in enumerate(self.tilesToGenerateOL):
                        if tile.name == item:
                            tileIndex = index
                            break

                    # change width to init tile and height to config
                    self.tilesToGenerateOL[tileIndex].width = self.tilesToGenerateOL[initTileIndex].width
                    self.tilesToGenerateOL[tileIndex].height = self.terminateTilesHeight

                    # resize height but keep the width
                    if ioSide:
                        ioSidetemp = ioSide
                    else:
                        ioSidetemp = "Bottom"
                    pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(tileIndex, pinDistancePrevTile, "Height", ioSidetemp, pinOrderChangePrevTile, "Bottom", False)
                    generatedTiles.append(item)
                    ioTiles[item] = [pinDistanceTile, pinOrderChangeTile, tileDensity]

        # check if IO- / terminate-tile up in fabric
        if fabricColumn[0] not in generatedTiles:
            # search for tile
            tileIndex: int
            for index, tile in enumerate(self.tilesToGenerateOL):
                if tile.name == fabricColumn[0]:
                    tileIndex = index
                    break

            # change width to init tile and height to config
            self.tilesToGenerateOL[tileIndex].width = self.tilesToGenerateOL[initTileIndex].width
            self.tilesToGenerateOL[tileIndex].height = self.terminateTilesHeight

            if ioSide:
                ioSidetemp = ioSide
            else:
                ioSidetemp = "Top"
            pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(tileIndex, pinDistancePrevTile, "Height", ioSidetemp, pinOrderChangePrevTile, "Top", False)
            ioTiles[fabricColumn[0]] = [pinDistanceTile, pinOrderChangeTile]

#####################################################################################################################################################################################
                # check if generated tile size bigger for mixedColumn. Regenerate all previous tiles with bigger size.
                #if self.tilesToGenerateOL[tileIndex].mixedColumn:
                #    errors, densitySuggest = generalFunctions.check_flow(self.openlaneDir, self.tilesToGenerateOL[tileIndex].name, False, logger, self.ol_run_name)
                #    if densitySuggest:
                #        f = open(f"{self.openlaneDir}/designs/{self.tilesToGenerateOL[tileIndex].name}/runs/{self.ol_run_name}/23-openroad-globalplacementskipio/openroad-globalplacementskipio.log")
                #        data = f.readlines()
                #        f.close()
                #        searchLine = "Suggested target density:"
                #        for line in data:
                #            if searchLine in line: 
                #                self.currentTileDensity = float(line[26:])
                #    if errors:
                #        # rerun resizing on current tile
                #        pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(tileIndex, pinDistancePrevTile, "Width", "", pinOrderChangePrevTile, False, "", False)
                #        # change width 
                #        for i in generatedTilesIndex:
                #            self.tilesToGenerateOL[i].width = self.tilesToGenerateOL[tileIndex].width
                #        self.tilesToGenerateOL[initTileIndex].width = self.tilesToGenerateOL[tileIndex].width
                #        # regenerate previous tiles
                #        pinDistanceTiletemp = pinDistanceTile
                #        pinOrderChangeTiletemp = pinOrderChangeTile
                #        tileDensityTemp = tileDensity
                #        for i in reversed(generatedTilesIndex):
                #            pinDistanceTiletemp, pinOrderChangeTiletemp, tileDensityTemp = self.resizeTileOptFlow(i, pinDistanceTiletemp, "", ioSide, pinOrderChangeTiletemp, self.tilesToGenerateOL[tileIndex].isSuperTile, "", False)
                #        #self.resizeTileOptFlow(initTileIndex, pinDistanceTile, "", ioSide, pinOrderChangeTile, self.tilesToGenerateOL[tileIndex].isSuperTile, "", False)
                #    # supertile subtile completed storage    
                #    if tileIndex not in generatedTilesIndex:
                #        generatedTilesIndex.append(tileIndex)
#####################################################################################################################################################################################            

        return generatedTiles, ioTiles

    def run(self):
        pinDistanceInitialTile = {}
        pinOrderChangeInitialTile = {}
        
        if not self.coreOnly:  
            # Generating Openlane Tile designs folder structure
            logger.info("Generating OpenLane Tile designs folder structure")
            for tile in self.tilesToGenerateOL:
                tileFolder = f"mkdir -p {self.openlaneDir}/designs; mkdir -p {self.openlaneDir}/designs/{tile.name}; mkdir -p {self.openlaneDir}/designs/{tile.name}/src; touch {self.openlaneDir}/designs/{tile.name}/config.json"
                proc = sp.Popen(tileFolder, shell=True, stdin=sp.PIPE, stdout=sp.PIPE, encoding='utf8')
                proc.communicate()
                proc.stdout.close()
                proc.terminate()
            logger.info("Finish generating")

            # Move RTL from FABulous to Openlane folder structure
            logger.info("Moving Tile RTL to Openlane designs folder")
            for tile in self.tilesToGenerateOL:
                tile_dir = f"{self.projectDir}/Tile/{tile.name}"
                for subdir, dirs, files in os.walk(tile_dir):
                    for file in files:
                        if (file[-2:] == '.v'):
                            shutil.copyfile(os.path.join(subdir, file), f"{self.openlaneDir}/designs/{tile.name}/src/{file}")
                shutil.copyfile(os.path.join(f"{self.projectDir}/Test", "sequential_16bit_en_tb.v"), f"{self.openlaneDir}/designs/{tile.name}/src/fabulous_tb.v")
                shutil.copyfile(os.path.join(f"{self.projectDir}/Fabric", "models_pack.v"), f"{self.openlaneDir}/designs/{tile.name}/src/models_pack.v")
                shutil.copyfile(os.path.join(f"{self.projectDir}", "gate_map.v"), f"{self.openlaneDir}/designs/{tile.name}/gate_map.v")

            # ------------------------------------------------------------------------------------------------------------------------------
            # resize flow for initial tile
            # ------------------------------------------------------------------------------------------------------------------------------
            # run either flow with optimizations or without depending on optFlag
            logger.info(f"Generating tiles in OpenLane flow with tile resizing and start sizes defined in {self.configPath}")
            # run optimized resizing flow on starter tile
            pinDistanceInitialTile, pinOrderChangeInitialTile, tileDensity = self.resizeTileOptFlow(0, "", "Both", "", "", "", False)

            # ------------------------------------------------------------------------------------------------------------------------------
            # rest of the tiles in fabric
            # ------------------------------------------------------------------------------------------------------------------------------
            pinDistanceTile = {} 
            pinOrderChangeTile = {}
            terminateTilesInfo = {}
            finishedTiles = []
            tileColumn: int

            # find first column of starter tile in fabric
            for line in self.fabricTileMap:
                if self.tilesToGenerateOL[0].name in line:
                    tileColumn = line.index(self.tilesToGenerateOL[0].name)
                    break

            # go through init tile column
            finishedTilesTemp, terminateTiles = self.propagateColumnInMap(tileColumn, 0, pinDistanceInitialTile, pinOrderChangeInitialTile, "")
            finishedTiles.extend(finishedTilesTemp)
            terminateTilesInfo.update(terminateTiles)

            # propagate columns to the right of the starter tile to find min width of other columns
            for stepRight in range(tileColumn + 1, len(self.fabricTileMap[1])):
                # search for tile
                foundAt: int
                for index, tile in enumerate(self.tilesToGenerateOL):
                    if tile.name == self.fabricTileMap[1][stepRight] or self.fabricTileMap[1][stepRight] in tile.subTiles:
                        foundAt = index
                        break

                # change height to init tile
                if self.tilesToGenerateOL[foundAt].name not in finishedTiles:
                    self.tilesToGenerateOL[foundAt].height = self.tilesToGenerateOL[0].height
                    # multiply height if is SuperTile 
                    if self.tilesToGenerateOL[foundAt].isSuperTile:
                        self.tilesToGenerateOL[foundAt].height = self.tilesToGenerateOL[0].height * len(self.tilesToGenerateOL[foundAt].subTiles)
                # IO-Column
                if stepRight == (len(self.fabricTileMap[1])-1):
                    pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(foundAt, pinDistanceInitialTile, "Width", "Right", pinOrderChangeInitialTile, "", False)
                    finishedTilesTemp, unusedTerminateTiles = self.propagateColumnInMap(stepRight, foundAt, pinDistanceTile, pinOrderChangeTile, "Right")
                    terminateTilesInfo.update(unusedTerminateTiles)
                    finishedTiles.extend(finishedTilesTemp)
                # Normal or Super Column
                elif self.tilesToGenerateOL[foundAt].name not in finishedTiles:
                    pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(foundAt, pinDistanceInitialTile, "Width", "", pinOrderChangeInitialTile, "", False)
                    finishedTilesTemp, terminateTiles = self.propagateColumnInMap(stepRight, foundAt, pinDistanceTile, pinOrderChangeTile, "")
                    finishedTiles.extend(finishedTilesTemp)
                    terminateTilesInfo.update(terminateTiles)

            # propagate columns to the left of the starter tile to find min width of other columns
            for stepLeft in reversed(range(0, tileColumn)):
                # search for tile
                foundAt: int
                for index, tile in enumerate(self.tilesToGenerateOL):
                    if tile.name == self.fabricTileMap[1][stepLeft] or self.fabricTileMap[1][stepLeft] in tile.subTiles:
                        foundAt = index
                        break
                # change height to init tile
                if self.tilesToGenerateOL[foundAt].name not in finishedTiles:
                    self.tilesToGenerateOL[foundAt].height = self.tilesToGenerateOL[0].height
                    # multiply height if is SuperTile 
                    if self.tilesToGenerateOL[foundAt].isSuperTile:
                        self.tilesToGenerateOL[foundAt].height = self.tilesToGenerateOL[0].height * len(self.tilesToGenerateOL[foundAt].subTiles)
                # IO-Column
                if stepLeft == 0:
                    pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(foundAt, pinDistanceInitialTile, "Width", "Left", pinOrderChangeInitialTile, "", False)
                    finishedTilesTemp, unusedTerminateTiles = self.propagateColumnInMap(stepLeft, foundAt, pinDistanceTile, pinOrderChangeTile, "Left")
                    finishedTiles.extend(finishedTilesTemp)
                    terminateTilesInfo.update(unusedTerminateTiles)
                # Normal or Super Column  
                elif self.tilesToGenerateOL[foundAt].name not in finishedTiles:
                    pinDistanceTile, pinOrderChangeTile, tileDensity = self.resizeTileOptFlow(foundAt, pinDistanceInitialTile, "Width", "", pinOrderChangeInitialTile, "", False)
                    finishedTilesTemp, terminateTiles = self.propagateColumnInMap(stepLeft, foundAt, pinDistanceTile, pinOrderChangeTile, "")
                    finishedTiles.extend(finishedTilesTemp)
                    terminateTilesInfo.update(terminateTiles)

            # ------------------------------------------------------------------------------------------------------------------------------
            # generate terminate tiles with same dimensions and pin order on sides
            # ------------------------------------------------------------------------------------------------------------------------------
            # max height for terminate north tiles
            heightTerminate = 0
            maxHeightTileIndex = 0
            terminateNorthTilesIndexes = []
            completedNorthTilesIndexes = []
            leftTileIndex = 0
            rightTileIndex = 0

            if self.fabricTileMap[0][0] != "NULL":
                # search for tile
                for index, tileSearch in enumerate(self.tilesToGenerateOL):
                    if tileSearch.name == self.fabricTileMap[0][0]:
                        leftTileIndex = index
                        break
            if self.fabricTileMap[0][-1] != "NULL":
                # search for tile
                for index, tileSearch in enumerate(self.tilesToGenerateOL):
                    if tileSearch.name == self.fabricTileMap[0][-1]:
                        rightTileIndex = index
                        break

            for tile in self.fabricTileMap[0]:
                if tile != "NULL":
                    # search for tile
                    foundAt: int
                    for index, tileSearch in enumerate(self.tilesToGenerateOL):
                        if tileSearch.name == tile:
                            foundAt = index
                            break
                    if heightTerminate < self.tilesToGenerateOL[foundAt].height:
                        heightTerminate = self.tilesToGenerateOL[foundAt].height
                        maxHeightTileIndex = foundAt
                    terminateNorthTilesIndexes.append(foundAt)

            # generate all terminate north tiles with max height and pin order
            completedNorthTilesIndexes.append(maxHeightTileIndex)
            for tileIndex in terminateNorthTilesIndexes:
                if tileIndex not in completedNorthTilesIndexes:
                    # change height to reference tile
                    self.tilesToGenerateOL[tileIndex].height = heightTerminate

                    # keep height and keep the width
                    if tileIndex == leftTileIndex:
                        iopos = "Left"
                        cornerpos = "Top"
                    elif tileIndex == rightTileIndex:
                        iopos = "Right"
                        cornerpos = "Top"
                    else:
                        iopos = "Top"
                        cornerpos = ""

                    # determine if special case of terminate tile and or supertile column
                    isSuperColumn = False
                    for index, tile in enumerate(self.fabricTileMap[0]):
                        if tile == self.tilesToGenerateOL[tileIndex].name:
                            underTile = self.fabricTileMap[1][index]
                    if self.getSupertileName(underTile):
                        isSuperColumn = True
                    if self.tilesToGenerateOL[tileIndex].name == self.fabricTileMap[0][0] or self.tilesToGenerateOL[tileIndex].name == self.fabricTileMap[0][-1]:
                        isSuperColumn = True

                    self.resizeTileOptFlow(tileIndex, terminateTilesInfo[self.tilesToGenerateOL[tileIndex].name][0], "", iopos, terminateTilesInfo[self.tilesToGenerateOL[tileIndex].name][1], cornerpos, isSuperColumn)
                    completedNorthTilesIndexes.append(tileIndex)

            # max height for terminate south tiles
            heightTerminate = 0
            maxHeightTileIndex = 0
            terminateSouthTilesIndexes = []
            completedSouthTilesIndexes = []
            leftTileIndex = 0
            rightTileIndex = 0

            if self.fabricTileMap[-1][0] != "NULL":
                # search for tile
                for index, tileSearch in enumerate(self.tilesToGenerateOL):
                    if tileSearch.name == self.fabricTileMap[0][0]:
                        leftTileIndex = index
                        break
            if self.fabricTileMap[-1][-1] != "NULL":
                # search for tile
                for index, tileSearch in enumerate(self.tilesToGenerateOL):
                    if tileSearch.name == self.fabricTileMap[0][-1]:
                        rightTileIndex = index
                        break

            for tile in self.fabricTileMap[-1]:
                if tile != "NULL":
                    # search for tile
                    foundAt: int
                    for index, tileSearch in enumerate(self.tilesToGenerateOL):
                        if tileSearch.name == tile:
                            foundAt = index
                            break
                    if heightTerminate < self.tilesToGenerateOL[foundAt].height:
                        heightTerminate = self.tilesToGenerateOL[foundAt].height
                        maxHeightTileIndex = foundAt
                    terminateSouthTilesIndexes.append(foundAt)

            # generate all terminate south tiles with max height and pin order
            completedSouthTilesIndexes.append(maxHeightTileIndex)
            for tileIndex in terminateSouthTilesIndexes:
                if tileIndex not in completedSouthTilesIndexes:
                    # change height to reference tile
                    self.tilesToGenerateOL[tileIndex].height = heightTerminate

                    # keep height and keep the width
                    if tileIndex == leftTileIndex:
                        iopos = "Left"
                        cornerpos = "Bottom"
                    elif tileIndex == rightTileIndex:
                        iopos = "Right"
                        cornerpos = "Bottom"
                    else:
                        iopos = "Bottom"
                        cornerpos = ""

                    isSuperColumn = False
                    for index, tile in enumerate(self.fabricTileMap[-1]):
                        if tile == self.tilesToGenerateOL[tileIndex].name:
                            aboveTile = self.fabricTileMap[-2][index]
                    if self.getSupertileName(aboveTile):
                        isSuperColumn = True
                    if (self.tilesToGenerateOL[tileIndex].name == self.fabricTileMap[-1][0] or self.tilesToGenerateOL[tileIndex].name == self.fabricTileMap[-1][-1]):
                        isSuperColumn = True

                    self.resizeTileOptFlow(tileIndex, terminateTilesInfo[self.tilesToGenerateOL[tileIndex].name][0], "", iopos, terminateTilesInfo[self.tilesToGenerateOL[tileIndex].name][1], cornerpos, isSuperColumn)
                    completedSouthTilesIndexes.append(tileIndex)

        # delete entries in io placer
        pinTcl = ["\n", "place_pins {*}$arg_list -random_seed 42 -hor_layers $HMETAL -ver_layers $VMETAL \n", "\n", "write"]
        f = open(f"{self.openlaneDir}/openlane/scripts/openroad/ioplacer.tcl")
        data = f.readlines()
        f.close()

        cutIndex = [i for i, s in enumerate(data) if 'place_pin' in s]
        cutIndex = min(cutIndex)
        data = data[:cutIndex]
        data.extend(pinTcl)
        with open(f"{self.openlaneDir}/openlane/scripts/openroad/ioplacer.tcl", "w") as f:
            f.writelines(data)
            f.close() 

        # ------------------------------------------------------------------------------------------------------------------------------
        # Copy and implement prehardened Macros (RAM)[TODO REMOVE and add macro prehardened]
        # ------------------------------------------------------------------------------------------------------------------------------

        # ------------------------------------------------------------------------------------------------------------------------------
        # Generate PDN[TODO]
        # ------------------------------------------------------------------------------------------------------------------------------
         
        # ------------------------------------------------------------------------------------------------------------------------------
        # fabric hardening
        # ------------------------------------------------------------------------------------------------------------------------------
        # generate fabric folder structure with OL
        logger.info("Generating OpenLane fabric macro folder structure")
        fabricFolder = f"mkdir -p {self.openlaneDir}/designs/{self.fabulousRunName}; mkdir -p {self.openlaneDir}/designs/{self.fabulousRunName}/src; touch {self.openlaneDir}/designs/{self.fabulousRunName}/config.json"
        proc = sp.Popen(fabricFolder, shell=True, stdin=sp.PIPE, stdout=sp.PIPE, encoding='utf8')
        proc.communicate()
        proc.stdout.close()
        proc.terminate()

        # folder structure for hardening the core
        try:
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/gds")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/lef")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/lib")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/multicorner")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/multicorner/min")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/multicorner/nom")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/multicorner/max")
            os.makedirs(f"{self.openlaneDir}/designs/{self.fabulousRunName}/src/BB")
        except OSError:
            pass
        # move gds, lef, lib, verilog files
        for tile in self.tilesToGenerateOL:
            if tile.name != "NULL":
                shutil.copyfile(f"{self.openlaneDir}/designs/{tile.name}/runs/{self.ol_run_name}/final/nl/{tile.name}.nl.v", f"{self.openlaneDir}/designs/{self.fabulousRunName}/src/BB/{tile.name}.v")
                shutil.copyfile(f"{self.openlaneDir}/designs/{tile.name}/runs/{self.ol_run_name}/final/gds/{tile.name}.gds", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/gds/{tile.name}.gds")
                shutil.copyfile(f"{self.openlaneDir}/designs/{tile.name}/runs/{self.ol_run_name}/final/lef/{tile.name}.lef", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/lef/{tile.name}.lef")
                shutil.copyfile(f"{self.openlaneDir}/designs/{tile.name}/runs/{self.ol_run_name}/final/lib/nom_ss_100C_1v60/{tile.name}__nom_ss_100C_1v60.lib", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/lib/{tile.name}.lib")
                shutil.copyfile(f"{self.openlaneDir}/designs/{tile.name}/runs/{self.ol_run_name}/final/spef/max/{tile.name}.max.spef", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/multicorner/max/{tile.name}.spef")
                shutil.copyfile(f"{self.openlaneDir}/designs/{tile.name}/runs/{self.ol_run_name}/final/spef/nom/{tile.name}.nom.spef", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/multicorner/nom/{tile.name}.spef")
                shutil.copyfile(f"{self.openlaneDir}/designs/{tile.name}/runs/{self.ol_run_name}/final/spef/min/{tile.name}.min.spef", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/multicorner/min/{tile.name}.spef")
        if self.ramGenerate:
            shutil.copyfile(f"{self.openlaneDir}/designs/{self.ramName}/runs/{self.ol_run_name}/final/nl/{self.ramName}.nl.v", f"{self.openlaneDir}/designs/{self.fabulousRunName}/src/BB/{self.ramName}.v")
            shutil.copyfile(f"{self.openlaneDir}/designs/{self.ramName}/runs/{self.ol_run_name}/final/gds/{self.ramName}.gds", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/gds/{self.ramName}.gds")
            shutil.copyfile(f"{self.openlaneDir}/designs/{self.ramName}/runs/{self.ol_run_name}/final/lef/{self.ramName}.lef", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/lef/{self.ramName}.lef")
            shutil.copyfile(f"{self.openlaneDir}/designs/{self.ramName}/runs/{self.ol_run_name}/final/lib/nom_ss_100C_1v60/{self.ramName}__nom_ss_100C_1v60.lib", f"{self.openlaneDir}/designs/{self.fabulousRunName}/macros/lib/{self.ramName}.lib")
        
        # move eFPGA fabric verilog files
        for subdir, dirs, files in os.walk(f"{self.projectDir}/Fabric"):
            for file in files:
                if file != "BlockRAM_1KB.v":
                    shutil.copyfile(os.path.join(f"{self.projectDir}/Fabric", file), f"{self.openlaneDir}/designs/{self.fabulousRunName}/src/{file}") 
        # calculate fabric height
        fabricTileHeightTotal = 0
        rowNum = 0
        tileHeights = []
        column = []
        for row in self.fabricTileMap:
            column.append(row[1]) # second column
        for tile in column:
            # search for tile
            foundAt: int
            for index, tileSearch in enumerate(self.tilesToGenerateOL):
                if tileSearch.name == tile or tile in tileSearch.subTiles:
                    foundAt = index
                    break
            # find tile hight
            fabricTileHeightTotal += self.tilesToGenerateOL[foundAt].height
            tileHeights.append(self.tilesToGenerateOL[foundAt].height)
            rowNum += 1

        # calculate fabric width
        fabricTileWidthTotal = 0
        columnNum = 0
        tileWidths = []
        for tile in self.fabricTileMap[1]:
            # search for tile
            foundAt: int
            for index, tileSearch in enumerate(self.tilesToGenerateOL):
                if tileSearch.name == tile or tile in tileSearch.subTiles:
                    foundAt = index
                    break
            # find tile width
            fabricTileWidthTotal += self.tilesToGenerateOL[foundAt].width
            tileWidths.append(self.tilesToGenerateOL[foundAt].width)
            columnNum += 1
        # generate macro_placement.cfg
        heightPos = fabricTileHeightTotal + self.marginFab + self.marginFabCore + (rowNum -1) * self.marginTiles
        configTilePlacement, macroHooks = genConfig.macroPlace(heightPos, self.marginFab, self.marginFabCore, self.marginTiles, self.fabricTileMap, self.tilesToGenerateOL, tileHeights, tileWidths, self.openlaneDir, self.fabulousRunName)
        # RAM placement
 
        if self.ramGenerate:
            ramBlocksCount = int(fabricTileHeightTotal / (self.ramHeight + self.marginRAM))
            heightPos = fabricTileHeightTotal + self.marginFab + self.marginFabCore + (rowNum -1) * self.marginTiles
            #self.ramHeight + self.marginRAM
            maxWidthPos = self.marginFabCore + self.marginFab + fabricTileWidthTotal + ((rowNum -1) * self.marginTiles) + self.marginRAM
            ramBlocksCount = 4
            for i in range(ramBlocksCount):
                heightPos -= self.ramHeight
                configTilePlacement += f"Inst_BlockRAM_{(ramBlocksCount - i) -1} {maxWidthPos + self.marginRAM} {heightPos} N \n"
                macroHooks += f"\"Inst_BlockRAM_{(ramBlocksCount - i) -1} vccd1 vssd1 vccd1 vssd1,\","
                heightPos -= self.marginRAM
        else:
            self.ramWidth = 0
            self.marginRAM = 0
        configTilePlacement += "}"
        macroHooks = macroHooks[:-1] + "]"

        # change height and width because of halo between tiles
        fabricTileHeightTotal += (rowNum -1) * self.marginTiles 
        fabricTileWidthTotal += (rowNum -1) * self.marginTiles

        # generate config.json for faric macro
        tileNames = []
        for tile in self.tilesToGenerateOL:
            tileNames.append(tile.name)
        logger.info(f"Generate OpenLane core config files for core: {self.fabulousRunName}")
        genConfig.generateCoreConfig(self.openlaneDir, self.fabulousRunName, fabricTileHeightTotal, fabricTileWidthTotal + self.marginRAM, tileNames, macroHooks, self.marginFabCore, self.marginFab, self.ramWidth, self.coreConfig, self.fabulousRunName, self.targetDensity, self.marginRAM, configTilePlacement)

        # add black box comment to black box files to avoid STA check
        for subdir, dirs, files in os.walk(f"{self.openlaneDir}/designs/{self.fabulousRunName}/src/BB"):
            for file in files:
                src = open(f"{self.openlaneDir}/designs/{self.fabulousRunName}/src/BB/{file}", "r")
                staLine = "/// sta-blackbox \n"
                data = src.readlines()
                data.insert(0, staLine)
                src.close()
                src = open(f"{self.openlaneDir}/designs/{self.fabulousRunName}/src/BB/{file}", "w")
                src.writelines(data)
                src.close()      
        # cut STA command
        #cutIndex = min(cutIndex)
        #for index, line in enumerate(data[cutIndex:]):
        #    if line.rstrip():
        #        data[cutIndex + index] = "#" + data[cutIndex + index]
        #    else:
        #        break

        #with open(f"{self.openlaneDir}/scripts/tcl_commands/synthesis.tcl","w") as f: #TODO
        #    f.writelines(data)
        #    f.close()

        # run OL flow on fabric
        logger.info(f"Start OpenLane flow for fabric {self.fabulousRunName}")
        openlane_nix = f"cd {self.openlaneDir}; nix-shell shell.nix"
        tile_command = f"openlane {self.openlaneDir}/designs/{self.fabulousRunName}/config.json --run-tag {self.ol_run_name} --overwrite"
        proc = sp.Popen(openlane_nix + " --run \"" + tile_command + "\"", shell=True, stdin=sp.PIPE, stdout=sp.PIPE, encoding='utf8')
        proc.communicate()
        proc.stdout.close()
        proc.terminate()
        logger.info(f"OpenLane flow for fabric {self.fabulousRunName} complete.")

        # reverse comment STA checksuperColumnSizes[x]
        #f.close()

        #cutIndex = [i for i, s in enumerate(data) if '#    run_sta' in s]
        #cutIndex = min(cutIndex)
        #for index, line in enumerate(data[cutIndex:]):
        #    if line.rstrip():
        #        data[cutIndex + index] = data[cutIndex + index][1:]
        #    else:
        #        break

        #with open(f"{self.openlaneDir}/scripts/tcl_commands/synthesis.tcl","w") as f:
        #    f.writelines(data)
        #    f.close()
