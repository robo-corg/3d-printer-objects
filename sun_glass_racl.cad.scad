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