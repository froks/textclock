include <config.scad>
use <common.scad>

module backplate_wall() {
    intersection() {
        cube([TOTAL_WIDTH, TOTAL_HEIGHT, 10]);
        round_edges_cube();
    }
}

backplate_wall();