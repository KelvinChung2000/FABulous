yosys -import

proc load_verilog_files {dir {exclude {}}} {
    # Skip this directory if its basename is in the exclude list
    if {[lsearch -exact $exclude [file tail $dir]] >= 0} { return }

    # Read .v files in this directory
    foreach file [glob -nocomplain -directory $dir -type f -- *.v] {
        read_verilog -overwrite -sv $file
        puts $file
    }

    # Recurse into subdirectories (skip basenames in exclude list)
    foreach subdir [glob -nocomplain -directory $dir -type d -- *] {
        if {[lsearch -exact $exclude [file tail $subdir]] >= 0} { continue }
        load_verilog_files $subdir $exclude
    }
}

load_verilog_files $::env(TILES_DIR) {macro timing_model}
read_verilog -sv $::env(EXTRA_VERILOG_FILES)

### FIXME: Bad pattern ###
#read_liberty -lib ./lib/cs_buf.lib
######

# Default synth script
if {$::env(flat) == 1} {
    synth -flatten -top $::env(TOP_NAME)
} else {
    synth -top $::env(TOP_NAME)
}

# Top module name should be TOP_NAME
renames -top $::env(TOP_NAME)
renames -wire

#opt -purge -full

# Handle technology mapping
techmap -map $::env(TECHMAP_FILES)
simplemap

# Maps clock gates
clockgate -liberty  $::env(LIB_CORNER_FILE)

# Map flip flops to the technology
dfflibmap -liberty $::env(LIB_CORNER_FILE)

# opt -purge -full

# x-vals to logic 0
setundef -zero

# Replace assign with bufers, TIHI TILO map, infer tristates
splitnets
hilomap -hicell {*}$::env(TIEHI_CELL_AND_PORT) -locell {*}$::env(TIELO_CELL_AND_PORT)
insbuf -buf {*}$::env(MIN_BUF_CELL_AND_PORTS)
tribuf

### FIXME: Bad pattern ###
#delete my_buf
#delete break_comb_loop
#techmap -map ./lib/techmap/buf_map.v 
######


# Map combinational logic to standard cells
abc -D [expr 1000000 / $::env(CLK_FREQ_MHZ)] -liberty $::env(LIB_CORNER_FILE)

# Remove unwanted stff
opt -purge -full

# Emit netlist
write_verilog -noattr -noexpr $::env(OUTPUT_DIR)/$::env(TOP_NAME).nl.syn.v

# Some stats
tee -o $::env(OUTPUT_DIR)/synth_check.txt check -mapped
tee -o $::env(OUTPUT_DIR)/synth_stat.txt stat -top $::env(TOP_NAME) -liberty $::env(LIB_CORNER_FILE) -tech cmos













