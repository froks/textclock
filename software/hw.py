import machine
import neopixel

import config

pin = machine.Pin(0, machine.Pin.OUT)

np = neopixel.NeoPixel(pin, len(config.LETTERPLATE) * config.LETTERPLATE_WIDTH, bpp=4)


def update_lit_pixelarray(pixels):
    np.fill((0, 0, 0, 0))
    for pixel in pixels:
        np[pixel] = (0, 0, 0, 20)

    np.write()


clock_timer = None


def init_clock_timers(update_clock, update_ntp):
    global clock_timer
    clock_timer = machine.Timer(-1)
    clock_timer.init(period=10000, mode=machine.Timer.PERIODIC, callback=update_clock)  # 10s
    clock_timer.init(period=3600000, mode=machine.Timer.PERIODIC, callback=update_ntp)  # 1h

# tim = Timer(-1)
# tim.init(period=5000, mode=Timer.ONE_SHOT, callback=lambda t:print(1))
# tim.init(period=2000, mode=Timer.PERIODIC, callback=lambda t:print(2))
