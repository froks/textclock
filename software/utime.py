# simulate micropythons utime

import datetime
import pytz

MICROPYTHON_TIME_DELTA = (datetime.date(2000, 1, 1) - datetime.date(1970, 1, 1)).days * 24 * 60 * 60


def time():
    import time
    import calendar

    return calendar.timegm(time.gmtime()) - MICROPYTHON_TIME_DELTA


def localtime(timestamp):
    import urtc

    if not timestamp:
        x = datetime.datetime.now(tz=pytz.UTC)
    else:
        x = datetime.datetime.fromtimestamp(timestamp + MICROPYTHON_TIME_DELTA, tz=pytz.UTC)

    return [x.year, x.month, x.day, x.hour, x.minute, x.second, x.weekday(), x.microsecond]


def mktime(tuple):
    import calendar

    return calendar.timegm(tuple) - MICROPYTHON_TIME_DELTA
