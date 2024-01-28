// CSG.scad - Basic example of CSG usage
$fa = 2;
$fs = 1.5;

side = 20;
half_side = side / 2;
height = 1.4;
hole_diameter = 12;

wall_height = height + 14.5;
wall_width = 1;

outer_wall_height = wall_height;
outer_wall_thickness = wall_width * 2;

cylinder_diameter = 8;
cylinder_height = height * 3;


grid_size = 7;



module grid() {
    translate([
        -.5 * (wall_width * .5 + grid_size * side), 
        -.5 * (wall_width * .5 + grid_size * side), 
        0
    ]) {
    
    // outer walls
    difference() {
        // color("green")
        cube([
            grid_size * side + outer_wall_thickness,
            grid_size * side + outer_wall_thickness,
            outer_wall_height
        ]);
        translate([outer_wall_thickness, outer_wall_thickness, -(outer_wall_height * .5)])
            cube([
                grid_size * side - outer_wall_thickness,
                grid_size * side - outer_wall_thickness,
                outer_wall_height * 2
            ]);
    }

    // grid
    translate([wall_width, wall_width, 0])
    for (y = [0:grid_size - 1])
    for (x = [0:grid_size - 1])
    translate([x * side, y * side, 0]) {
        // bottom plate with hole
        difference() {
            color("red")
            cube([side,side,height]);
            translate([half_side, half_side, -(height * .5)]) {
                cylinder(h = height * 2, d = hole_diameter);
            }
        }

        // // walls
        difference() {
            cube([side, side, wall_height]);
            translate([wall_width, wall_width, - (wall_height * .5)]) {
                cube([
                    (side - (2 * wall_width)),
                    (side - (2 * wall_width)),
                    wall_height * 3
                ]);
            }
        }
    }
}}