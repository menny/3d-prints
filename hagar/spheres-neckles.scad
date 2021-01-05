$fn=50;

use <../utils/ring.scad>

module spheres() {
    sphere(d=14);
    translate([0, 0, 9]) sphere(d=7);
}

module dagger() {
    polyhedron(
        points=[[3,0,0],[0, 1.5, 0], [-3, 0, 0], [0, -1.5, 0], [0, 0, 12]],
        faces=[[0, 1, 2, 3], [1, 0, 4], [2, 1, 4], [3, 2, 4], [0, 3, 4]]);
}

//difference() {
//    spheres();
//    translate([0, 0, 10.75]) dagger();
//}
//ring
//translate([0, 0, -8]) rotate([90, 90, 0]) ring(2, 1);

translate([20, 0, 0]) dagger();

