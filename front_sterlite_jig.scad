$fn = 90;

STERLITE_FRONT_WIDTH = 295;
MODULE_WIDTH = STERLITE_FRONT_WIDTH / 2;
MODULE_HEIGHT = 34;
FILLAMENT_HOLE_DIAMETER = 7.8;
NOTCH_WIDTH = 3.20;
 
%cube([STERLITE_FRONT_WIDTH, MODULE_HEIGHT, 2]);
difference() {
    hull() {
        cube([MODULE_WIDTH, MODULE_HEIGHT, 2]);
        translate([0, -4, 0])
        cube([8, 4, 2]);
    }
    interface_width = STERLITE_FRONT_WIDTH*1;
    interface_offset = interface_width/4 - interface_width/8 + (STERLITE_FRONT_WIDTH - interface_width)/2;

    for (i = [0:3]) {
        translate([i*interface_width/4 + interface_offset, MODULE_HEIGHT/2, 1])
        cylinder(h=4, d=FILLAMENT_HOLE_DIAMETER, center=true);
    }
}

translate([-4 - NOTCH_WIDTH, 0, 0])
cube([4, MODULE_HEIGHT, 2]);

translate([-4 - NOTCH_WIDTH, -4, 0])
cube([4 + NOTCH_WIDTH, 4, 2]);


