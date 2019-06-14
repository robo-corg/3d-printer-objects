case_scale = [2, 1, 0.5];

difference() {
    scale(case_scale) {
        difference() {
            cube([1,1,1]);
            trim = [0.1/case_scale[0], 0.1/case_scale[1]];
            translate([trim[0], trim[1], -0.5])
                cube([1 - trim[0]*2, 1 - trim[1]*2, 2]);
        }
    }
    
    translate([0.3, 0.5, 0.2]) 
        rotate([90, 0, 0])
            linear_extrude(height=1)
                scale([0.01, 0.01, 0.5])
                    text("Hello Dad");
    

}

for (x = [0:1]) {
    for (y = [0:1]) {
        translate([x*case_scale[0], y*case_scale[1], 0])
            scale([0.025, 0.025, 1])
                cylinder();
    }
}