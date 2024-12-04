import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def OAI(A,B,C,D):
    Y= ~((A|B)&(D|C))&1
    return Y

@cocotb.test(skip=True)
async def test(dut,A,B,C,D):

    dut.A.value = A
    dut.B.value = B
    dut.C.value = C
    dut.D.value = D

    await Timer(1, units ="ns")
    result = dut.Y.value
    print (" ")
    print (f"Реакция на {dut.A.value}{dut.B.value}{dut.C.value}{dut.D.value}- это = {result}" )
    print (" ")
    trueResult = OAI(A,B,C,D)
    print(trueResult)

    assert result == trueResult, f"Результат не {trueResult}!"

tf = TestFactory(test_function=test)
tf.add_option(name='A',optionlist=[0,1])
tf.add_option(name='B',optionlist=[0,1])
tf.add_option(name='C',optionlist=[0,1])
tf.add_option(name='D',optionlist=[0,1])
tf.generate_tests()