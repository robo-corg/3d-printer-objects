$fn = 96;

use <gears/gears.scad>;

RACK_ENABLED = 0;
PINION_ENABLED = 0;
SHAFT_ENABLED = 0;
BASE_ENABLED = 0;

//rack_and_pinion(2, 40, 8, 1, 1, width=2, together_built=false);

rack_length = 70;
rack_height = 6;
width = 4;

module rack_end() {
    translate ([rack_length/2, -rack_height/2 + 0.5, width/2]) {
        cube([1, rack_height + 1, width], center=true);
    }
}

module shooter_rack() {
    rack(modul=1, length=rack_length, height=rack_height, width=width, pressure_angle=20, helix_angle=0);
    
    translate([-0.5, -4, 5]) {
        rotate([0, 90, 0]) {
            cylinder(r=1, h=rack_length, center=true);
        }

        translate([0, 0, -0.5]) 
            cube(size=[rack_length, 2, 1], center=true);
    }
}

if (RACK_ENABLED) {
    shooter_rack();
}

function get_gear_df(modul, tooth_number, width, bore, pressure_angle = 20, helix_angle = 0, optimized = true) =
    // Dimension Calculations  
    let (d=modul * tooth_number)                                           // Pitch Circle Diameter
    let (alpha_spur = atan(tan(pressure_angle)/cos(helix_angle)))// Helix Angle in Transverse Section
    let (db = d * cos(alpha_spur))                                      // Base Circle Diameter
    let (rb = db / 2)                                                    // Base Circle Radius
    let (da = (modul <1)? d + modul * 2.2 : d + modul * 2)               // Tip Diameter according to DIN 58400 or DIN 867
    let (ra = da / 2)                                                    // Tip Circle Radius
    let (c =  (tooth_number <3)? 0 : modul/6)                                // Tip Clearance
    d - 2 * (modul + c)                                      // Root Circle Diameter
;

PINION_GEAR_DF = get_gear_df(
    modul=1, tooth_number=32, width=4, bore=4, pressure_angle = 20, helix_angle = 0, optimized = false
);

MOTOR_GEAR_DF = get_gear_df(
    modul=1, tooth_number=16, width=4, bore=4, pressure_angle = 20, helix_angle = 0, optimized = false
);

echo(PINION_GEAR_DF=PINION_GEAR_DF);
echo(MOTOR_GEAR_DF=MOTOR_GEAR_DF);

module pinoin() {
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

if (PINION_ENABLED) {
    pinoin();
}


module shaft() {
    difference() {
        shaft_height = 43.5;
        cylinder(r=2, h=shaft_height, center=true);

        translate([0, 0, shaft_height/2-8 + 0.01]) {
            translate ([1.5, -2, 0]) {
                cube([4,4,8]);
            }

            mirror ([1, 0, 0]) {
                translate ([1.5, -2, 0]) {
                    cube([4,4,8]);
                }
            }
        }
    }
}

if (SHAFT_ENABLED) {
    translate([0, 0, 20]) {
        shaft();
    }
}

module corners() {
    children();


    mirror([1, 0, 0]) {
        children();
    }

    mirror([0, 1, 0]) {
        children();
        
        mirror([1, 0, 0]) {
            children();
        }
    }    
}

if (BASE_ENABLED) {
    translate ([30, 30, 0]) {
        translate([0, 0, 4]) {
            motor_base_width = 22.5;
            padding_width = 16;
            left_width = 16;

            translate ([left_width/2 - 2, 0, 3/2 - 4]) {
                difference() {
                    width = motor_base_width + padding_width + left_width;
                    length = 22.5 + 12;
                    bolt_d = 3;
                    bolt_head_d = 5.8;
                    bolt_leeway = 2.5;

                    cube([width, length, 3], center=true);
                
                    corners() {
                        translate([width/2 - bolt_d/2 - bolt_leeway, length/2 - bolt_d/2 - bolt_leeway, 0]) {
                            cylinder(r=bolt_d/2, h=4, center=true);
                            translate([0, 0, 1]) {
                                cylinder(r=bolt_head_d/2, h=2, center=true);
                            }
                        }
                    }
                }
            }

            difference() {
                //cylinder(r=22.5/2+3, h=6, center=true);
                cube([motor_base_width + 3, 22.5 + 3, 8], center=true);
                translate ([0, 0, 1.5]) {
                    cylinder(r=22.5/2, h=6, center=true);
                }
            }

            
            difference() {
                translate ([motor_base_width/2 + 9, 0, 0]) {
                    cube([18, 16, 8], center=true);
                }
                translate([PINION_GEAR_DF/2 + MOTOR_GEAR_DF/2 + 2, 0, 0]) {
                    cylinder(r=2.05, h=40, center=true);
                }
            }
        }

        translate([0, 0, 40]) {
            %spur_gear(
                modul=1, tooth_number=16, width=4, bore=4, pressure_angle = 20, helix_angle = 0, optimized = false
            );
        }

        translate([0, 0, 24]) {
            %cylinder(r=2, h=40, center=true);
        }

        translate([PINION_GEAR_DF/2 + MOTOR_GEAR_DF/2 + 2, 0, 22]) {
            %shaft();

            translate([0, 0, 20]) {
                rotate([180, 0, 0]) {
                    %pinoin();
                }

                %shooter_rack();
            }

            
        }

        
    }
}
// translate ([0, -1.4, 0.5]) {
//     cube([20, 1.2, 1], center=true);
// }

