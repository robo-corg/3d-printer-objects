$fn = 96;

use <gears/gears.scad>;

RACK_ENABLED = 1;
PINION_ENABLED = 0;

//rack_and_pinion(2, 40, 8, 1, 1, width=2, together_built=false);

rack_length = 70;
rack_height = 6;
width = 4;

module rack_end() {
    translate ([rack_length/2, -rack_height/2 + 0.5, width/2]) {
        cube([1, rack_height + 1, width], center=true);
    }
}

if (RACK_ENABLED) {
    rack(modul=1, length=rack_length, height=rack_height, width=width, pressure_angle=20, helix_angle=0);
    
    translate([-0.5, -4, 5]) {
        rotate([0, 90, 0]) {
            cylinder(r=1, h=rack_length, center=true);
        }

        translate([0, 0, -0.5]) 
            cube(size=[rack_length, 2, 1], center=true);
    }
}

if (PINION_ENABLED) {
    spur_gear(modul=1, tooth_number=32, width=4, bore=4, pressure_angle = 20, helix_angle = 0, optimized = false);

    translate ([1.5, -2, 0]) {
        cube([4,4,8]);
    }

    mirror ([1, 0, 0]) {
        translate ([1.5, -2, 0]) {
            cube([4,4,8]);
        }
    }


    translate ([0, 0, 4]) {
        difference() {
            spur_gear(modul=1, tooth_number=32, width=4, bore=4, pressure_angle = 20, helix_angle = 0, optimized = false);
            translate ([-20, 0, -0.1]) {
                cube([40, 40, 5]);
            }
        }
    }
}


// translate ([30, 30, 4]) {
//     translate ([0, 0, 3/2 - 4]) {
//         cube([22.5 + 12, 22.5 + 12, 3], center=true);
//     }

//     difference() {
//         //cylinder(r=22.5/2+3, h=6, center=true);
//         cube([22.5 + 3, 22.5 + 3, 8], center=true);
//         translate ([0, 0, 1.5]) {
//             cylinder(r=22.5/2, h=6, center=true);
//         }
//     }
// }
// translate ([0, -1.4, 0.5]) {
//     cube([20, 1.2, 1], center=true);
// }