ARDUINO_MEGA_LENGTH = 102;
ARDUINO_MEGA_WIDTH = 54;
ARDUINO_BOTTOM_CLEARANCE = 4;
ARDUINO_THROUGH_HOLE_RADIUS = 1.5;
BOTTOM_HEIGHT = 4;
BOTTOM_WINGS = 2;

$fs = 0.25;

module mega_mount() {
    clearance_center = BOTTOM_HEIGHT/2 + ARDUINO_BOTTOM_CLEARANCE/2;

    cube([ARDUINO_MEGA_LENGTH, ARDUINO_MEGA_WIDTH, BOTTOM_HEIGHT], center=true);
    
    translate([0, 0, -2]) {
        cube([ARDUINO_MEGA_LENGTH, ARDUINO_MEGA_WIDTH + BOTTOM_WINGS*2, 2], center=true);
    }

    translate([ARDUINO_MEGA_LENGTH/2 - 1.5 - 13, ARDUINO_MEGA_WIDTH/2 - 1.5 - 1, clearance_center]) {
        cylinder(
            ARDUINO_BOTTOM_CLEARANCE,
            ARDUINO_THROUGH_HOLE_RADIUS + 0.5,
            ARDUINO_THROUGH_HOLE_RADIUS + 0.5,
            center=true
        );
    }

    translate([ARDUINO_MEGA_LENGTH/2 - 1.5 - 13, -ARDUINO_MEGA_WIDTH/2 + 1.5 + 0.5, clearance_center]) {
        cylinder(
            ARDUINO_BOTTOM_CLEARANCE,
            ARDUINO_THROUGH_HOLE_RADIUS + 0.5,
            ARDUINO_THROUGH_HOLE_RADIUS + 0.5,
            center=true
        );
    }
    
    translate([0, 0, ARDUINO_BOTTOM_CLEARANCE + BOTTOM_HEIGHT/2]) {
        translate([ARDUINO_MEGA_LENGTH/2 - 1.5 - 13, ARDUINO_MEGA_WIDTH/2 - 1.5 - 1, 1.5]) {
            cylinder(
                3,
                ARDUINO_THROUGH_HOLE_RADIUS,
                ARDUINO_THROUGH_HOLE_RADIUS,
                center=true
            );
        }

        translate([ARDUINO_MEGA_LENGTH/2 - 1.5 - 13, -ARDUINO_MEGA_WIDTH/2 + 1.5 + 0.5, 1.5]) {
            cylinder(
                3,
                ARDUINO_THROUGH_HOLE_RADIUS,
                ARDUINO_THROUGH_HOLE_RADIUS,
                center=true
            );
        }
    }

    translate([-ARDUINO_MEGA_LENGTH/2 + 15 + 5/2, 0, clearance_center]) {
        cube([5, 30, ARDUINO_BOTTOM_CLEARANCE], center=true);
    }
}

color("green") {
    difference() {
        mega_mount();
        translate([10, 0, 0]) {
            cube([ARDUINO_MEGA_LENGTH - 32, ARDUINO_MEGA_WIDTH - 16, BOTTOM_HEIGHT + 4], center=true);
        }
    }
}

WALLS_WIDTH = 2;
WALLS_HEIGHT = 40;

module m3_hole() {
    translate([ARDUINO_MEGA_LENGTH/2 - 6/2 - 3.5, ARDUINO_MEGA_WIDTH/2 + WALLS_WIDTH/2, -6/2 - 3.5]) {
        //cube([6, 2.5, 6], center=true);
        rotate([90, 0, 0]) {
            cylinder(8, 1.5, 1.5, center=true);
        }
    }
}

difference() {
    translate([0, ARDUINO_MEGA_WIDTH/2 + WALLS_WIDTH/2 + 2, 0]) {
        translate([0, 0, WALLS_HEIGHT/2 - BOTTOM_HEIGHT/2 - 3]) {
            cube([ARDUINO_MEGA_LENGTH, WALLS_WIDTH, WALLS_HEIGHT], center=true);
        }
        translate([0, -2, 0]) {
            cube([ARDUINO_MEGA_LENGTH, 2, 2], center=true);
        }
        translate([0, -2, -4]) {
            cube([ARDUINO_MEGA_LENGTH, 2, 2], center=true);
        }
        translate([0, -1, -7]) {
            cube([ARDUINO_MEGA_LENGTH, 4, 7], center=true);
        }
    }
    m3_hole();
    mirror([1, 0, 0]) {
        m3_hole();
    }
}
translate([0, ARDUINO_MEGA_WIDTH/2 + WALLS_WIDTH/2 + 2, 0]) {
    translate([0, -3, WALLS_HEIGHT - 7/2]) {
        cube([ARDUINO_MEGA_LENGTH, 4, 7], center=true);
    }
}
