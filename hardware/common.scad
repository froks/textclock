include <config.scad>
use <letter_plate.scad>

module rounded_cube(size, r, offset=0) {
    x = size[0];
    y = size[1];
    z = size[2];
	hull() {
		translate([r+offset, r+offset, 0]) cylinder(h=z, r=r);
		translate([x-r-offset, r+offset, 0]) cylinder(h=z, r=r);
		translate([x-r-offset, y-r-offset, 0]) cylinder(h=z, r=r);
		translate([r+offset, y-r-offset, 0]) cylinder(h=z, r=r);
	}
}

module rounded_triangle(size, r) {
	width = size[0];
	height = size[1];
	depth = size[2];
	hull() {
		union() {
			translate([-width/2, 0, depth/2]) cylinder(h=depth, r=r, center=true);
			translate([+width/2, 0, depth/2]) cylinder(h=depth, r=r, center=true);
			translate([0, height, depth/2]) cylinder(h=depth, r=r, center=true);
		}
	}
}

module triangle(point1, point2, depth) {
    linear_extrude(height=depth)
        polygon(points=[[0,0], point1, point2],
                paths=[[0,1,2]]);
}

module round_edges_cube(offset=0) {
    translate([0, 0, -50]) rounded_cube([TOTAL_WIDTH, TOTAL_HEIGHT, 100], r=ROUND_EDGES_RADIUS, offset=offset);
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

module corner_hole(d, h, offset) {
    translate([CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               CORNER_MOUNTING_HOLE_WALL_DIAMETER/2,
               h/2 + offset - h])
        cylinder(h=h+0.01, 
                 d=d, 
                 center=true);
}

module corner_holes(d, h, offset) {
    translate([CORNER_MOUNTING_HOLE_OFFSET,
               CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole(d, h, offset);
    translate([CORNER_MOUNTING_HOLE_OFFSET,
               TOTAL_HEIGHT-CORNER_MOUNTING_HOLE_WALL_DIAMETER-CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole(d, h, offset);
    translate([TOTAL_WIDTH-CORNER_MOUNTING_HOLE_WALL_DIAMETER-CORNER_MOUNTING_HOLE_OFFSET,
               CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole(d, h, offset);
    translate([TOTAL_WIDTH-CORNER_MOUNTING_HOLE_WALL_DIAMETER - CORNER_MOUNTING_HOLE_OFFSET,
               TOTAL_HEIGHT-CORNER_MOUNTING_HOLE_WALL_DIAMETER - CORNER_MOUNTING_HOLE_OFFSET,
               0]) 
        corner_hole(d, h, offset);
}

