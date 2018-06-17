# simulate micropythons machine

import threading


class Pin:
    OUT = 1

    def __init__(self, id, mode=-1, pull=-1):
        pass


class Timer:
    PERIODIC = 1

    t = None
    callback = None

    def __init__(self, id):
        pass

    def init(self, period, mode, callback):
        if mode != self.PERIODIC:
            raise Exception('unknown mode')
        self.callback = callback
        t = threading.Timer(period/1000, callback, [self])
        t.start()

    def obj_callback(self):
        self.callback()

class I2C:
    pass