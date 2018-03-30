import time_funcs

import datetime

current_time = datetime.datetime.now()
# current_time = datetime.datetime(2018, 3, 30, 10, 59)

px = time_funcs.get_pixels_for_time(current_time)

time_funcs.print_letterplate(px)

