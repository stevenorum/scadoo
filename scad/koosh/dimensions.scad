use <../functions.scad>;
include <../constants.scad>;
$fn = 360;
$iota = 0.001;
$multiplier = 25.4;

ring_length = 1.0;
ring_max_thickness = 0.1;
ring_inner_diameter = 1.77;
ring_trailing_inner_diameter = 1.8;
ring_leading_inner_diameter = 1.83;
ring_outer_diameter = ring_inner_diameter + 2* ring_max_thickness;
ring_inner_radius = ring_inner_diameter / 2;
ring_outer_radius = ring_outer_diameter / 2;
ring_trailing_inner_radius = ring_trailing_inner_diameter / 2;
ring_leading_inner_radius = ring_leading_inner_diameter / 2;



ring_leading_edge_thickness = 0.03;
ring_trailing_edge_thickness = 0.03;

ring_leading_outer_radius = ring_leading_inner_radius + ring_leading_edge_thickness;
ring_trailing_outer_radius = ring_trailing_inner_radius + ring_trailing_edge_thickness;

ring_leading_section_length = 0.2;
ring_trailing_section_length = ring_length - ring_leading_section_length - 0.1;
ring_middle_section_length = ring_length - ring_leading_section_length - ring_trailing_section_length;
ring_fin_count = 6;
ring_fin_angle = 30;
ring_fin_thickness = 0.04;

ring_leading_origin = [0,0,ring_leading_section_length/2];
ring_middle_origin = [0,0,ring_leading_section_length + ring_middle_section_length/2];
ring_trailing_origin = [0,0,ring_leading_section_length + ring_middle_section_length + ring_trailing_section_length/2];


module circularAirfoil(sections) {
     for (i = [0:len(sections)-1]) {
          section = sections[i];
          echo(section);
          lng = section[0];
          or1 = section[1];
          ir1 = (len(section) >= 3) ? section[2] : -1;
          or2 = (len(section) >= 4) ? section[3] : -1;
          ir2 = (len(section) >= 5) ? section[4] : -1;
          section_origin = [0,0,sumRange(sections, last=i, index=0)+lng/2];
          echo(section_origin);
          cylinderAround(R=or1,
                         L=lng,
                         IR=ir1,
                         R2=or2,
                         IR2=ir2,
                         O=section_origin);
     };
};

module smoothify(L, OR1, IR1, OR2=-1, IR2=-1, steps=5, factor=0.5, origin=[0,0,0]) {
     sect_length = L/steps;
     _OR2 = OR2 <= 0 ? OR1 : OR2;
     _IR2 = IR2 <= 0 ? IR1 : IR2;
     // The logic here is hilariously janky and probably not good, but it's good enough for me for now.
     // It only produces a convex trailing edge for steps=2, so that's not ideal, also.
     // Also, the last two sections are a bit weird due to how it does the smoothing
     // (it tries to smooth directly to the end, instead of smoothing past and truncating.)
     mid_outer_radii = [ for (i = [1 : 1 : steps-1]) OR1 + (_OR2-OR1)*(1-pow(factor, i)) ];
     mid_inner_radii = [ for (i = [1 : 1 : steps-1]) IR1 + (_IR2-IR1)*(1-pow(factor, i)) ];
     outer_radii = concatenate([OR1],concatenate(mid_outer_radii,[_OR2]));
     inner_radii = concatenate([IR1],concatenate(mid_inner_radii,[_IR2]));
     sections = [ for (i = [0 : 1 : steps-1])
               [sect_length, outer_radii[i], inner_radii[i], outer_radii[i+1], inner_radii[i+1]]
          ];
     translate(origin) {
          circularAirfoil(sections);
     };
};





start_or = ring_inner_radius + ring_leading_edge_thickness;
end_or = ring_outer_radius;
or_diff = end_or-start_or;
sect_lng = ring_leading_section_length/4;

start_ir = ring_inner_radius;
end_ir = ring_inner_radius;
ir_diff = end_ir-start_ir;



scale([$multiplier,$multiplier,$multiplier]) {
union() {


/* circularAirfoil(sections); */
smoothify(ring_leading_section_length,
          OR1=ring_leading_outer_radius,
          IR1=ring_leading_inner_radius,
          OR2=ring_outer_radius,
          IR2=ring_inner_radius,
          steps=3,
          factor=0.3,
          origin=ring_leading_origin-[0,0,ring_leading_section_length/2]
     );
/* cylinderAround(R=ring_inner_radius + ring_leading_edge_thickness, */
/*                L=ring_leading_section_length, */
/*                IR=ring_inner_radius, */
/*                R2=ring_outer_radius, */
/*                O=ring_leading_origin); */
cylinderAround(R=ring_outer_radius,
               L=ring_middle_section_length,
               IR=ring_inner_radius,
               O=ring_middle_origin);
smoothify(ring_trailing_section_length,
          OR1=ring_outer_radius,
          IR1=ring_inner_radius,
          OR2=ring_trailing_outer_radius,
          IR2=ring_trailing_inner_radius,
          steps=1,
          origin=ring_trailing_origin-[0,0,ring_trailing_section_length/2],
          factor=.6
     );
/* cylinderAround(R=ring_outer_radius, */
/*                L=ring_trailing_section_length, */
/*                IR=ring_inner_radius, */
/*                R2=ring_inner_radius + ring_trailing_edge_thickness, */
/*                O=ring_trailing_origin); */

if (ring_fin_count > 0) {
     circumference = $PI * ring_outer_diameter;
     echo(circumference);
     polar_diff_angle = tan(ring_fin_angle) * ring_trailing_section_length / (circumference) * 360;
     echo(polar_diff_angle);
     for (i = [0:ring_fin_count-1]) {
          polar_start_angle = i*360/ring_fin_count;
          polar_end_angle = polar_start_angle + polar_diff_angle;
          intersection() {
               cylinderAround(R=ring_outer_radius,
                              L=ring_trailing_section_length,
                              IR=ring_inner_radius,
                              
                              IR2=ring_trailing_inner_radius,
                              O=ring_trailing_origin);
               hull() {
                    translate([0,0,ring_leading_section_length+ring_middle_section_length]) {
                         pull($iota) {
                              rotateAround(polar_start_angle) {
                                   rectangleRelative(-ring_fin_thickness/2,0,ring_fin_thickness,ring_outer_radius);
                              }
                         };
                    };
                    translate([0,0,ring_length]) {
                         pull(-1*$iota) {
                              rotateAround(polar_end_angle) {
                                   rectangleRelative(-ring_fin_thickness/2,0,ring_fin_thickness,ring_outer_radius);
                              }
                         };
                    };
               };
          };
     };
};


};
};
