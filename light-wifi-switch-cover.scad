$fn=50;

module ring(r1, r2) {
    rotate_extrude() translate([r1,0,0]) circle(r2);
}

translate(0, 0, 26) ring(2, 12);
difference() {
    union() {
        cylinder(h=25, d1=50, d2=13);
    }
    cylinder(h=22, d1=46, d2=11);
    cylinder(h=25, d=11);
 }
    