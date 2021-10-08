$fn=50;

first_line = "דבר ראשון,";
second_line = "תרגעי";

//board
difference() {
    color("red") minkowski() {
        translate([5, 5, 0]) cube([140, 80, 0.5]);
        cylinder(r=5,h=0.5);
    }
    
    translate([7, 7, 0]) cylinder(2, 1.5, 1.5);
    translate([143, 7, 0]) cylinder(2, 1.5, 1.5);
    translate([143, 83, 0]) cylinder(2, 1.5, 1.5);
    translate([7, 83, 0]) cylinder(2, 1.5, 1.5);
}

//text
translate([75, 65, 1])
    color("green")
    linear_extrude(height = 1)
    text(text = first_line, size = 14, direction="rtl", language="he", halign="center", valign="center");

translate([75, 40, 1])
    color("green")
    linear_extrude(height = 1.5)
    text(text = second_line, size = 18, direction="rtl", language="he", halign="center", valign="center");

//clamp
translate([148, 20, 2.5]) color("grey") {
    difference() {
        minkowski() {
            sphere(d=5);
            cube([17,6, 7]);
        }
        translate([2.5, -2, 2.5]) minkowski() {
            sphere(d=7);
            cube([12,12,3]);
        }
        translate([1.5, -2, 2]) cube([14,20,15]);
    }
    difference() {
        translate([0, -1, -2.5]) cube([40, 8, 1]);
        #translate([30, 3, -2.5]) cylinder(5, 1.5, 1.5);
    }
}

