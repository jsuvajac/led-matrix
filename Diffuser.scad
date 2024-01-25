$fa = 2;
$fs = 1.5;

side = 20;
height = 1.4;
wall_width = 2;
wall_height = 5;
wall_width_w_tolerance = wall_width + 0.9;

grid_size = 7;

difference() {
    color("blue")
    cube([
        grid_size * side + wall_width_w_tolerance * 2,
        grid_size * side + wall_width_w_tolerance * 2,
        wall_height
    ]);
    translate([wall_width_w_tolerance * .5, wall_width_w_tolerance * .5, -(wall_height * .5)])
        cube([
            grid_size * side + wall_width_w_tolerance,
            grid_size * side + wall_width_w_tolerance,
            wall_height * 2
        ]);
}

// grid
translate([wall_width * .5, wall_width * .5, 0]) {
// front plate
color("red")
cube([
    side * grid_size + wall_width,
    side * grid_size + wall_width,
    height
]);

// grid
translate([wall_width * .5, wall_width * .5, 0]) {
for (y = [0:grid_size - 1])
for (x = [0:grid_size - 1])
translate([x * side, y * side, 0]) {
    // cell inserts
    union() {
        color("green")
        translate([wall_width * .5, wall_width * .5, +(height)]) {
            cube([side - wall_width, side - wall_width, height]);
        }
    }
}
}
}
