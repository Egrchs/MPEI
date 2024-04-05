# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

### SOURCES for 3 mark
# VERILOG_SOURCES += ../src/osu035_stdcells.v

### SOURCES for 4 mark
# VERILOG_SOURCES += ../src/four_bit_adder.v
# VERILOG_SOURCES += ../src/seven.v

### SOURCES for 5 mark
# VERILOG_SOURCES += ../src/x2b.v

# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file

### HDL for 3 mark
# TOPLEVEL = FAX1
# TOPLEVEL = HAX1
# TOPLEVEL = NOR3X1
# TOPLEVEL = OAI22X1
# TOPLEVEL = AND2X1
# TOPLEVEL = NOR2X1
# TOPLEVEL = OAI21X1

### HDL for 4 mark
# TOPMODULE = seven
# TOPMODULE = four_bit_adder

### HDL for 5 mark
# TOPLEVEL = x2b

# MODULE is the basename of the Python test file

### Tests for 3 mark
# MODULE = tests_FAX1_factory
# MODULE = tests_HAX1_factory
# MODULE = tests_NOR3x1
# MODULE = tests_OAI22X1
# MODULE = tests4AND2x1
# MODULE = tests4NOR2X1
# MODULE = tests4OAI21X1

### Tests for 4 mark
# MODULE = tests_seven
# MODULE = tests_adder

### Tests for 5 mark
# MODULE = tests_x2b

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
