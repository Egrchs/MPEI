import cocotb 
import asyncio
from cocotb.triggers import Timer
from cocotb.triggers import ClockCycles
from cocotb.regression import TestFactory
from transitions import Machine
from transitions.extensions import GraphMachine

class FSM_Class(object):
        pass

testFSM = FSM_Class()

stateArray = ["000","001","010","011", "100", "101"]

transitionArray = [
        {'trigger': 'clk',    'source': '000',        'dest': '001'},
        {'trigger': 'rst',    'source': '000',        'dest': '000'},

        {'trigger': 'clk',    'source': '001',        'dest': '010'},
        {'trigger': 'rst',    'source': '001',        'dest': '000'},

        {'trigger': 'clk',    'source': '010',        'dest': '011'},
        {'trigger': 'rst',    'source': '010',        'dest': '000'},
    
        {'trigger': 'clk',    'source': '011',        'dest': '100'},
        {'trigger': 'rst',    'source': '011',        'dest': '000'},

        {'trigger': 'clk',    'source': '100',        'dest': '101'},
        {'trigger': 'rst',    'source': '100',        'dest': '000'},

        {'trigger': 'clk',    'source': '101',        'dest': '000'},
        {'trigger': 'rst',    'source': '101',        'dest': '000'},
    ]

machine = Machine(model       = testFSM,
                  states      = stateArray,
                  transitions = transitionArray,
                  initial     = "000"
                )
                      
@cocotb.test()
async def S0_S0(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.reset.value = 1
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.rst()
    l = "0000"

    print(f"{(l)}")
    print(f"Реакция на reset в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"

@cocotb.test()
async def S0_S1(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.clk()
    l = "0001"

    print(f"{(l)}")
    print(f"Реакция на clk в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0001!"

@cocotb.test()
async def S1_S2(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.clk()
    l = "0011"

    print(f"{(l)}")
    print(f"Реакция на clk в S1 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0011!"

@cocotb.test()
async def S2_S3(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.clk()
    l = "0110"

    print(f"{(l)}")
    print(f"Реакция на clk в S2 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0110!"

@cocotb.test()
async def S3_S4(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.clk()
    l = "1100"

    print(f"{(l)}")
    print(f"Реакция на clk в S3 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 1100!"

@cocotb.test()
async def S4_S5(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.clk()
    l = "1000"

    print(f"{(l)}")
    print(f"Реакция на clk в S4 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 1000!"

@cocotb.test()
async def S5_S0(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.clk()
    l = "0000"

    print(f"{(l)}")
    print(f"Реакция на clk в S5 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0000!"

@cocotb.test()
async def S0_S4(dut):
    dut.reset.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 0
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.o_lfsr.value
    currentstate = dut.o_lfsr.value
    testFSM.clk()
    l = "0000"

    print(f"{(l)}")
    print(f"Реакция на clk в S5 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0000!"

