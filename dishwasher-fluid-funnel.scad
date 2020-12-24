$fn=50;

module ring(r1, r2) {
    rotate_extrude() translate([r1,0,0]) circle(r2);
}

difference() {
    union() {
        //top
        cylinder(h = 30, r1=27, r2=3);
        //tube
        translate([0, 0, 30]) cylinder(h = 30, r1=3, r2=2);
        //ring to hold bottle
        translate([51, 0, 0]) ring(25, 1);
        //ring around the funnel
        ring(25.75, 1.5);
    }
    union() {
        cylinder(h = 60, r1=3, r2=1.5);
        cylinder(h = 28, r1=25, r2=2);
    }
}
