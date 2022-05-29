// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-nc-sa/4.0/
// (c) 2018 Florian Roks <florian.roks (a) gmail.com>

include <config.scad>
use <common.scad>

function strToNbr(str, i=0, nb=0) = i == len(str) ? nb : nb+strToNbr(str, i+1, search(str[i],"0123456789")[0]*pow(10,len(str)-i-1));

module letter(x, y) {
    letter = LETTERFACE[y][x];
    font_index = strToNbr(LETTERFACE_FONTS[y][x]);
    font = FONT_NAMES[font_index];
    size = FONT_SIZES[font_index];
    text(text=letter, size=size, valign="center", halign="center", font=font);
}

module letter_cutouts() {
    translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE/2,
               VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE/2,
               LETTER_PLATE_LETTER_BOTTOM]) {
        for(y = [0 : 1 : LETTER_MATRIX_HEIGHT - 1]) {
            for(x = [LETTER_MATRIX_WIDTH - 1 : -1 : 0]) {
                translate([
                    (LETTER_MATRIX_WIDTH*LED_STRIPE_HORIZ_DISTANCE) - (x+1)*LED_STRIPE_HORIZ_DISTANCE, 
                    (LETTER_MATRIX_HEIGHT * LED_STRIPE_VERT_DISTANCE) - (y+1)*LED_STRIPE_VERT_DISTANCE, 
                    0]) {
                    linear_extrude(height=LETTER_PLATE_THICKNESS)
                            rotate([0,180,0])
                                letter(x=x, y=y);
                }
            }
        }
    }
}

module front_plate() {
    cube([TOTAL_WIDTH, TOTAL_HEIGHT, LETTER_PLATE_THICKNESS]);
}

module outer_frame() {
    cube([TOTAL_WIDTH, OUTER_WALL_THICKNESS, OUTER_WALL_HEIGHT]);
    cube([OUTER_WALL_THICKNESS, TOTAL_HEIGHT, OUTER_WALL_HEIGHT]);
    translate([0, TOTAL_HEIGHT-OUTER_WALL_THICKNESS, 0]) 
        cube([TOTAL_WIDTH, OUTER_WALL_THICKNESS, OUTER_WALL_HEIGHT]);
    translate([TOTAL_WIDTH-OUTER_WALL_THICKNESS, 0, 0]) 
        cube([OUTER_WALL_THICKNESS, TOTAL_HEIGHT, OUTER_WALL_HEIGHT]);
}

module inner_separator_grid() {
    for(x = [0 : 1 : LETTER_MATRIX_WIDTH]) {
        translate([x*LED_STRIPE_HORIZ_DISTANCE+HORIZ_SIDE_EXTRA-LETTER_SEPARATOR_THICKNESS/2, 
                   0, 
                   0])
            cube([LETTER_SEPARATOR_THICKNESS, 
                  TOTAL_HEIGHT, 
                  LETTER_SEPARATOR_HEIGHT]);
    }
    for(y = [0 : 1 : LETTER_MATRIX_HEIGHT]) {
        translate([0, 
                   (y*LED_STRIPE_VERT_DISTANCE)+VERT_SIDE_EXTRA-LETTER_SEPARATOR_THICKNESS/2, 
                   0])
            cube([TOTAL_WIDTH, 
                  LETTER_SEPARATOR_THICKNESS, 
                  LETTER_SEPARATOR_HEIGHT]);
    }   
}

module screw_hole_walls(z_offset) {
    for (p = LETTER_PLATE_MOUNTING_HOLE_POSITIONS) {
        translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE * p[0], 
                   VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE * p[1], 
                   z_offset]) 
            cylinder(h=LETTER_SEPARATOR_HEIGHT, 
                     d=LETTER_PLATE_SCREW_WALL_DIAMETER);
    }
}

module screw_holes(z_offset, d) {
    for (p = LETTER_PLATE_MOUNTING_HOLE_POSITIONS) {
        translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE * p[0],
                   VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE * p[1],
                   z_offset]) 
            cylinder(h=LETTER_PLATE_SCREW_INSERT_HEIGHT+0.01, 
                     d=d);
    }
    
}

module corner_hole_wall(offset=0,h=OUTER_WALL_HEIGHT) {
    translate([CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               h/2])
        cube(size = [CORNER_MOUNTING_HOLE_WALL_DIAMETER+offset,
                     CORNER_MOUNTING_HOLE_WALL_DIAMETER+offset, 
                     h - WALLMOUNT_PLATE_THICKNESS], 
                 center=true);
}

