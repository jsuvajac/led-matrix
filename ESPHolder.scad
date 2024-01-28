$fa = 2;



board_hole_r = 1.5 - .1;
board_x = 48.2;
board_y = 25.5;
board_h = 1.6;

holes_h = 21;
holes_w  = 44;


stand_w = .5;
stand_h = 3.3;

wall_offset = 2.2;

// board
module board() {
    cut = 5;
    hull() {
        stand(0, 0, board_h, stand_w);
        stand(0, holes_h, board_h, stand_w);

        // wall
        stand(holes_w + wall_offset, 0, board_h, stand_w);
        stand(holes_w + wall_offset, holes_h, board_h, stand_w);
    }
}

// stand
module all_stands() {
    translate([0, 0, board_h]) {
        stand(0, 0, 5, board_hole_r);
        stand(0, holes_h, 5, board_hole_r);
        stand(holes_w, 0, 5, board_hole_r);
        stand(holes_w, holes_h, 5, board_hole_r);

        stand(0, 0, stand_h, board_hole_r + stand_w);
        stand(0, holes_h, stand_h, board_hole_r + stand_w);
        stand(holes_w, 0, stand_h, board_hole_r + stand_w);
        stand(holes_w, holes_h, stand_h, board_hole_r + stand_w);
    }
}

module stand(x, y, h, r) {
    translate([x, y, 0])
    difference() {
        cylinder(h = h, r = r, $fs = .5);
        cylinder(h = h, r = 1.95 * .5, $fs = .5);
    }
}

module port_wall() {
    cutout_h = 3.1;
    cutout_w = 7.8;

    translate([holes_w + (board_hole_r + stand_w)*.5 + wall_offset, 0, board_h]) {
        difference() {
            cube([1, holes_h, stand_h * 1.5]);

            translate([-2, .5 * (holes_h - cutout_w), stand_h - cutout_h])
            cube([4, cutout_w, cutout_h]);
        }
    }
}
module port_hole() {
    cutout_h = 3.1;
    cutout_w = 7.8;

    translate([holes_w + (board_hole_r + stand_w)*.5 + wall_offset, 0, board_h]) {
        translate([-2, .5 * (holes_h - cutout_w), stand_h - cutout_h])
            cube([5, cutout_w, cutout_h]);
    }
}

module esp() {
    union() {
        board();
        all_stands();
        // port_wall();
    }
}

module esp_hole() {
    port_hole();
}

