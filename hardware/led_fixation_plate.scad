// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// https://creativecommons.org/licenses/by-nc-sa/4.0/
// (c) 2018 Florian Roks <florian.roks (a) gmail.com>


include <config.scad>
use <common.scad>
use <letter_plate.scad>

ESP8266_HOLE_DIST_HORIZ = 25;
ESP8266_HOLE_DIST_VERT = 52;

ESP8266_HOLE_DIAMETER = 4;
ESP8266_HOLE_DEPTH = 5;
ESP8266_HOLE_WALL_THICKNESS = 3;
ESP8266_HOLE_OFFSET = 0.6;

ESP8266_OFFSET_VERT = 50;

RTC_HOLE_DIST = 22;
RTC_HOLE_DIAMETER = 4;
RTC_HOLE_DEPTH = 5;
RTC_HOLE_WALL_THICKNESS = 3;
RTC_HOLE_OFFSET = 0.6;

module rtc_mounts(d, h, offset) {
    z_offset = LED_FIXATION_PLATE_THICKNESS + offset;
    y_offset = 20;
    x_offset = TOTAL_WIDTH/2 + ESP8266_HOLE_DIST_HORIZ + 10;
    translate([x_offset,
               y_offset,
               0]) {
        translate([RTC_HOLE_DIST/2, 
                   0, 
                   z_offset])
            cylinder(d=d, h=RTC_HOLE_DEPTH);
    }
    translate([x_offset,
               y_offset,
               0]) {
        translate([-RTC_HOLE_DIST/2, 
                   0, 
                   z_offset])
            cylinder(d=d, h=RTC_HOLE_DEPTH);
    }
}

module esp8266_mounts(d, h, offset) {
    z_offset = LED_FIXATION_PLATE_THICKNESS + offset;
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

module electronic_mounts_walls() {
    esp8266_mounts(d=ESP8266_HOLE_DIAMETER+ESP8266_HOLE_WALL_THICKNESS,
                   h=ESP8266_HOLE_DEPTH+ESP8266_HOLE_OFFSET-0.01,
                   offset=0);
    rtc_mounts(d=RTC_HOLE_DIAMETER+RTC_HOLE_WALL_THICKNESS,
               h=RTC_HOLE_DEPTH+RTC_HOLE_OFFSET-0.01,
               offset=0);
}

module electronic_mounts_holes() {
    esp8266_mounts(d=ESP8266_HOLE_DIAMETER, 
                   h=ESP8266_HOLE_DEPTH+ESP8266_HOLE_OFFSET,
                   offset=ESP8266_HOLE_OFFSET);
    rtc_mounts(d=RTC_HOLE_DIAMETER,
               h=RTC_HOLE_DEPTH+RTC_HOLE_OFFSET,
               offset=RTC_HOLE_OFFSET);
}


CABLE_MOUNT_WIDTH = 6;
CABLE_MOUNT_HEIGHT = 8;
CABLE_MOUNT_THICKNESS = 8;
CABLE_MOUNT_EDGE_ROUNDNESS = 2;

module cable_mount() {
    difference() {
        translate([-CABLE_MOUNT_WIDTH/2, -CABLE_MOUNT_HEIGHT/2, -CABLE_MOUNT_THICKNESS/2]) 
            rounded_cube([CABLE_MOUNT_WIDTH, CABLE_MOUNT_HEIGHT, CABLE_MOUNT_THICKNESS], CABLE_MOUNT_EDGE_ROUNDNESS);
        translate([-CABLE_MOUNT_WIDTH/2-0.01, -CABLE_MOUNT_HEIGHT/4, -CABLE_MOUNT_THICKNESS/4]) 
            cube([CABLE_MOUNT_WIDTH+0.1, CABLE_MOUNT_HEIGHT/2, CABLE_MOUNT_THICKNESS/2], CABLE_MOUNT_EDGE_ROUNDNESS);
    }
}

module cable_mount_post() {
    translate([TOTAL_WIDTH/2 + 6, 10, CABLE_MOUNT_HEIGHT/2 ]) {
        cable_mount();
    }
}

module led_fixation_plate() {   
    intersection() {
        difference() {
            union() {
                led_fixation_plate_simple();
                electronic_mounts_walls();
                cable_mount_post();
            };
            led_fixation_plate_cutouts();
            electronic_mounts_holes();
            screw_holes(z_offset=-0.01, d=SCREW_DIAMETER);
        }
        translate([0,0,-10]) fit_inner_cube();
    }
}

led_fixation_plate();