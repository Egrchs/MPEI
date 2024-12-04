#!/bin/bash
# rm ../dump/*
# cd ../tb 
iverilog -o sim.vvp tb.v #-c command.f -f rtl_filelist.f -f sim_filelist.f
vvp sim.vvp +z=1
# mv sim.out wave.vcd dump/
# if [[ $1 -eq 1 ]] then
#     gtkwave dump/wave.vcd
# fi