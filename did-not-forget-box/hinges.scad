
module hinge_base(width, depth, height1, height2, connecting_r, wall_thickness, wall_hole_width) {
    difference() {
        union() {
            polyhedron(
                points=[[0,0,0],[width,0,0],[width,depth,0],[0,depth,0],[0,0,height1],[width,0,height1],[width,depth,height2],[0,depth,height2]],
                faces =[[0,1,2,3],[4,5,1,0],[5,6,2,1],[6,7,3,2], [7,4,0,3],[7,6,5,4]]
            );
            
            rotate([0, 90, 0]) translate([connecting_r-height1, 0, 0]) cylinder(r=connecting_r, h=width);
            translate([width/2, depth/2, -wall_thickness/2]) {
                #cube([wall_hole_width, depth, wall_thickness], center=true);
                translate([0, 0, -wall_thickness*3/4]) cube([width, depth, wall_thickness/2], center=true);
            }
        }
        //removing
        rotate([0, 90, 0]) translate([connecting_r-height1, 0, 0]) cylinder(r=connecting_r/3, h=width);
    }
}

module hinge_connecting_nook(index, height1, height2, width, depth, connecting_r) {
    nook_height = (width/3);
    position = index*nook_height;
    rotate([0, 90, 0]) translate([-height1+connecting_r, 0, position]) cylinder(r=connecting_r, h=nook_height);
}

