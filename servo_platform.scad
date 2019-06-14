HEIGHT = 2.5;
M = 0.1;

BOLT_SIZE = 4;
BOLT_SIZE_R = BOLT_SIZE / 2;
NUT_SIZE = 7;
NUT_R = NUT_SIZE/2;

$fs = 0.5;

module servo_arm() {
    h = HEIGHT + M;
    
    SERVO_ARM_SHAFT_DIAMETER = 7.21;
    SERVO_ARM_SHAFT_R = SERVO_ARM_SHAFT_DIAMETER/2;

    cylinder(h, SERVO_ARM_SHAFT_R, SERVO_ARM_SHAFT_R, center=true);

    ARM_WIDTH = 5.77;

    translate ([0, -ARM_WIDTH/2, -h/2]) {
        cube([19.68, 5.77, h]);
    }
}



difference() {
    group() {
        cube([45, 45, HEIGHT], center=true);
        translate([0, 0, HEIGHT]) {
            cube([45, 45, HEIGHT], center=true);
        }
    }
    servo_arm();
    translate([45/2 - 6, 42/2 - 4, 0]) {
        cube([NUT_SIZE, NUT_SIZE, HEIGHT + M], center=true);
    }
    translate([-45/2 + 6, 42/2 - 4, 0]) {
        cube([NUT_SIZE, NUT_SIZE, HEIGHT + M], center=true);
    }
    translate([-45/2 + 6, -42/2 + 4, 0]) {
        cube([NUT_SIZE, NUT_SIZE, HEIGHT + M], center=true);
    }
    translate([45/2 - 6, -42/2 + 4, 0]) {
        cube([NUT_SIZE, NUT_SIZE, HEIGHT + M], center=true);
    }
    translate([0, 0, HEIGHT]) {
        translate([45/2 - 6, 42/2 - 4, 0]) {
            cylinder(HEIGHT + M, BOLT_SIZE_R, BOLT_SIZE_R, center=true);
        }
        translate([-45/2 + 6, 42/2 - 4, 0]) {
            cylinder(HEIGHT + M, BOLT_SIZE_R, BOLT_SIZE_R, center=true);
        }
        translate([-45/2 + 6, -42/2 + 4, 0]) {
            cylinder(HEIGHT + M, BOLT_SIZE_R, BOLT_SIZE_R, center=true);
        }
        translate([45/2 - 6, -42/2 + 4, 0]) {
            cylinder(HEIGHT + M, BOLT_SIZE_R, BOLT_SIZE_R, center=true);
        }
    }
}

//servo_arm();