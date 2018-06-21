include <config.scad>
use <common.scad>
use <letter_plate.scad>

WALLMOUNT_WIDTH = 15;
WALLMOUNT_HEIGHT = 10;
WALLMOUNT_EDGE_RADIUS = 1;

CABLE_SLOT_WIDTH = 30;
CABLE_SLOT_HEIGHT = 50;
CABLE_ROUND_EDGES = 2;


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
            round_edges_cube();
            cube([TOTAL_WIDTH,
                  TOTAL_HEIGHT,
                  WALLMOUNT_PLATE_THICKNESS]);
        }
        wall_mount_holes();
        corner_holes(offset=20, d=SCREW_DIAMETER, h=100);
        corner_holes(offset=WALLMOUNT_PLATE_THICKNESS+0.01, d=SCREW_DIAMETER*2, h=WALLMOUNT_PLATE_THICKNESS-1.5);
        translate([TOTAL_WIDTH/2-CABLE_SLOT_WIDTH/2,-CABLE_ROUND_EDGES,-0.01]) 
            rounded_cube([CABLE_SLOT_WIDTH, CABLE_SLOT_HEIGHT+CABLE_ROUND_EDGES, WALLMOUNT_PLATE_THICKNESS+0.1], CABLE_ROUND_EDGES);
    }

}


backplate_wall();
