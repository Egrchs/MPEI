import cocotb
import random
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def adder_model(A,B):
    Y = A + B
    return Y

@cocotb.test()

async def adder_randomised_test(dut):
    """Test for adding 2 random numbers multiple times"""

    for i in range(30):
        A = random.randint(0, 15)
        B = random.randint(0, 15)

        dut.A.value = A
        dut.B.value = B
        print (" ")
        print (f" {dut.A.value} + {dut.B.value} = {dut.SUM.value} " )
        print (" ")
        await Timer(2, units="ns")

        assert dut.SUM.value == adder_model(
            A, B
        ), f"Рандомизированный тест не прошел: {dut.A.value} + {dut.B.value} = {dut.SUM.value}"