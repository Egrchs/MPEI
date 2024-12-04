import cocotb 
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.regression import TestFactory

# Проверка 
@cocotb.test(skip = True)
async def reset(dut):
    cocotb.start_soon(Clock(dut.CLK, 2, units="ns").start())
    dut.reset.value = 0
    dut.D.value = D

async def test(dut,D):
    """Проверка на все возможные комбинации входных переменных"""
    dut.reset.value = 0
    cocotb.start_soon(Clock(dut.CLK, 2, units="ns").start())
    dut.D.value = D


    #Ждём 5
    await ClockCycles (dut.CLK, 1)
    result = dut.Q.value
    
    print("")
    print(f"Реакция на  {dut.D.value} - это {result}")
    print("")
    trueResult = model(dut.CLK.value,D)
    assert result == trueResult, f"Результат не {trueResult}!"
    
tf = TestFactory(test_function=test)
tf.add_option(name='D', optionlist=[0, 1])
tf.generate_tests()