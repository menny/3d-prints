$fn=50;
    
linear_extrude(height = 20) {
    square([2,9],center=false);
    translate([0, 9, 0]) {
        square([94, 2],center=false);
        translate([92, 0, 0]) {
            //wall sine mount
            rotate([180, 0, 0]) {
                square([2, 2.5],center=false);
                translate([0, 2.5]) {
                    for(i=[0:0.5:39]){
                        rotate([45, 0, 0]) translate([i, i/3 + 2 * sin(11*(i + 180)),0]) square([1, 2],center=false);
                    }
                    translate([38, 8, 0]) {
                        square([2, 14],center=false);
                    }
                }
            }
        }
    }
}


//bottom round branch
rotate([270, 0, 0]) {
    translate([92, -10, 6]) {
        difference() {
            cylinder(h=170, r1=10, r2=7, center=false);
            translate([-20, -10, -5]) cube([20, 20, 180]);
        }
    }
}