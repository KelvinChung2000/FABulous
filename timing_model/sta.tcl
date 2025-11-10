read_liberty $::env(LIB_CORNER_FILE)

### FIXME: Bad pattern ###
#read_liberty ./lib/cs_buf.lib
######

if {$::env(PHYS_FLOW) == 0} {
read_verilog $::env(OUTPUT_DIR)/$::env(TOP_NAME).nl.syn.v
}
if {$::env(PHYS_FLOW) == 1} {
read_verilog $::env(FINAL_NL)
}

link_design  $::env(TOP_NAME)

if {$::env(PHYS_FLOW) == 1} {
read_spef    $::env(NOM_SPEF)
}

proc calc_delay {SRC DST} {
    
    try {

        set SRC_str "$SRC"
        set DST_str "$DST"
        
        set SRC [get_pins $SRC]
        set DST [get_pins $DST]

        # make the source pin a virtual clock origin
        create_clock -name P2P_CLK -period 0.0 $SRC

        # tell STA to stop timing at the destination pin
        set_output_delay 0.0 -clock P2P_CLK $DST

        # now the path is constrained, so the normal report works
        #report_checks -from $SRC -to $DST -format summary

        set path  [lindex [find_timing_paths -from $SRC -to $DST] 0]

        # |slack| = cell delay If clock period is zero
        set slack [get_property -object_type path $path slack]

        set start [get_property -object_type pin [get_property -object_type path $path startpoint] full_name]
        set end [get_property -object_type pin [get_property -object_type path $path endpoint] full_name]

        set delay [expr {abs($slack)}]

        #puts "\nSource Pin: $start"
        #puts "Destination pin: $end"
        #puts [format "Delay: %.6f ns" $delay]

        return $delay

    } on error {errMsg errDict} {
        # puts "\[WARN\] Path not found or empty: set 0 delay for: $SRC_str -> $DST_str"
        # puts stderr "Error: $errMsg"
        return Inf
    }
}

proc replaceField5 {csv newValue} {
    # treat the CSV as a list - split on ',' and join on ','
    set fields [split $csv ","]

    # Index 4 is the value between the 4th and 5th comma
    if {[llength $fields] >= 5} {
        lset fields 4 $newValue
        return [join $fields ","]
    } else {
        return $csv
    }
}

# set result [calc_delay Inst_LUT4AB_switch_matrix/inst_cus_mux41_buf_J2MID_CDb_BEG1/A0 Inst_LUT4AB_switch_matrix/_085_/X]

#=================================================================================================================================

set_disable_timing [get_ports FrameData]

source $::env(OUTPUT_DIR)/pips_sta_map.tcl
set fh [open $::env(OUTPUT_DIR)/$::env(TOP_NAME).pips.txt "a"]
set line_num [exec wc -l < $::env(PIPS_FILE)]
incr line_num
set line_count 1

set current_delay Inf
dict for {key outerlist} $pips_q {
    foreach src_list [lindex $outerlist 0]  {
        foreach dst_list [lindex $outerlist 1] {
            set result [calc_delay $src_list $dst_list]        
            if {$result < $current_delay} {
                set current_delay $result
            } 
        }
    }
    if {$current_delay == Inf} {
        puts "\[WARN\] Path not found or empty: set NONE delay for:"
        set current_delay NONE
    }

    set file_content [replaceField5 $key $current_delay]
    puts "\[$line_count/$line_num\] $file_content"
    puts $fh $file_content
    incr line_count

    set current_delay Inf
}

close $fh
