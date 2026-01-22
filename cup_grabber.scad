include <BOSL2/std.scad>
include <BOSL2/gears.scad>


$fn = 90;
PITCH_RADIUS = pitch_radius(mod=2, teeth=20);
SHAFT_DIAM = 5;
SHAFT_HEIGHT = 10;  // Gap between spring and gears
SPRING_R1 = SHAFT_DIAM/2;  // Inner radius matches shaft
SPRING_R2 = 20;  // Outer radius

// Create a spiral shape for a flat coil spring which will attach to the gear
module flat_coil_spring(r1=5, r2=20, turns=3, width=2, thickness=0.5) {
    spiral_path = helix(h=0, r1=r1, r2=r2, turns=turns);
    strip_profile = square([width, thickness], center=true);
    path_sweep(strip_profile, spiral_path);
}

// === Assembly ===

// Drive shaft - connects spring to first gear
translate([0, 0, -SHAFT_HEIGHT])
    cylinder(d=SHAFT_DIAM, h=2*SHAFT_HEIGHT + 8);  // From platform through gear

// Flat coil spring at bottom (z=0)
!flat_coil_spring(r1=SPRING_R1, r2=SPRING_R2, turns=3, width=2, thickness=0.5);

// Anchor post at outer end of spring
translate([SPRING_R2, 0, -SHAFT_HEIGHT])
    cylinder(d=SHAFT_DIAM, h=SHAFT_HEIGHT);

// First gear (driven by spring) - elevated above spring
translate([0, 0, SHAFT_HEIGHT])
    spur_gear(mod=2, teeth=20, thickness=8, shaft_diam=SHAFT_DIAM);

// Second gear (free-spinning) - also elevated
translate([PITCH_RADIUS*2, 0, SHAFT_HEIGHT])
    spur_gear(mod=2, teeth=20, thickness=8, shaft_diam=SHAFT_DIAM, gear_spin=9);

// Second gear shaft - fixed to platform
translate([PITCH_RADIUS*2, 0, -SHAFT_HEIGHT])
    cylinder(d=SHAFT_DIAM, h=2*SHAFT_HEIGHT + 8);

// Mounting platform which the spring and shafts for the gears will interface with
// this sits bellow everything
translate([-15, -15, -SHAFT_HEIGHT]) {
    cube([60, 30, 5]);
}