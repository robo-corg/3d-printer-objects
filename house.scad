house_size = rands(0.5, 1, 3);
roof_overhang = rands(0.1, 0.3, 2);
door_width = 0.2;
door_height = 0.25;

window_size = 0.15;

// body
union() {
    cube(house_size);
    
    door_location = rands(0.1, house_size[0] - door_width - 0.1, 1)[0];

    translate([door_location, -0.01, 0])
        color("red")
            cube([door_width, 0.1, door_height]);
    
    door_empty_space_left = door_location;
    window_door_offset = window_size + 0.05;
    
    if (door_empty_space_left > window_door_offset + 0.01) {
        window_location = rands(0.1, door_empty_space_left - window_door_offset, 1)[0];

        translate([window_location, -0.01, door_height - window_size - 0.02])
            color("LightBlue")
                cube([window_size, 0.1, window_size]);
    }
}

// roof
union() {
    scale(concat(roof_overhang, [1]) + [1, 1, 0])
        translate(concat(roof_overhang, [0])*-0.25)
            scale(house_size*0.5)
                translate([1, 1, 2])
                    polyhedron(
                      points=[ [1,1,0],[1,-1,0],[-1,-1,0],[-1,1,0], // the four points at base
                               [0,0,1]  ],                                 // the apex point 
                      faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
                                  [1,0,3],[2,1,3] ]                         // two triangles for square base
                     );

    translate([rands(0.1, house_size[0] - 0.1, 1)[0], rands(0.1, house_size[1] - 0.1, 1)[0], house_size[2]*1.1])
        color("red")
            cube([0.1, 0.1, 0.3]);
}