# Current script location
set script_dir [file dirname [file normalize [info script]]]
puts $script_dir

# Get arguments
lassign $argv a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12

# Needed config vars mostly tile files and pdk timing libs and verilog files
set env(CLK_FREQ_MHZ) $a0
set env(TILES_DIR) $a1
set env(FINAL_NL) $a2
set env(NOM_SPEF) $a3
set env(OUTPUT_DIR) $a4
set env(PIPS_FILE) $a5
set env(TOP_NAME) $a6
set env(EXTRA_VERILOG_FILES) $a7
set env(LIB_CORNER_FILE) $a8
set env(TECHMAP_FILES) $a9
set env(TIEHI_CELL_AND_PORT) $a10
set env(TIELO_CELL_AND_PORT) $a11
set env(MIN_BUF_CELL_AND_PORTS) $a12

# Needed config vars mostly tile files and pdk timing libs and verilog files
#source $script_dir/config.tcl

# internal global vars
set env(flat) 0

# internal programs needed for this flow
set _sta sta
set _synth yosys
set _py python3

##########################
# SYNTH MAPPING STAGE
##########################

set env(PHYS_FLOW) 0

exec mkdir -p $::env(OUTPUT_DIR)
exec $_synth -c $script_dir/synth.tcl >@stdout 2>@stderr

# execute the query_generator.py
if {$::env(PHYS_FLOW) == 0} {
    if {$::env(flat) == 0} {
        set script  [file join $script_dir "query_generator.py"]
        set args    [list --nl_hier $::env(OUTPUT_DIR)/$::env(TOP_NAME).nl.syn.v --pips $::env(PIPS_FILE) --out $::env(OUTPUT_DIR)/pips_sta_queries.txt]
    } else {
        set script  [file join $script_dir "query_flat.py"]
        set args    [list --nl $::env(OUTPUT_DIR)/$::env(TOP_NAME).nl.syn.v --pips $::env(PIPS_FILE) --out $::env(OUTPUT_DIR)/pips_sta_queries.txt]
    }
    
    set cmd     [list $_py $script]        
    try {
        puts "\nGenerating PIPS query-file for STA (SYNTH MAPPIG)...\n"
        [exec {*}$cmd {*}$args]
    } on error {msg} {
        puts -nonewline stderr $msg
        puts "\n"
    }
}

# execute the tm_model.py
puts "\nMap query-file to tcl dict ..."
exec $_py $script_dir/tm_model.py $::env(OUTPUT_DIR)/pips_sta_queries.txt  > $::env(OUTPUT_DIR)/pips_sta_map.tcl
exec $_sta -no_splash -threads 10 -exit $script_dir/sta.tcl >@stdout 2>@stderr

##########################
# PHYSICAL MAPPING STAGE
##########################

set env(PHYS_FLOW) 1

if {$::env(PHYS_FLOW) == 1} {
exec mkdir -p $::env(OUTPUT_DIR)/PHYS
set env(OUTPUT_DIR) $::env(OUTPUT_DIR)/PHYS
}

# execute the query_flat.py
if {$::env(PHYS_FLOW) == 1} {
    set script  [file join $script_dir "query_flat.py"]
    set args    [list --nl $::env(FINAL_NL) --pips $::env(PIPS_FILE) --out $::env(OUTPUT_DIR)/pips_sta_queries.txt]
    set cmd     [list $_py $script]         

    try {
        puts "\nGenerating PIPS query-file for STA (PHYSICAL MAPPING) ...\n"
        [exec {*}$cmd {*}$args]
    } on error {msg} {
        puts -nonewline stderr $msg
        puts "\n"
    }
}
# execute the tm_model.py
puts "\nMap query-file to tcl dict ..."
exec $_py $script_dir/tm_model.py $::env(OUTPUT_DIR)/pips_sta_queries.txt  > $::env(OUTPUT_DIR)/pips_sta_map.tcl
exec $_sta -no_splash -threads 10 -exit $script_dir/sta.tcl >@stdout 2>@stderr

##########################
# MERGING MAPPING STAGE
##########################

set env(OUTPUT_DIR) $::env(OUTPUT_DIR)/../
puts "\nGenerating FINAL PIPS file (COMB MERGING)...\n"
exec mkdir -p $::env(OUTPUT_DIR)/FINAL
exec $_py $script_dir/merge.py $::env(OUTPUT_DIR)/$::env(TOP_NAME).pips.txt $::env(OUTPUT_DIR)/PHYS/$::env(TOP_NAME).pips.txt -o $::env(OUTPUT_DIR)/FINAL/$::env(TOP_NAME).pips_tm.txt

puts "\nDONE\n"













