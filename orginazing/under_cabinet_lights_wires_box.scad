$fn=50;

screw_r1=2.5;
screw_r2=1.4;

module square_box(
    height,
    width_large, width_small,
    depth) {
    polyhedron(points=[
                [0, 0, 0], [0, depth, 0],
                [width_large, depth, 0],
                [width_small, 0, 0],
                [0, 0, height], [0, depth, height],
                [width_large, depth, height],
                [width_small, 0, height]
                ],
            faces=[
                  [0,1,2,3],  // bottom
                  [4,5,1,0],  // front
                  [7,6,5,4],  // top
                  [5,6,2,1],  // right
                  [6,7,3,2],  // back
                  [7,4,0,3]]);
}
module box_part(
    height,
    width_large, width_small,
    depth,
    corner_radius, wall_thickness) {
    wall_diff=2*wall_thickness;
    difference() {
        union() {
            minkowski() {
              sphere(d=corner_radius);
              square_box(height,
                    width_large, width_small,
                    depth);
            }
    
        //screw front
        translate([width_large, -2*wall_thickness, height-corner_radius+wall_thickness]) cube([12,12,4]);
        //screw back
        translate([width_small, depth-12+wall_thickness, height-corner_radius+wall_thickness]) cube([12,12,4]);
        }
        //hollow
        translate([wall_thickness, wall_thickness, wall_thickness]) {
            minkowski() {
              sphere(d=corner_radius);
              square_box(height,
                width_large-wall_diff, width_small-wall_diff,
                depth-wall_diff);
            }
        }
        //top opening
        translate([0-corner_radius, 0-corner_radius, height]) cube([width_large+2*corner_radius,depth + 2*corner_radius,corner_radius]);
        //front enterance
        translate([0, -2*wall_thickness, corner_radius]) cube([width_small,2*wall_thickness,height]);
        //back enterance
        translate([0, depth, corner_radius]) cube([width_small,2*wall_thickness,height]);
        //screw front
        translate([width_large+6+wall_thickness, 6-2*wall_thickness, height-corner_radius+wall_thickness]) cylinder(4, r1=screw_r1, r2=screw_r2);
        //screw back
        #translate([width_small+6+wall_thickness, depth-6+wall_thickness, height-corner_radius+wall_thickness]) cylinder(4, r1=screw_r1, r2=screw_r2);
    }
}

box_part(20, 30, 30, 100, 6, 1.5);
