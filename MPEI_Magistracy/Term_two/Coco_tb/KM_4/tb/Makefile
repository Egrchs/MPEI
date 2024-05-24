# Директория с RTL
VERILOG_DIRS = ../src
RTL_FILEPATHS = $(foreach dir, $(VERILOG_DIRS), $(wildcard $(addprefix $(dir)/*,*.v)))

# Выбор симулятора
SIM ?= icarus

# Выбор языка симуляции
TOPLEVEL_LANG ?= verilog

# Расположение файла с исходниками
VERILOG_SOURCES += ${RTL_FILEPATHS}

# Имя модуля верхнего уровня в RTL-описании
TOPLEVEL = Bus

# Имя тестового модуля
MODULE = test_bus_reset

# Настройка симулятора с помощью готовых предустановок
include $(shell cocotb-config --makefiles)/Makefile.sim