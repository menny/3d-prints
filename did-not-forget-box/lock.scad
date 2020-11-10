$fn=50;

module slide() {
    rotate([0, 90, 0]) linear_extrude(height=4) difference()  {square(10);circle(10);}
}

difference() {
    translate([4, 4, 0]) cylinder(r=5, h=2, center=false);
    translate([2, 4, 0]) cylinder(r=0.5, h=2, center=false);
    translate([6, 4, 0]) cylinder(r=0.5, h=2, center=false);
}

translate([2, 8, 0]) {
    difference() {
        union() {
            cube(size=[4, 9, 2], center=false);
            translate([0, -2, 4]) resize([4, 11, 2]) slide();
        }
        translate([0, 0, 3]) resize([4, 9, 3]) slide();
    }
}
    
    