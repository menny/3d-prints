
module box_part(height, hinge_height, hinge_width) {
    corner_radius=4;
    wall_thickness=2;
    cube_size=90;
    difference() {
        minkowski() {
          sphere(d=corner_radius);
          cube([cube_size,cube_size,height]);
        }
        //hollow
        translate([wall_thickness, wall_thickness, wall_thickness]) {
            minkowski() {
              sphere(d=corner_radius);
              cube([cube_size-2*wall_thickness, cube_size-2*wall_thickness, height + corner_radius]);
            }
        }
        translate([0-corner_radius, 0-corner_radius, height]) cube([cube_size+2*corner_radius,cube_size + 2*corner_radius,corner_radius]);
        
        translate([-wall_thickness/2, cube_size/6, height-hinge_height/2]) cube([wall_thickness, hinge_width, hinge_height], center=true);
        translate([-wall_thickness/2, cube_size*5/6, height-hinge_height/2]) cube([wall_thickness, hinge_width, hinge_height], center=true);
        //nooks for straps
        #translate([-2*wall_thickness, cube_size/4, -corner_radius/2]) rotate([0, 90, 0]) cylinder(r=1, h=cube_size+2*corner_radius, center=false);
        #translate([-2*wall_thickness, cube_size*3/4, -corner_radius/2]) rotate([0, 90, 0]) cylinder(r=1, h=cube_size+2*corner_radius, center=false);
        
        #translate([-wall_thickness, cube_size/4, -corner_radius/2]) cylinder(r=1, h=corner_radius+height, center=false);
        #translate([-wall_thickness, cube_size*3/4, -corner_radius/2]) cylinder(r=1, h=corner_radius+height, center=false);
        
        #translate([cube_size+wall_thickness, cube_size/4, -corner_radius/2]) cylinder(r=1, h=corner_radius+height, center=false);
        #translate([cube_size+wall_thickness, cube_size*3/4, -corner_radius/2]) cylinder(r=1, h=corner_radius+height, center=false);
    }
}

//box_part(14, 6, 10);
