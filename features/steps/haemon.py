from behave import *
import subprocess as sp


def before_scenario(context, scenario):
    context.daemons = []


def after_scenario(context, scenario):
    for d in context.daemons:
        d.terminate()
        try:
            d.wait(60)
        except TimeoutExpired:
            d.kill()
            try:
                d.wait(60)


@given('That I have started haemon')
def step_impl(context):
    port = 8888
    with sp.Popen(['heamon', '--port {}'.format(port)]) as proc:
        context.daemons.append(proc)
        context.haemon = Haemon(port)


class Haemon:

    def __init__(port):
        self._port = port

    @property
    def port(self):
        return self._port
