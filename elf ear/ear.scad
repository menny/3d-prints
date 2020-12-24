$fn=50;

module flat_ear(projection_angle, rotate_angle, cylinder_r) {
    projection() rotate([projection_angle, rotate_angle, 0]) cylinder(h = 100, r1=cylinder_r, r2=1.5);
}

module ear_path(projection_angle, rotate_angle, cylinder_r) {
    difference() {
        flat_ear(projection_angle, rotate_angle, cylinder_r);
        offset(r=2) offset(r=-4) flat_ear(projection_angle, rotate_angle, cylinder_r);
    }
}

module ear_slice(projection_angle, rotate_angle, cylinder_r, slice_height) {
    linear_extrude(height=slice_height) ear_path(projection_angle, rotate_angle, cylinder_r);
}

//ear

ear_height=15;
step_size=0.01;
slice_height=ear_height*step_size;

difference() {
    union() {
        translate([0, 0, 2]) {
            for(step=[1:-1*step_size:0]) {
                cylinder_r = 18*sqrt(step);
                projection_angle = -10 * step;
                rotate_angle = 40 * pow(step, 2);
                translate([0, 0, ear_height*step]) ear_slice(projection_angle, rotate_angle, cylinder_r, slice_height);
            }
        }
        //cap-flat
        translate([0.5, 0, 1]) cylinder(h=5, d=30);
    }
    
    //hole
    translate([0.5, 0, 0]) cylinder(h=5.5, d=27);
}
