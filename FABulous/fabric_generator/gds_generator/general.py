import os
import re
import shutil


# extract pin info out of synthesis file and config
def initialRunCombinDict(synthesisFile, frameBitsPerRow, maxFramesPerCol,
                         pinSides, isSuperTile):
    pinWires = {}
    pinDict = {}
    f = open(synthesisFile)
    data = f.read()
    f.close()
    unprocessedPinsSynthesis = re.findall("\w+ \[(\d+)\:(\d+)\] (\w+)", data)
    for pin in unprocessedPinsSynthesis:
        pinWires[pin[2]] = int(pin[0]) - int(pin[1]) + 1
    
    if isSuperTile:
        matches = [pin for pin in pinSides if "FrameData" in pin]
        for pin in matches:
            pinWires[pin] = frameBitsPerRow
        matches = [pin for pin in pinSides if "FrameStrobe" in pin]
        for pin in matches:
            pinWires[pin] = maxFramesPerCol
        matches = [pin for pin in pinSides if "UserCLK" in pin]
        for pin in matches:
            pinWires[pin] = 1
    else:
        pinWires["FrameData"] = frameBitsPerRow
        pinWires["FrameData_O"] = frameBitsPerRow
        pinWires["FrameStrobe"] = maxFramesPerCol
        pinWires["FrameStrobe_O"] = maxFramesPerCol
        pinWires["UserCLK"] = 1
        pinWires["UserCLKo"] = 1
    temp = {}
    temp["Top"] = []
    temp["Bottom"] = []
    temp["Right"] = []
    temp["Left"] = []

    for pin in pinSides:
        pinBundle = []
        if pin in pinWires:
            if pinWires[pin] == 1:
                pinBundle.append(f"{pin}")
            else:
                for num in range(pinWires[pin]):
                    pinBundle.append(f"{pin}[{num}]")
            temp[pinSides[pin]].extend(pinBundle)
        elif not isSuperTile:
            pinBundle.append(f"{pin}")
            temp[pinSides[pin]].extend(pinBundle)
    layer = {}
    layer[2] = temp["Top"]
    pinDict["Top"] = layer
    layer = {}
    layer[2] = temp["Bottom"]
    pinDict["Bottom"] = layer
    layer = {}
    layer[3] = temp["Right"]
    pinDict["Right"] = layer
    layer = {}
    layer[3] = temp["Left"]
    pinDict["Left"] = layer

    return pinDict


# generates list of how pins are interconnected
def generate_pin_pairs(synthesisFile, fabricGen, tileName):
    pairNameBuf = ""
    pinsSynthesis = {}
    portPairs = {}
    noConnectionPin = []

    f = open(synthesisFile)
    data = f.read()
    f.close()

    unprocessedPinsSynthesis = re.findall("\w+ \[(\d+)\:(\d+)\] (\w+)", data)
    for pin in unprocessedPinsSynthesis:
        pinsSynthesis[pin[2]] = int(pin[0]) - int(pin[1]) + 1

    # get all pin pairs
    internPins = fabricGen.fabric.getTileByName(tileName).getPortPairs()
    for pair in internPins:
        if 'NULL' not in pair:
            if pair[0] == pairNameBuf:
                tempA = pair[0]
                tempB = pair[1]
                pair[0] = tempB
                pair[1] = tempA
            else:
                pairNameBuf = pair[0]
            if pair[2] == 1:
                portPairs[pair[0]] = pair[1]
            else:
                for i in range(pinsSynthesis[pair[0]]):
                    nameSource = f"{pair[0]}[{i}]"
                    portPairs[nameSource] = f"{pair[1]}[{i}]"
        elif ('NULL' in pair and pair[3] != 'NULL'):
            if pair[2] == 1:
                # portPairs[pair[3]] = "NULL"
                noConnectionPin.append(f"{pair[3]}")
            else:
                for i in range(pinsSynthesis[pair[3]]):
                    # nameSource = f"{pair[3]}[{i}]"
                    # portPairs[nameSource] = "NULL"
                    noConnectionPin.append(f"{pair[3]}[{i}]")
    # pairTemp = ""
    # for pair in pairsToPair:
    #     if pairTemp:
    #         for i in range(pinsSynthesis[pair]):
    #             nameSource = f"{pair}[{i}]"
    #             portPairs[nameSource] = f"{pairTemp}[{i}]"
    #             nameSource = f"{pairTemp}[{i}]"
    #             portPairs[nameSource] = f"{pair}[{i}]"
    #         pairTemp = ""
    #     else:
    #         pairTemp = pair

    # add strobe and data
    for i in range(fabricGen.fabric.frameBitsPerRow):
        portPairs[f"FrameData[{i}]"] = f"FrameData_O[{i}]"
        portPairs[f"FrameData_O[{i}]"] = f"FrameData[{i}]"
    for i in range(fabricGen.fabric.maxFramesPerCol):
        portPairs[f"FrameStrobe[{i}]"] = f"FrameStrobe_O[{i}]"
        portPairs[f"FrameStrobe_O[{i}]"] = f"FrameStrobe[{i}]"

    return portPairs, noConnectionPin


