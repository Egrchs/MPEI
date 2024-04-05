import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def fax(A,B,C):
    Y = [0,0]
    Y[0] = ((A&B)|(B&C)|(A&C))&1
    Y[1] = (A^B^C)&1
    return Y

@cocotb.test(skip=True)
async def test(dut,A,B,C):

    dut.A.value = A
    dut.B.value = B
    dut.C.value = C

    await Timer(1, units ="ns")
    result1 = dut.YC.value
    result2 = dut.YS.value
    print (" ")
    print (f"Реакция на {dut.A.value}{dut.B.value}{dut.C.value}- это YC= {result1} YS= {result2}" )
    print (" ")
    trueResult = fax(A,B,C)

    assert result1 == trueResult[0], f"Результат не {trueResult[0]}!"
    assert result2 == trueResult[1], f"Результат не {trueResult[1]}!"

tf = TestFactory(test_function=test)
tf.add_option(name='A',optionlist=[0,1])
tf.add_option(name='B',optionlist=[0,1])
tf.add_option(name='C',optionlist=[0,1])
tf.generate_tests()