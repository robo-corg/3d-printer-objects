BASE_WIDTH = 37;
BASE_DEPTH = 10;
BASE_HEIGHT = 26;
MONITOR_DEPTH = 21;
MONITOR_BEZZLE = 5;

//cube([BASE_WIDTH, 10, BASE_HEIGHT]);

difference() {
    cube([BASE_WIDTH + 10, MONITOR_DEPTH + 25, 5 + MONITOR_BEZZLE], center=true);
    translate([0, -5, -2.5]) {
        cube([BASE_WIDTH + 10 + 2, MONITOR_DEPTH, MONITOR_BEZZLE + 0.5], center=true);
    }
    translate([0, 15, 0]) {
        cube([BASE_WIDTH, BASE_DEPTH, 5 + MONITOR_BEZZLE + 2], center=true);
    }
}

