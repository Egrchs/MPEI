# Директория с RTL
# VERILOG_DIRS = ../src
# $(info VERILOG_DIRS  = $(VERILOG_DIRS))

# RTL_FILEPATHS = $(foreach dir, $(VERILOG_DIRS), $(wildcard $(addprefix $(dir)/*,*.v)))
# $(info RTL_FILEPATHS = $(RTL_FILEPATHS))

# Выбор симулятора
SIM ?= icarus

# Выбор языка симуляции
TOPLEVEL_LANG ?= verilog

# Расположение файла с исходниками
VERILOG_SOURCES += ../src/Bus.v

# Имя модуля верхнего уровня в RTL-описании
TOPLEVEL = Bus

# Имя тестового модуля
MODULE = test_bus_reset

# Настройка симулятора с помощью готовых предустановок
include $(shell cocotb-config --makefiles)/Makefile.sim