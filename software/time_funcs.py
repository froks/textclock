from config import LETTERPLATE, LETTERPLATE_WIDTH, MINUTES_TABLE, HOURS_TABLE


def check_mapping(values_dict):
    for k, v in values_dict.items():
        for tupel in v:
            if isinstance(tupel, str):
                if tupel != 'CURRENT_HOUR' and tupel != 'NEXT_HOUR':
                    raise Exception("Invalid string value {}".format(tupel))
                continue
            line = LETTERPLATE[tupel[0]]
            if not tupel[1] in line:
                raise Exception('In line {}: {} - {} does not exist'.format(k, v, tupel[1]))


check_mapping(MINUTES_TABLE)
check_mapping(HOURS_TABLE)


def diff_value(val1, val2):
    if val1 > val2:
        return val1 - val2
    elif val1 < val2:
        return val2 - val1
    else:
        return 0


def get_closest_value(values_dict, key):
    closest_key = None
    for k in values_dict.keys():
        if closest_key is None:
            closest_key = k

        # print(closest_key, diff_value(k, key), diff_value(closest_key, key), k)

        if diff_value(k, key) <= diff_value(closest_key, key):
            closest_key = k
    return values_dict[closest_key]


def get_pixels_for_value(value):
    y = value[0]
    line = LETTERPLATE[y]
    idx = line.index(value[1])
    end_idx = idx + len(value[1]) - 1

    return [y * LETTERPLATE_WIDTH + x for x in range(idx, end_idx + 1, 1)]


def get_pixels_for_time(current_time):
    closest_minutes = get_closest_value(MINUTES_TABLE, current_time.minute)

    pixels = []

    for v in closest_minutes:
        if isinstance(v, str):
            hour = None
            if v == 'CURRENT_HOUR':
                hour = current_time.hour
            elif v == 'NEXT_HOUR':
                hour = (current_time.hour + 1) % 24

            for h in HOURS_TABLE[hour]:
                pixels.extend(get_pixels_for_value(h))

            continue
        value_pixels = get_pixels_for_value(v)
        pixels.extend(value_pixels)

    return pixels


def print_letterplate(pixels):
    for y in range(0, len(LETTERPLATE)):
        for x in range(0, LETTERPLATE_WIDTH):
            if (y*LETTERPLATE_WIDTH + x) in pixels:
                print(LETTERPLATE[y][x], end='')
            else:
                print(' ', end='')
        print()