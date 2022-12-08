cube([3, 240, 3]);

translate([1.5, 1.5, 0]) {
    difference() {
        cylinder(16, 3, 3);
        cylinder(16, 1, 1);
    }
}

translate([1.5, 1.5+240, 0]) {
    difference() {
        cylinder(18, 3, 3);
        cylinder(18, 1, 1);
    }
}