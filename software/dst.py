import utime

TZ_OFFSET_DST = 7200
TZ_OFFSET_NORMAL = 3600


def get_dst_start_for_year(year):
    for day in range(31, 31-7, -1):
        timestamp = utime.mktime((year, 3, day, 0, 2, 0, -1, -1))
        if utime.localtime(timestamp)[6] == 6:
            return timestamp


def get_dst_end_for_year(year):
    for day in range(31, 31-7, -1):
        timestamp = utime.mktime((year, 10, day, 0, 3, 0, -1, -1))
        if utime.localtime(timestamp)[6] == 6:
            return timestamp


def apply_dst_offset(timestamp):
    time_tuple = utime.localtime(timestamp)
    # CET - summertime is active between last sunday in march at 2:00, and ends on last sunday in october at 3
    dst_start_timestamp = get_dst_start_for_year(time_tuple[0])
    dst_end_timestamp = get_dst_end_for_year(time_tuple[0])
    if (timestamp >= dst_start_timestamp) and (timestamp < dst_end_timestamp):
        return timestamp + TZ_OFFSET_DST
    else:
        return timestamp + TZ_OFFSET_NORMAL
