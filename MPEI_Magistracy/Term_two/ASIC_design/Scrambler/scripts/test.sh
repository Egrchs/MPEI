#!/bin/bash
rm ../dump/*
cd ../ 
iverilog -g2012 -f rtl_filelist.f -f sim_filelist.f -o dump/sim.out
vvp dump/sim.out
if [[ $1 -eq 1 ]] then
    gtkwave dump/wave.vcd
fi