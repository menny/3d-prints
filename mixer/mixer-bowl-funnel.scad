use <../utils/prism.scad>

$fn=150;

slice_factor=140/670;
bowl_radius=106;
walls_thickness=2;
funnel_openning_angle=15;
funnel_length=88;
funnel_wall_height=20;
funnel_angle=15;
funnel_openning_1=-65;
funnel_openning_2=funnel_openning_1-50;

connector_height=walls_thickness+1;
connector_size=8;

module connector() {
    cube([walls_thickness, connector_size, connector_height]);
    offset=(walls_thickness-connector_size)/2;
    translate([offset,-offset,0]) cube([connector_size, walls_thickness, connector_height]);
}

module connectors() {
    rotate([0, 0, 45*slice_factor]) translate([7+bowl_radius, 0, 10]) connector();
    rotate([0, 0, 170*slice_factor]) translate([7+bowl_radius, 0, 10]) connector();
    rotate([0, 0, 300*slice_factor]) translate([7+bowl_radius, 0, 10]) connector();
}

module hinge_as_cookie() {
    cylinder(walls_thickness, r=6);
    resize([12, 12, 4]) sphere(r=100);
    //chips
    chip_xs=[-4, -1, 0, 3, 3, -1, -3];
    chip_ys=[-2, 4, -1, 0, 2, -3, 2];
    for(chip_index=[0:6]) {
        chip_x=chip_xs[chip_index];
        chip_y=chip_ys[chip_index];
        translate([chip_x, chip_y, -1.5]) sphere(r=0.75);
    }
}
//hinges to hold to the bowl ring (looks like a cookie)
module bowl_guard_clip_on_cookie_hinges() {
    translate([bowl_radius, 0, 0]) rotate([0, 90, 0]) hinge_as_cookie();
    rotate([0, 0, 360*slice_factor]) translate([bowl_radius, 0, 0]) rotate([0, 90, 0]) hinge_as_cookie();
}


//bowl guard clip-on
module bowl_guard_clip_on() {
    difference() {
        rotate_extrude(angle=360*slice_factor) {
            translate([bowl_radius, 0, 0]) {
                square([walls_thickness, 10]);
                translate([0, 10, 0]) square([15, walls_thickness]);
                translate([13, 5, 0]) square([walls_thickness, 5]);
            }
        }
        //holes
        connectors();
    }
    
    bowl_guard_clip_on_cookie_hinges();
}

//funnel

module funnel_connector(cookie_spin) {
    rotate([90, 0, 270]) translate([0, 6, -10]) rotate([0, 0, cookie_spin]) hinge_as_cookie();
    rotate([0, 0, 270]) translate([-connector_size/2, 0, 0]) {
        prism(connector_size, connector_size, connector_size, connector_size+4);
        translate([(connector_size-walls_thickness)/2, 0, -connector_height]) connector();
    }
}

module funnel_connectors() {
    rotate([0, 0, 45*slice_factor]) translate([7+bowl_radius, 0, 8]) funnel_connector(0);
    rotate([0, 0, 170*slice_factor]) translate([7+bowl_radius, 0, 8]) funnel_connector(90);
    rotate([0, 0, 300*slice_factor]) translate([7+bowl_radius, 0, 8]) funnel_connector(210);
}

module funnel() {
    translate([0, 0, 30]) {
        difference() {
            rotate_extrude(angle=360*slice_factor) {
                translate([bowl_radius, 12, 0]) {
                    rotate([0, 0, -55]) square([walls_thickness, funnel_length]);
                }
            }
            
            //removing the extra funnel
            translate([bowl_radius, 0, 0]) rotate([90, -30, 25]) cube([100, 50, 50]);
            rotate([0, 0, 360*slice_factor]) translate([bowl_radius, 0, 0]) rotate([0, -30, -25]) cube([100, 50, 50]);
        }

        //funnel walls
        translate([bowl_radius, 1, 10]) rotate([90, -33, 25.5]) cube([funnel_length+5, funnel_wall_height, walls_thickness]);
            rotate([0, 0, 360*slice_factor-1]) translate([bowl_radius, 0, 10]) rotate([0, -33, -24]) cube([funnel_length+5, walls_thickness,  funnel_wall_height]);
        
        //and connectors
        funnel_connectors();
    }
}

//print
//bowl_guard_clip_on();
funnel();
