$fn=50;

use <../utils/ring.scad>


module dagger() {
    color("silver") {
        polyhedron(
            points=[[3,0,0],[0, 1.5, 0], [-3, 0, 0], [0, -1.5, 0], [0, 0, 12]],
            faces=[[0, 1, 2, 3], [1, 0, 4], [2, 1, 4], [3, 2, 4], [0, 3, 4]]);
    }
}

module top_ring() {
    color("black") rotate([90, 90, 0]) ring(2.2, 1);
}

module bottom_sphere() {
    difference() {
        color("red") sphere(d=7);
        translate([0, 0, 1.75]) dagger();
    }
}

module top_sphere() {
    difference() {
        color("green") sphere(d=14);
        //making some holes
        translate([0, 0, -8.7]) top_ring();
        translate([0, 0, 8]) bottom_sphere();
        translate([-1, -1, 3]) cube([2, 2, 2]);
    }
}

//translate([-15, 0, 0]) top_ring();
//translate([0, 0, 0]) top_sphere();
//translate([15, 0, 0]) {
//    bottom_sphere();
//    //connector for the top sphere
//    translate([-0.75, -0.75, -4.5]) cube([1.5, 1.5, 2]);
//}
translate([30, 0, 0]) dagger();

