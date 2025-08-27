import configparser

def trim(number, precision):
    x = 10 ** precision
    temp = int(number*x)
    trimmed = temp / x
    return trimmed
# generate config.json file for a OpenLane tile,
# small needed difference between initial automatic run and follow ups
def generate_OpenLane_config(openlaneDir, tile, macroConfig, initial_run,
                             density):
    # flow depandent configuration values
    if initial_run:
        configText = [
            "{\n", f"\"DESIGN_NAME\": \"{tile.name}\",\n",
            "\"VERILOG_FILES\": \"dir::src/*.v\",\n",
            f"\"SYNTH_LATCH_MAP\": \"{openlaneDir}/designs/{tile.name}/gate_map.v\",\n",
            f"\"BASE_SDC_FILE\": \"{openlaneDir}/designs/{tile.name}/{tile.name}.sdc\",\n",
            "\"FP_SIZING\": \"absolute\",\n",
            f"\"DIE_AREA\": \"0 0 {tile.width}.0 {tile.height}.0\",\n",
            f"\"CORE_AREA\": \"3 3 {tile.width - 3}.0 {tile.height - 3}.0\",\n",
            #f"\"GRT_OBS\": \"met5 0 0 {tile.width}.0 {tile.height}.0\",\n",
            "\"RT_MAX_LAYER\": \"met4\",\n"
        ]
    else:
        configText = [
            "{\n", f"\"DESIGN_NAME\": \"{tile.name}\",\n",
            f"\"VERILOG_FILES\": \"dir::{tile.name}.synthesis.opt.v\",\n",
            f"\"SYNTH_LATCH_MAP\": \"{openlaneDir}/designs/{tile.name}/gate_map.v\",\n",
            f"\"BASE_SDC_FILE\": \"{openlaneDir}/designs/{tile.name}/{tile.name}.sdc\",\n",
            "\"SYNTH_READ_BLACKBOX_LIB\": true,\n",
            "\"SYNTH_ELABORATE_ONLY\": true,\n",
            "\"FP_SIZING\": \"absolute\",\n",
            f"\"DIE_AREA\": \"0 0 {tile.width}.0 {tile.height}.0\",\n",
            f"\"CORE_AREA\": \"3 3 {tile.width - 3}.0 {tile.height - 3}.0\",\n",
            #f"\"GRT_OBS\": \"met5 0 0 {tile.width}.0 {tile.height}.0\",\n",
            "\"RT_MAX_LAYER\": \"met4\",\n"
        ]

    # user defined configuration values
    if tile.name in macroConfig:
        for configLine in macroConfig[tile.name]:
            configText.append(
                f"\"{configLine}\": {macroConfig[tile.name][configLine]},\n")
    else:
        default = "DEFAULT"
        for configLine in macroConfig[default]:
            configText.append(
                f"\"{configLine}\": {macroConfig[default][configLine]},\n")
    configText.append("\"FP_PDN_MULTILAYER\": \"false\",\n")
    configText.append(f"\"PL_TARGET_DENSITY_PCT\": {density}\n")
    configText.append("}")

    with open(f"{openlaneDir}/designs/{tile.name}/config.json", "w") as f:
        f.writelines(configText)
        f.close()

    timingLoopsKill(tile.name, openlaneDir)


# generate config.json file for whole OpenLane core
def generateCoreConfig(openlaneDir, coreName, tileHeightArea, tileWidthArea, tiles, hooks,
                       marginFABCore, marginFab, ramWidth, coreConfig,
                       designName, density, marginRAM, tilePlacement):
    configText = [
        "{\n", f"\"DESIGN_NAME\": \"{designName}\",\n",
        "\"VERILOG_FILES\": \"dir::src/*.v\",\n",
        "\"EXTRA_VERILOG_MODELS\": \"dir::src/BB/*.v\",\n",
        f"\"DIE_AREA\": \"0 0 {tileWidthArea + 2*(marginFABCore+marginFab) + ramWidth + marginRAM}.0 {tileHeightArea + 2*(marginFABCore+ marginFab)}.0\",\n",
        f"\"CORE_AREA\": \"{marginFABCore}.0 {marginFABCore}.0 {tileWidthArea + marginFABCore + 2*marginFab + marginRAM}.0 {tileHeightArea + marginFABCore + 2*marginFab}.0\",\n",
        "\"FP_SIZING\": \"absolute\",\n"
    ]

    # user defined configuration values
    for configLine in coreConfig:
        configText.append(
            f"\"{configLine}\": {coreConfig[configLine]},\n")
    configText.append(f"\"PDN_MACRO_CONNECTIONS\": {hooks},\n")  
    configText.append(f"\"PL_TARGET_DENSITY_PCT\": {density},\n")
    configText.append(f"{tilePlacement}")
    configText.append("}")

    with open(f"{openlaneDir}/designs/{coreName}/config.json", "w") as f:
        f.writelines(configText)
        f.close()

    timingLoopsKill(coreName, openlaneDir)


