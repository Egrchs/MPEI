import itertools
import logging
import os
import cocotb_test.simulator
import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
from cocotbext.uart import UartSource, UartSink


class TB:
    def __init__(self, dut):
        self.dut = dut

        self.log = logging.getLogger("cocotb.tb")
        self.log.setLevel(logging.DEBUG)

        self.source = UartSource(dut.data, baud=115200)
        self.sink = UartSink(dut.data, baud=115200)


async def run_test(dut, payload_lengths=None, payload_data=None):

    tb = TB(dut)

    await Timer(10, 'us')

    for test_data in [payload_data(x) for x in payload_lengths()]:

        await tb.source.write(test_data)

        rx_data = bytearray()

        while len(rx_data) < len(test_data):
            rx_data.extend(await tb.sink.read())

        tb.log.info("Read data: %s", rx_data)

        assert tb.sink.empty()

        await Timer(100, 'us')


def prbs31(state=0x7fffffff):
    while True:
        for i in range(8):
            if bool(state & 0x08000000) ^ bool(state & 0x40000000):
                state = ((state & 0x3fffffff) << 1) | 1
            else:
                state = (state & 0x3fffffff) << 1
        yield state & 0xff


def size_list():
    return list(range(1, 16)) + [128]


def incrementing_payload(length):
    return bytearray(itertools.islice(itertools.cycle(range(256)), length))


def prbs_payload(length):
    gen = prbs31()
    return bytearray([next(gen) for x in range(length)])


if cocotb.SIM_NAME:

    factory = TestFactory(run_test)
    factory.add_option("payload_lengths", [size_list])
    factory.add_option("payload_data", [incrementing_payload, prbs_payload])
    factory.generate_tests()


# cocotb-test

tests_dir = os.path.dirname(__file__)


def test_uart(request):
    dut = "test_uart"
    module = os.path.splitext(os.path.basename(__file__))[0]
    toplevel = dut

    verilog_sources = [
        os.path.join(tests_dir, f"{dut}.v"),
    ]

    parameters = {}

    extra_env = {f'PARAM_{k}': str(v) for k, v in parameters.items()}

    sim_build = os.path.join(tests_dir, "sim_build",
        request.node.name.replace('[', '-').replace(']', ''))

    cocotb_test.simulator.run(
        python_search=[tests_dir],
        verilog_sources=verilog_sources,
        toplevel=toplevel,
        module=module,
        parameters=parameters,
        sim_build=sim_build,
        extra_env=extra_env,
    )
