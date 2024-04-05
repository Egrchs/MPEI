import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

def x2b(data) :
    match data:
        case 0b0011:
            op = '0000'
            invalid = 0
        case 0b0100:
            op = '0001'
            invalid = 0
        case 0b0101:
            op = '0010'
            invalid = 0
        case 0b0110:
            op = '0011'
            invalid = 0
        case 0b0111:
            op = '0100'
            invalid = 0
        case 0b1000:
            op = '0101'
            invalid = 0 
        case 0b1001:
            op = '0110'
            invalid = 0
        case 0b1010:
            op = '0111'
            invalid = 0
        case 0b1011:
            op = '1000'
            invalid = 0
        case 0b1100:
            op = '1001'
            invalid = 0                       
        case _:
            op = 'xxxx'
            invalid = 1
    return op, invalid




@cocotb.test()
async def test(dut):
    for num in range(16):
        dut.inp.value = num


        await Timer(1, units ="ns")
        result1 = dut.op.value
        result2 = dut.invalid.value
        print (" ")
        print (f"Реакция на {dut.inp.value} это op= {result1}   invalid= {result2}  ")
        print (" ") 
        trueResult = x2b(num)
        print(trueResult)
        assert (str(result1)) == trueResult[0], f"Результат не {trueResult[0]}!"
        assert (result2) == trueResult[1], f"Результат не {trueResult[1]}!"

