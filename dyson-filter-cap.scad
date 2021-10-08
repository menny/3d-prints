$fn=50;
r=20;

difference() {
    resize(newsize=[r*2,r*2,30]) sphere(r=r);
    #translate([0, 0, -15]) cylinder(22, r*2, r*2);
    translate([0, 0, -1.5]) resize(newsize=[r*2,r*2,30]) sphere(r=r);
}
translate([0, 0, 5]) cylinder(h=9, r1=1.5, r2=3);