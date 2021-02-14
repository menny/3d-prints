//!OpenSCAD
// title      : OpenSCAD bend procedures
// author     : flavius on Thingiverse, Stuart P. Bentley (@stuartpb)
// version    : 1.0.0
// file       : bend.scad
// repository : https://github.com/stuartpb/bend.scad.git

// Bend flat object on the cylinder width specified radius
// dimensions: vector with dimensions of the object that should be bent
// radius:     distance of the cylinder axis
// nsteps:     number of parts the object will be split into before being bent 
module cylindric_bend(dimensions, radius, nsteps = $fn) {
  step_angle = nsteps == 0 ? $fa : atan(dimensions.y/(radius * nsteps));
  steps = ceil(nsteps == 0 ? dimensions.y/ (tan(step_angle) * radius) : nsteps);
  step_width = dimensions.y / steps;
  {
    intersection() {
      children();
      cube([dimensions.x, step_width/2, dimensions.z]);
    }      
    for (step = [1:steps]) {
      translate([0, radius * sin(step * step_angle), radius * (1 - cos(step * step_angle))])
        rotate(step_angle * step, [1, 0, 0])
          translate([0, -step * step_width, 0])
            intersection() {
              children();
              translate([0, (step - 0.5) * step_width, 0])
                cube([dimensions.x, step_width, dimensions.z]);
            }
    }
  }
}

// arg: dimensions of a bounding box to bend (it starts at [0,0,0] and has positive x,y,z)
// arg: number of slices (quality versus performance)
// arg: resulting angle in degrees
module cylindric_bend_2( dimensions, nsteps, angle_deg ){
  assert( nsteps >= 1 );
  steps = nsteps -1;  // first slice hack

  step_angle = angle_deg / steps;
  step_width = dimensions.y / steps;
  // a parallel to x axis in z height (basically a radius)
  radius = 0;

  echo( "cylindric_bend() started..." );

  step_shift = 0.5;
  for( step = [0:1:steps] ){
    hull(){
      if( step == 0 ){
        intersection() {
          translate( [0,-step_width/2,0] )
            children();
          // first slice
          translate( [0,-step_width/2,0] )
            cube( [dimensions.x, step_width, dimensions.z] );
        }
      }

      for( substep = [step:1:min( step+1, steps )] ){
        translate( [0,
                    radius * sin( substep * step_angle ),
                    radius * ( 1 - cos(substep * step_angle) )] )
          rotate( step_angle * substep, [-1, 0, 0] )
            translate( [0, -(substep-step_shift) * step_width, 0] )
              intersection() {
                children();
                translate( [0, (substep-2*step_shift) * step_width, 0] )
                  cube( [dimensions.x, step_width, dimensions.z] );
              }
      }
    }
  }

  echo( "cylindric_bend() finished" );
}

// Bend flat object on parabola
// dimensions: vector with dimensions of the object that should be bent
// steepness:  coeficient 'a' of the function 'y = a * x^2'
// nsteps:     number of parts the object will be split into before being bent 
module parabolic_bend(dimensions, steepness, nsteps = $fn) {
  function curr_z(step, ysw) = steepness * pow(step * ysw, 2);
  function flat_width(step, ysw) = 
    ysw * sqrt(pow(2 * steepness * step * ysw, 2) + 1);
  function acc_y(step, ysw) =
    step == 0 ? ysw / 2 : acc_y(step - 1, ysw) + flat_width(step, ysw);

  max_y = dimensions.y / sqrt(1 + steepness);
  ysw = nsteps == 0 ? tan($fa) / (2 * steepness) : max_y / nsteps;
  steps = ceil(nsteps == 0 ? max_y / ysw : nsteps);
  {
    intersection() {
      children();
      cube([dimensions.x, ysw/2, dimensions.z]);
    }      		

    for (step = [1:steps]) {
      curr_flat = flat_width(step, ysw);
      acc_flat = acc_y(step - 1, ysw);
      angle = atan(2 * steepness * step * ysw);
      {
        translate([0, step * ysw, curr_z(step, ysw)])
          rotate(angle, [1, 0, 0])
            translate([0, -acc_flat - curr_flat/2, 0])
              intersection() {
                children();
                translate([0, acc_flat, 0])
                  cube([dimensions.x, curr_flat, dimensions.z]);
              }
      }
    }
  }
}

module textCylinder(	text="TEST"
						,r=30
						,h=2			// embosed height of letters
						,size=10		// text(size=)
						,rotate=[0,0,0]		// | y= rotate face of text
											// | z= rotate around the circumference
											// | x is ignored
						,font=undef		// : these allow default value in text()
						,spacing=undef	// : undef gets rid of WARNING unknown variable
						,language=undef
						,script=undef
						,valign=undef
						,halign="center" // is centered due to the technique used here
										// feel free to try others, YMMV.
						,direction=undef
						) { 
	s=0.1; s2=s*2;	// small, for difference etc.
	l=3;			// large (as a multiplyer) to allow for text size irregularity
	tall=( rotate!=[0,0,0] || direction=="btt" || direction=="ttb" );
	_h= (	tall 					// keep cut cylinders to reasonable size
			? (size*len(text)*l) 
			: size*l ); 
	_r=(r+h)*l;
	//echo(r=r,h=h,text=text,size=size,rotate=rotate);
	//echo(l=l,tall=tall,_h=_h,_r=_r);
	difference() {
		rotate([90,rotate[1],rotate[2]])
			linear_extrude(height=r+h,convexity=5)
				text(text,size,halign="center"
						,font=font
						,spacing=spacing
						,language=language
						,script=script
						,valign=valign
						,direction=direction
				);
		// -
		translate([0,0,size/2]) {
			cylinder(r=r,h=_h,center=true);
			difference() {
				cylinder(r=_r,h=_h+s,center=true);
				// -
				cylinder(r=r+h,h=_h+s2,center=true);
			} //d
		} // t
	} // d
} // textCylinder