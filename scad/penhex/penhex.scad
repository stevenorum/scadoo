use <../functions.scad>;

function hexagon_vertices(length, X=0, Y=0) = [
          [sin(0)*length+X, cos(0)*length+Y],
          [sin(60)*length+X, cos(60)*length+Y],
          [sin(120)*length+X, cos(120)*length+Y],
          [sin(180)*length+X, cos(180)*length+Y],
          [sin(240)*length+X, cos(240)*length+Y],
          [sin(300)*length+X, cos(300)*length+Y]
          ];

module hexagon(length, X=0, Y=0, IR=0) {
     points = hexagon_vertices(length, X=X, Y=Y);
     if (IR <= 0) {
          polygon(points);
     };
     if (IR > 0) {
          difference() {
               polygon(points);
               hexagon(IR, X=X, Y=Y);
          };
     };
};

module tube(theight, tcenter, OR, thickness, bthickness) {
     pull(bthickness) {
          hexagon(OR, X=tcenter[0], Y=tcenter[1]);
     };
     window_height = 4*bthickness;
     window_gap = 4*bthickness;
     window_req_height = window_height + window_gap;
     window_count = floor((theight-bthickness) / window_req_height);
     window_heights = [ for (i = [0 : 1 : window_count-1]) bthickness + window_gap/2 + window_req_height*(i)];
     difference() {
          pull(theight + bthickness) {
               hexagon(OR, IR=OR-thickness, X=tcenter[0], Y=tcenter[1]);
          };
          union() {
               corners = hexagon_vertices(OR*1.01, X=tcenter[0], Y=tcenter[1]);
               rectangle_points = [ for (i = [0 : 1 : 2]) [
                         (2*corners[i]+corners[(i+1)%6])/3,
                         (corners[i]+2*corners[(i+1)%6])/3,
                         (2*corners[i+3]+corners[(i+4)%6])/3,
                         (corners[i+3]+2*corners[(i+4)%6])/3]];
               for (i = [0:len(rectangle_points)-1]) {
                    translate([0,0,theight]) {
                         pull(bthickness) {
                              polygon(rectangle_points[i]);
                         };
                    };
                    for (j = [0:len(window_heights)-1]) {
                         translate([0,0,window_heights[j]]) {
                              pull(window_height) {
                                   polygon(rectangle_points[i]);
                              };
                         };
                    };
               };
          };
     };
};


length = 25.4/1.5;
thickness = 25.4/10;
bottom_thickness = 25.4/8;
center_height = 25.4*3.5;
max_inner_height = 25.4*3;
min_inner_height = 25.4*1.5;

min_outer_height = 0.25;
max_outer_height = min_inner_height;

function center(angle, l) = [sin(angle)*l, cos(angle)*l];

clength = (2*length-thickness)*cos(30);

ur_center = center(30, clength);
r_center = center(90, clength);
lr_center = center(150, clength);
ll_center = center(210, clength);
l_center = center(270, clength);
ul_center = center(330, clength);

true_center = [0,0];

/* inner_centers = [ */
/*      ur_center, */
/*      r_center, */
/*      lr_center, */
/*      ll_center, */
/*      l_center, */
/*      ul_center */
/*      ]; */

/* outer_centers = [ */
/*      r_center + ur_center, */
/*      l_center + ul_center, */
/*      lr_center + ll_center, */
/*      r_center + r_center, */
/*      l_center + l_center, */
/*      ul_center + ul_center, */
/*      ur_center + ur_center, */
/*      ur_center + ul_center, */
/*      ll_center + l_center, */
/*      lr_center + r_center, */
/*      ll_center + ll_center, */
/*      lr_center + lr_center */
/*      ]; */

/* inner_heights = rands(min_inner_height, max_inner_height, len(inner_centers)); */
/* outer_heights = rands(min_outer_height, max_outer_height, len(outer_centers)); */


inner_centers = [
     true_center,
     ur_center,
     r_center,
     lr_center,
     ll_center,
     l_center,
     ul_center,
     ur_center + ul_center,
     ur_center + ur_center,
     r_center + ur_center,
     r_center + r_center,
     lr_center + r_center,
     lr_center + lr_center,
     lr_center + ll_center,
     ll_center + ll_center,
     ll_center + l_center,
     l_center + l_center,
     l_center + ul_center,
     ul_center + ul_center
     ];

unit = 25.4;



for (i = [0:len(inner_centers)-1]) {
     tube((19-i)*25.4*.2, inner_centers[i], length, thickness, bottom_thickness);
};






/* heights = [2,2.5,2.75,3,3.25,3.5,3.75]; */


/* tube(center_height, true_center, length, thickness, bottom_thickness); */

/* for (i = [0:len(inner_centers)]) { */
/*      tube(inner_heights[i], inner_centers[i], length, thickness, bottom_thickness); */
/* }; */
/* for (i = [0:len(outer_centers)]) { */
/*      tube(outer_heights[i], outer_centers[i], length, thickness, bottom_thickness); */
/* }; */
