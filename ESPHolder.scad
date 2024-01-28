$fa = 2;

// board
holes_h = 21;
holes_w  = 44;
wall_offset = 2.2;
board_h = 1.6;

// stands
stand_w = .5;
stand_h = 3.3;
screw_hole_r = 1.5;
screw_thread_inner_r = 1.95 * .5;


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

module port_wall() {
    cutout_h = 3.1;
    cutout_w = 7.8;

    translate([holes_w + (screw_hole_r + stand_w)*.5 + wall_offset, 0, board_h]) {
        difference() {
            cube([1, holes_h, stand_h * 1.5]);

            translate([-2, .5 * (holes_h - cutout_w), stand_h - cutout_h])
            cube([4, cutout_w, cutout_h]);
        }
    }
}

module esp_port_hole() {
    cutout_h = 3.1;
    cutout_w = 7.8;

    translate([holes_w + (screw_hole_r + stand_w)*.5 + wall_offset, 0, board_h]) {
        translate([-2, .5 * (holes_h - cutout_w), stand_h - cutout_h])
            cube([5, cutout_w, cutout_h]);
    }
}


module esp_stands() {
    // hole
    h_h = stand_h + 1.7;
    h_r = screw_hole_r;
    stand(0, 0, h_h, h_r);
    stand(0, holes_h, h_h, h_r);
    stand(holes_w, 0, h_h, h_r);
    stand(holes_w, holes_h, h_h, h_r);

    // stands
    s_h = stand_h;
    s_r = screw_hole_r + stand_w;
    stand(0, 0, s_h, s_r);
    stand(0, holes_h, s_h, s_r);
    stand(holes_w, 0, s_h, s_r);
    stand(holes_w, holes_h, s_h, s_r);

    // foot
    ft_h = stand_h * .5;
    ft_r = screw_hole_r + stand_w * 2;
    stand(0, 0, ft_h, ft_r);
    stand(0, holes_h, ft_h, ft_r);
    stand(holes_w, 0, ft_h, ft_r);
    stand(holes_w, holes_h, ft_h, ft_r);
}

module stand(x, y, h, r) {
    translate([x, y, 0])
    difference() {
        cylinder(h = h, r = r, $fs = .5);
        cylinder(h = h, r = screw_thread_inner_r, $fs = .5);
    }
}


module esp_holder() {
    union() {
        board();
        translate([0, 0, board_h]) all_stands();
        // port_wall();
    }
}

