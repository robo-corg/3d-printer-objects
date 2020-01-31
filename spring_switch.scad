SPRING_DIAMETER = 9;
SPRING_HEIGHT = 35;
GAP = 2;
WALL_THICKNESS = 2;
SPRING_OUTER_GAP = 0.1;

spring_radius = SPRING_DIAMETER / 2;

height = SPRING_HEIGHT + 15;

module spring_holder() {
    difference() {
        cylinder(height, spring_radius + WALL_THICKNESS + SPRING_OUTER_GAP, spring_radius + WALL_THICKNESS + SPRING_OUTER_GAP, $fn = 100);
        translate([0, 0, 1]) {
            cylinder(height, spring_radius + SPRING_OUTER_GAP, spring_radius + SPRING_OUTER_GAP, $fn = 100);
        }
    }

    cylinder(height, spring_radius - GAP, spring_radius - GAP, $fn = 100);
}

//spring_holder();

difference() {
    translate([0, 0, 1]) {
        cylinder(height, spring_radius + SPRING_OUTER_GAP - 0.1, spring_radius + SPRING_OUTER_GAP - 0.1, $fn = 100);
    }
    cylinder(height, spring_radius - GAP + 0.1, spring_radius - GAP + 0.1, $fn = 100);
}