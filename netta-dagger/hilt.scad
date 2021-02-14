$fn=50;

use <diamond.scad>

//hilt
difference() {
    union() {
        cube([70, 25, 20]);
        translate([35, 12.5, -65]) cylinder(h = 65, d=25);
    }
    //hole for the dagger
    #translate([32.5, 10, 15]) cube([5, 5, 5]);
    //holes for the diamonds
    translate([35, 25, 4]) diamond();
    translate([35, 0, 4]) diamond();
    translate([35, 25, -33]) diamond();
    translate([35, 0, -33]) diamond();
}