# generate initial config for automatic script TODO REWORK CORE
def generateAutoConfig(configName):
    configText = configparser.ConfigParser()
    configText.optionxform = str
    configText["General"] = {
        "OpenLane_path": "/path/to/OpenLane",
        "SupertileFreeRunPath": "/path/to/FABulous/run/just/with/subtiles",
        "PDKPath": "/home/user/.volare/sky130A",
        "StarterTile": "LUT4AB",
        "ResizeTilesOptimizations": "False",
        "ResizeOptimizationsIterations": "5",
        "DensityStepsPercent": "1",
        "OpenLaneRunName": "automatic_run",
        "FABulousRunName": "eFPGA",
        "RAMEnable": "False",
        "MarginTiles": "20",
        "MarginFab": "50",
        "MarginFabCore": "3",
        "GenerateRTL": "True",
        "TargetDensityStart": "75",
        "TerminateTilesStartHeight": "39",
        "MarginRAM": "50",
        "CoreOnly": "False",
        "ResizeDensity": "False",
        "GridSizeMet2": "0.46",
        "GridSizeMet3": "0.68",
        "MarginMet2": "0.23",
        "MarginMet3": "0.34",
        "PinWidth": "0.3",
        "PinDepth": "1.5"
    }
    configText["Dimensions"] = {
        "StarterTileWidth": "225",
        "StarterTileHeight": "225",
        "LUT4AB_Width": "225",
        "RegFile_Width": "230",
        "DSP_Width": "205",
        "RAM_IO_Width": "125",
        "W_IO_Width": "60"
    }
    configText["OpenLaneMacro_DEFAULT"] = {
        "CLOCK_PORT": "\"UserCLK\"",
        "CLOCK_PERIOD": "40",
        "FP_IO_HLAYER": "\"met3\"",
        "FP_IO_VLAYER": "\"met2\"",
        "CLOCK_WIRE_RC_LAYER": "\"met4\"",
        "FP_PDN_HORIZONTAL_LAYER": "\"met3\"",
        "VDD_NETS": "[\"vccd1\"]",
        "GND_NETS": "[\"vssd1\"]",
        "VDD_PINS": "[\"vccd1\"]",
        "GND_PINS": "[\"vssd1\"]",
        "SYNTH_POWER_DEFINE": "\"USE_POWER_PINS\"",
        "FP_PDN_ENABLE_RAILS": "1",
        "FP_PDN_CHECK_NODES": "0",
        "FP_PDN_VPITCH": "75",
        "FP_PDN_HPITCH": "75",
        "FP_IO_VEXTEND": "1.5",
        "FP_IO_HEXTEND": "1.5",
        "FP_IO_VLENGTH": "0.8",
        "FP_IO_HLENGTH": "0.8",
        "FP_IO_HTHICKNESS_MULT": "2",
        "FP_IO_VTHICKNESS_MULT": "2",
        "GPL_CELL_PADDING": "4",
        "CLOCK_TREE_SYNTH": "1",
        "SYNTH_STRATEGY": "\"AREA 0\"",
        "SYNTH_MAX_FANOUT": "5",
        "SYNTH_FLAT_TOP": "0",
        "SYNTH_NO_FLAT": "1",
        "MAX_TRANSITION_CONSTRAINT": "1.0",
        "MAX_FANOUT_CONSTRAINT": "16",
        "PL_RESIZER_SETUP_SLACK_MARGIN": "1",
        "GLB_RESIZER_SETUP_SLACK_MARGIN": "0.2",
        "GLB_RESIZER_HOLD_SLACK_MARGIN": "0.2",
        "PL_RESIZER_HOLD_SLACK_MARGIN": "1",
        "MAGIC_DEF_LABELS": "0",
        "SYNTH_BUFFERING": "0",
        "RUN_HEURISTIC_DIODE_INSERTION": "1",
        "HEURISTIC_ANTENNA_THRESHOLD": "110",
        "GRT_REPAIR_ANTENNAS": "1"
    }
    configText["OpenLaneMacro_TileName"] = {
        "CLOCK_PORT": "\"UserCLK\"",
        "CLOCK_PERIOD": "40",
        "FP_IO_HLAYER": "\"met3\"",
        "FP_IO_VLAYER": "\"met2\"",
        "CLOCK_WIRE_RC_LAYER": "\"met4\"",
        "FP_PDN_HORIZONTAL_LAYER": "\"met3\"",
        "VDD_NETS": "[\"vccd1\"]",
        "GND_NETS": "[\"vssd1\"]",
        "VDD_PINS": "[\"vccd1\"]",
        "GND_PINS": "[\"vssd1\"]",
        "SYNTH_POWER_DEFINE": "\"USE_POWER_PINS\"",
        "FP_PDN_ENABLE_RAILS": "1",
        "FP_PDN_CHECK_NODES": "0",
        "FP_PDN_VPITCH": "75",
        "FP_PDN_HPITCH": "75",
        "FP_IO_VEXTEND": "1.5",
        "FP_IO_HEXTEND": "1.5",
        "FP_IO_VLENGTH": "0.8",
        "FP_IO_HLENGTH": "0.8",
        "FP_IO_HTHICKNESS_MULT": "2",
        "FP_IO_VTHICKNESS_MULT": "2",
        "GPL_CELL_PADDING": "4",
        "CLOCK_TREE_SYNTH": "1",
        "SYNTH_STRATEGY": "\"AREA 0\"",
        "SYNTH_MAX_FANOUT": "5",
        "SYNTH_FLAT_TOP": "0",
        "SYNTH_NO_FLAT": "1",
        "MAX_TRANSITION_CONSTRAINT": "1.0",
        "MAX_FANOUT_CONSTRAINT": "16",
        "PL_RESIZER_SETUP_SLACK_MARGIN": "1",
        "GLB_RESIZER_SETUP_SLACK_MARGIN": "0.2",
        "GLB_RESIZER_HOLD_SLACK_MARGIN": "0.2",
        "PL_RESIZER_HOLD_SLACK_MARGIN": "1",
        "MAGIC_DEF_LABELS": "0",
        "SYNTH_BUFFERING": "0",
        "RUN_HEURISTIC_DIODE_INSERTION": "1",
        "HEURISTIC_ANTENNA_THRESHOLD": "110",
        "GRT_REPAIR_ANTENNAS": "1"
    }
    configText["OpenLaneCore"] = {
        "PDK": "\"sky130A\"",
        "CLOCK_PORT": "\"CLK\"",
        "CLOCK_PERIOD": "40",
        "SYNTH_NO_FLAT": "1",
        "FP_SIZING": "absolute",
        "VDD_NETS": "[\"vccd1\"]",
        "GND_NETS": "[\"vssd1\"]",
        "FP_IO_VEXTEND": "4.8",
        "FP_IO_HEXTEND": "4.8",
        "FP_IO_VLENGTH": "0.7",  
        "FP_IO_HLENGTH": "0.7", 
        "FP_IO_VTHICKNESS_MULT": "4",
        "FP_IO_HTHICKNESS_MULT": "4",
        "FP_IO_MIN_DISTANCE": "1",
        "FP_PDN_CORE_RING": "1",
        "FP_PDN_CORE_RING_VWIDTH": "1.6", 
        "FP_PDN_CORE_RING_HWIDTH": "1.6",  
        "FP_PDN_CORE_RING_VOFFSET": "1.6", 
        "FP_PDN_CORE_RING_HOFFSET": "1.6", 
        "FP_PDN_CORE_RING_VSPACING": "1.6",
        "FP_PDN_CORE_RING_HSPACING": "1.6",
        "PL_TARGET_DENSITY_PCT": "70"
    }
    with open(configName, "w") as f:
        configText.write(f)
        f.close()


