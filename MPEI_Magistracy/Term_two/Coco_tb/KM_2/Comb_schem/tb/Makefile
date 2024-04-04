# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += ../src/osu035_stdcells.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
# TOPLEVEL = AND2X1
# TOPLEVEL = NOR2X1
TOPLEVEL = OAI2X1
# TOPLEVEL = AND2X1
# TOPLEVEL = AND2X1

# MODULE is the basename of the Python test file
# MODULE = tests4and2X1
# MODULE = tests4NOR2X1
MODULE = tests4OAI2X1
# MODULE = tests4and2x1
# MODULE = tests4and2x1

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
