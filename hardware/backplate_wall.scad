include <config.scad>
use <common.scad>
use <letter_plate.scad>

BACKPLATE_HEIGHT = 10;
BACKPLATE_THICKNESS = 2;
BACKPLATE_HOLE_OFFSET = 8;

BACKPLATE_WALLMOUNT_WIDTH = 15;
BACKPLATE_WALLMOUNT_HEIGHT = 10;
BACKPLATE_WALLMOUNT_EDGE_RADIUS = 1;

SCREW_HEAD_DEPTH = 3.5;
SCREW_HEAD_DIAMETER = 6;

ESP8266_HOLE_DIST_HORIZ = 25;
ESP8266_HOLE_DIST_VERT = 52;

ESP8266_HOLE_DIAMETER = 4;
ESP8266_HOLE_DEPTH = 5;
ESP8266_HOLE_WALL_THICKNESS = 3;
ESP8266_HOLE_OFFSET = 0.6;

ESP8266_OFFSET_VERT = 30;

RTC_HOLE_DIST = 22;
RTC_HOLE_DIAMETER = 4;
RTC_HOLE_DEPTH = 5;
RTC_HOLE_WALL_THICKNESS = 3;
RTC_HOLE_OFFSET = 0.6;

USERPORT_WALL_THICKNESS_HORIZ = 2;
USERPORT_WALL_THICKNESS_VERT = 2;

module outer_case() {
    difference() {
        intersection() {
            cube([TOTAL_WIDTH, 
                  TOTAL_HEIGHT, 
                  BACKPLATE_HEIGHT]);
                round_edges_cube();
        }
        hole_depth = BACKPLATE_HEIGHT-BACKPLATE_THICKNESS;
        translate([0, 0, -0.1])
            rounded_cube([TOTAL_WIDTH, 
                          TOTAL_HEIGHT,
                          hole_depth], 
                         r=ROUND_EDGES_RADIUS, 
                         offset=BACKPLATE_HOLE_OFFSET);
        corner_holes(d=SCREW_DIAMETER,
                     h=BACKPLATE_HEIGHT+0.1,
                     offset=BACKPLATE_HEIGHT+0.1);
        corner_holes(d=SCREW_HEAD_DIAMETER,
                     h=SCREW_HEAD_DEPTH, 
                     offset=BACKPLATE_HEIGHT+0.1);
    }
}

module rtc_mounts(d, h, offset) {
    z_offset = BACKPLATE_HEIGHT-h-0.01-offset;
    y_offset = TOTAL_HEIGHT/10*6;
    translate([TOTAL_WIDTH/2,
               y_offset,
               0]) {
        translate([RTC_HOLE_DIST/2, 
                   0, 
                   z_offset])
            cylinder(d=d, h=RTC_HOLE_DEPTH);
    }
    translate([TOTAL_WIDTH/2,
               y_offset,
               0]) {
        translate([-RTC_HOLE_DIST/2, 
                   0, 
                   z_offset])
            cylinder(d=d, h=RTC_HOLE_DEPTH);
    }
}

module esp8266_mounts(d, h, offset) {
    //-ESP8266_HOLE_DEPTH-ESP8266_HOLE_OFFSET
    z_offset = BACKPLATE_HEIGHT-h-0.01-offset;
    translate([TOTAL_WIDTH/2,
               ESP8266_OFFSET_VERT+ESP8266_HOLE_DIST_VERT/2,
               0]) {
        translate([ESP8266_HOLE_DIST_HORIZ/2, 
                   ESP8266_HOLE_DIST_VERT/2, 
                   z_offset])
            cylinder(d=d, h=ESP8266_HOLE_DEPTH);
        translate([-ESP8266_HOLE_DIST_HORIZ/2, 
                   ESP8266_HOLE_DIST_VERT/2, 
                   z_offset])
            cylinder(d=d, h=ESP8266_HOLE_DEPTH);
        translate([ESP8266_HOLE_DIST_HORIZ/2, 
                   -ESP8266_HOLE_DIST_VERT/2, 
                   z_offset])
            cylinder(d=d, h=ESP8266_HOLE_DEPTH);
        translate([-ESP8266_HOLE_DIST_HORIZ/2, 
                   -ESP8266_HOLE_DIST_VERT/2, 
                   z_offset])
            cylinder(d=d, h=h);
    }
}

module wall_mount_holes() {
    translate([TOTAL_WIDTH/2, TOTAL_HEIGHT/5*4, 0])
        rounded_triangle([BACKPLATE_WALLMOUNT_WIDTH, 
                          BACKPLATE_WALLMOUNT_HEIGHT, 
                          BACKPLATE_HEIGHT+0.1], 
                         r=BACKPLATE_WALLMOUNT_EDGE_RADIUS);
}

module userport() {
    translate([TOTAL_WIDTH/2-ESP8266_HOLE_DIST_HORIZ/2, 0, 0])
        rounded_cube([ESP8266_HOLE_DIST_HORIZ, 
              ESP8266_OFFSET_VERT-5,
              BACKPLATE_HEIGHT], r=2);
}

module userport_hole() {
    button_access_width = ESP8266_HOLE_DIST_HORIZ - 8;
    translate([TOTAL_WIDTH/2-button_access_width/2, -5, BACKPLATE_THICKNESS])
        rounded_cube([button_access_width,
              ESP8266_OFFSET_VERT+3,
              10], r = 2);
}

module cable_holder() {
    difference() {
        translate([TOTAL_WIDTH/2 - 2.5, 0.01, 0.01])
            rotate([0,0,0])
                cube([5, 10, BACKPLATE_HEIGHT/3*2],
                             r=1); // cube
        translate([TOTAL_WIDTH/2, 0, BACKPLATE_HEIGHT/3*2]) 
            rotate([90, 0, 0]) // cable 
                cylinder(r=2.8,h=100,center=true);
        translate([TOTAL_WIDTH/2 - 10, 5-1.5, BACKPLATE_HEIGHT/2-0.5]) 
            cube([20, 3, 3]); // cutout, so zip-tie is firm
        
        translate([TOTAL_WIDTH/2+0.72, 5, 0.01+BACKPLATE_HEIGHT
        +1.5/2-BACKPLATE_HOLE_OFFSET])
                cube([20, 3, 1.5], center=true);
    }
}

module backplate_wall() {
    difference() {
        union() {
            outer_case();
            esp8266_mounts(d=ESP8266_HOLE_DIAMETER+ESP8266_HOLE_WALL_THICKNESS,
                           h=ESP8266_HOLE_DEPTH+ESP8266_HOLE_OFFSET-0.03,
                           offset=0);
            rtc_mounts(d=RTC_HOLE_DIAMETER+RTC_HOLE_WALL_THICKNESS,
                       h=RTC_HOLE_DEPTH+RTC_HOLE_OFFSET-0.03,
                       offset=0);
            userport();
        }
        wall_mount_holes();
        userport_hole();
        esp8266_mounts(d=ESP8266_HOLE_DIAMETER, 
                       h=ESP8266_HOLE_DEPTH,
                       offset=ESP8266_HOLE_OFFSET);
        rtc_mounts(d=RTC_HOLE_DIAMETER,
                   h=RTC_HOLE_DEPTH,
                   offset=RTC_HOLE_OFFSET);
    }
    cable_holder();

}


translate([TOTAL_WIDTH, 0, BACKPLATE_HEIGHT])
    rotate([0, 180, 0])
        backplate_wall();
