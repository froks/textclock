# -*- coding: utf-8 -*-

LETTERPLATE = ["TWENTYFIVEN",  # 0
               "QUARTERHALF",  # 1
               "TENEPASTNTO",  # 2
               "TWONETHREEQ",  # 3
               "SIXFIVEFOUR",  # 4
               "SEVENELEVEN",  # 5
               "NINEIGHTENT",  # 6
               "TWELVE☼☁\uE288❄⚡",  # 7
               "••O'CLOCK••",  # \u2022\u2022O'CLOCK\u2022\u2022 #8
               ]

LETTERPLATE_WIDTH = len(LETTERPLATE[0])

# the right-hand site in the following tables take an array of strings or tuples (or mixed)

# a tuple can be used in both tables, it consists of the line and the characters to be highlighted (lines start at 0!)
# a string in the MINUTES_TABLE may also contain 'CURRENT_HOUR' or 'NEXT_HOUR', which refer to the HOURS_TABLE, and add
# the tuples in those to highlight
MINUTES_TABLE = {
    0:  ['CURRENT_HOUR', (8, 'O\'CLOCK')],
    5:  [(0, 'FIVE'), (2, 'PAST'), 'CURRENT_HOUR'],
    10: [(2, 'TEN'), (2, 'PAST'), 'CURRENT_HOUR'],
    15: [(1, 'QUARTER'), (2, 'PAST'), 'CURRENT_HOUR'],
    20: [(0, 'TWENTY'), (2, 'PAST'), 'CURRENT_HOUR'],
    25: [(0, 'TWENTYFIVE'), (2, 'PAST'), 'CURRENT_HOUR'],
    30: [(1, 'HALF'), (2, 'TO'), 'NEXT_HOUR'],
    35: [(0, 'TWENTYFIVE'), (2, 'TO'), 'NEXT_HOUR'],
    40: [(0, 'TWENTY'), (2, 'TO'), 'NEXT_HOUR'],
    45: [(1, 'QUARTER'), (2, 'TO'), 'NEXT_HOUR'],
    50: [(2, 'TEN'), (2, 'TO'), 'NEXT_HOUR'],
    55: [(0, 'FIVE'), (2, 'TO'), 'NEXT_HOUR'],
    60: ['NEXT_HOUR', (8, 'O\'CLOCK')],
}

HOURS_TABLE = {
    0: [(7, 'TWELVE')],
    1: [(3, 'ONE')],
    2: [(3, 'TWO')],
    3: [(3, 'THREE')],
    4: [(4, 'FOUR')],
    5: [(4, 'FIVE')],
    6: [(4, 'SIX')],
    7: [(5, 'SEVEN')],
    8: [(6, 'EIGHT')],
    9: [(6, 'NINE')],
    10: [(6, 'TEN')],
    11: [(5, 'ELEVEN')],
    12: [(7, 'TWELVE')],
    13: [(3, 'ONE')],
    14: [(3, 'TWO')],
    15: [(3, 'THREE')],
    16: [(4, 'FOUR')],
    17: [(4, 'FIVE')],
    18: [(4, 'SIX')],
    19: [(5, 'SEVEN')],
    20: [(6, 'EIGHT')],
    21: [(6, 'NINE')],
    22: [(6, 'TEN')],
    23: [(5, 'ELEVEN')],
    24: [(7, 'TWELVE')],
}


def LOCALE_SPECIFIC_PIXEL_UPDATE_FUNC(hours, minutes, pixel_data):
    additional_dots = minutes % 5
    if additional_dots >= 1:
        pixel_data[LETTERPLATE_WIDTH * 8 + 0] = 255
    if additional_dots >= 2:
        pixel_data[LETTERPLATE_WIDTH * 8 + 1] = 255
    if additional_dots >= 3:
        pixel_data[LETTERPLATE_WIDTH * 8 + 9] = 255
    if additional_dots >= 4:
        pixel_data[LETTERPLATE_WIDTH * 8 + 10] = 255


LOCALE_SPECIFIC_MINUTES_FUNC = lambda hours, minutes: minutes - minutes % 5
