$fn=20;

// Distance between two leds on a strip - depending on your mounting direction, only one is actually relevant,
// but to keep the clock square, they should be the
LED_STRIPE_HORIZ_DISTANCE = 16.66;
LED_STRIPE_VERT_DISTANCE = 16.66;

// The size of a single led module on that strip

// The stripe-segments are soldered together, at those points the distance between leds varies a lot,
// sometimes resoldering is required, so the distances between the leds match up
LED_STRIPE_LED_WIDTH = 8;
LED_STRIPE_LED_HEIGHT = 8;

// Since there are small capacitors right next to the leds, we need to provide a little space for them
LED_STRIPE_CAP_WIDTH = 3;
LED_STRIPE_CAP_HEIGHT = 5;
LED_STRIPE_CAP_DEPTH = 1.5; // 1;

// Defines the offset for those capacitors from the leds
LED_STRIPE_CAP_OFFSET_X = -4;
LED_STRIPE_CAP_OFFSET_Y = 0;

// Parameters for the screw holes
LETTER_PLATE_SCREW_INSERT_HEIGHT = 6; // 3.5;
LETTER_PLATE_SCREW_INSERT_WALL_THICKNESS = 2;
LETTER_PLATE_SCREW_INSERT_DIAMETER = 4;
LETTER_PLATE_SCREW_WALL_DIAMETER = LETTER_PLATE_SCREW_INSERT_DIAMETER + LETTER_PLATE_SCREW_INSERT_WALL_THICKNESS;
SCREW_DIAMETER = 3.2; // OD of M2.5 threaded insert to be heat inserted

// Parameters for the corner holes (used to mount wallplate)
CORNER_MOUNTING_HOLE_INSERT_HEIGHT = LETTER_PLATE_SCREW_INSERT_HEIGHT;
CORNER_MOUNTING_HOLE_INSERT_DIAMETER = LETTER_PLATE_SCREW_INSERT_DIAMETER;
CORNER_MOUNTING_HOLE_INSERT_WALL_THICKNESS = LETTER_PLATE_SCREW_INSERT_WALL_THICKNESS;
CORNER_MOUNTING_HOLE_WALL_DIAMETER = CORNER_MOUNTING_HOLE_INSERT_DIAMETER + CORNER_MOUNTING_HOLE_INSERT_WALL_THICKNESS;
CORNER_MOUNTING_HOLE_OFFSET = 1.85;

OUTER_HOLES_DIST = 2;
INNER_HOLES_DIST = 4;

LETTER_PLATE_LETTER_BOTTOM = 0.15;
LETTER_PLATE_THICKNESS = 1.05;
LETTER_SEPARATOR_THICKNESS = 2;
LETTER_SEPARATOR_HEIGHT = 10;

LED_HOLDER_PLATE_HEIGHT = 1.5;
INNER_PLATE_TOLERANCE = 1;

LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH = 0.6;
LED_HOLDER_PLATE_DIVIDER_CUTOUT_TOLERANCE = 1;

LED_FIXATION_CUTOUT_HEIGHT = 11;
LED_FIXATION_CUTOUT_WIDTH = 6;
LED_FIXATION_PLATE_THICKNESS = 2;

// Height of the backplate
WALLMOUNT_PLATE_THICKNESS = 6;

ELECTRONICS_HEIGHT = 15;

OUTER_WALL_THICKNESS = 2;
OUTER_WALL_HEIGHT = 2 + LETTER_SEPARATOR_HEIGHT +
    (LED_HOLDER_PLATE_HEIGHT-LED_HOLDER_PLATE_DIVIDER_CUTOUT_DEPTH) +
    LED_FIXATION_PLATE_THICKNESS + ELECTRONICS_HEIGHT;
// 2mm height tolerance to adjust fitting and led-stripe height

ROUND_EDGES_RADIUS = 3;

CONFIG_HORIZ_EXTRA = 0;
CONFIG_VERT_EXTRA = 0;


TESTER_MODE = false;
