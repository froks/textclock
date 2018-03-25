// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-nc-sa/4.0/
// (c) 2018 Florian Roks <florian.roks (a) gmail.com>

include <config.scad>
use <letter_plate.scad>

module led_holes() {
	for (y = [0 : 1 : LETTER_MATRIX_HEIGHT - 1]) {
		for (x = [0 : 1 : LETTER_MATRIX_WIDTH - 1]) {
            translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE*x,
                       VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE*y, 
                       0]) 
			translate([LED_STRIPE_HORIZ_DISTANCE/2, 
                       LED_STRIPE_VERT_DISTANCE/2, 
                       -10]) 
                cube([LED_STRIPE_LED_WIDTH, 
                      LED_STRIPE_LED_HEIGHT, 
                      100], 
                     center = true);
		}
	}
}

module cap_holes() {
	for (y = [0 : 1 : LETTER_MATRIX_HEIGHT - 1]) {
		for (x = [0 : 1 : LETTER_MATRIX_WIDTH - 1]) {
            translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE*x+LED_STRIPE_CAP_OFFSET_X,
                       VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE*y+LED_STRIPE_CAP_OFFSET_Y, 
                       0]) {
                translate([LED_STRIPE_HORIZ_DISTANCE/2, 
                           LED_STRIPE_VERT_DISTANCE/2, 
                           LED_HOLDER_PLATE_HEIGHT-LED_STRIPE_CAP_DEPTH/2])
                    cube([LED_STRIPE_CAP_WIDTH, 
                          LED_STRIPE_CAP_HEIGHT, 
                          LED_STRIPE_CAP_DEPTH+0.01], 
                         center = true);
            }
            translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE*x-LED_STRIPE_CAP_OFFSET_X,
                       VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE*y+LED_STRIPE_CAP_OFFSET_Y, 
                       0]) {
                translate([LED_STRIPE_HORIZ_DISTANCE/2, 
                           LED_STRIPE_VERT_DISTANCE/2, 
                           LED_HOLDER_PLATE_HEIGHT-LED_STRIPE_CAP_DEPTH/2])
                    cube([LED_STRIPE_CAP_WIDTH, 
                          LED_STRIPE_CAP_HEIGHT, 
                          LED_STRIPE_CAP_DEPTH+0.01], 
                         center = true);
            }
		}
	}
}

module screw_holes() {
   for (p = LETTER_PLATE_MOUNTING_HOLE_POSITIONS) {
       translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE*p[0], 
                  VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE*p[1],
                  0]) 
        cylinder(d=SCREW_DIAMETER, h=100, center=true);
   }
}

module separator_cutout() {
    for (y = [0 : 1 : LETTER_MATRIX_HEIGHT]) {
        translate([TOTAL_WIDTH/2, 
                   VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE*y, 
                   LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH/2]) 
            cube([TOTAL_WIDTH, 
                  LETTER_SEPARATOR_THICKNESS + LED_HOLDER_PLATE_DIVIDER_CUTOUT_TOLERANCE,
                  LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH+0.01], 
                 center = true);
    }
    for (x = [0 : 1 : LETTER_MATRIX_WIDTH]) {
        translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE*x, 
                   VERT_SIDE_EXTRA + TOTAL_HEIGHT/2, 
                   LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH/2]) 
            cube([LETTER_SEPARATOR_THICKNESS + LED_HOLDER_PLATE_DIVIDER_CUTOUT_TOLERANCE, 
                  TOTAL_WIDTH, 
                  LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH+0.01], 
                 center = true);
    }
    for (p = LETTER_PLATE_MOUNTING_HOLE_POSITIONS) {
       translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE*p[0], 
                  VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE*p[1], 
                  LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH/2])
        cylinder(d=LETTER_PLATE_SCREW_INSERT_DIAMETER+LETTER_PLATE_SCREW_INSERT_WALL_THICKNESS+LED_HOLDER_PLATE_DIVIDER_CUTOUT_TOLERANCE, 
                 h=LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH+0.01, center=true);
    }
}

module fit_inner_cube() {
    size_x = TOTAL_WIDTH-2*OUTER_WALL_THICKNESS-2*INNER_PLATE_TOLERANCE;     size_y = TOTAL_HEIGHT-2*OUTER_WALL_THICKNESS-2*INNER_PLATE_TOLERANCE;
    difference() {
        translate([OUTER_WALL_THICKNESS+INNER_PLATE_TOLERANCE,
                   OUTER_WALL_THICKNESS+INNER_PLATE_TOLERANCE, 
                   -10])
            cube([size_x, size_y, 100]);
        corner_holes_walls(offset = INNER_PLATE_TOLERANCE, h=100);
    }
}

module led_holder_plate() {
    intersection() {
        difference() {
            cube([TOTAL_WIDTH,
                  TOTAL_HEIGHT, 
                  LED_HOLDER_PLATE_HEIGHT]);
            led_holes();
            cap_holes();
            screw_holes();
            separator_cutout();
        };
        translate([0,0,-30]) fit_inner_cube();
    }
}

// arranged for 3d-printing / stl-export
translate([TOTAL_WIDTH, 0, LED_HOLDER_PLATE_HEIGHT]) 
    rotate([0,180,0]) 
        led_holder_plate();
