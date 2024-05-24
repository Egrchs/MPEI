import cocotb
import random
import numpy as np
from cocotb.triggers import Timer

def multiplex(select,in0,in1,in2) :
    select = np.binary_repr(select, width=32)[30:]
    match select:
        case '00':
            out = in0
        case '01':
            out = in1
        case '10':
            out = in2         
        case _:
            out = in0  
    return out




@cocotb.test()
async def test(dut):
    for i in range(10):
        num = random.randint(0,2**32)
        dut.in_0 = num
        dut.in_1 = num + 1
        dut.in_2 = num + 2
        sl = random.randint(0,3)
        dut.sel = sl
        await Timer(1, units ="ns")
        result1 = dut.mux_out

        print (" ")
        print (f"Реакция на {dut.sel} это sel_s0 = {result1}    ")
        print (" ") 
        trueResult = np.binary_repr(multiplex(sl,num,num+1,num+2), width=32)
        print(trueResult)
        assert (str(result1)) == trueResult, f"Результат не {trueResult}!"
       
