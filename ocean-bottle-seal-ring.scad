$fn=50;

rotate_extrude() translate([30,0,0]) {
    mirror([1,0,0]) polygon([
        [0,0], [4,0],
        [4,5], [3,5],
        [3,3.5]
    ]);
}