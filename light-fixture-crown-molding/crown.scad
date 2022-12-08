$fn=50;

use <../utils/text_on.scad>
use <../utils/ring.scad>

inner_radius=60;
crown_radius=150;
crown_start_height=10;
crown_end_height=30;
profile_thickness=3;

module crown_profile() {
    
    translate([inner_radius, 0, 0]) {
        //inner ring
        square([profile_thickness, crown_end_height], false);
        
        
        //outter ring
        translate([crown_radius, 0, 0]) square([profile_thickness, crown_start_height], false);
    }
}
/*
rotate_extrude() {
    translate([0, 9, 0]) {
        translate([92, 0, 0]) {
            //wall sine mount
            rotate([180, 0, 0]) {
                square([2, 2.5],center=false);
                translate([0, 2.5]) {
                    for(i=[0:0.5:39]){
                        rotate([45, 0, 0]) translate([i, i/3 + 2 * sin(11*(i + 180)),0]) square([1, 2],center=false);
                    }
                    translate([38, 0, 0]) {
                        square([2, 8],center=false);
                    }
                }
            }
        }
    }
}
*/
rotate_extrude() {
    crown_profile();
}
translate([0, 0, crown_end_height]) ring(profile_thickness/2+inner_radius, profile_thickness/2);