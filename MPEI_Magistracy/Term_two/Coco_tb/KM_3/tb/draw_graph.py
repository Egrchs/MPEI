from transitions import Machine

from transitions.extensions import GraphMachine

class FSM_Class(object):
    pass

testFSM = FSM_Class()

stateArray = ["Start","Position1","Position2","Position3","End"]

transitionArray = [
    {'trigger': 'cycle',   'source': 'Start',        'dest': 'Position1'},
    {'trigger': 'hold',    'source': 'Start',        'dest': 'Start'},

    {'trigger': 'cycle',   'source': 'Position1',    'dest': 'Position2'},            

    {'trigger': 'cycle',   'source': 'Position2',    'dest': 'Position3'},
    {'trigger': 'hold',    'source': 'Position2',    'dest': 'Position2'},

    {'trigger': 'cycle',   'source': 'Position3',    'dest': 'End'},            
 
    {'trigger': 'cycle',   'source': 'End',          'dest': 'Start'},
    {'trigger': 'hold',    'source': 'End',          'dest': 'End'},
]

machine = GraphMachine(model=testFSM,
                       states=stateArray,
                       transitions=transitionArray,
                       initial="Start",
                       title = 'Конечный автомат 3')

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/start.svg', prog='dot')

testFSM.hold()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/start_hold.svg', prog='dot')


testFSM.cycle()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/Position1.svg', prog='dot')

testFSM.cycle()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/Position2.svg', prog='dot')


testFSM.hold()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/Position2_hold.svg', prog='dot')

testFSM.cycle()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/Position3.svg', prog='dot')


testFSM.cycle()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/End.svg', prog='dot')

testFSM.hold()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/End_hold.svg', prog='dot')

testFSM.cycle()
testFSM.state

testFSM.get_graph().draw('/home/k-105-01/workspace/Student/ЭР-05м-23/Krylov_BV/coco_KM_3/Start_cycle.svg', prog='dot')
