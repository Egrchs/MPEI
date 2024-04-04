#!/bin/bash
rm ../dump/*
iverilog -g2009 -I ../src -o ../dump/sim.out $1 $2
vvp ../dump/sim.out
gtkwave ../dump/wave.vcd