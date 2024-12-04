# Выбор симулятора
SIM ?= icarus
# Выбор языка симуляции
TOPLEVEL_LANG ?= verilog
# Расположение файла с исходниками
VERILOG_SOURCES += Bus.v
# Имя модуля верхнего уровня в RTL-описании
TOPLEVEL = Bus
# Имя тестового модуля
# MODULE = testbench_LATCH
MODULE = test_bus_reset
# Настройка симулятора с помощью готовых предустановок
include $(shell cocotb-config --makefiles)/Makefile.sim


