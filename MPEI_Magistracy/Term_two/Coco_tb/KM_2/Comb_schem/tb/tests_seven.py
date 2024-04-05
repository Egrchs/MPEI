import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def seven(data) :
    lookupTable = {0b0000 :0b0111111,
                   0b0001 :0b0000110,
                   0b0010 :0b1011011,
                   0b0011 :0b1001111,
                   0b0100 :0b1100110,
                   0b0101 :0b1101101,
                   0b0110 :0b1110101,
                   0b0111 :0b0000111,
                   0b1000 :0b1111111,
                   0b1001 :0b1101111,
                   0b1010 :0b1110111,
                   0b1011 :0b1111100,
                   0b1100 :0b0111001,
                   0b1101 :0b1011110,
                   0b1110 :0b1110011,
                   0b1111 :0b1110001}
    Y = lookupTable[data]
    return Y

def getBinDigit(num,n):
    mask = 1 << n
    maskedNum = num & mask
    binDigit = maskedNum >> n
    return binDigit

@cocotb.test()
async def test(dut):
    for num in range(16):
        dut.a.value = getBinDigit(num,3)
        dut.b.value = getBinDigit(num,2)
        dut.c.value = getBinDigit(num,1)
        dut.d.value = getBinDigit(num,0)

        await Timer(1, units ="ns")
        result = dut.out.value
        print (" ")
        print (f"Реакция на {dut.a.value}{dut.b.value}{dut.c.value}{dut.d.value}- это Y= {result}  ")
        print (" ")
        trueResult = seven(num)
        assert (result) == trueResult, f"Результат не {trueResult}!"


