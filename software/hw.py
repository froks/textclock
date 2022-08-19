import machine
import neopixel
import urtc
import config

# esp82666 pin 0
pin = machine.Pin(0, machine.Pin.OUT)
# esp32
# pin = machine.Pin(18, machine.Pin.OUT)

np = neopixel.NeoPixel(pin, len(config.LETTERPLATE) * config.LETTERPLATE_WIDTH, bpp=4)
# esp8266
i2c = machine.I2C(freq=100000, sda=machine.Pin(4), scl=machine.Pin(5))

rtc = urtc.DS1307(i2c=i2c, address=104)

current_pixels = bytearray(len(config.LETTERPLATE) * config.LETTERPLATE_WIDTH)
pixel_buffer = bytearray(len(current_pixels))

clock_timer = []


def update_pixels(new_pixels):
    for i in range(len(new_pixels)):
        pixel_buffer[i] = new_pixels[i]


def add_timer(period, callback):
    # esp8266
    timer = machine.Timer(-1)
    timer.init(period=period, mode=machine.Timer.PERIODIC, callback=callback)
    clock_timer.append(timer)


def wheel_color(n, opacity):
    def apply_opacity(color):
        if opacity >= 255:
            return color
        elif opacity <= 0:
            return 0
        # approximation of color * opacity/255.0, just doesn't use floating point operations
        return (color * opacity) >> 8

    colorwheel_part = int(n / 128)
    if colorwheel_part == 0:
        return apply_opacity(127 - n % 128), apply_opacity(n % 128), 0, 0
    elif colorwheel_part == 1:
        return 0, apply_opacity(127 - n % 128), apply_opacity(n % 128), 0
    elif colorwheel_part == 2:
        return apply_opacity(n % 128), 0, apply_opacity(127 - n % 128), 0
    else:
        print(colorwheel_part)
        return 0, 0, 0, 0


def pixel_effect():
    np.fill((0, 0, 0, 0))

    for j in range(0, 384 * 5):
        for i in range(len(current_pixels)):
            dest = pixel_buffer[i]
            current = current_pixels[i]
            new = 0
            if dest != current or dest != 0 or current != 0:
                if dest == current:
                    opacity = 255
                elif dest < current:
                    # when a pixel is supposed to fade out (dest 0, current = 255)
                    new = current - 50
                    if new < 0:
                        new = 0
                    current_pixels[i] = new
                    opacity = abs(current - dest)
                else:
                    # when a pixel is supposed to fade in (dest = 255, current = 0)
                    new = current + 10
                    if new > 255:
                        new = 255
                    current_pixels[i] = new
                    opacity = 255 - abs(dest - current)
#                print(i, dest, current, opacity)
                np[i] = (wheel_color(((i * int(384 / np.n)) + j) % 384, opacity))
            else:
                np[i] = (0, 0, 0, 0)

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



