import cocotb
from cocotb.triggers import Timer

def model(data) :
    lookupTable = {0b000 :1,
                   0b001 :0,
                   0b010 :0,
                   0b011 :0,
                   0b100 :0,
                   0b101 :0,
                   0b110 :0,
                   0b111 :0}
    Y = lookupTable[data]
    return Y

def getBinDigit(num,n):
    mask = 1 << n
    maskedNum = num & mask
    binDigit = maskedNum >> n
    return binDigit

@cocotb.test()
async def test(dut):
    numberOfInputs = 3 

    for num in range(2**numberOfInputs):
        dut.A.value = getBinDigit(num,2)
        dut.B.value = getBinDigit(num,1)
        dut.C.value = getBinDigit(num,0)
        await Timer(1, units ="ns")
        result = dut.Y.value
        print (" ")
        print (f"Реакция на {dut.A.value}{dut.B.value}{dut.C.value}- это {result}" )
        print (" ")
        trueResult = model(num)
        assert result == trueResult, f"Результат не {trueResult}!"