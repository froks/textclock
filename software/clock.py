import time_funcs
import dst
import utime
import ntptime
import hw
import urtc


def sync_time_ntp():
    try:
        ntptime.settime()
        hw.rtc.datetime(datetime=utime.localtime(utime.time()))
        print("NTP - time synced")
    except Exception as e:
        print('Error while getting NTP-time: {}', e)


i = 0


def refresh_time_display():
    global i
    print('updating time-display')
    local_timestamp = dst.apply_dst_offset(urtc.tuple2seconds(hw.rtc.datetime()))
    time_tuple = utime.localtime(local_timestamp)
    print(time_tuple)
    px = time_funcs.get_pixels_for_time(time_tuple[3], time_tuple[4])
    time_funcs.print_letterplate(px)
    hw.update_lit_pixelarray(px)
    if i > 30:
        print_meminfo()
        i = 0
    else:
        i = i + 1


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
    hw.add_timer(30000, lambda x: refresh_time_display())  # update the displayed letters every 30 seconds
    # hw.add_timer(30000, lambda x: print_meminfo())
    # hw.add_timer(600000, lambda x: sync_time_ntp())  # the rtc of esp8266 is *bad*, update from network every 10 minutes

    while True:
        hw.pixel_effect()


if __name__ == '__main__':
    start()
