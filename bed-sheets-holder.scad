$fn=50;

ring_d=5;
ring_hole_r=9;
rings_distance=100;
ring_gap_angle=300;

module holder() {
    rotate_extrude(angle=ring_gap_angle) translate([ring_hole_r,0,0]) circle(d=ring_d);
    translate([ring_hole_r*cos(ring_gap_angle), ring_hole_r*sin(ring_gap_angle), 0]) sphere(d=ring_d);

    translate([rings_distance, 0, 0]) rotate(a=240) rotate_extrude(angle=ring_gap_angle) translate([ring_hole_r,0,0]) circle(d=ring_d);
    translate([rings_distance-ring_hole_r*cos(ring_gap_angle), ring_hole_r*sin(ring_gap_angle), 0]) sphere(d=ring_d);

    hull() {
        translate([rings_distance/2,ring_hole_r/2,0]) cube([rings_distance-2*ring_hole_r, ring_hole_r, ring_d], center=true);
        translate([ring_hole_r,0,0]) sphere(d=ring_d);
        translate([0,ring_hole_r,0]) sphere(d=ring_d);
        
        translate([rings_distance-ring_hole_r,0,0]) sphere(d=ring_d);
        translate([rings_distance,ring_hole_r,0]) sphere(d=ring_d);
    }
}

module peg() {
    peg_ring_d=2;
    translate([0, 0, -ring_d/2+peg_ring_d/2]) {
        hull() {
            rotate_extrude() translate([ring_hole_r-peg_ring_d/2,0,0]) circle(d=peg_ring_d);
            cylinder(h=2*ring_d, r1=ring_hole_r, r2=ring_hole_r/3);
        }
        translate([0, 0, 2*ring_d]) cylinder(h=ring_d, r=ring_hole_r/3);
        translate([0, 0, 3*ring_d]) sphere(r=ring_hole_r/3);
    }
}

holder();

translate([0, ring_hole_r*3]) peg();
translate([ring_hole_r*2+5, ring_hole_r*3]) peg();