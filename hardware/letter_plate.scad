// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-nc-sa/4.0/
// (c) 2018 Florian Roks <florian.roks (a) gmail.com>

include <config.scad>

module letter(v, special) {
    if (special) {
        text(text = v, size = FONT_SPECIAL_SIZE, valign="center", halign="center", font=FONT_SPECIAL);
    } else {
        text(text = v, size = FONT_NORMAL_SIZE, valign="center", halign="center", font=FONT_NORMAL);
    }
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
                                letter(v = LETTERFACE[y][x],
                                       special = (LETTER_MATRIX_HEIGHT-1 == y),
                                       x=x, y=y);
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

module screw_hole_walls() {
    for (p = LETTER_PLATE_MOUNTING_HOLE_POSITIONS) {
        translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE * p[0], 
                   VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE * p[1], 
                   LETTER_SEPARATOR_HEIGHT - LETTER_SEPARATOR_HEIGHT]) 
            cylinder(h=LETTER_SEPARATOR_HEIGHT, d=LETTER_PLATE_SCREW_WALL_DIAMETER);
    }
}

module screw_holes() {
    for (p = LETTER_PLATE_MOUNTING_HOLE_POSITIONS) {
        translate([HORIZ_SIDE_EXTRA + LED_STRIPE_HORIZ_DISTANCE * p[0],
                   VERT_SIDE_EXTRA + LED_STRIPE_VERT_DISTANCE * p[1],
                   LETTER_SEPARATOR_HEIGHT - LETTER_PLATE_SCREW_INSERT_HEIGHT]) 
            cylinder(h=LETTER_PLATE_SCREW_INSERT_HEIGHT+0.01, 
                     d=LETTER_PLATE_SCREW_INSERT_DIAMETER);
    }
    
}

module corner_hole_wall(offset=0,h=OUTER_WALL_HEIGHT) {
    translate([CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               h/2])
        cylinder(h=h, 
                 d=CORNER_MOUNTING_HOLE_WALL_DIAMETER+offset, 
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
}

module corner_holes_walls_bump() {
    intersection() {
        corner_holes_walls(offset=OUTER_WALL_THICKNESS, h=LETTER_SEPARATOR_HEIGHT);
        cube([TOTAL_WIDTH, TOTAL_HEIGHT, TOTAL_DEPTH]);
    }
}


module corner_hole() {
    translate([CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               CORNER_MOUNTING_HOLE_INSERT_HEIGHT/2 + OUTER_WALL_HEIGHT - CORNER_MOUNTING_HOLE_INSERT_HEIGHT])
        cylinder(h=CORNER_MOUNTING_HOLE_INSERT_HEIGHT+0.01, 
                 d=CORNER_MOUNTING_HOLE_INSERT_DIAMETER, 
                 center=true);
}

module corner_holes() {
    translate([CORNER_MOUNTING_HOLE_OFFSET,
               CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole();
    translate([CORNER_MOUNTING_HOLE_OFFSET,
               TOTAL_HEIGHT-CORNER_MOUNTING_HOLE_WALL_DIAMETER-CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole();
    translate([TOTAL_WIDTH-CORNER_MOUNTING_HOLE_WALL_DIAMETER-CORNER_MOUNTING_HOLE_OFFSET,
               CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole();
    translate([TOTAL_WIDTH-CORNER_MOUNTING_HOLE_WALL_DIAMETER - CORNER_MOUNTING_HOLE_OFFSET,
               TOTAL_HEIGHT-CORNER_MOUNTING_HOLE_WALL_DIAMETER - CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole();
}

module clock_front() {
    difference() {
        union() {
            outer_frame();
            front_plate();
            inner_separator_grid();
            screw_hole_walls();
            corner_holes_walls_bump();
            corner_holes_walls();
        }
        letter_cutouts();
        screw_holes();
        corner_holes();
    }
    
}

// arranged for 3d-printing / stl-export
clock_front();

