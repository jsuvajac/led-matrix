
include <BOSL2/std.scad>

include <ESPHolder.scad>
include <Diffuser.scad>
include <Grid.scad>


$fa = 2;
$fs = 1.5;

side = 20;
height = 1.4;
wall_width = 1;
wall_width_w_tolerance = wall_width - .1;

grid_size = 7;

cut_len = 4.9;
side_len = grid_size * side + wall_width_w_tolerance * 2 + 2.15;
side_width = side_len - cut_len;

wall_height_1 = 35;   // angled side square
wall_height_2 = 12.5; // square

// offset to on top of an led row
esp_x = (.5 * side_len) - 48.2 - 1;
esp_y = (.5 * side_len) - 25.5 - 18.5;

module back_panel() {
    mirror([1, 0, 0])
    union() {
        translate([0, 0, .5* height])
            cube([side_len, side_width, height], center=true);

        translate([esp_x, esp_y, height]) esp_stands();

        difference() {
            rect_tube(
                wall=wall_width_w_tolerance,
                h=wall_height_1,
                size1=[side_len, side_width],
                size2=[side_len, side_len],
                shift=[0, cut_len * .5],
                center=false
            );

            translate([esp_x, esp_y, 0]) esp_port_hole();
        }

        translate([0, cut_len * .5, wall_height_1])
            rect_tube(
                wall=wall_width_w_tolerance,
                h=wall_height_2,
                size=[side_len, side_len],
                center=false
            );
    }

    // translate([-2.2, -2.2, 100]) rotate([0, 180, 0]) diffuser();
    // translate([-wall_width, wall_width, 50]) grid();
}


back_panel();
