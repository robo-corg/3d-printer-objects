FEEDER_WIDTH = 200;
FEEDER_HEIGHT = 50;
FEEDER_DEPTH = 100;


difference() {
    cube([FEEDER_WIDTH, FEEDER_DEPTH, FEEDER_HEIGHT]);
    translate([10, 10, 10.01]) {
        cube([FEEDER_WIDTH - 20, FEEDER_DEPTH - 20, FEEDER_HEIGHT - 10]);
    }
}

// Bin 1 Zone
%translate([10, 10, 10.01]) {
    cube([(FEEDER_WIDTH - 20)/2, FEEDER_DEPTH - 20, FEEDER_HEIGHT - 10]);
}

// Bin 2 Zone
%translate([(FEEDER_WIDTH - 20)/2 + 10, 10, 10.01]) {
    cube([(FEEDER_WIDTH - 20)/2, FEEDER_DEPTH - 20, FEEDER_HEIGHT - 10]);
}