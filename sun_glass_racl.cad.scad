//cylinder(1, 10, 10);

// rotate_extrude(angle=180, convexity = 10)
// translate([2, 0, 0])
// difference() {
//     circle(r = 1,$fn = 100);
//     // translate([0, 0.5, 0]) {
//     //     cube([2, 1, 2], center=true);
//     // }
// };

OUTER_RADIUS = 50;
THICKNESS = 10;
DEPTH = 2;
BAR_LENGTH = 194;

/* [STL element to export] */
ARM_RIGHT = true;
ARM_LEFT = true;
MOUNTING = true;
BAR = true;

module arm() {
    difference() {
        linear_extrude(height = DEPTH) {
            difference() {
                circle(r = OUTER_RADIUS,$fn = 200);
                circle(r = OUTER_RADIUS - THICKNESS,$fn = 200);
            };
        };

        translate([0, OUTER_RADIUS/2, DEPTH-1]) {
                cube([OUTER_RADIUS*2, OUTER_RADIUS, DEPTH*2], center=true);
        };

    rotate([0, 0, -7]) {
        translate([OUTER_RADIUS - THICKNESS/2, 0, DEPTH/2]) {
            cylinder(1.01, 4, 4,$fn = 100);
        }
    }
    }

    // rotate([0, 0, -5]) {
    //     translate([OUTER_RADIUS - THICKNESS/2, 0, DEPTH/2]) {
    //         cylinder(1, 4, 4,$fn = 100);
    //     }
    // }

    translate([-OUTER_RADIUS, 0, 0]) {
        cube([THICKNESS, THICKNESS, DEPTH]);
        translate([0, THICKNESS - 5, 0]) {
            cube([2, 5, 10]);
        }
    }
}

module left_mounting() {
    difference() {
        translate([-OUTER_RADIUS - 1, 0, -4]) {
            cube([THICKNESS, THICKNESS, 102]);
        }
        arm();
        
        translate([-OUTER_RADIUS - 1, 0, 0]) {
            translate([1, 0, -0.5]) {
                cube([THICKNESS, THICKNESS, 0.5]);
            }
        }

        translate([-OUTER_RADIUS + 2, - 1, 20]) {
            cube([THICKNESS, THICKNESS + 2, THICKNESS]);
            translate([-1, THICKNESS, -1]) {
                cube([THICKNESS, 2, THICKNESS + 2]);
            }
            translate([THICKNESS - 4, 0, -1]) {
                cube([1, THICKNESS, THICKNESS + 2]);
            }
            translate([THICKNESS - 6, 0, -1]) {
                cube([1, THICKNESS, THICKNESS + 2]);
            }
            translate([0, THICKNESS/2 + 3/4, THICKNESS/2]) {
                rotate([0, 90, 0]) {
                    cylinder(THICKNESS, 3, 3, center=true, $fn=200);
                }
            }
        }
    }
}

if (ARM_RIGHT) {
    arm();
}

if (ARM_LEFT) {
    translate([0,0,196]) {
        rotate([0, 0, 0]) {
            mirror([0, 0, 1]) {
                arm();
            }
        }
    }
}

if (MOUNTING) {
    left_mounting();
    translate([0,0,196]) {
        mirror([0, 0, 1]) {
            left_mounting();
        }
    }
}

if (BAR) {
    rotate([0, 0, -7]) {
        translate([OUTER_RADIUS - THICKNESS/2,0, BAR_LENGTH/2 + DEPTH - 1]) {
            translate([0,0, 0]) {
                cylinder(BAR_LENGTH, 4, 4, center=true, $fn=200);
            }
        }
    }
}