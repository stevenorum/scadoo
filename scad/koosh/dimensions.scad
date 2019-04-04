use <../functions.scad>;
include <../constants.scad>;

$iota = 0.001;
multiplier = 25.4;

ring_length = 0.5;
ring_max_thickness = 0.1;
ring_inner_diameter = 1.25;
ring_outer_diameter = ring_inner_diameter + 2* ring_max_thickness;
ring_inner_radius = ring_inner_diameter / 2;
ring_outer_radius = ring_outer_diameter / 2;
ring_leading_edge_thickness = 0;
ring_trailing_edge_thickness = 0;
ring_leading_section_length = 0.1;
ring_trailing_section_length = 0.3;
ring_middle_section_length = ring_length - ring_leading_section_length - ring_trailing_section_length;
ring_fin_count = 6;
ring_fin_angle = 45;
ring_fin_thickness = 0.05;

ring_leading_origin = [0,0,ring_leading_section_length/2];
ring_middle_origin = [0,0,ring_leading_section_length + ring_middle_section_length/2];
ring_trailing_origin = [0,0,ring_leading_section_length + ring_middle_section_length + ring_trailing_section_length/2];


module circularAirfoil(sections) {
     for (i = [0:len(sections)-1]) {
          section = sections[i];
          lng = section[0];
          or1 = section[1];
          ir1 = (len(section) >= 3) ? section[2] : -1;
          or2 = (len(section) >= 4) ? section[3] : -1;
          ir2 = (len(section) >= 5) ? section[4] : -1;
          section_origin = [0,0,sumRange(sections, last=i, index=0) + lng/2];
          cylinderAround(R=or1,
                         L=lng,
                         IR=ir1,
                         R2=or2,
                         IR2=ir2,
                         O=section_origin);
     };
};

start_or = ring_inner_radius + ring_leading_edge_thickness;
end_or = ring_outer_radius;
or_diff = end_or-start_or;
sect_lng = ring_leading_section_length/4;

start_ir = ring_inner_radius;
end_ir = ring_inner_radius;
ir_diff = end_ir-start_ir;

sections = [
     [sect_lng, start_or, start_ir, start_or+or_diff*0.4],
     [sect_lng, start_or+or_diff*0.4, start_ir, start_or+or_diff*0.7],
     [sect_lng, start_or+or_diff*0.7, start_ir, start_or+or_diff*0.9],
     [sect_lng, start_or+or_diff*0.9, start_ir, start_or+or_diff*1.0],
     ];

circularAirfoil(sections);

/* cylinderAround(R=ring_inner_radius + ring_leading_edge_thickness, */
/*                L=ring_leading_section_length, */
/*                IR=ring_inner_radius, */
/*                R2=ring_outer_radius, */
/*                O=ring_leading_origin); */
cylinderAround(R=ring_outer_radius,
               L=ring_middle_section_length,
               IR=ring_inner_radius,
               O=ring_middle_origin);
cylinderAround(R=ring_outer_radius,
               L=ring_trailing_section_length,
               IR=ring_inner_radius,
               R2=ring_inner_radius + ring_trailing_edge_thickness,
               O=ring_trailing_origin);

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
