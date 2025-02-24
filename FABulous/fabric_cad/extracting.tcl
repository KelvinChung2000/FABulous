
package require json

proc readJsonFile {filePath} {
    set fileId [open $filePath r]
    set jsonData [read $fileId]
    close $fileId
    set parsedData [json::json2dict $jsonData]
    return $parsedData
}


yosys read_verilog -sv /Users/kelvin/FABulous/myProject/Tile/PE/ALU.v
yosys hierarchy -auto-top
yosys proc
yosys design -save base
#connect -set
yosys opt;;;
set stat [yosys tee -s result.json stat -json]
set cell_count [dict get $stat design num_cells ]

set design [yosys tee write_json]
