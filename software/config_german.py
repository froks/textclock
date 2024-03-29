LETTERPLATE = ["FÜNFZWANZIG",  # 0
               "DREIVIERTEL",  # 1
               "EINSZEHNELF",  # 2
               "VORHALBNACH",  # 3
               "ACHTNEUNELF",  # 4
               "ZWEIKDREINS",  # 5
               "XSECHSIEBEN",  # 6
               "QYZWÖLFÜNFJ",  # 7
               "GVIERPZEHNO",  # 8
               "⚠♻✉UHR☼☁☂❄⚡",  # "\u26a0\u267B\u2709\u0298\u2160\u2161\u263C\u2601\u2602\u2744\u26A1"
               ]

LETTERPLATE_WIDTH = len(LETTERPLATE[0])

# the right hand site in the following tables take an array of strings or tuples (or mixed)

# a tuple can be used in both tables, it consists of the line and the characters to be highlighted (lines start at 0!)
# a string in the MINUTES_TABLE may also contain 'CURRENT_HOUR' or 'NEXT_HOUR', which refer to the HOURS_TABLE, and add
# the tuples in those to highlight
MINUTES_TABLE = {
    0:  ['CURRENT_HOUR'],
    5:  [(0, 'FÜNF'), (3, 'NACH'), 'CURRENT_HOUR'],
    10: [(2, 'ZEHN'), (3, 'NACH'), 'CURRENT_HOUR'],
    15: [(1, 'VIERTEL'), (3, 'NACH'), 'CURRENT_HOUR'],
    20: [(0, 'ZWANZIG'), (3, 'NACH'), 'CURRENT_HOUR'],
    25: [(0, 'FÜNFZWANZIG'), (3, 'NACH'), 'CURRENT_HOUR'],
    30: [(3, 'HALB'), 'NEXT_HOUR'],
    35: [(0, 'FÜNFZWANZIG'), (3, 'VOR'), 'NEXT_HOUR'],
    40: [(0, 'ZWANZIG'), (3, 'VOR'), 'NEXT_HOUR'],
    45: [(1, 'VIERTEL'), (3, 'VOR'), 'NEXT_HOUR'],
    50: [(2, 'ZEHN'), (3, 'VOR'), 'NEXT_HOUR'],
    55: [(0, 'FÜNF'), (3, 'VOR'), 'NEXT_HOUR'],
    60: ['NEXT_HOUR'],
}

HOURS_TABLE = {
    0: [(7, 'ZWÖLF')],
    1: [(5, 'EINS')],
    2: [(5, 'ZWEI')],
    3: [(5, 'DREI')],
    4: [(8, 'VIER')],
    5: [(7, 'FÜNF')],
    6: [(6, 'SECHS')],
    7: [(6, 'SIEBEN')],
    8: [(4, 'ACHT')],
    9: [(4, 'NEUN')],
    10: [(8, 'ZEHN')],
    11: [(4, 'ELF')],
    12: [(7, 'ZWÖLF')],
    13: [(5, 'EINS')],
    14: [(5, 'ZWEI')],
    15: [(5, 'DREI')],
    16: [(8, 'VIER')],
    17: [(7, 'FÜNF')],
    18: [(6, 'SECHS')],
    19: [(6, 'SIEBEN')],
    20: [(4, 'ACHT')],
    21: [(4, 'NEUN')],
    22: [(8, 'ZEHN')],
    23: [(4, 'ELF')],
    24: [(7, 'ZWÖLF')],
}

LOCALE_SPECIFIC_PIXEL_UPDATE_FUNC = None
LOCALE_SPECIFIC_MINUTES_FUNC = None
