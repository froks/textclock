include <config.scad>
use <letter_plate.scad>

module rounded_cube(xyz, r) {
    x = xyz[0];
    y = xyz[1];
    z = xyz[2];
    hull() {
        translate([r, r, 0]) cylinder(h=z, r=r);
        translate([x-r, r, 0]) cylinder(h=z, r=r);
        translate([x-r, y-r, 0]) cylinder(h=z, r=r);
        translate([r, y-r, 0]) cylinder(h=z, r=r);
    }
}

module triangle(point1, point2, depth) {
    linear_extrude(height=depth)
        polygon(points=[[0,0], point1, point2],
                paths=[[0,1,2]]);
}

module round_edges_cube() {
    translate([0, 0, -50]) rounded_cube([TOTAL_WIDTH, TOTAL_HEIGHT, 100], r=3);
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

