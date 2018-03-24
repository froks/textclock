// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-nc-sa/4.0/
// (c) 2018 Florian Roks <florian.roks (a) gmail.com>


include <config.scad>
use <led_holder_plate.scad>

module led_fixation_plate_cutouts() {
    for (y = [0 : 1 : LETTER_MATRIX_HEIGHT - 1]) {
        translate([OUTER_WALL_THICKNESS+INNER_PLATE_TOLERANCE-0.01+LED_FIXATION_CUTOUT_WIDTH/2, 
                   VERT_SIDE_EXTRA + y*LED_STRIPE_VERT_DISTANCE+LED_STRIPE_VERT_DISTANCE/2, 
                   -0.01]) {
            cube([LED_FIXATION_CUTOUT_WIDTH, 
                  LED_FIXATION_CUTOUT_HEIGHT, 
                  LED_FIXATION_PLATE_THICKNESS*3],
                 center=true);
        }
        translate([TOTAL_WIDTH-OUTER_WALL_THICKNESS-LED_FIXATION_CUTOUT_WIDTH/2-INNER_PLATE_TOLERANCE, 
                   VERT_SIDE_EXTRA + y*LED_STRIPE_VERT_DISTANCE+LED_STRIPE_VERT_DISTANCE/2, 
                   -0.01]) {
            cube([LED_FIXATION_CUTOUT_WIDTH+0.01, 
                  LED_FIXATION_CUTOUT_HEIGHT, 
                  LED_FIXATION_PLATE_THICKNESS*3],
                 center=true);
        }
    }
}

module led_fixation_plate_simple() {
    cube([TOTAL_WIDTH,
          TOTAL_HEIGHT,
          LED_FIXATION_PLATE_THICKNESS]);
}

module led_fixation_plate() {   
    intersection() {
        difference() {
            led_fixation_plate_simple();
            led_fixation_plate_cutouts();
            screw_holes();
        }
        translate([0,0,-10]) fit_inner_cube();
    }
}

led_fixation_plate();