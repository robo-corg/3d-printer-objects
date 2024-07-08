$fn = 100;

MAGNET_DIAMTER = 31.6;
MAGNET_TICKNESS = 2;
HOLDER_THICKNESS = 2;
HOLDER_TOP_THICKNESS = 3.1;
HOLDER_BOTTOM_THICKNESS = 2;

module magnet_holder() {
    difference() {
        cylinder(d=MAGNET_DIAMTER + HOLDER_THICKNESS*2, h=MAGNET_TICKNESS + HOLDER_TOP_THICKNESS + HOLDER_BOTTOM_THICKNESS);
        translate([0, 0, HOLDER_BOTTOM_THICKNESS]) {
            cylinder(d=MAGNET_DIAMTER, h=MAGNET_TICKNESS);
        }
    }
}

magnet_holder();

translate([0, 0, nut_trap_m4_bbox()[2]/2 + MAGNET_TICKNESS + HOLDER_THICKNESS*2])
intersection() {
    cylinder(d=nut_trap_m4_bbox()[0], h=nut_trap_m4_bbox()[2], center=true);
    nut_trap_m4(center=true);
}

for (n = [0:4]) {
    rotate([0, 0, n*90])
    translate([nut_trap_m4_bbox()[0]/2 + MAGNET_DIAMTER/2, 0, nut_trap_m4_bbox()[2]/2])
    nut_trap_m4(center=true);
}

module nut_trap_cutout(bolt_diameter, width, height, depth) {
    // Hole for bolt
    translate([width/2, height/2, 0]) {
        cylinder(h = depth + 2.1, d = bolt_diameter, center = false);
    }
    // nut trap box cut out
    cube([width, height, depth], center = false);
}

function nut_trap_bbox(bolt_diameter=2, width = 4, height=4.4, depth=2, housing_width=2, housing_height=2, housing_top_depth=2, housing_bottom_depth=2) = [
    width + housing_width*2,
    height + housing_height*2,
    depth + housing_top_depth + housing_bottom_depth
];

function bbox_center_offset(bbox) = [
    -bbox[0]/2,
    -bbox[1]/2,
    -bbox[2]/2
];

module nut_trap(bolt_diameter=2, width = 4, height=4.4, depth=2, housing_width=2, housing_height=2, housing_top_depth=2, housing_bottom_depth=2, debug_cutaway=false, center=false) {
    bbox = nut_trap_bbox(bolt_diameter, width, height, depth, housing_width, housing_height, housing_top_depth, housing_bottom_depth);

    offset = center ? bbox_center_offset(bbox) : [0, 0, 0];

    translate(offset) {
        difference() {
            translate([0, 0, 0])
            cube(bbox, center = false);
            translate([housing_width, housing_height, housing_bottom_depth])
            nut_trap_cutout(bolt_diameter, width, height, depth);
            if (debug_cutaway) {
                translate([-1, -1, - 1]) {
                    cube([(width + housing_width*2)/2 + 1, height + housing_height*2 + 2, depth + housing_top_depth + housing_bottom_depth + 2], center = false);
                }
            }
        }
        if (debug_cutaway) {
            %translate([housing_width, housing_height, housing_bottom_depth])
            nut_trap_cutout(bolt_diameter, width, height, depth);
        }
    }
}

module nut_trap_m2(bolt_diameter=2, width = 4, depth=2, height=4.4, housing_width=2, housing_height=2, housing_top_depth=2, housing_bottom_depth=2, debug_cutaway=false, center=false) {
    nut_trap(
        bolt_diameter=bolt_diameter,
        width = width,
        height=height,
        depth=depth,
        housing_width=housing_width,
        housing_height=housing_height,
        housing_top_depth=housing_top_depth,
        housing_bottom_depth=housing_bottom_depth,
        debug_cutaway=debug_cutaway,
        center=center
    );
}

module nut_trap_m4(bolt_diameter=4, width = 6.85, height=7.75, depth=3.1, housing_width=2, housing_height=2, housing_top_depth=2, housing_bottom_depth=2, debug_cutaway=false, center=false) {
    nut_trap(
        bolt_diameter=bolt_diameter,
        width = width,
        height=height,
        depth=depth,
        housing_width=housing_width,
        housing_height=housing_height,
        housing_top_depth=housing_top_depth,
        housing_bottom_depth=housing_bottom_depth,
        debug_cutaway=debug_cutaway,
        center=center
    );
}

function nut_trap_m4_bbox(bolt_diameter=4, width = 6.85, height=7.75, depth=3.1, housing_width=2, housing_height=2, housing_top_depth=2, housing_bottom_depth=2) =
    nut_trap_bbox(bolt_diameter, width, height, depth, housing_width, housing_height, housing_top_depth, housing_bottom_depth);