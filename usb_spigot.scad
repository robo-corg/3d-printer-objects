$fn= 30;

include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/joiners.scad>

WIRE_DIAMETER = 3.5;

module wire_bolt() {
    difference() {
        screw("M8,15", head="hex", anchor=CENTER, orient=BACK);

        translate([0, 0, 0])
        rotate([90, 0, 0])
        cylinder(40, d = 3.5, center=true);
    }
}


module spigot_half_top() {
    difference() {
        wire_bolt();
        translate([-10, -20, 0])
        cube([20, 40, 10]);
    }
    translate([3, 6.2, 0])
    cube([2, 4, 2]);
}

spigot_half_top();


module spigot_half_bottom() {
    difference() {
        wire_bolt();
        mirror([0, 0, 1])
        translate([-10, -20, 0])
        cube([20, 40, 10]);
        
        translate([3, 6.2, -0.1])
        cube([2, 4, 2]);
    }
}

translate([20, 0, 0])
spigot_half_bottom();


translate([0,-25,0]) {
    nut("M8", thickness=10);
}