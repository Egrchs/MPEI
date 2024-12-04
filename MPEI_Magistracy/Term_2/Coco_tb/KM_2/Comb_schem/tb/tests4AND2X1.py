import cocotb
from cocotb.triggers import Timer

################################
# Наивный вариант тестирования #
################################

@cocotb.test()
async def zeroZero(dut):
    """Реакция на 00"""
    dut.A.value = 0
    dut.B.value = 0

    #Ждем 1 нс
    await Timer(1, units="ns")
    result = dut.Y.value
    print("")
    print(f"Реакция на 00 - это {result}")
    print("")
    assert result == 0, "Результат не 0!"

@cocotb.test()
async def zeroOne(dut):
    """Реакция на 01"""
    dut.A.value = 0
    dut.B.value = 1

    #Ждем 1 нс
    await Timer(1, units="ns")
    result = dut.Y.value
    print("")
    print(f"Реакция на 01 - это {result}")
    print("")
    assert result == 0, "Результат не 0!"

@cocotb.test()
async def oneZero(dut):
    """Реакция на 10"""
    dut.A.value = 1
    dut.B.value = 0

    #Ждем 1 нс
    await Timer(1, units="ns")
    result = dut.Y.value
    print("")
    print(f"Реакция на 10 - это {result}")
    print("")
    assert result == 0, "Результат не 0!"

@cocotb.test()
async def oneOne(dut):
    """Реакция на 11"""
    dut.A.value = 1
    dut.B.value = 1

    #Ждем 1 нс
    await Timer(1, units="ns")
    result = dut.Y.value
    print("")
    print(f"Реакция на 11 - это {result}")
    print("")
    assert result == 1, "Результат не 1!"

######################################################
# Вариант тестирования с поисковой таблицей и циклом #
######################################################
    
def model(data):
    lookupTable = {0b00:0,
                   0b01:0,
                   0b10:0,
                   0b11:1}
    
    Y = lookupTable[data]
    return Y

def getBinDigit(num,n):
    mask = 1 << n
    maskedNum = num & mask
    binDigit = maskedNum >> n
    return binDigit

@cocotb.test()
async def test(dut):
    numberOfInputs = 2
    for num in range(2**numberOfInputs):
        dut.A.value = getBinDigit(num,0)
        dut.B.value = getBinDigit(num,1)

        await Timer(1, units="ns")
        result = dut.Y.value
        print("")
        print(f"Реакция на {dut.A.value}{dut.B.value} - это {result}")
        print("")
        trueResult = model(num)
        assert result == trueResult, f"Результат не {trueResult}"

######################################################
# Вариант тестирования с фабрикой                    #
######################################################
        
from cocotb.regression import TestFactory

def model(A, B):
    Y = A & B
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
    trueResult = model(A, B)
    assert result == trueResult, f"Результат не {trueResult}"

tf = TestFactory(test_function=test)
tf.add_option(name='A', optionlist=[0, 1])
tf.add_option(name='B', optionlist=[0, 1])
tf.generate_tests()