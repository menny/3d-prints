module strap_out_box(width, height, radius) {
    hull() {
        offset=radius/2;
        translate([offset, offset, 0]) {
            translate([0, 0, 0]) sphere(r=radius);
            translate([width-radius, 0, 0]) sphere(r=radius);
            translate([width-radius, height-radius, 0]) sphere(r=radius);
            translate([0, height-radius, 0]) sphere(r=radius);
        }
    }
}

module strap_inner_box(width, height, radius) {
    hull() {
        offset=radius/2;
        translate([offset, offset, 0]) {
            translate([0, 0, 0]) cylinder(r=radius, h=20);
            translate([width-radius, 0, 0]) cylinder(r=radius, h=20);
            translate([width-radius, height-radius, 0]) cylinder(r=radius, h=20);
            translate([0, height-radius, 0]) cylinder(r=radius, h=20);
        }
    }
}

module strap(innerWidth, innerHeight, radius, strapThickness) {
    resize([0,0,strapThickness*2], auto=[false,false,true]) {
        difference() {
            strap_out_box(innerWidth, innerHeight, radius);
            //hollow
            translate([strapThickness, strapThickness, -10]) {
                strap_inner_box(innerWidth-2*strapThickness, innerHeight-2*strapThickness, radius);
            }        
        }

        for (transValues = [0, innerHeight] ) {
            translate([0, transValues, strapThickness/2]) rotate([0, innerWidth, 0]) cylinder(r=0.5, h=innerWidth, center=false);
        }

        for (transValues = [0, innerWidth] ) {
            translate([transValues, 0, strapThickness/2]) rotate([270, 0, 0]) cylinder(r=0.5, h=innerHeight, center=false);
        }
    }
}

//$fn=50;
//strap(90, 20, 4, 1.5);