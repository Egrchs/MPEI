import cocotb 
from cocotb.triggers import Timer

prev_result = 0

# 10 - D/CLK/R/S

# Проверка на 0100
@cocotb.test()
async def t0100(dut):
    """Реакция на 0100"""
    dut.CLK.value = 0
    dut.D.value   = 0
    dut.R.value   = 0
    dut.S.value   = 0
    prev_result   = 1
    await Timer(1, units="ns")
    dut.CLK.value = 1
    #Ждём 1 нс
    await Timer(1, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на 0100 - это {result}")
    print("")
    assert result == 0, "Результат не 0!"


# Проверка на 1100
@cocotb.test()
async def t1100(dut):
    """Реакция на 1000"""
    dut.CLK.value = 0
    dut.D.value   = 1
    dut.R.value   = 0
    dut.S.value   = 0

    result = dut.Q.value
    print("")
    print(f"Реакция до - это {result}")

    await Timer(1, units="ns")
    dut.CLK.value = 1
    #Ждём 1 нс
    await Timer(10, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на 1100 - это {result}")
    print("")
    assert result == 1, "Результат не 1!"
 
# Проверка на SET
@cocotb.test()
async def tSET(dut):
    """Реакция на 0001"""
    dut.CLK.value = 0
    dut.D.value   = 0
    dut.R.value   = 0
    dut.S.value   = 1

    #Ждём 1 нс
    await Timer(1, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на SET - это {result}")
    print("")
    assert result == 1, "Результат не 1!"
 
 # Проверка на RST
@cocotb.test()
async def tRST(dut):
    """Реакция на 0010"""
    dut.CLK.value = 0
    dut.D.value   = 0
    dut.R.value   = 1
    dut.S.value   = 0

    #Ждём 1 нс
    await Timer(1, units="ns")
    result = dut.Q.value
    print("")
    print(f"Реакция на RST - это {result}")
    print("")
    assert result == 0, "Результат не 0!"