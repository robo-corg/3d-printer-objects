SHAFT_DIAMETER = 28;
RING_WIDTH = 6;
RING_HEIGHT = 8;



module attachment(length, traps) {
    translate([SHAFT_DIAMETER/2 + RING_WIDTH + 2, 0, RING_HEIGHT/2]) {
        difference() {
            cube([10, length, RING_HEIGHT], center=true);
            translate([0.5, length/2 + 0.5, 0]) {
                rotate([90, 0, 0]) {
                    cylinder(length + 1, 2, 2, $fn = 100);
                }
            }

            if (traps) {
                translate([0.5, length/2 + 0.5, 0]) {
                    rotate([90, 0, 0]) {
                        cylinder(2, 2.5, 2.5, $fn = 100);
                    }
                } 
                translate([0.5, -(length/2 + 0.5) + 3, 0]) {
                    rotate([90, 0, 0]) {
                        cylinder(4, 3.1, 3.1, $fn = 6);
                    }
                } 
            }
        }
    }
}

module ring() {
    difference() {
        cylinder(RING_HEIGHT, SHAFT_DIAMETER/2 + RING_WIDTH, SHAFT_DIAMETER/2 + RING_WIDTH, $fn = 100);
        translate([0,0, -0.5]) {
            cylinder(RING_HEIGHT + 1, SHAFT_DIAMETER/2, SHAFT_DIAMETER/2, $fn = 100);
        }
    }

    attachment(9, false);
    rotate([0, 0, 90]) {
        attachment(18, true);
    }
    rotate([0, 0, -90]) {
        attachment(18, true);
    }
}

if (1) {
    difference() {
        ring();
        translate([-SHAFT_DIAMETER, -SHAFT_DIAMETER, -1]) {
            cube([SHAFT_DIAMETER, SHAFT_DIAMETER*2, SHAFT_DIAMETER]);
        }
    }
}

if (0) {
    difference() {
        ring();
        translate([0, -SHAFT_DIAMETER, -1]) {
            cube([SHAFT_DIAMETER, SHAFT_DIAMETER*2, SHAFT_DIAMETER]);
        }
    }
}