import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def fax(A,B):
    Y = [0,0]
    Y[0] = ((A&B))&1
    Y[1] = (A^B)&1
    return Y

@cocotb.test(skip=True)
async def test(dut,A,B):

    dut.A.value = A
    dut.B.value = B


    await Timer(1, units ="ns")
    result1 = dut.YC.value
    result2 = dut.YS.value
    print (" ")
    print (f"Реакция на {dut.A.value}{dut.B.value}- это YC= {result1} YS= {result2}" )
    print (" ")
    trueResult = fax(A,B)

    assert result1 == trueResult[0], f"Результат не {trueResult[0]}!"
    assert result2 == trueResult[1], f"Результат не {trueResult[1]}!"

tf = TestFactory(test_function=test)
tf.add_option(name='A',optionlist=[0,1])
tf.add_option(name='B',optionlist=[0,1])
tf.generate_tests()