// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-nc-sa/4.0/
// (c) 2018 Florian Roks <florian.roks (a) gmail.com>


use <led_holder_plate.scad>;
use <led_fixation_plate.scad>;
use <letter_plate.scad>;
include <config.scad>

exploded_view = false;

// assembly-view
clock_front();

exploded_offset_diff = 10;

led_holder_plate_z_offset = LETTER_SEPARATOR_HEIGHT-LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH;

%translate([0,
            0,
            (exploded_view ? 2*exploded_offset_diff : 0) + led_holder_plate_z_offset])
    led_holder_plate();

led_fixation_plate_z_offset = led_holder_plate_z_offset + LED_HOLDER_PLATE_HEIGHT;

%translate([0,
            0,
            (exploded_view ? 3*exploded_offset_diff : 0) + led_fixation_plate_z_offset])
    led_fixation_plate();