# place macros as defined in config file
def macroPlace(heightPos, marginFab, marginFabCore, marginTiles, fabricTileMap, tilesToGenerateOL, tileHeights, tileWidths, openlaneDir, fabulousRunName):
     # generate macro_placement.cfg
    configTilePlacement = "\"MACROS\": {\n"
    macroHooks = "["
    superPositions = []
    superColumnSizes = {}
    superTileNames = {}
    macros = {}
    for y, column in enumerate(fabricTileMap):
        for x, tile in enumerate(column):
            for genTile in tilesToGenerateOL:
                if tile in genTile.subTiles:
                    superPositions.append(x)
                    superColumnSizes[x] = len(genTile.subTiles)
                    superTileNames[x] = genTile.name

    for tile in tilesToGenerateOL:
        if tile.name != "NULL":
            macros[tile.name] = []
    for y, column in enumerate(fabricTileMap):
        widthPos = marginFabCore + marginFab
        heightPos -= tileHeights[y]
        for x, tile in enumerate(column):
            if x in superPositions:
                if ((y - 1 + superColumnSizes[x])% superColumnSizes[x]) == 0 and y != len(fabricTileMap) - 1 and y != 0:
                 
                    superHeightPos = heightPos - tileHeights[y] * (superColumnSizes[x] - 1)
                    print(tileHeights)
                    macros[superTileNames[x]].append([x, y, widthPos, superHeightPos])
                    macroHooks += f"\"Tile_X{x}Y{y}_{superTileNames[x]} vccd1 vssd1 vccd1 vssd1,\","     #eFPGA_inst.
                elif y == 0 or y == len(fabricTileMap) - 1:
                    macros[tile].append([x, y, widthPos, heightPos])

            elif tile != "NULL":
                macros[tile].append([x, y, widthPos, heightPos])
                macroHooks += f"\"Tile_X{x}Y{y}_{tile} vccd1 vssd1 vccd1 vssd1,\","      #eFPGA_inst.
            widthPos += (tileWidths[x] + marginTiles)
        heightPos -= marginTiles

    for macro in macros:
        configTilePlacement += f"\"{macro}\":" + "{\n"
        configTilePlacement += "    \"gds\": [\n"
        configTilePlacement += f"        \"dir::macros/gds/{macro}.gds\"\n"
        configTilePlacement += "    ],\n"
        configTilePlacement += "    \"lef\": [\n"
        configTilePlacement += f"        \"dir::macros/lef/{macro}.lef\"\n"
        configTilePlacement += "    ],\n"
        
        configTilePlacement += "    \"instances\": {\n"
        for instances in macros[macro]:
            configTilePlacement += f"        \"Tile_X{instances[0]}Y{instances[1]}_{macro}\"" + ": {\n"
            configTilePlacement += f"            \"location\": [{instances[2]}, {instances[3]}],\n"
            configTilePlacement += "            \"orientation\": \"N\"\n"
            configTilePlacement += "        },\n"
        configTilePlacement = configTilePlacement[:-2]
        configTilePlacement += "\n"
        configTilePlacement += "    },\n"
        configTilePlacement += "    \"nl\": [\n"
        configTilePlacement += f"        \"dir::src/BB/{macro}.v\"\n"
        configTilePlacement += "    ],\n"
        #configTilePlacement += #"    \"spef\": {\n"
        #configTilePlacement += #"        \"min_*\": [\n"
        #configTilePlacement += #f"            \"dir::macros/multicorner/min/{superTileNames[x]}.spef\"\n"
        #configTilePlacement += #"        ],\n"
        #configTilePlacement += #"        \"nom_*\": [\n"
        #configTilePlacement += #f"            \"dir::macros/multicorner/nom/{superTileNames[x]}.spef\"\n"
        #configTilePlacement += #"        ],\n"
        #configTilePlacement += #"        \"max_*\": [\n"
        #configTilePlacement += #f"            \"dir::macros/multicorner/max/{superTileNames[x]}.spef\"\n"
        #configTilePlacement += #"        ]\n"
        #configTilePlacement += #"    },\n"
        configTilePlacement += "    \"lib\": {\n"
        configTilePlacement += f"        \"*\": \"dir::macros/lib/{macro}.lib\"\n"
        configTilePlacement += "    }\n"
        configTilePlacement += "},\n"
        macroHooks += f"\"Tile_X{instances[0]}Y{instances[1]}_{macro} vccd1 vssd1 vccd1 vssd1,\","    #eFPGA_inst.
    
    configTilePlacement = configTilePlacement[:-2]


    return configTilePlacement, macroHooks
        
