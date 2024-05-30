import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge

outputs_model = {
    'gnt1'          :     'x',
    'gnt2'          :     'x',
    'sb_masters'    :   2*'x',
    'sb_mastlock'   :     'x',
    'RDATA'         :  32*'z',
    'HADDR'         :  14*'z',
    'sel_0'         :  0b1   ,
    'sel_1'         :     'x',
    'sel_2'         :     'x',
    'sel_slave'     :  0b0   ,
    'WDATA'         :  32*'z',
}

outputs_result = outputs_model.copy()

def readOutputs (outputs_result, dut):
    for key in outputs_result.keys():
        pinObject = getattr(dut,key)

        if type (outputs_model[key]) == str:
            outputs_result[key] = str(pinObject.value)
        else:
            outputs_result[key] = pinObject.value
    return outputs_result            


@cocotb.test()
async def test_default (dut):
    #"проверка сброса шины "
    cocotb.start_soon(Clock(dut.clk,2,units="ns").start())
    dut.rst.value = 0

    await FallingEdge(dut.clk)
    dut.rst.value =1

    print ("")
    print ("После сброса")
    for key in outputs_result:
        print(f"{key:<15}: {outputs_result[key]}")
    print ("")    

    outputs_model['gnt1']         = 0b0
    outputs_model['gnt2']         = 0b0
    outputs_model['sb_masters']   = 0b0
    outputs_model['sb_mastlock']  = 0b0


    await ClockCycles(dut.clk , 1)

    readOutputs (outputs_result, dut)


    print ("")
    print ("После сброса и последуещего тактового сигнала")
    for key in outputs_result:
        print(f"{key:<15}: {outputs_result[key]}")
    print ("")    

    for key in outputs_model:
        AssertionString = f"Ожидали {outputs_model[key]} а получили {outputs_result[key]} "
        assert outputs_result[key] == outputs_model[key] , AssertionString