$fa = 2;



board_hole_r = 1.5 - .1;
board_x = 48.2;
board_y = 25.5;
board_h = 1.6;

holes_h = 21;
holes_w  = 44;


stand_w = .5;
stand_h = 3;

// board
module board() {
    cut = 5;
    // difference() {
    //     cube([board_x, board_y, board_h]);
    //     translate([cut, cut, 0])
    //     cube([board_x - 2 * cut, board_y - 2 * cut, board_h]);
    // }
    hull() {
        stand(0, 0, board_h, board_hole_r + stand_w);
        stand(0, holes_h, board_h, board_hole_r + stand_w);
        stand(holes_w, 0, board_h, board_hole_r + stand_w);
        stand(holes_w, holes_h, board_h, board_hole_r + stand_w);
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


// port wall
union() {
    board();
    all_stands();
}
