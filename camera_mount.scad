CAMERA_WIDTH = 25.3;
CAMERA_LENGTH = 24.2;
CAMERA_PCB_HEIGHT = 1.7;
CAMERA_PCB_AND_RIBBON_HEIGHT = 4.45;

TOP_THROUGH_HOLE_MARGIN = 1;
THROUGH_HOLE_RADIUS = 1;

translate([0, 0, 2]) {
    cube([CAMERA_WIDTH, CAMERA_LENGTH, 1], center=true);
}

difference() {
    translate([0, 0, 2.5 - (pcb_leeway + 1)/2]) {
        cube([CAMERA_WIDTH + 2, CAMERA_LENGTH + 2, pcb_leeway + 1], center=true);
    }
    translate([0, 0, 2.5 - (pcb_leeway + 1)/2]) {
        cube([CAMERA_WIDTH, CAMERA_LENGTH, pcb_leeway + 2], center=true);
    }
    translate([0, -5, 2.5 - (pcb_leeway + 1)/2]) {
        cube([CAMERA_WIDTH, CAMERA_LENGTH, pcb_leeway + 2], center=true);
    }
}

pcb_leeway = CAMERA_PCB_AND_RIBBON_HEIGHT - CAMERA_PCB_HEIGHT;

peg_length = pcb_leeway + 2 + CAMERA_PCB_HEIGHT;
peg_length_diff = peg_length - pcb_leeway;

module standoffs() {
    translate([CAMERA_WIDTH/2 - 0.5, 4, pcb_leeway/2 - 1.25]) {
        cube([1, 14, pcb_leeway], center=true);
    }

    translate([CAMERA_WIDTH/2 - 1.5, CAMERA_LENGTH/2 - 1.5, pcb_leeway/2 - 1.25]) {
        cube([4, 4, pcb_leeway], center=true);
    }

    translate([CAMERA_WIDTH/2 - 1.5, CAMERA_LENGTH/2 - 1 - 13.22, pcb_leeway/2 - 1.25]) {
        cube([4, 3, pcb_leeway], center=true);
    }

    translate([CAMERA_WIDTH/2 - THROUGH_HOLE_RADIUS - TOP_THROUGH_HOLE_MARGIN - 0.1, CAMERA_LENGTH/2 - THROUGH_HOLE_RADIUS - TOP_THROUGH_HOLE_MARGIN, peg_length/2 - 1.25 - peg_length_diff]) {
        cylinder(peg_length, THROUGH_HOLE_RADIUS, THROUGH_HOLE_RADIUS, center=true, $fn=32);
    }

    translate([CAMERA_WIDTH/2 - THROUGH_HOLE_RADIUS - TOP_THROUGH_HOLE_MARGIN - 0.1, CAMERA_LENGTH/2 - THROUGH_HOLE_RADIUS - 13.22, peg_length/2 - 1.25 - peg_length_diff]) {
        cylinder(peg_length, THROUGH_HOLE_RADIUS, THROUGH_HOLE_RADIUS, center=true, $fn=32);
    }
}

standoffs();

mirror([1, 0, 0]) {
    standoffs();
}