$fn=50;

scale([4.2, 4.2, 4.2]) {
    color("#1a1203") {
        difference() {
            cube([12, 12, 18]);
            #translate([1, 1, 1.5]) cube([10, 10, 18]);
            translate([-0.3, 0, 14]) { 
                #rotate([0, 0, -45]) cube([0.3, 20, 4]);
            }
            
            translate([12, -0.2, 14]) { 
                #rotate([0, 0, 45]) cube([0.3, 20, 4]);
            }
        }
    };
/*
    translate([40, 0, 0]) {
        color("silver") {
            cube([10, 14, 18]);
        };
    }

    translate([0, -40, 0]) {
        color("#414240")
        cube([10, 14, 11]);
    }
    translate([ 40, -40, 0]) {
        color("gray")
        cube([12, 10, 12]);
    }

    translate([ 20, -20, 0]) {
        color("#90664b")
        cube([ 13.5, 8, 17]);
    }
*/
}