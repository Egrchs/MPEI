import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge , RisingEdge

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
    await RisingEdge(dut.clk )
    dut.rst.value =0

    outputs_model['gnt1']         = 0b0
    outputs_model['gnt2']         = 0b0
    outputs_model['sb_masters']   = 0b0
    outputs_model['sb_mastlock']  = 0b0
        # запрос без блокировки шины
    await RisingEdge(dut.clk )
    dut.HADDR_M1.value = 0b01010011110011 
    dut.HADDR_M2.value = 0b00010010000000 
    dut.RDATA_S0.value = 11
    dut.RDATA_S1.value = 3137
    dut.RDATA_S2.value = 335811
    dut.WDATA_M1 = 24457
    dut.WDATA_M2 = 27
    dut.sb_lock_m1.value =1
    dut.sb_lock_m2.value =1
    dut.req1.value = 1
    dut.req2.value = 1
    await ClockCycles(dut.clk , 2)

    outputs_model['gnt1']         = 0b1
    outputs_model['gnt2']         = 0b0
    outputs_model['sb_masters']   = 0b01
    outputs_model['sb_mastlock']  = 0b0
    outputs_model['RDATA']        = 0b00000000000000000000110001000001
    outputs_model['HADDR']        = 0b01010011110011
    outputs_model['sel_0']        = 0b0
    outputs_model['sel_1']        = 0b1
    outputs_model['sel_2']        = 0b0
    outputs_model['sel_slave']    = 0b01
    outputs_model['WDATA']        = 0b00000000000000000101111110001001
    await ClockCycles(dut.clk , 1)

    readOutputs (outputs_result, dut)
    print ("")
    print ("Одиночный запрос без блокировки шины")
    for key in outputs_result:
        print(f"{key:<15}: {outputs_result[key]}")
    print ("")

    #for key in outputs_model:
    #    AssertionString = f"Ожидали {outputs_model[key]} а получили {outputs_result[key]} "
    #    assert outputs_result[key] == outputs_model[key] , AssertionString 
    
  

