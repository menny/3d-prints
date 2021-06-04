$fn=50;

include <../utils/ring.scad>

module herbs_bed() {
    linear_extrude(2) {
        difference() {
            square(40);
            //holes
            translate([20, 20]) circle(d= 14);
            translate([9, 9]) circle(d= 14);
            translate([31, 9]) circle(d= 14);
            translate([9, 31]) circle(d= 14);
            translate([31, 31]) circle(d= 14);
            //holes for the pulling stick
            translate([20, 3]) circle(d=3);
            translate([20, 37]) circle(d=3);
        }
    }

    //rings around the holes
    translate([20, 20, 1]) ring(7, 1);
    translate([9, 9, 1]) ring(7, 1);
    translate([31, 9, 1]) ring(7, 1);
    translate([9, 31, 1]) ring(7, 1);
    translate([31, 31, 1]) ring(7, 1);

    //stands
    translate([3, 3, 2]) cylinder(h=6, r=1);
    translate([3, 37, 2]) cylinder(h=6, r=1);
    translate([37, 3, 2]) cylinder(h=6, r=1);
    translate([37, 37, 2]) cylinder(h=6, r=1);
}