# check for string in textfile
def check_string(datafile, keyword):
    for line in datafile:
        if keyword in line:
            return True
    return False


# log for tile resizing steps
def writeLog(lines, file, mode):
    f = open(file, mode)
    for line in lines:
        f.write(line)
    f.close()


# copy and overwrite a file
def copyAndOverwrite(src, dest):
    if os.path.exists(dest):
        shutil.rmtree(dest)
    shutil.copytree(src, dest)


# returns False when no error in area/sizing and True when area to small
def check_flow(openlaneDir, tileName, interruptFlow, logger, olRun):
    if os.path.exists(
            f"{openlaneDir}/designs/{tileName}/runs/{olRun}/warning.log"):
        with open(f"{openlaneDir}/designs/{tileName}/runs/{olRun}/warning.log", "r") as f:
            datafile = f.readlines()
            if check_string(datafile, "Hold violations found in the following corners"):
                return True, False
            if check_string(datafile, "core area is too small"):
                if not interruptFlow:
                    return True, False
                else:
                    raise ValueError(
                        f"Tile {tileName} is sized wrong in fabric.csv. Try making your floorplan larger or run gen_openlane_fab with '-r' or '-resize'."
                    )

    if os.path.exists(
            f"{openlaneDir}/designs/{tileName}/runs/{olRun}/error.log"):
        if os.stat(f"{openlaneDir}/designs/{tileName}/runs/{olRun}/error.log").st_size > 0:
            with open(f"{openlaneDir}/designs/{tileName}/runs/{olRun}/error.log",
                      "r") as f:
                datafile = f.readlines()
                if check_string(
                        datafile, "resizer_routing_design") or check_string(
                            datafile, "Try making your floorplan area larger"
                        ) or check_string(
                            datafile,
                            "Routing congestion too high") or check_string(
                                datafile,
                                "resizer_routing_timing.tcl") or check_string(
                                    datafile, "floorplan") or check_string(
                                        datafile, "Step 26 (routing)") or check_string(datafile, "quit_on_magic_drc") or check_string(datafile, "exceeds 100%"):
                    if not interruptFlow:
                        return True, False
                    else:
                        raise ValueError(
                            f"Tile {tileName} is sized wrong in fabric.csv. Try making your floorplan larger or run gen_openlane_fab with '-r' or '-resize'."
                        )
                elif check_string(
                        datafile,
                        "There are setup violations in the design at the Typical corner."
                ):
                    logger.warning(
                        "There are setup violations in the design at the Typical corner"
                    )
                    return False, False
                elif check_string(
                    datafile,
                    "Use a higher -density"
                ):
                    return False, True
                else:
                    raise ValueError(
                        f"Unknown error in running OpenLane flow for tile {tileName}. Check OpenLane error logs for the tile."
                    )
        else:
            logger.info(f"{tileName} OpenLane flow succeeded.")
            return False, False


