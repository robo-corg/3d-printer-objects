CAMERA_WIDTH = 25.3;
CAMERA_LENGTH = 24.2;
CAMERA_PCB_HEIGHT = 1.7;
CAMERA_PCB_AND_RIBBON_HEIGHT = 4.45;

TOP_THROUGH_HOLE_MARGIN = 1;
THROUGH_HOLE_RADIUS = 1;

// Lens is a box shape
LENS_SIZE = 8.7;
LENS_OFFSET_Y = 11.7;

// Depth of back enclosure + PCB
BACK_AND_PCB_DEPTH = 5.6;

MOUNTING_SPACE = 4;
MOUNTING_SCREW_DIAMETER = 2;

// translate([0, 0, 2]) {
//     difference() {
//         cube([CAMERA_WIDTH, CAMERA_LENGTH, 1], center=true);

//         translate([0, CAMERA_LENGTH/2 - LENS_SIZE/2 - LENS_OFFSET_Y + 1.5, 0]) {
//             cube([LENS_SIZE, LENS_SIZE, 2], center=true);
//         }
//     }
// }


pcb_leeway = CAMERA_PCB_AND_RIBBON_HEIGHT - CAMERA_PCB_HEIGHT;
chasis_depth = pcb_leeway + 1;

module mounting_screw_hole_left() {
    translate([CAMERA_WIDTH/2, -CAMERA_LENGTH/2 - MOUNTING_SPACE/2 - 1, chasis_depth/4 - 0.25]) {
        rotate([0, 90, 0]) {
            cylinder(3, MOUNTING_SCREW_DIAMETER/2, MOUNTING_SCREW_DIAMETER/2, center=true, $fn=32);
        }
    }
}

difference() {
    translate([0, -MOUNTING_SPACE/2, 2.5 - (pcb_leeway + 1)/2]) {
        cube([CAMERA_WIDTH + 2, CAMERA_LENGTH + 2 + MOUNTING_SPACE, pcb_leeway + 1], center=true);
    }
    translate([0, 0, 2.5 - (pcb_leeway + 1)/2]) {
        cube([CAMERA_WIDTH, CAMERA_LENGTH, pcb_leeway + 2], center=true);
    }
    translate([0, -5 - MOUNTING_SPACE/2, 2.5 - (pcb_leeway + 1)/2]) {
        cube([CAMERA_WIDTH, CAMERA_LENGTH + MOUNTING_SPACE, pcb_leeway + 2], center=true);
    }
    mounting_screw_hole_left();
    mirror([1, 0, 0]) {
        mounting_screw_hole_left();
    }
}




peg_length = pcb_leeway + 2 + CAMERA_PCB_HEIGHT;
peg_length_diff = peg_length - pcb_leeway;

module standoffs() {
    translate([CAMERA_WIDTH/2 - 0.5, 4, pcb_leeway/2 - 1.25]) {
        cube([1, 14, pcb_leeway], center=true);
    }

    difference() {
        translate([CAMERA_WIDTH/2 - 1.6, CAMERA_LENGTH/2 - 1.5, pcb_leeway/2 - 1.25]) {
            cube([4, 4, pcb_leeway], center=true);
        }

        translate([CAMERA_WIDTH/2 - THROUGH_HOLE_RADIUS - TOP_THROUGH_HOLE_MARGIN - 0.1, CAMERA_LENGTH/2 - THROUGH_HOLE_RADIUS - TOP_THROUGH_HOLE_MARGIN, peg_length/2 - 1.25 - peg_length_diff]) {
            cylinder(peg_length, THROUGH_HOLE_RADIUS, THROUGH_HOLE_RADIUS, center=true, $fn=32);
        }
    }

    difference() {
        translate([CAMERA_WIDTH/2 - 1.6, CAMERA_LENGTH/2 - 1 - 13.22, pcb_leeway/2 - 1.25]) {
            cube([4, 3, pcb_leeway], center=true);
        }

        translate([CAMERA_WIDTH/2 - THROUGH_HOLE_RADIUS - TOP_THROUGH_HOLE_MARGIN - 0.1, CAMERA_LENGTH/2 - THROUGH_HOLE_RADIUS - 13.22, peg_length/2 - 1.25 - peg_length_diff]) {
            cylinder(peg_length, THROUGH_HOLE_RADIUS, THROUGH_HOLE_RADIUS, center=true, $fn=32);
        }
    }
}

standoffs();

mirror([1, 0, 0]) {
    standoffs();
}


STAND_HEIGHT = 120;
STAND_DEPTH = 6;

difference() {
    translate([0, -CAMERA_LENGTH/2 - MOUNTING_SPACE/2 + 1 + -STAND_HEIGHT/2, 2- STAND_DEPTH/4]) {
        difference() {
            cube([CAMERA_WIDTH + 6, STAND_HEIGHT, STAND_DEPTH], center=true);
            translate([0, 4, 0]) {
                cube([CAMERA_WIDTH + 2, STAND_HEIGHT - 4, STAND_DEPTH + 1], center=true);
            }
        }
    }
    translate([2, 0, 0]) {
        mounting_screw_hole_left();
    }
    
    mirror([1, 0, 0]) {
        translate([2, 0, 0]) {
            mounting_screw_hole_left();
        }
    }
}

module stand_screw_hole() {
    translate([CAMERA_WIDTH/2 + 6, 0, (STAND_DEPTH + 10)/2 - 2]) {
        rotate([90, 0, 0]) {
            cylinder(3, MOUNTING_SCREW_DIAMETER/2, MOUNTING_SCREW_DIAMETER/2, center=true, $fn=32);
        }
    }
}

translate([0, -MOUNTING_SPACE -CAMERA_LENGTH/2  - 16, 2- STAND_DEPTH/4]) {
    cube([CAMERA_WIDTH + 4, 2, STAND_DEPTH], center=true);
}

translate([0, -STAND_HEIGHT -CAMERA_LENGTH/2, 2- STAND_DEPTH/4 + 5]) {

    // Stand
    difference() {
        cube([CAMERA_WIDTH + 16, 2, STAND_DEPTH + 10], center=true);
        stand_screw_hole();
        mirror([1, 0, 0]) {
            stand_screw_hole();
        }
        mirror([0, 0, 1]) {
            stand_screw_hole();
            mirror([1, 0, 0]) {
                stand_screw_hole();
            }   
        }
    }
}