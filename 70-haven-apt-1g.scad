$fn=50;

thin_wall = 5;
thick_wall = 12;
floor_thickness = 2;
wall_height = 12*11;

frame_x_length = 
    thin_wall + 4.5 + (12*7+4.5) + //hallway
    thin_wall + (12*13+11) + //living room
    thick_wall + (12*4+10.5) + //bath
    thin_wall + (12+9) + //master room closet
    thin_wall + (12*16+6) + thick_wall; //master bedroom
    
frame_y_length = 
    thick_wall + (12*16+6) + //living room
    thin_wall + (12*5) + (12*3+4) + (12*3+1) + (12*8+7) + // halllway
    thick_wall + (12*7+1.5) + thin_wall;//netta room

module base_frame() {
    color("gray") cube([
        frame_x_length,
        frame_y_length,
        floor_thickness
    ]);
}

molding_none = 0;
molding_in = 1;
molding_out = 2;
molding_in_out = 3;

module molding(length) {
    rotate([0, 90, 0]) linear_extrude(height = length) {
        radius = 1;
        polygon(points=[
            [0, 0],
            [-radius, 0],
            for (i = [91:180]) [radius*cos(i), radius*sin(i)],
            [0, radius]
        ]);
    }
}

module wall(angle, thickness, length, molding) {
    rotate([0, 0, angle]) {
        cube([length, thickness, wall_height]);
    
        do_molding_in = molding == molding_in || molding == molding_in_out;
        do_molding_out = molding == molding_out || molding == molding_in_out;
        
        molding_height = 4;
        
        if (do_molding_in) {
            translate([0,thickness,0]) molding(length);
        }
    }
}

module entrance_single_frame(thickness, height, frame_width) {
    outer_thickness_delta = 1;
    
    linear_extrude(height = height)
        polygon(points=[
            [-frame_width, outer_thickness_delta],
            [-frame_width,-thickness-outer_thickness_delta],
            [frame_width, -thickness],
            [frame_width, 0]
        ]);
}

module enterance_frame(angle, thickness, height, width) {
    frame_width = 4;
    rotate([0, 0, angle]) {
        entrance_single_frame(thickness, height+frame_width, frame_width);
        translate([width, 0, 0]) mirror([1,0,0]) entrance_single_frame(thickness, height+frame_width, frame_width);
        translate([-frame_width, 0, height]) rotate([0, 90, 0]) entrance_single_frame(thickness, width+2*frame_width, frame_width);
    }
}

module living_room() {
    translate([
        thin_wall + 4.5 + (12*7+4.5),//hallway
        frame_y_length - thick_wall,
        0
    ]) {
        // walls
        west_wall = thin_wall + (12*13+11);
        south_wall = thick_wall + (12*16+6);
        wall(0, thick_wall, west_wall, molding_in);
        wall(-90, thin_wall, south_wall, molding_in);
        translate([west_wall, thick_wall, 0]) wall(-90, thick_wall, south_wall + thick_wall, molding_in_out);
        translate([0, -south_wall, 0]) wall(0, thin_wall, west_wall, molding_in);
        
        //south entrance
        translate([5+thin_wall, -south_wall+thin_wall, 0]) enterance_frame(0, thin_wall, 12*9, 12*3);
        //south-north entrance
        translate([west_wall-5-12*3, -south_wall+thin_wall, 0]) enterance_frame(0, thin_wall, 12*9, 12*3);
        //north entrance
        translate([west_wall + thick_wall, -12*9, 0]) enterance_frame(-90, thick_wall, 12*9, 12*2);
    }
}

base_frame();

translate([0, 0, floor_thickness]) {
    living_room();
}