SLOP = 0.01;
$fn = 60;
KEYSTONE_FACE_WIDTH = 17;
KEYSTONE_FACE_HEIGHT = 15;
KEYSTONE_FACE_DEPTH = 9.3;
KEYSTONE_CLIP_WIDTH = 21;
KEYSTONE_CLIP_HEIGHT = 18;
KEYSTONE_CLIP_DEPTH = 11.75;
KEYSTONE_JACKET_WIDTH = KEYSTONE_CLIP_WIDTH + 4;
KEYSTONE_JACKET_HEIGHT = KEYSTONE_CLIP_HEIGHT + 4;
KEYSTONE_JACKET_DEPTH = KEYSTONE_FACE_DEPTH + KEYSTONE_CLIP_DEPTH;

MOUNT_DEPTH = 4;
MOUNT_BOLT_DIAMETER = 4;

difference() {
    translate([0, 0, KEYSTONE_FACE_DEPTH/2 -KEYSTONE_JACKET_DEPTH/2])
    cube([
        KEYSTONE_JACKET_WIDTH,
        KEYSTONE_JACKET_HEIGHT,
        KEYSTONE_JACKET_DEPTH
    ], center=true);

    cube([
        KEYSTONE_FACE_WIDTH,
        KEYSTONE_FACE_HEIGHT,
        KEYSTONE_FACE_DEPTH + SLOP
        ],
        center=true
    );

    translate([0, 0, -KEYSTONE_FACE_DEPTH/2 - KEYSTONE_CLIP_DEPTH/2])
    cube([
        KEYSTONE_CLIP_WIDTH,
        KEYSTONE_CLIP_HEIGHT,
        KEYSTONE_CLIP_DEPTH + SLOP
        ],
        center=true
    );

    hull() {
        translate([0, 0, 0])
        cube([
            KEYSTONE_FACE_WIDTH,
            KEYSTONE_FACE_HEIGHT,
            2
        ], center=true);

        translate([0, 0, -5])
        cube([
            KEYSTONE_CLIP_WIDTH,
            KEYSTONE_FACE_HEIGHT,
            2
        ], center=true);
    }
}




module mount() {
    translate([0, 0, KEYSTONE_FACE_DEPTH/2 - MOUNT_DEPTH/2])
    difference() {
        intersection() {
            translate([KEYSTONE_JACKET_WIDTH/2, -50, -50])
            cube([
                100,
                100,
                100
                ]
            );
            hull() {
                translate([KEYSTONE_JACKET_WIDTH/2, KEYSTONE_JACKET_HEIGHT/2 - 4, 0])
                cylinder(h=MOUNT_DEPTH, r=4, center=true);

                translate([KEYSTONE_JACKET_WIDTH/2, -KEYSTONE_JACKET_HEIGHT/2 + 4, 0])
                cylinder(h=MOUNT_DEPTH, r=4, center=true);

                translate([KEYSTONE_JACKET_WIDTH/2 + 8, KEYSTONE_JACKET_HEIGHT/2 - 8, 0])
                cylinder(h=MOUNT_DEPTH, r=4, center=true);

                translate([KEYSTONE_JACKET_WIDTH/2 + 8, -KEYSTONE_JACKET_HEIGHT/2 + 8, 0])
                cylinder(h=MOUNT_DEPTH, r=4, center=true);
            }
        }

        translate([KEYSTONE_JACKET_WIDTH/2  + 6, 0, 0])
        cylinder(h=MOUNT_DEPTH + 8, d=MOUNT_BOLT_DIAMETER, center=true);
    }
}

mount();
mirror([1, 0, 0])
mount();