# rewrite ioplacer.tcl to place pins at fixed positions and metal layers
def ioPlace(tile, combinDict, openlaneDir, prevPosGrid, resize, ioSide,
            isSuperTile, superTileCount, tileOffset, gridSizeMet2, gridSizeMet3, marginMet2, marginMet3, pinWidth, pinDepth):
    marginHorizontal = trim((gridSizeMet3 * 2 + marginMet3), 3)
    marginVertical = trim((gridSizeMet2 * 2  + marginMet2), 3)
    maxHeight = tile.height - marginHorizontal * 2
    maxWidth = tile.width - marginVertical * 2
    posGrid = {}
    notEnoughArea = False

    if isSuperTile:
        maxHeight = maxHeight - marginHorizontal * 2

    # edit ioplacer.tcl
    placerTcl = []
    for side in combinDict:
        posGrid[side] = []
        for layer in combinDict[side]:
            distanceBetweenPins: float = 0
            position: float = 0
            # initial tile
            if resize == 'Both':
                if side in ['Top', 'Bottom']:
                    distanceBetweenPins = trim(
                        ((maxWidth) / (len(combinDict[side][layer]) + 1)),4)
                else: 
                    if isSuperTile:
                        distanceBetweenPins = trim(
                            ((maxHeight - (superTileCount - 1) * tileOffset) / (len(combinDict[side][layer]) + 1)),4)
                    else:
                        distanceBetweenPins = trim(
                            ((maxHeight) / (len(combinDict[side][layer]) + 1)),4)
            # terminate tiles
            elif resize == 'Height':
                if side in ['Top', 'Bottom']:
                    distanceBetweenPins = prevPosGrid[side]
                    #if isSuperTile:
                    #    if side == "Top":
                    #        distanceBetweenPins = prevPosGrid["Bottom"]
                    #    elif side == "Bottom":
                    #        distanceBetweenPins = prevPosGrid["Top"]
                    if side == ioSide:
                        distanceBetweenPins = trim(
                            ((maxWidth) /
                             (len(combinDict[side][layer]) + 1)),4)
                else:
                    distanceBetweenPins = trim(
                        ((maxHeight) / (len(combinDict[side][layer]) + 1)),4)
            # new tile in following column
            elif resize == 'Width':
                if side in ['Top', 'Bottom']:
                    distanceBetweenPins = trim( 
                        ((maxWidth) / (len(combinDict[side][layer]) + 1)),4)
                elif side == 'Left':
                    distanceBetweenPins = prevPosGrid['Right']
                    if side == ioSide:
                        distanceBetweenPins = trim(
                            ((maxHeight) /
                             (len(combinDict[side][layer]) + 1)),4)
                elif side == 'Right':
                    distanceBetweenPins = prevPosGrid['Left']
                    if side == ioSide:
                        distanceBetweenPins = trim(
                            ((maxHeight) /
                             (len(combinDict[side][layer]) + 1)),4)
                    #if isSuperTile:
            elif not resize:
                # only for terminate tiles last height iteration loop
                # through all terminate tiles
                #if not prevPosGrid:
                if side in ['Top', 'Bottom']:
                    distanceBetweenPins = trim( 
                        ((maxWidth) /
                         (len(combinDict[side][layer]) + 1)),4)
                else:
                    distanceBetweenPins = trim(
                        ((maxHeight) /
                         (len(combinDict[side][layer]) + 1)),4)
                # Super tiles and no resize
                #else:
                #    if side in ['Top', 'Bottom']:
                #        distanceBetweenPins = prevPosGrid[side]
                #    else:
                #        distanceBetweenPins = prevPosGrid[side]
                #    if isSuperTile:
                #        if side == "Top":
                #            distanceBetweenPins = prevPosGrid["Bottom"]
                #        elif side == "Bottom":
                #            distanceBetweenPins = prevPosGrid["Top"]
                #        else:
                #            distanceBetweenPins = prevPosGrid[side]
            if isSuperTile and side in ['Left', 'Right']:
                superPartialHeight = tile.height / superTileCount
                superTileNonOffsetArea = [[marginHorizontal, superPartialHeight - marginHorizontal]]
                for i in range(superTileCount - 1):
                    superTileNonOffsetArea.append([trim(((superPartialHeight + tileOffset) * (i + 1) + marginHorizontal), 4), trim(((superPartialHeight + tileOffset) * (i + 1) + superPartialHeight - marginHorizontal),4)])

            # Snap pins to manufacturing grid
            if side in ['Top', 'Bottom']:
                posManufactureGrid = []
                position = marginVertical
                for pin in combinDict[side][layer]:
                    posManufactureGrid.append(position)
                    position = trim((position + distanceBetweenPins),4)
                # Snap all points
                snappedPositions = [trim((round(x / gridSizeMet2) * gridSizeMet2 + marginVertical),4) for x in posManufactureGrid]
            else:
                posManufactureGrid = []
                position = marginHorizontal
                if isSuperTile:
                    pinSubCount = len(combinDict[side][layer]) / superTileCount 
                    print(pinSubCount)
                    subTileCount = 1
                    for pincount, pin in enumerate(combinDict[side][layer]):
                        for index, area in enumerate(superTileNonOffsetArea):
                            if index == 0:
                                #if (pincount + 2) % pinSubCount == 0:
                                #    position = superTileNonOffsetArea[index + 1][0]
                                #    print(f"position: {position} # case: 1 # pin: {pin} # pincount {pincount}")
                                #    posManufactureGrid.append(position)
                                #    break
                                if (pincount ) % pinSubCount == 0 and pincount != 0 and pincount!= (len(combinDict[side][layer])-1)                         :
                                    position = superTileNonOffsetArea[index + 1][0]
                                    print(pincount)
                                    posManufactureGrid.append(position)
                                    #position = trim((position + distanceBetweenPins),4)
                                    break
                                elif position >= area[0] and position <= area[1]:
                                    #print(f"position: {position} # case: 2 # pin: {pin} # pincount {pincount}")
                                    posManufactureGrid.append(position)
                                    break
                            #elif (pincount + 2) % pinSubCount == 0:
                            #    position = superTileNonOffsetArea[subTileCount][0]
                            #    posManufactureGrid.append(position)
                            #    subTileCount = subTileCount + 1
                                #position = trim((position + distanceBetweenPins),4)
                            #    break
                            else:
                                #if pincount % pinSubCount == 0:
                                #    position = superTileNonOffsetArea[index][0]
                                #    print(pincount)
                                #    posManufactureGrid.append(position)
                                #    #position = trim((position + distanceBetweenPins),4)
                                #    break
                                if position >= superTileNonOffsetArea[index - 1][1] and position <= area[0]:
                                    position = area[0]
                                    posManufactureGrid.append(position)
                                    print(pincount)
                                    break
                                elif position >= area[0] and position <= area[1]:
                                    #print(f"position: {position} # case: 3 # pin: {pin} # pincount {pincount}")
                                    posManufactureGrid.append(position)
                                    break
                        position = trim((position + distanceBetweenPins),4)
                else:
                    for pin in combinDict[side][layer]:
                        posManufactureGrid.append(position)
                        position = trim((position + distanceBetweenPins),4)
                # Snap all points
                snappedPositions = [trim((round(x / gridSizeMet3) * gridSizeMet3 + marginHorizontal),4) for x in posManufactureGrid]#
                

        
            for index, pin in enumerate(combinDict[side][layer]):
                if pin != "NULL":
                    if side == 'Top':
                        pinTcl = [
                            f"place_pin -pin_name {pin} -layer met{layer} -location {{{snappedPositions[index]} {(tile.height - pinDepth/2)}}} -pin_size {{{pinWidth} {pinDepth}}} \n" 
                            #f"place_pin -pin_name {pin} -layer met{layer} -location {{{'%.2f' % (position + margin + 1)} {'%.2f' % (maxHeight + margin * 2 - pinDepth/2)}}} -pin_size {{{pinWidth} {pinDepth}}}   \n" #-force_to_die_boundary
                        ]
                    elif side == 'Bottom':
                        pinTcl = [
                            f"place_pin -pin_name {pin} -layer met{layer} -location {{{snappedPositions[index]} {pinDepth/2}}} -pin_size {{{pinWidth} {pinDepth}}} \n"
                            #f"place_pin -pin_name {pin} -layer met{layer} -location {{{'%.2f' % (position + margin + 1)} {0}}} -pin_size {{{pinWidth} {pinDepth}}}   \n"
                        ]
                    elif side == 'Left':
                        if isSuperTile:
                            #if any(lower <= position <= upper for (lower, upper) in superTileNonOffsetArea):
                            pinTcl = [
                                f"place_pin -pin_name {pin} -layer met{layer} -location {{{pinDepth/2} {snappedPositions[index]}}} -pin_size {{{pinDepth} {pinWidth}}} \n"
                            ]
                        else:
                            pinTcl = [
                                f"place_pin -pin_name {pin} -layer met{layer} -location {{{pinDepth/2} {snappedPositions[index]}}} -pin_size {{{pinDepth} {pinWidth}}} \n"
                                #f"place_pin -pin_name {pin} -layer met{layer} -location {{{0} {'%.2f' % (position + margin + 1)}}} -pin_size {{{pinDepth} {pinWidth}}}   \n"
                            ]
                    elif side == 'Right':
                        if isSuperTile:
                            #if any(lower <= position <= upper for (lower, upper) in superTileNonOffsetArea):
                            pinTcl = [
                                f"place_pin -pin_name {pin} -layer met{layer} -location {{{(tile.width - pinDepth/2)} {snappedPositions[index]}}} -pin_size {{{pinDepth} {pinWidth}}} \n"
                            ]
                        else:
                            pinTcl = [
                                f"place_pin -pin_name {pin} -layer met{layer} -location {{{(tile.width - pinDepth/2)} {snappedPositions[index]}}} -pin_size {{{pinDepth} {pinWidth}}} \n"
                                #f"place_pin -pin_name {pin} -layer met{layer} -location {{{'%.2f' % (maxWidth + margin * 2)} {'%.2f' % (position + margin + 1)}}} -pin_size {{{pinDepth} {pinWidth}}}    \n"
                            ]
                    placerTcl.extend(pinTcl)

            posGrid[side] = distanceBetweenPins

            # check if min pin distance is not met
            if side in ['Top', 'Bottom']:
                if (distanceBetweenPins + pinWidth/2) < gridSizeMet2:
                    notEnoughArea = True
            else:
                if (distanceBetweenPins + pinWidth/2) < gridSizeMet3:
                    notEnoughArea = True
    pinTcl = [
        "\n",
        "place_pins {*}$arg_list -random_seed 42 -hor_layers $HMETAL -ver_layers $VMETAL \n",
        "\n", "write_views", "\n", "report_design_area_metrics"

    ]
    placerTcl.extend(pinTcl)

    f = open(f"{openlaneDir}/openlane/scripts/openroad/ioplacer.tcl")
    data = f.readlines()
    f.close()

    # replace place_pins with generated placement
    cutIndex = [i for i, s in enumerate(data) if 'place_pin' in s]
    if min(cutIndex):
        cutIndex = min(cutIndex)
        data = data[:cutIndex]
    data.extend(placerTcl)
    with open(f"{openlaneDir}/openlane/scripts/openroad/ioplacer.tcl", "w") as f:
        f.writelines(data)
        f.close()

    return posGrid, notEnoughArea


