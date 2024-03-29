import config_english as c

LETTERPLATE = c.LETTERPLATE

LETTERPLATE_WIDTH = c.LETTERPLATE_WIDTH

HOURS_TABLE = c.HOURS_TABLE

MINUTES_TABLE = c.MINUTES_TABLE

LOCALE_SPECIFIC_PIXEL_UPDATE_FUNC = c.LOCALE_SPECIFIC_PIXEL_UPDATE_FUNC

if c.LOCALE_SPECIFIC_MINUTES_FUNC:
    LOCALE_SPECIFIC_MINUTES_FUNC = c.LOCALE_SPECIFIC_MINUTES_FUNC
else:
    LOCALE_SPECIFIC_MINUTES_FUNC = lambda hours, minutes: minutes
