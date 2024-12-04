import cocotb 
import asyncio
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
from transitions import Machine
from transitions.extensions import GraphMachine

class FSM_Class(object):
        pass

testFSM = FSM_Class()

stateArray = ["00","01","10","11"]

transitionArray = [
        {'trigger': 'one',   'source': '00',        'dest': '01'},
        {'trigger': 'zero',   'source': '00',        'dest': '00'},

        {'trigger': 'one',   'source': '01',        'dest': '00'},
        {'trigger': 'zero',   'source': '01',        'dest': '10'},

        {'trigger': 'one',   'source': '10',        'dest': '11'},
        {'trigger': 'zero',   'source': '10',        'dest': '00'},
    
        {'trigger': 'one',   'source': '11',        'dest': '01'},
        {'trigger': 'zero',   'source': '11',        'dest': '00'},
    ]

machine = Machine(model=testFSM,
                       states=stateArray,
                       transitions=transitionArray,
                       initial="00")
                      
@cocotb.test()
async def S0_S0(dut):
    dut.rst.value = 0
    await Timer(1, units="ns")
    dut.rst.value = 1
    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.y.value
    currentstate = dut.currentstate.value
    testFSM.zero()
    l = testFSM.state


    print(f"{int(l)}")
    print(f"Реакция на {X} в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"

@cocotb.test()
async def S0_S1(dut):
    dut.rst.value = 0
    await Timer(1, units="ns")
    dut.rst.value = 1
    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    result = dut.y.value
    currentstate = dut.currentstate.value
    testFSM.one()
    l = testFSM.state


    print(f"{int(l)}")
    print(f"Реакция на {X} в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"

machine = Machine(states=stateArray, initial='01')

@cocotb.test()
async def S1_S2(dut):
    dut.rst.value = 0
    await Timer(1, units="ns")
    dut.rst.value = 1
    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    result = dut.y.value
    currentstate = dut.currentstate.value
    print(testFSM.state)
    testFSM.zero()
    testFSM.state
    l = testFSM.state


    print(f"{int(l)}")
    print(f"Реакция на {X} в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"




machine = Machine(states=stateArray, initial='10')

@cocotb.test()
async def S2_S3(dut):
    dut.rst.value = 0
    await Timer(1, units="ns")
    dut.rst.value = 1
    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    result = dut.y.value
    currentstate = dut.currentstate.value
    print(testFSM.state)
    testFSM.one()
    testFSM.state
    l = testFSM.state


    print(f"{int(l)}")
    print(f"Реакция на {X} в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"

machine = Machine(states=stateArray, initial='11')

@cocotb.test()
async def S3_S1(dut):
    dut.rst.value = 0
    await Timer(1, units="ns")
    dut.rst.value = 1
    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    result = dut.y.value
    currentstate = dut.currentstate.value
    print(testFSM.state)
    testFSM.one()
    testFSM.state
    l = testFSM.state


    print(f"{int(l)}")
    print(f"Реакция на {X} в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"

machine = Machine(model=testFSM,states=stateArray,transitions=transitionArray, initial='11')

@cocotb.test()
async def S3_S0(dut):
    machine1 = Machine(model=testFSM,states=stateArray,transitions=transitionArray, initial='11')

    print(testFSM.state) 
    dut.rst.value = 0
    await Timer(1, units="ns")
    dut.rst.value = 1
    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    
    result = dut.y.value
    currentstate = dut.currentstate.value
    print(testFSM.state)
    testFSM.zero()
    testFSM.state
    l = testFSM.state


    print(f"{int(l)}")
    print(f"Реакция на {X} в S0 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"
    
 
@cocotb.test()
async def S2_S0(dut):
    machine2 = Machine(model=testFSM,states=stateArray,transitions=transitionArray, initial='10')

    print(testFSM.state) 
    dut.rst.value = 0
    await Timer(1, units="ns")
    dut.rst.value = 1
    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 1
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")

    dut.clk.value = 0
    X = 0
    dut.x.value = X
    await Timer(1, units="ns")
    dut.clk.value = 1
    await Timer(1, units="ns")
    
    result = dut.y.value
    currentstate = dut.currentstate.value
    print(testFSM.state)
    testFSM.zero()
    testFSM.state
    l = testFSM.state


    print(f"{int(l)}")
    print(f"Реакция на {X} в S2 - это {currentstate}")
    print("")
    assert str(currentstate) == (l), "Результат не 0!"
 