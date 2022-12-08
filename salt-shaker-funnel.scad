$fn=80;

use <utils/text_on.scad>

module ring(r1, r2) {
    rotate_extrude() translate([r1,0,0]) circle(r2);
}

difference() {
    union() {
        //top tube
        translate([0, 0, -10]) cylinder(h = 10, r=30);
        //top funnel
        cylinder(h = 25, r1=30, r2=10);
        //bottom tube
        translate([0, 0, 25]) cylinder(h = 5, r=10);
    }
    union() {
        translate([0, 0, -10]) cylinder(h = 10, r=29);
        cylinder(h = 25, r1=29, r2=9);
        translate([0, 0, 25]) cylinder(h = 5, r=9);
    }
}

translate([0, 0, -10]) text_on_cylinder(t="NaCl", r=30.5, h=10, extrusion_height=2, size=7, font="DejaVu Sans Mono:style=Bold");

rotate([0, 0, 180]) translate([0, 0, -10]) text_on_cylinder(t="Piper Nigrum", r=30.5, h=10.5, extrusion_height=2, size=6, font="DejaVu Sans Mono:style=Bold");
