# simulate micropythons neopixel


class NeoPixel:
    def __init__(self, pin, n, bpp=3):
        self.pin = pin
        self.n = n
        self.bpp = bpp
        pass

    def fill(self, value):
        pass

    def __setitem__(self, i, v):
        pass

    def __len__(self):
        return self.n

    def write(self):
        pass
