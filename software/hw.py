import machine
import neopixel
import urtc
import config

pin = machine.Pin(18, machine.Pin.OUT)

np = neopixel.NeoPixel(pin, len(config.LETTERPLATE) * config.LETTERPLATE_WIDTH, bpp=4)
i2c = machine.I2C(freq=100000, sda=machine.Pin(4), scl=machine.Pin(5))
# i2c = machine.I2C(freq=100000, sda=machine.Pin(5), scl=machine.Pin(4))
rtc = urtc.DS1307(i2c=i2c, address=104)

lit_pixels = bytearray(len(config.LETTERPLATE) * config.LETTERPLATE_WIDTH)
pixel_buffer = bytearray(len(lit_pixels))

clock_timer = []


def add_timer(period, callback):
    # Implementation for ESP8266 (only virtual timer is supported)
    global clock_timer
    if len(clock_timer) > 0:
        timer = clock_timer[0]
    else:
        timer = machine.Timer(-1)

    timer.init(period=period, mode=machine.Timer.PERIODIC, callback=callback)
    clock_timer.append(timer)


def wheel_color(n):
    colorwheel_part = int(n / 128)
    if colorwheel_part == 0:
        return 127 - n % 128, n % 128, 0, 0
    elif colorwheel_part == 1:
        return 0, 127 - n % 128, n % 128, 0
    elif colorwheel_part == 2:
        return n % 128, 0, 127 - n % 128, 0
    else:
        print(colorwheel_part)


def pixel_effect():
    np.fill((0, 0, 0, 0))

    for j in range(0, 384 * 5):
        for i in range(len(lit_pixels)):
            if lit_pixels[i] != 0:
                np[i] = (wheel_color(((i * int(384 / np.n)) + j) % 384))
            else:
                np[i] = 0

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
