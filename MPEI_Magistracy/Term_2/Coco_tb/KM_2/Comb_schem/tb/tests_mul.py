import cocotb
import random
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def mul_model(A,B):
    Y = A * B
    return Y

@cocotb.test()

async def adder_randomised_test(dut):
    """Test for adding 2 random numbers multiple times"""

    for i in range(30):
        A = random.randint(0, 15)
        B = random.randint(0, 15)

        dut.in1.value = A
        dut.in2.value = B
        print (" ")
        print (f" {dut.in1.value} * {dut.in2.value} = {dut.pro.value} " )
        print (" ")
        await Timer(2, units="ns")

        assert dut.pro.value == mul_model(
            A, B
        ), f"Рандомизированный тест не прошел: {dut.in1.value} * {dut.in2.value} = {dut.pro.value}"