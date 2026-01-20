// Main trough dimensions
FEEDER_WIDTH = 200;
FEEDER_HEIGHT = 50;
FEEDER_DEPTH = 100;
WALL_THICKNESS = 10;

// Bin parameters
BIN_WALL = 3;
BIN_CORNER_RADIUS = 3;
BIN_CLEARANCE = 0.3; // Clearance for easy insertion

// Clip mechanism parameters
CLIP_WIDTH = 12;
CLIP_HEIGHT = 8;
CLIP_THICKNESS = 1.5;
CLIP_PROTRUSION = 1.2;
SLOT_DEPTH = CLIP_PROTRUSION + 0.5;
CLIP_FLEX_UNDERCUT = 0.8; // Makes clip tabs flexible

// Calculated bin dimensions
BIN_ZONE_WIDTH = (FEEDER_WIDTH - 2*WALL_THICKNESS) / 2;
BIN_ZONE_DEPTH = FEEDER_DEPTH - 2*WALL_THICKNESS;
BIN_ZONE_HEIGHT = FEEDER_HEIGHT - WALL_THICKNESS;

// Export mode: "assembly", "trough_only", "bin1_only", "bin2_only", "holder_arm"
EXPORT_MODE = "assembly";


module trough() {
    difference() {
        cube([FEEDER_WIDTH, FEEDER_DEPTH, FEEDER_HEIGHT]);

        // Main cavity
        translate([WALL_THICKNESS, WALL_THICKNESS, WALL_THICKNESS + 0.01]) {
            cube([FEEDER_WIDTH - 2*WALL_THICKNESS, FEEDER_DEPTH - 2*WALL_THICKNESS, FEEDER_HEIGHT - WALL_THICKNESS]);
        }

        // Clip slots for bin 1 (left bin)
        // Front left slot
        translate([WALL_THICKNESS - SLOT_DEPTH, WALL_THICKNESS + 10, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }
        // Front right slot (at divider)
        translate([WALL_THICKNESS + BIN_ZONE_WIDTH - 0.01, WALL_THICKNESS + 10, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }
        // Back left slot
        translate([WALL_THICKNESS - SLOT_DEPTH, FEEDER_DEPTH - WALL_THICKNESS - 10 - CLIP_WIDTH, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }
        // Back right slot (at divider)
        translate([WALL_THICKNESS + BIN_ZONE_WIDTH - 0.01, FEEDER_DEPTH - WALL_THICKNESS - 10 - CLIP_WIDTH, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }

        // Clip slots for bin 2 (right bin)
        // Front left slot (at divider)
        translate([WALL_THICKNESS + BIN_ZONE_WIDTH - SLOT_DEPTH, WALL_THICKNESS + 10, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }
        // Front right slot
        translate([FEEDER_WIDTH - WALL_THICKNESS - 0.01, WALL_THICKNESS + 10, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }
        // Back left slot (at divider)
        translate([WALL_THICKNESS + BIN_ZONE_WIDTH - SLOT_DEPTH, FEEDER_DEPTH - WALL_THICKNESS - 10 - CLIP_WIDTH, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }
        // Back right slot
        translate([FEEDER_WIDTH - WALL_THICKNESS - 0.01, FEEDER_DEPTH - WALL_THICKNESS - 10 - CLIP_WIDTH, FEEDER_HEIGHT - CLIP_HEIGHT - 5]) {
            cube([SLOT_DEPTH + 0.01, CLIP_WIDTH, CLIP_HEIGHT]);
        }
    }
}

module rounded_cube(size, radius) {
    hull() {
        translate([radius, radius, 0])
            cylinder(r=radius, h=size[2]);
        translate([size[0]-radius, radius, 0])
            cylinder(r=radius, h=size[2]);
        translate([radius, size[1]-radius, 0])
            cylinder(r=radius, h=size[2]);
        translate([size[0]-radius, size[1]-radius, 0])
            cylinder(r=radius, h=size[2]);
    }
}

module clip_tab() {
    // Flexible clip tab with undercut for flexibility
    difference() {
        cube([CLIP_PROTRUSION, CLIP_WIDTH, CLIP_HEIGHT]);
        // Undercut to make tab flexible
        translate([-0.01, CLIP_THICKNESS, CLIP_FLEX_UNDERCUT]) {
            cube([CLIP_PROTRUSION, CLIP_WIDTH - 2*CLIP_THICKNESS, CLIP_HEIGHT]);
        }
    }
}

module holder_arm() {
    %color("ForestGreen", 0.9)
    translate([FEEDER_WIDTH/2 - 5, 0, FEEDER_HEIGHT]) {
        difference() {
            cube([10, FEEDER_DEPTH, 3]);
            // M3 bolt hole
            translate([5, WALL_THICKNESS/2, -0.5]) {
                cylinder(4, 1.5, 1.5, $fn = 100);
            }
            translate([5, FEEDER_DEPTH - WALL_THICKNESS/2, -0.5]) {
                cylinder(4, 1.5, 1.5, $fn = 100);
            }
        }
    }
}

module nut_trap_m3() {
    cylinder(4, 1.5, 1.5, $fn = 100);
    cube([5.42, 6.02, 2.3], center=true);
    translate([0, -4, 0]) {
        cube([5.42, 6.02, 2.3], center=true);
    }
}

module bin() {
    difference() {
        // Outer shell with rounded bottom corners
        union() {
            // Main body
            cube([BIN_ZONE_WIDTH - BIN_CLEARANCE, BIN_ZONE_DEPTH - BIN_CLEARANCE, BIN_ZONE_HEIGHT]);

            // // Clip tabs - left side
            // translate([-CLIP_PROTRUSION, 10, BIN_ZONE_HEIGHT - CLIP_HEIGHT - 5]) {
            //     clip_tab();
            // }
            // translate([-CLIP_PROTRUSION, BIN_ZONE_DEPTH - BIN_CLEARANCE - 10 - CLIP_WIDTH, BIN_ZONE_HEIGHT - CLIP_HEIGHT - 5]) {
            //     clip_tab();
            // }

            // // Clip tabs - right side
            // translate([BIN_ZONE_WIDTH - BIN_CLEARANCE, 10, BIN_ZONE_HEIGHT - CLIP_HEIGHT - 5]) {
            //     clip_tab();
            // }
            // translate([BIN_ZONE_WIDTH - BIN_CLEARANCE, BIN_ZONE_DEPTH - BIN_CLEARANCE - 10 - CLIP_WIDTH, BIN_ZONE_HEIGHT - CLIP_HEIGHT - 5]) {
            //     clip_tab();
            // }
        }

        // Interior cavity with rounded corners
        translate([BIN_WALL, BIN_WALL, BIN_WALL]) {
            rounded_cube([
                BIN_ZONE_WIDTH - BIN_CLEARANCE - 2*BIN_WALL,
                BIN_ZONE_DEPTH - BIN_CLEARANCE - 2*BIN_WALL,
                BIN_ZONE_HEIGHT
            ], BIN_CORNER_RADIUS);
        }
    }
}

// Main assembly
if (EXPORT_MODE == "assembly" || EXPORT_MODE == "trough_only") {
    difference() {
        trough();
        // Holder arm nut traps (center front and back)
        translate([FEEDER_WIDTH/2, WALL_THICKNESS/2, FEEDER_HEIGHT-3]) {
            nut_trap_m3();
        }
        translate([FEEDER_WIDTH/2, FEEDER_DEPTH - WALL_THICKNESS/2, FEEDER_HEIGHT-3]) {
            mirror([0, 1, 0]) {
                nut_trap_m3();
            }
        }

        // Corner nut traps for future add-ons
        // Front-left corner
        translate([WALL_THICKNESS/2, WALL_THICKNESS/2, FEEDER_HEIGHT-3]) {
            nut_trap_m3();
        }
        // Front-right corner
        translate([FEEDER_WIDTH - WALL_THICKNESS/2, WALL_THICKNESS/2, FEEDER_HEIGHT-3]) {
            nut_trap_m3();
        }
        // Back-left corner
        translate([WALL_THICKNESS/2, FEEDER_DEPTH - WALL_THICKNESS/2, FEEDER_HEIGHT-3]) {
            mirror([0, 1, 0]) {
                nut_trap_m3();
            }
        }
        // Back-right corner
        translate([FEEDER_WIDTH - WALL_THICKNESS/2, FEEDER_DEPTH - WALL_THICKNESS/2, FEEDER_HEIGHT-3]) {
            mirror([0, 1, 0]) {
                nut_trap_m3();
            }
        }
    }
}



if (EXPORT_MODE == "assembly") {
    // Bin 1 (left)
    %color("SteelBlue", 0.7)
    translate([WALL_THICKNESS + BIN_CLEARANCE/2, WALL_THICKNESS + BIN_CLEARANCE/2, WALL_THICKNESS]) {
        bin();
    }

    // Bin 2 (right)
    %color("Coral", 0.7)
    translate([WALL_THICKNESS + BIN_ZONE_WIDTH + BIN_CLEARANCE/2, WALL_THICKNESS + BIN_CLEARANCE/2, WALL_THICKNESS]) {
        bin();
    }
}

if (EXPORT_MODE == "bin1_only") {
    bin();
}

if (EXPORT_MODE == "bin2_only") {
    bin();
}

if (EXPORT_MODE == "assembly" || EXPORT_MODE == "holder_arm") {
    holder_arm();
}