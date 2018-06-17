#from machine import Pin

# from neopixel import NeoPixel

#pin = Pin(0, Pin.OUT)  # set GPIO0 to output to drive NeoPixels^


# np = NeoPixel(pin, 110, bpp=4)  # create NeoPixel driver on GPIO0 for 8 pixels


# np[0] = (255, 255, 255, 255) # set the first pixel to white
# np.write()              # write data to all pixels
# r, g, b, w = np[0]         # get first pixel colour

# def lit(nrs, color):
#     for nr in nrs:
#         np[nr] = color
#
#
# # (0, 0, 0, 20)
#
# zw = (4, 5, 6, 7, 8, 9, 10)
# nach = (40, 41, 42, 43)
# drei = (60, 61, 62, 63)
#
# import time
#
#
# def wheelColor(n):
#     l = int(n / 128)
#     if l == 0:
#         return 127 - n % 128, n % 128, 0, 0
#     elif l == 1:
#         return 0, 127 - n % 128, n % 128, 0
#     elif l == 2:
#         return n % 128, 0, 127 - n % 128, 0
#     else:
#         print(l)
#
#
# def rainbowCycle(delay, np):
#     n = np.n
#     for j in range(0, 384 * 5):
#         for i in range(0, n):
#             np[i] = (wheelColor(((i * int(384 / n)) + j) % 384))
#         np.write()
#         time.sleep_us(delay)
