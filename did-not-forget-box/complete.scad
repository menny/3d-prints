$fn=50;

include <box.scad>;
include <hinges.scad>;
include <strap.scad>;

module box_bottom() {
    difference() {
        box_part(14, 6, 2);
        translate([91, 45, 11]) cube([3, 2, 6], center=true);
    }
}

module box_top() {
    translate([0, 100, 0]) {
        difference() {
            box_part(6, 5, 2);
            translate([45, 45, -2])  mirror([0, 1, 0]) rotate([0, 0, 90]) linear_extrude(height = 1, center = true, convexity = 10) import(file = "logo.svg", center = true, dpi = 200);
        }
    }
    translate([91, 140, 4]) minkowski() {
              sphere(d=2);
              cube([1,10,1]);
            }
}

wall_thickness=2.5;
wall_hole_width=2;

module box_clip() {
    translate([100, 0, 0]) {
        difference() {
            union() {
                difference() {
                    cylinder(r=5, h=2, center=false);
                    rotate([0, 0, 270]) linear_extrude(height = 1, center = true, convexity = 10) import(file = "small-star-2.svg", center = true, dpi = 120);
                }
                translate([-3.5, -wall_hole_width/2, 2]) cube([7, wall_hole_width, wall_thickness], center=false);
                translate([-3.5, -3, 4.5]) cube([7, 6, 2], center=false);
                translate([4, -1, 0]) cube([4, 2, 2], center=false);
                difference() {
                    
                    
                }
                
                translate([8, 1, 0]) rotate([0, 0, 270]) polyhedron(
                            points=[[0,0,0],[2,0,0],[2,3,0],[0,3,0],[0,0,2],[2,0,2],[2,3,0],[0,3,0]],
                            faces =[[0,1,2,3],[4,5,1,0],[5,6,2,1],[6,7,3,2], [7,4,0,3],[7,6,5,4]]);   
            }
            //a small nook for holding the top lid
            translate([4.5, -3, 2]) minkowski() {
                sphere(d=2);
                cube([1.5,6,1]);
            }
        }
    }
}

module hinges() {
    for (transValues = [ [50, true, 6], [60, true, 6], [70, false, 5], [80, false, 5]] ) {
        width=8;
        depth=transValues[2];
        height1=6;
        height2=2;
        connecting_r=2;
        translate([-20, transValues[0], 0]) rotate([0, 270, 0]) {
            difference() {
                hinge_base(width, depth, height1, height2, connecting_r, wall_thickness, wall_hole_width);
                if (transValues[1]) {
                    hinge_connecting_nook(1, height1, height2, width, depth, connecting_r);
                } else {
                    hinge_connecting_nook(0, height1, height2, width, depth, connecting_r);
                    hinge_connecting_nook(2, height1, height2, width, depth, connecting_r);
                }
            }
            
        }
    }
}

module straps() {
    translate([-50, 20, 0]) strap(90, 20, 4, 2);
    translate([-50, 60, 0]) strap(90, 20, 4, 2);
}

//box_clip();
//hinges();
//box_clip();
straps();
//box_bottom();
//rotate([180, 0, 0]) box_top();