import cocotb
import random
import numpy as np
from cocotb.triggers import Timer

def decoder(adress) :
    adressm=np.binary_repr(adress, width=64)
    adressm= adressm[-14:-12] 
    selm_s0 = 'x'
    selm_s1 = 'x'
    selm_s2 = 'x'
    selm_slave = 'xx'
    match adressm:
        case '00':
            selm_s0 = '1'
            selm_s1 = '0'
            selm_s2 = '0'
            selm_slave = '00'
        case '01':
            selm_s0 = '0'
            selm_s1 = '1'
            selm_s2 = '0'
            selm_slave = '01'
        case '10':
            selm_s0 = '0'
            selm_s1 = '0'
            selm_s2 = '1'
            selm_slave = '10'         
        case _:
            selm_s0 = '1'
            selm_s1 = selm_s1
            selm_s2 = selm_s2   
            selm_slave = '00'         
    return selm_s0,selm_s1,selm_s2,selm_slave,adressm




@cocotb.test()
async def test(dut):
    for i in range(10):
        num = random.randint(0,16384)
        dut.inp_Addr = num


        await Timer(1, units ="ns")
        result1 = dut.sel_s0
        result2 = dut.sel_s1
        result3 = dut.sel_s2
        result4 = dut.sel_slave

        print (" ")
        print (f"Реакция на {dut.inp_Addr} это sel_s0 = {result1}   sel_s1 = {result2} sel_s2 = {result3} sel_slave = {result4}  ")
        print (" ") 
        trueResult = decoder(num)
        print(trueResult)
        assert (str(result1)) == trueResult[0], f"Результат не {trueResult[0]}!"
        assert (str(result2)) == trueResult[1], f"Результат не {trueResult[1]}!"
        assert (str(result3)) == trueResult[2], f"Результат не {trueResult[2]}!"
        assert (str(result4)) == trueResult[3], f"Результат не {trueResult[3]}!"