module corner_holes_walls(offset=0,h=OUTER_WALL_HEIGHT) {
    translate([CORNER_MOUNTING_HOLE_OFFSET,
               CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole_wall(offset=offset,h=h);
    translate([CORNER_MOUNTING_HOLE_OFFSET,
               TOTAL_HEIGHT - CORNER_MOUNTING_HOLE_WALL_DIAMETER - CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole_wall(offset=offset,h=h);
    translate([TOTAL_WIDTH - CORNER_MOUNTING_HOLE_WALL_DIAMETER-CORNER_MOUNTING_HOLE_OFFSET,
               CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole_wall(offset=offset,h=h);
    translate([TOTAL_WIDTH - CORNER_MOUNTING_HOLE_WALL_DIAMETER - CORNER_MOUNTING_HOLE_OFFSET,
               TOTAL_HEIGHT - CORNER_MOUNTING_HOLE_WALL_DIAMETER - CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole_wall(offset=offset,h=h);
    pos = CORNER_MOUNTING_HOLE_OFFSET + HORIZ_SIDE_EXTRA/1.2;

    translate([0, 0, 0])
        triangle([pos, 0], [0, pos], TOTAL_DEPTH);
    translate([TOTAL_WIDTH, 0, 0])
        triangle([0, pos], [-pos, 0], TOTAL_DEPTH);
    translate([TOTAL_WIDTH, TOTAL_HEIGHT, 0])
        triangle([0, -pos], [-pos, 0], TOTAL_DEPTH);
    translate([0, TOTAL_HEIGHT, 0])
        triangle([0, -pos], [pos, 0], TOTAL_DEPTH);
}

module corner_holes_walls_bump() {
    intersection() {
        corner_holes_walls(offset=OUTER_WALL_THICKNESS, h=LETTER_SEPARATOR_HEIGHT);
        cube([TOTAL_WIDTH, TOTAL_HEIGHT, TOTAL_DEPTH]);
    }
}

module outer_walls_bump(additional_height=0) {
    union() {
        cube([TOTAL_WIDTH, OUTER_WALL_THICKNESS+1, LETTER_SEPARATOR_HEIGHT + additional_height]);
        cube([OUTER_WALL_THICKNESS+1, TOTAL_HEIGHT, LETTER_SEPARATOR_HEIGHT + additional_height]);
        translate([0,TOTAL_HEIGHT-OUTER_WALL_THICKNESS-1,0]) 
            cube([TOTAL_WIDTH, OUTER_WALL_THICKNESS+1, LETTER_SEPARATOR_HEIGHT + additional_height]);
        translate([TOTAL_WIDTH-OUTER_WALL_THICKNESS-1,0,0]) 
            cube([OUTER_WALL_THICKNESS+1, TOTAL_HEIGHT, LETTER_SEPARATOR_HEIGHT + additional_height]);
    }
}

CABLE_SLOT_WIDTH = 5;
CABLE_SLOT_CORNERS = 2;

module clock_front() {
    difference() {
        intersection() {
            round_edges_cube();

            union() {
                outer_frame();
                front_plate();
                inner_separator_grid();
                outer_walls_bump();
                screw_hole_walls(z_offset=LETTER_SEPARATOR_HEIGHT - LETTER_SEPARATOR_HEIGHT);
//                corner_holes_walls_bump();

                corner_holes_walls();
            }
        }
        letter_cutouts();
        screw_holes(z_offset=LETTER_SEPARATOR_HEIGHT - LETTER_PLATE_SCREW_INSERT_HEIGHT, d=LETTER_PLATE_SCREW_INSERT_DIAMETER);
        corner_holes(d=CORNER_MOUNTING_HOLE_INSERT_DIAMETER, 
		             h=CORNER_MOUNTING_HOLE_INSERT_HEIGHT, 
					 offset=OUTER_WALL_HEIGHT);
        translate([TOTAL_WIDTH/2, 0, OUTER_WALL_HEIGHT-ELECTRONICS_HEIGHT/2+CABLE_SLOT_CORNERS])
            rotate([90,90,0])
                translate([-ELECTRONICS_HEIGHT/2, -CABLE_SLOT_WIDTH/2, -100/2]) rounded_cube([ELECTRONICS_HEIGHT, CABLE_SLOT_WIDTH, 100], CABLE_SLOT_CORNERS);
    }
    
}

module tester_plate() {
    difference() {
        intersection() {
            round_edges_cube();

            union() {
                front_plate();
                inner_separator_grid();
                outer_walls_bump(1.6);
            }
        }
        letter_cutouts();
    }
    
}

// arranged for 3d-printing / stl-export
if (TESTER_MODE == true) { tester_plate(); } else { clock_front(); }

