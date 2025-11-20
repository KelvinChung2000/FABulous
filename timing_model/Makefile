# This Makefile runs the timing model:
# First it creates the the open sta queries for the pips that
# are mapped to the netlist std-cell pins
# then this queries are converted to an tcl-dictionary to
# store it in memory to avoid ongoing IO operations
# Then open sta can loop through this dict to calc the delay ...

all:
	tclsh flow.tcl