# keep initial order for not resized pin sides and take new calculated ones
# for resized pin sides
def fixUpdateOrder(combinDict, initCombinDict, prevTilePinOrderChange,
                   resizeDim, ioSide, cornerPos, lastTermLoop):
    pinOrderChangeTemp = {}
    pinOrderChange = {}
    fixedCombinDict = {}
    prevTile = {}
    init = {}

    # initial index initiation for ordering
    for side in initCombinDict:
        init[side] = {}
        for layer in initCombinDict[side]:
            init[side][layer] = []
            for index, pin in enumerate(initCombinDict[side][layer]):
                init[side][layer].append(index)

    # for start tile only
    if not prevTilePinOrderChange:
        prevTile = init
    else:
        # Super tile pin extend or decrease if previous tile was super tile
        if len(prevTilePinOrderChange["Left"]) < len(init["Left"]) or (len(prevTilePinOrderChange["Right"]) < len(init["Right"])):
            sizeFactor = len(init["Left"]) / len(prevTilePinOrderChange["Left"])
            for side in prevTilePinOrderChange:
                prevTile[side] = prevTilePinOrderChange[side]
                for i in range(0, sizeFactor - 1):
                    prevTile[side].extend([(len(prevTilePinOrderChange[side]) * i + 1) + x for x in prevTilePinOrderChange[side]])
        elif len(prevTilePinOrderChange["Left"]) > len(init["Left"]) or (len(prevTilePinOrderChange["Right"]) > len(init["Right"])):
            sizeFactor = len(prevTilePinOrderChange["Left"]) / len(init["Left"])
            for side in prevTilePinOrderChange:
                x = int(len(prevTilePinOrderChange[side])/ sizeFactor)
                prevTile[side] = prevTilePinOrderChange[side][:x]
        else:
            prevTile = prevTilePinOrderChange
    # only in opt flow
    if combinDict:
        # changes to initial pin order
        for side in initCombinDict:
            pinOrderChangeTemp[side] = {}
            pinOrderChange[side] = {}
            for layer in initCombinDict[side]:
                pinOrderChangeTemp[side][layer] = []
                for pin in initCombinDict[side][layer]:
                    pinIndex = combinDict[side][layer].index(pin)
                    pinOrderChangeTemp[side][layer].append(pinIndex)
    # only in initial resize flow
    else:
        pinOrderChangeTemp = prevTile

    # change new change indexes depending on resizing / sides
    if resizeDim == "Both":
        pinOrderChange = pinOrderChangeTemp

    elif resizeDim == "Width":
        if ioSide == "Right":
            pinOrderChange["Right"] = init["Right"]
            pinOrderChange["Left"] = pinOrderChangeTemp["Left"]
        elif ioSide == "Left":
            pinOrderChange["Left"] = init["Left"]
            pinOrderChange["Right"] = pinOrderChangeTemp["Right"]
        else:
            pinOrderChange["Right"] = pinOrderChangeTemp["Right"]
            pinOrderChange["Left"] = pinOrderChangeTemp["Left"]

        if not combinDict:
            pinOrderChange["Top"] = init["Top"]
            pinOrderChange["Bottom"] = init["Bottom"]
        else:
            # if isSuperTile:
            #    pinOrderChange["Top"] = pinOrderChangeTemp["Bottom"]
            #    pinOrderChange["Bottom"] = pinOrderChangeTemp["Top"]
            pinOrderChange["Top"] = pinOrderChangeTemp["Top"]
            pinOrderChange["Bottom"] = pinOrderChangeTemp["Bottom"]

    elif resizeDim == "Height":
        #if isSuperTile:
        #    pinOrderChange["Top"] = pinOrderChangeTemp["Bottom"]
        #    pinOrderChange["Bottom"] = pinOrderChangeTemp["Top"]
        #else:
        pinOrderChange["Top"] = pinOrderChangeTemp["Top"]
        pinOrderChange["Bottom"] = pinOrderChangeTemp["Bottom"]

        if ioSide == "Top" or cornerPos == "Top":
            pinOrderChange["Top"] = init["Top"]
        elif ioSide == "Bottom" or cornerPos == "Bottom":
            pinOrderChange["Bottom"] = init["Bottom"]

        if not combinDict:
            pinOrderChange["Right"] = init["Right"]
            pinOrderChange["Left"] = init["Left"]
        else:
            pinOrderChange["Right"] = pinOrderChangeTemp["Right"]
            pinOrderChange["Left"] = pinOrderChangeTemp["Left"]

    elif not resizeDim:
        #if isSuperTile:
        #    pinOrderChange["Top"] = pinOrderChangeTemp["Bottom"]
        #    pinOrderChange["Bottom"] = pinOrderChangeTemp["Top"]
        #    pinOrderChange["Right"] = pinOrderChangeTemp["Right"]
        #    pinOrderChange["Left"] = pinOrderChangeTemp["Left"]
        if ioSide:
            pinOrderChange = init
            if ioSide == "Top" or cornerPos == "Top":
                pinOrderChange["Bottom"] = pinOrderChangeTemp["Bottom"]
            elif ioSide == "Bottom" or cornerPos == "Bottom":
                pinOrderChange["Top"] = pinOrderChangeTemp["Top"]
        else:
            pinOrderChange = pinOrderChangeTemp
    
    # update pin order in combinDict
    if (lastTermLoop or ioSide in ["Right", "Left"]):        # ((isSuperTile and ioSide) or lastTermLoop or ioSide in ["Right", "Left"]):
        for side in pinOrderChange:
            fixedCombinDict[side] = {}
            for layer in pinOrderChange[side]:
                fixedCombinDict[side][layer] = []
                for pinIndex in pinOrderChange[side][layer]:
                    if pinIndex >= len(initCombinDict[side][layer]):
                        fixedCombinDict[side][layer].append("NULL")
                    else:
                        fixedCombinDict[side][layer].append(
                            initCombinDict[side][layer][pinIndex])
    else:
        for side in pinOrderChange:
            fixedCombinDict[side] = {}
            for layer in pinOrderChange[side]:
                fixedCombinDict[side][layer] = []
                for pinIndex in pinOrderChange[side][layer]:
                    fixedCombinDict[side][layer].append(
                        initCombinDict[side][layer][pinIndex])

    return fixedCombinDict, pinOrderChange
