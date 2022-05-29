include <config.scad>
use <common.scad>
use <letter_plate.scad>

WALLMOUNT_WIDTH = 15;
WALLMOUNT_HEIGHT = 10;
WALLMOUNT_EDGE_RADIUS = 1;

CABLE_SLOT_WIDTH = 30;
CABLE_SLOT_HEIGHT = 50;
CABLE_ROUND_EDGES = 2;

REDUCED_SIZE = 2*OUTER_WALL_THICKNESS + INNER_PLATE_TOLERANCE;

module wall_mount_holes() {
    translate([TOTAL_WIDTH/2, TOTAL_HEIGHT/5*4, -0.05])
        rounded_triangle([WALLMOUNT_WIDTH, 
                          WALLMOUNT_HEIGHT, 
                          WALLMOUNT_PLATE_THICKNESS+0.1], 
                         r=WALLMOUNT_EDGE_RADIUS);
}

module backplate_wall() {
    difference() {
        intersection() {
            translate([REDUCED_SIZE/2, REDUCED_SIZE/2, 0])
            cube([TOTAL_WIDTH - REDUCED_SIZE,
                  TOTAL_HEIGHT - REDUCED_SIZE,
                  WALLMOUNT_PLATE_THICKNESS]);
        }
        wall_mount_holes();
        corner_holes(offset=20, d=SCREW_DIAMETER, h=100);
        corner_holes(offset=WALLMOUNT_PLATE_THICKNESS+0.01, 
                     d=SCREW_DIAMETER*2, 
                     h=WALLMOUNT_PLATE_THICKNESS-1.5);
        translate([OUTER_WALL_THICKNESS,OUTER_WALL_THICKNESS, 1.5]) 
            cube([SCREW_DIAMETER, SCREW_DIAMETER, WALLMOUNT_PLATE_THICKNESS], center=false);
        translate([TOTAL_WIDTH-2*OUTER_WALL_THICKNESS,OUTER_WALL_THICKNESS, 1.5]) 
            cube([SCREW_DIAMETER, SCREW_DIAMETER, WALLMOUNT_PLATE_THICKNESS], center=false);
        translate([TOTAL_WIDTH-2*OUTER_WALL_THICKNESS,TOTAL_HEIGHT-2*OUTER_WALL_THICKNESS, 1.5]) 
            cube([SCREW_DIAMETER, SCREW_DIAMETER, WALLMOUNT_PLATE_THICKNESS], center=false);
        translate([OUTER_WALL_THICKNESS,TOTAL_HEIGHT-2*OUTER_WALL_THICKNESS, 1.5]) 
            cube([SCREW_DIAMETER, SCREW_DIAMETER, WALLMOUNT_PLATE_THICKNESS], center=false);
        translate([TOTAL_WIDTH/2-CABLE_SLOT_WIDTH/2,-CABLE_ROUND_EDGES,-0.01]) 
            rounded_cube([CABLE_SLOT_WIDTH, CABLE_SLOT_HEIGHT+CABLE_ROUND_EDGES, WALLMOUNT_PLATE_THICKNESS+0.1], CABLE_ROUND_EDGES);
    }

}


backplate_wall();