# generate SDC file for timing loops
def timingLoopsKill(name, openlaneDir):
    configText = ["create_clock [get_ports $::env(CLOCK_PORT)]  -name $::env(CLOCK_PORT)  -period $::env(CLOCK_PERIOD) \n",
                  "set clk_indx [lsearch [all_inputs] [get_port $::env(CLOCK_PORT)]]\n",
                  "set all_inputs_wo_clk [lreplace [all_inputs] $clk_indx $clk_indx]\n",
                  "set all_inputs_wo_clk_rst $all_inputs_wo_clk\n",
                  "set_input_delay 1.0  -clock [get_clocks $::env(CLOCK_PORT)] $all_inputs_wo_clk_rst\n",
                  "set_output_delay 2.0  -clock [get_clocks $::env(CLOCK_PORT)] [all_outputs]\n\n",
                  "set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]\n",
                  "set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]\n",
                  "puts \"\[INFO\]: Setting load to: $cap_load\"\n",
                  "set_load  $cap_load [all_outputs]\n\n",
                  "set_disable_timing [get_pins  -hierarchical -regexp {.*J\w*BEG.*}]\n"]
    # generate macro_placement.cfg
    with open(f"{openlaneDir}/designs/{name}/{name}.sdc", "w") as f:
        f.writelines(configText)
        f.close()

