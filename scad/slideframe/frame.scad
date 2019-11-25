use <../functions.scad>;

$inch = 25.4;
$noz = 0.4;
$buffer = 1;
$fn = 24;
$epsilon = 0.1;

slide_thickness = (1/8)*$inch;
slide_length = 3*$inch;
slide_height = 1*$inch;
edge_width = (1/8)*$inch;
thickness = 2;
border_thickness = (1/4)*$inch;
border_overlap = (1/16)*$inch;
peg_radius = border_thickness/4 - $noz;
piece_length = slide_length + $buffer + 2*border_thickness;
piece_height = slide_height + $buffer + 2*border_thickness;
piece_thickness = thickness*2 + slide_thickness;

nail_radius = 2;
tab_width = nail_radius * 6;
tab_height = tab_width;

window_length = slide_length - 2*border_overlap;
window_height = slide_height - 2*border_overlap;

back_thickness = slide_thickness + thickness;
front_thickness = thickness;

x_max = piece_length/2;
x_min = -1 * x_max;
y_max = piece_height/2;
y_min = -1 * y_max;

module plate(plate_thickness) {
     difference() {
          union() {
               pull(plate_thickness) {
                    square([piece_length, piece_height], center=true);
               };
          };
          union() {
               pull(plate_thickness) {
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=0,   X=x_max-(border_thickness/2), Y=y_max-(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=90,  X=x_max-(border_thickness/2), Y=y_min+(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=180, X=x_min+(border_thickness/2), Y=y_min+(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=270, X=x_min+(border_thickness/2), Y=y_max-(border_thickness/2));
               };
          };
     };

};

module back_piece(hanging=true) {
     difference() {
          union() {
               pull(back_thickness) {
                    square([piece_length, piece_height], center=true);
                    if (hanging) {
                         rectangleRelative(-1*tab_width/2, y_max-$epsilon, tab_width, tab_height+$epsilon);
                    };
               };
               if (!hanging) {
                    rotateAround(A=[0,0,0], O=[0,0,0]) {
                         plate(thickness);
                    };
               };
          };
          union() {
               if (hanging) {
                    pull(back_thickness) {
                         arc(R=tab_width,IR=tab_width/2, A=180, O=270,   X=0, Y=y_max+tab_height/2);
                         circleXY(nail_radius, 0, y_max+tab_height/2);
                    };
               };
               pull(slide_thickness, liftby=thickness) {
                    square([slide_length+$buffer, slide_height+$buffer], center=true);
                    circleXY(peg_radius, x_max-(border_thickness/2), y_max-(border_thickness/2));
                    circleXY(peg_radius, x_max-(border_thickness/2), y_min+(border_thickness/2));
                    circleXY(peg_radius, x_min+(border_thickness/2), y_min+(border_thickness/2));
                    circleXY(peg_radius, x_min+(border_thickness/2), y_max-(border_thickness/2));
               };
               pull(back_thickness) {
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=0,   X=x_max-(border_thickness/2), Y=y_max-(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=90,  X=x_max-(border_thickness/2), Y=y_min+(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=180, X=x_min+(border_thickness/2), Y=y_min+(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=270, X=x_min+(border_thickness/2), Y=y_max-(border_thickness/2));
               };
          };
     };
};


module front_piece(hanging=true) {
     difference() {
          union() {
               pull(front_thickness) {
                    square([piece_length, piece_height], center=true);
                    if (hanging) {
                         rectangleRelative(-1*tab_width/2, y_max-$epsilon, tab_width, tab_height+$epsilon);
                    };
               };
               pull(slide_thickness*0.75 + front_thickness) {
                    circleXY(peg_radius, x_max-(border_thickness/2), y_max-(border_thickness/2));
                    circleXY(peg_radius, x_max-(border_thickness/2), y_min+(border_thickness/2));
                    circleXY(peg_radius, x_min+(border_thickness/2), y_min+(border_thickness/2));
                    circleXY(peg_radius, x_min+(border_thickness/2), y_max-(border_thickness/2));
               };
          };
          union() {
               pull(front_thickness) {
                    if (hanging) {
                         arc(R=tab_width,IR=tab_width/2, A=180, O=270,   X=0, Y=y_max+tab_height/2);
                         circleXY(nail_radius, 0, y_max+tab_height/2);
                    };
                    square([window_length, window_height], center=true);
               };
               pull(front_thickness) {
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=0,   X=x_max-(border_thickness/2), Y=y_max-(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=90,  X=x_max-(border_thickness/2), Y=y_min+(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=180, X=x_min+(border_thickness/2), Y=y_min+(border_thickness/2));
                    arc(R=border_thickness,IR=border_thickness/2, A=90, O=270, X=x_min+(border_thickness/2), Y=y_max-(border_thickness/2));
               };
          };
     };
};
