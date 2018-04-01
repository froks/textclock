import machine
import neopixel

import config

pin = machine.Pin(0, machine.Pin.OUT)

np = neopixel.NeoPixel(pin, len(config.LETTERPLATE) * config.LETTERPLATE_WIDTH, bpp=4)

lit_pixels = []
old_lit_pixels = []

def update_lit_pixelarray(pixels):

    global lit_pixels, old_lit_pixels
    old_lit_pixels = lit_pixels
    lit_pixels = pixels


clock_timer = []


def add_timer(period, callback):
    global clock_timer
    timer = machine.Timer(-1)
    timer.init(period=period, mode=machine.Timer.PERIODIC, callback=callback)
    clock_timer.append(timer)


def wheel_color(n):
    l = int(n / 128)
    if l == 0:
        return 127 - n % 128, n % 128, 0, 0
    elif l == 1:
        return 0, 127 - n % 128, n % 128, 0
    elif l == 2:
        return n % 128, 0, 127 - n % 128, 0
    else:
        print(l)


def pixel_effect():
    np.fill((0, 0, 0, 0))
    for j in range(0, 384 * 5):
        for i in old_lit_pixels:
            np[i] = (0, 0, 0, 0)
        for i in lit_pixels:
            np[i] = (wheel_color(((i * int(384 / np.n)) + j) % 384))

        np.write()

# def init_clock_timers(update_clock, update_ntp):
#     global clock_timer
#     if not clock_timer:
#         clock_timer = machine.Timer(-1)
#     else:
#         clock_timer.deinit()
#     clock_timer.init(period=10000, mode=machine.Timer.PERIODIC, callback=lambda x: update_clock())  # 10s
    # clock_timer.init(period=3600000, mode=machine.Timer.PERIODIC, callback=lambda x: update_ntp())  # 1h

# tim = Timer(-1)
# tim.init(period=5000, mode=Timer.ONE_SHOT, callback=lambda t:print(1))
# tim.init(period=2000, mode=Timer.PERIODIC, callback=lambda t:print(2))
