$fn=50;

module grips_hull() {
    hull() {
        circle(d=14);
        translate([21, -10, 0]) circle(d=36);
    }
}

module tray_grip_quart_circle(outer_d) {
    intersection() {
        difference() {
            circle(d=outer_d);
            circle(d=outer_d-6);
        }
        square([outer_d/2, outer_d/2]);
    }
}

module tray_grip() {
    //bottom curve
    difference() {
        tray_grip_quart_circle(24);
        translate([-7, 5, 0]) square([10, 10]);
    }
    //top curve
    translate([5, 17.3, 0]) rotate([0, 0, 180]) {
        difference() {
            tray_grip_quart_circle(18);
            translate([-7,0, 0]) square([9, 9]);
        }
        //grip at top
        translate([10, 2, 0]) {
            difference() {
                resize([9, 12, 0]) circle(d=6);
                translate([-5, 0, 0]) square([10, 6]);
                translate([0, 0, 0]) resize([3, 6, 0]) circle(r=1);
            }
        }
    }
}

module stokke_grips() {
    difference() {
        difference() {
            offset(r=3) grips_hull();
            grips_hull();
        }
        polygon([
            [-3,-4], [50, -7],
            [50, -40], [-20, -40]
        ]);
    }
    translate([33.5, -10, 0]) rotate([0, 0, 15]) square([9, 3]);
}

module whole() {
    linear_extrude(5) {
        stokke_grips();
        //tray bar
        translate([-19, 8, 0]) rotate([0,0,-10]) {
            //square([3, 20]);
            tray_grip();
            translate([12, 0, 0]) rotate([0, 0, 180]) square([3, 165]);
            translate([0, -165, 0]) rotate([180, 0, 0]) tray_grip();
        }
    }
}

whole();
