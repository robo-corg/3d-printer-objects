$fn = 90;

BASE_WIDTH = 168 - 56;
TOP_WIDTH = 88;
HEIGHT = 210;
SCREW_HOLE_DIAMETER = 5;
SCREW_HOLE_SEPARATION = 56;

// w(0) = BASE_WIDTH;
// w(HEIGHT) = TOP_WIDTH;

module sterlite_recess() {
    linear_extrude(height=10, center=true)
    polygon(points=[
        [BASE_WIDTH/2, 0],
        [TOP_WIDTH/2, HEIGHT],
        [-TOP_WIDTH/2, HEIGHT],
        [-BASE_WIDTH/2, 0]
    ]);
}

%sterlite_recess();

MOUNT_HEIGHT = HEIGHT/2 + HEIGHT/4;

translate([0, MOUNT_HEIGHT, 0])
%import("barMount.stl", convexity=3);

module sterlite_jig() {
    intersection() {
        translate([0, MOUNT_HEIGHT, 0])
        cube([BASE_WIDTH, 16, 10], center=true);
        sterlite_recess();
    }
}

difference() {
    sterlite_jig();
    translate([0, MOUNT_HEIGHT, 0]) {
        translate([SCREW_HOLE_SEPARATION/2, 0, 0])
        cylinder(d=SCREW_HOLE_DIAMETER, h=20, center=true);
        translate([-SCREW_HOLE_SEPARATION/2, 0, 0])
        cylinder(d=SCREW_HOLE_DIAMETER, h=20, center=true);
    }
}