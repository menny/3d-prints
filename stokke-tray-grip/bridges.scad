$fn=50;


bridge_connector_gap_height=3;
bridge_connector_gap_length=8;
bridge_connector_length=1+bridge_connector_gap_length+2;
bridge_height=4.5;
bridge_width=3;

module bridge_connector() {
    difference() {
        cube([bridge_width, bridge_connector_length, bridge_height]);
        translate([0, 1, 0]) cube([bridge_width, bridge_connector_gap_length, bridge_connector_gap_height]);
    }
}

module bridge(bridge_length) {
    cube([bridge_width, bridge_length, bridge_height]);
translate([0, bridge_length-1, 0]) rotate([0, 0, 7.5]) bridge_connector();
translate([bridge_width, 0, 0]) rotate([0, 0, 180-7.5]) bridge_connector();

}

bridge(85);

translate([20, 0, 0]) bridge(110);