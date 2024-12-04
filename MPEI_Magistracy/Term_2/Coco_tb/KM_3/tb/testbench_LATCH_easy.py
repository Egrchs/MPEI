import cocotb 
from cocotb.triggers import Timer

prev_result = 0

# 10 - CLK/D

# Проверка на 10
@cocotb.test()
async def oneZero(dut):
    """Реакция на 10"""
    dut.CLK.value = 1
    dut.D.value   = 0
    prev_result = 0

    #Ждём 1 нс
    await Timer(1, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на 10 - это {result}")
    print("")
    assert result == 0, "Результат не 0!"

# Проверка на 00
@cocotb.test()
async def zeroZero(dut):
    """Реакция на 00"""
    dut.CLK.value = 0
    dut.D.value = 0

    #Ждём 1 нс
    await Timer(1, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на 00 - это {result}")
    print("")
    assert result == prev_result, f"Результат не {prev_result}!"

# Проверка на 11
@cocotb.test()
async def oneOne(dut):
    """Реакция на 10"""
    dut.CLK.value = 1
    dut.D.value   = 1
    prev_result   = 1

    #Ждём 1 нс
    await Timer(1, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на 10 - это {result}")
    print("")
    assert result == 1, "Результат не 1!"

# Проверка на 01
@cocotb.test()
async def zeroOne(dut):
    """Реакция на 01"""
    dut.CLK.value = 1 
    dut.D.value = 0

    #Ждём 1 нс
    await Timer(1, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на 01 - это {result}")
    print("")
    assert result == prev_result, f"Результат не {prev_result}!"