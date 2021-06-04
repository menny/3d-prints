use <utils/prism.scad>

$fn=50;

slice_height=0.4;

module holder_base(offset) {
    linear_extrude(slice_height) hull() {
        translate([1, 1, 0]) circle(d=3);
        translate([94-offset, 52-offset, 0]) circle(d=3);
        translate([1, 52-offset, 0]) circle(d=3);
        translate([94-offset, 1, 0]) circle(d=3);
        translate([96-offset, 26-offset, 0]) circle(d=3);
        translate([-3, 26-offset, 0]) circle(d=3);
    }
}

module holder_block(offset) {
    for(z=[0:slice_height:15]) {
        zRatio=z/15;
        translate([1.5*zRatio, 8*zRatio, z])
            scale([1-0.04*zRatio,1-0.2*zRatio, 1])
                holder_base(offset);
    }
}

//difference() {
//    holder_block(0);
//    
//    //curving the ez-pass
//    translate([2, 2, 1.2]) holder_block(4);
//    //some openings around
//    translate([-5, 10, 1.2]) cube([108, 34, 20]);
//    
//    translate([10, -5, 1.2]) cube([74, 80, 20]);
//}
//
//translate([38, 50, 0]) {
//    difference() {
//        cube([20, 20, 1.2]);
//        translate([8, 8, 0]) cube([4, 4, 4]);
//    }
//}

translate([38, 80, 0]) {
    cube([10, 10, 3]);
    translate([5, 5, 0]) linear_extrude(30, twist=100) square([4,4], center=true);
}