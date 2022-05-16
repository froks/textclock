# simulate micropythons machine

import threading
import utime


def _bin2bcd(value):
    return (value or 0) + 6 * ((value or 0) // 10)


class Pin:
    OUT = 1

    def __init__(self, id, mode=-1, pull=-1):
        pass


class Timer:
    PERIODIC = 1

    t = None
    callback = None
    period = None

    def __init__(self, id):
        pass

    def init(self, period, mode, callback):
        if mode != self.PERIODIC:
            raise Exception('unknown mode')
        self.period = period
        self.callback = callback
        self.t = threading.Timer(interval=self.period/1000, function=self.obj_callback)
        self.t.start()

    def obj_callback(self):
        self.callback(self)
        self.t = threading.Timer(interval=self.period/1000, function=self.obj_callback)
        self.t.start()

class I2C:
    def __init__(self, freq, scl, sda):
        pass

    def readfrom_mem(self, address, register, len):
        buffer = bytearray(7)
        timestamp = utime.localtime(None)
        buffer[0] = _bin2bcd(timestamp[5])
        buffer[1] = _bin2bcd(timestamp[4])
        buffer[2] = _bin2bcd(timestamp[3])
        buffer[3] = _bin2bcd(timestamp[6])
        buffer[4] = _bin2bcd(timestamp[2])
        buffer[5] = _bin2bcd(timestamp[1])
        buffer[6] = _bin2bcd(timestamp[0] - 2000)
        return buffer

    def writeto_mem(self, address, register, buffer):
        pass