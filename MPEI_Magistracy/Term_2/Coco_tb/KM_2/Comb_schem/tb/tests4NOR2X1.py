import cocotb
from cocotb.triggers import Timer

######################################################
# Вариант тестирования с фабрикой                    #
######################################################
        
from cocotb.regression import TestFactory
    
def model(A, B):
    Y = not(A or B)
    return Y

@cocotb.test(skip=True)
async def test(dut, A, B):
    dut.A.value = A
    dut.B.value = B

    await Timer(1, units="ns")
    result = dut.Y.value
    print("")
    print(f"Реакция на {dut.A.value}{dut.B.value} - это {result}")
    print("")
    trueResult  = model(A, B) 
    assert result == trueResult, f"Результат не {trueResult}"

tf = TestFactory(test_function=test)
tf.add_option(name='A', optionlist=[0, 1])
tf.add_option(name='B', optionlist=[0, 1])
tf.generate_tests()