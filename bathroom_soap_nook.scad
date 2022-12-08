// 17x9.5
$fn=50;

width=174;
height=7;
depth=95;
bottom_height=1;
sides_thickness=3;
corner=5;
inner_rotate=-2;
rib_height=4;
rib_width=3;

difference() {
    union() {
        difference() {
            cube([width, depth, height]);
            //carving out the nice inner
            translate([sides_thickness/2+corner/2, sides_thickness/2+corner/2, height-bottom_height]) {
                rotate([inner_rotate, 0, 0]) minkowski() {
                  sphere(d=corner);
                  cube([width-sides_thickness-corner, depth, height*2]);
                }
            }
        }

        ribs=8;
        for(rib_i = [0:1:ribs]) {
            _initial_offset = 2*sides_thickness;
            _ribs_offset = (width-4*sides_thickness)/ribs;
            _rib_offset=_initial_offset + _ribs_offset*rib_i;
            _rib_length=depth-rib_width;
            translate([_rib_offset, 0, 0]) rotate([270, 0, 0]) {
                resize([rib_width, rib_height*2, _rib_length]) cylinder(h=_rib_length, r=2);
                translate([0,0 , _rib_length]) resize([rib_width, rib_height*2, rib_width*2]) sphere(r=2);
            }
        }
    }
    //ensuring bottom is flat
    translate([0, 0, -10]) cube([width, depth, 10]); 
}