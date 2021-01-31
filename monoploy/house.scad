$fn=50;

difference() {
    union() {
        //house
        rotate([90, 0, 0]) linear_extrude(11) {
            polygon([[0.5,0], [0, 6], [-2, 6], [6, 10], [14, 6], [12, 6], [11.5, 0]]);
        }
        //chimney
        translate([6,-5.5]) cylinder(h=10.5, d=3);
    }
    //hollow inside
    translate([0, -1, 0]) rotate([90, 0, 0]) linear_extrude(9) {
            polygon([[1.5,0], [1, 5], [6, 9], [11, 5], [10.5, 0]]);
        }
}
//windows and door
module door_and_windows() {
    translate([-0.5, -3, 4]) color("black") cube([1, 2, 2], center=false);
    translate([-0.5, -10, 4]) color("black") cube([1, 2, 2], center=false);
    translate([-0.5, -7, 0]) color("black") cube([1, 3, 5], center=false);
}

translate([0.5, 0, 0]) rotate([0, -5, 0]) door_and_windows();
translate([11.5, 0, 0]) rotate([0, 5, 0]) door_and_windows();
