import time_funcs
import dst
import utime
import ntptime
import hw
import urtc
from config import LOCALE_SPECIFIC_PIXEL_UPDATE_FUNC


def sync_time_ntp():
    try:
        ntptime.settime()
        hw.rtc.datetime(datetime=utime.localtime(utime.time()))
        print("NTP - time synced")
    except Exception as e:
        print('Error while getting NTP-time: {}', e)


time_refresh_counter = 0
display_pixels = bytearray(len(hw.current_pixels))


def refresh_time_display():
    global time_refresh_counter
    print('updating time-display')
    local_timestamp = dst.apply_dst_offset(urtc.tuple2seconds(hw.rtc.datetime()))
    time_tuple = utime.localtime(local_timestamp)
    print(time_tuple)
    # clear & fill pixel_buffer with next lit pixels
    # we need to buffer pixels, to ensure that we don't get weird in-between states while updating the time
    # since pixel_effect uses hw.lit_pixels constantly to display pixels
    for i in range(len(display_pixels)):
        display_pixels[i] = 0
    time_funcs.update_pixels_for_time(time_tuple[3], time_tuple[4], display_pixels)
    if LOCALE_SPECIFIC_PIXEL_UPDATE_FUNC:
        LOCALE_SPECIFIC_PIXEL_UPDATE_FUNC(time_tuple[3], time_tuple[4], display_pixels)

    # blit pixels to actually displayed pixels
    hw.update_pixels(display_pixels)
    time_funcs.print_letterplate(display_pixels)

    if time_refresh_counter > 30:
        print_meminfo()
        time_refresh_counter = 0
    else:
        time_refresh_counter = time_refresh_counter + 1


def print_meminfo():
    import micropython
    import gc
    gc.collect()
    micropython.mem_info()

    if callable(getattr(gc, 'mem_free', None)):
        print('Initial free: {} allocated: {}'.format(gc.mem_free(), gc.mem_alloc()))


def start():
    sync_time_ntp()
    refresh_time_display()

    print("registering timers")
    hw.add_timer(10000, lambda x: refresh_time_display())  # update the displayed letters every 10 seconds
    hw.add_timer(600000, lambda x: sync_time_ntp())  # the rtc of esp8266 is *bad*, update from network every 10 minutes
    # hw.add_timer(30000, lambda x: print_meminfo())

    while True:
        hw.pixel_effect()


if __name__ == '__main__':
    start()
