include <BOSL2/std.scad>
include <BOSL2/gears.scad>

PITCH_RADIUS = pitch_radius(mod=2, teeth=20);

spur_gear(mod=2, teeth=20, thickness=8, shaft_diam=5);


translate([PITCH_RADIUS*2, 0, 0]) {
    spur_gear(mod=2, teeth=20, thickness=8, shaft_diam=5, gear_spin=9);
}

// Create a spiral shape for a flat coil spring which will attach to the gear
module flat_coil_spring(r1=5, r2=20, turns=3, width=2, thickness=0.5) {
    spiral_path = helix(h=0, r1=r1, r2=r2, turns=turns);
    strip_profile = square([width, thickness], center=true);
    path_sweep(strip_profile, spiral_path);
}

flat_coil_spring();