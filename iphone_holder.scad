use <MCAD/boxes.scad>

IPHONE_8_PLUS_WIDTH = 78.5;
IPHONE_8_PLUS_DEPTH = 8;
IPHONE_8_PLUS_SIDE_BEZZLE = 3;

LIGHTNING_CABLE_WIDTH = 10;

HOLDER_HEIGHT = 80;

module prism(l, w, h){
    polyhedron(
            points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
            faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
            );
    
    // preview unfolded (do not include in your function
    // z = 0.08;
    // separation = 2;
    // border = .2;
    // translate([0,w+separation,0])
    //     cube([l,w,z]);
    // translate([0,w+separation+w+border,0])
    //     cube([l,h,z]);
    // translate([0,w+separation+w+border+h+border,0])
    //     cube([l,sqrt(w*w+h*h),z]);
    // translate([l+border,w+separation+w+border+h+border,0])
    //     polyhedron(
    //             points=[[0,0,0],[h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[h,0,z],[0,sqrt(w*w+h*h),z]],
    //             faces=[[0,1,2], [3,5,4], [0,3,4,1], [1,4,5,2], [2,5,3,0]]
    //             );
    // translate([0-border,w+separation+w+border+h+border,0])
    //     polyhedron(
    //             points=[[0,0,0],[0-h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[0-h,0,z],[0,sqrt(w*w+h*h),z]],
    //             faces=[[1,0,2],[5,3,4],[0,1,4,3],[1,2,5,4],[2,0,3,5]]
    //             );
}

module cradle() {
    difference() {
        cube([IPHONE_8_PLUS_WIDTH + 4, HOLDER_HEIGHT, IPHONE_8_PLUS_DEPTH + 4], center=true);

        translate([0, 2, 0]) {
            cube([IPHONE_8_PLUS_WIDTH, HOLDER_HEIGHT, IPHONE_8_PLUS_DEPTH], center=true);
        }

        translate([0, 2, 4]) {
            cube([IPHONE_8_PLUS_WIDTH - IPHONE_8_PLUS_SIDE_BEZZLE*2, HOLDER_HEIGHT, IPHONE_8_PLUS_DEPTH], center=true);
        }
    }

    translate([-IPHONE_8_PLUS_WIDTH/2 - 7, -HOLDER_HEIGHT/2 + 2, 0]) {
        cube([10, 4, IPHONE_8_PLUS_DEPTH + 4], center=true);
    }

    mirror([1, 0, 0]) {
        translate([-IPHONE_8_PLUS_WIDTH/2 - 7, -HOLDER_HEIGHT/2 + 2, 0]) {
            cube([10, 4, IPHONE_8_PLUS_DEPTH + 4], center=true);
        }
    }
}

cradle();
translate([0, HOLDER_HEIGHT/2 + 76/2 - 28, -8]) {
    difference() {
        cube([IPHONE_8_PLUS_WIDTH + 4, 76, 8], center=true);
        translate([0, 2, 0]) {
            cube([IPHONE_8_PLUS_WIDTH + 4 - 4, 76 - 2, 8 - 4], center=true);
        }
    }
}

translate([-IPHONE_8_PLUS_WIDTH/2 -2, -HOLDER_HEIGHT/2, -6]) {
    mirror([0, 0, -1]) {
        prism(IPHONE_8_PLUS_WIDTH + 4, HOLDER_HEIGHT - 28, 6);
    }
}

// rotate([-7, 0, 0]) {
//     cradle();
// }

$fn = 32;

// difference() {
//     translate([-IPHONE_8_PLUS_WIDTH/2 - 8, -HOLDER_HEIGHT/2 + 3, 0]) {
//         roundedBox([10, 10, 50], 1, false);
//     }
//     rotate([-7, 0, 0]) {
//         cradle();
//     }
// }

// mirror([1, 0, 0]) {
//     difference() {
//         translate([-IPHONE_8_PLUS_WIDTH/2 - 8, -HOLDER_HEIGHT/2 + 3, 0]) {
//             roundedBox([10, 10, 50], 1, false);
//         }
//         rotate([-7, 0, 0]) {
//             cradle();
//         }
//     }
// }