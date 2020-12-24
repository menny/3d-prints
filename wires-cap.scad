$fn=50;

resize([3.5, 0, 0]) {
difference() {
    cylinder(h = 6, r1=2, r2=3);
    translate([0, 0, 2]) cylinder(h = 6, r1=1.75, r2=2);
}
}
