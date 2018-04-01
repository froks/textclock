import time_funcs
import dst
import utime
import ntptime
import hw


def sync_time_ntp():
    ntptime.settime()
    print("NTP - time synced")


def refresh_time_display():
    print('updating time-display')
    local_timestamp = dst.apply_dst_offset(utime.time())
    time_tuple = utime.localtime(local_timestamp)
    print(time_tuple)
    px = time_funcs.get_pixels_for_time(time_tuple[3], time_tuple[4])
    time_funcs.print_letterplate(px)
    hw.update_lit_pixelarray(px)


def start():
    sync_time_ntp()
    refresh_time_display()
    hw.add_timer(30000, lambda x: refresh_time_display())  # update the displayed letters every 30 seconds
    hw.add_timer(600000, lambda x: sync_time_ntp())  # the rtc of esp8266 is *bad*, update from network every 10 minutes

    while True:
        hw.pixel_effect()


if __name__ == '__main__':
    start()
