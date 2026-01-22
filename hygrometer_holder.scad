HOLDER_WIDTH = 120;
HOLDER_DEPTH = 50;

$fn = 100;

difference() {
    cube([HOLDER_WIDTH, HOLDER_DEPTH, 5]);
    translate([HOLDER_WIDTH/2, HOLDER_DEPTH/2, 2]) {
        cylinder(d=42.5, h=8, center=true);
    }
}

// rises on each end to allow for the hygrometer to stick out a bit
module spacer() {
    translate([0, 0, 5]) {
        cube([25, HOLDER_DEPTH, 5]);
        // wedge based ramp
        translate([25, 0, 0])
        polyhedron(points=[[0, 0, 5], [5, 0, 0], [5, HOLDER_DEPTH, 0], [0, HOLDER_DEPTH, 5], [0, 0, 0], [0, HOLDER_DEPTH, 0]], faces=[
            // ramp
            [0, 1, 2, 3],
            // bottom
            [4, 5, 2, 1],
            // left side (x=0)
            [4, 0, 3, 5],
            // front (y=0)
            [4, 1, 0],
            // back (y=HOLDER_DEPTH)
            [5, 3, 2]
        ]);
    }
}

spacer();

translate([HOLDER_WIDTH, 0, 0])
mirror([1, 0, 0])
spacer();