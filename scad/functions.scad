module warn(s) {
     echo(str("<h1 style='color:red'>", s, "</h1>"));
     // Using the undefined variable 'bar' triggers a warning, which ensures that I look at the console and see the big red message.
     foo = bar;
};

module complainUnless(complaint, assertion) {
     if (!assertion) {
          warn(complaint);
     };
};

module assert(assertion) {
     complainUnless("Assertion failed!", assertion);
};

module rectangle(x1, y1, x2, y2) {
     translate([(x1+x2)/2,(y1+y2)/2,0]) {
          square([abs(x2-x1), abs(y2-y1)], center=true);
     };
};

module rectangleRelative(x1, y1, x2, y2) {
     rectangle(x1, y1, x1+x2, y1+y2);
};

module semicircle(R, sides=24) {
    intersection() {
        circle(R, $fn=sides, center=true);
        translate([R, 0, 0]) {
            square(R*2, center=true);
        };
    };
};

module arc ( R, A=360, O=0, sides=24, X=0, Y=0, IR=0) {
     // Creates the arc starting on the Y axis and rotating clockwise.
     // O is the offset angle of the start, going clockwise.
     //direction = A >= 0 ? -1 : 1;
     //A = abs(A);
     difference() {
          translate([X, Y, 0]) {
               rotate([0,0,-O + (A >= 0 ? 0 : abs(A))]) {
                    union() {
                         if (A >= 180) {
                              union() {
                                   rotate([0,0,180-abs(A)]) {
                                        semicircle(R, sides);
                                   };
                                   semicircle(R, sides);
                              };
                         };
                         if (A < 180) {
                              intersection() {
                                   rotate([0,0,180-abs(A)]) {
                                        semicircle(R, sides);
                                   };
                                   semicircle(R, sides);
                              };
                         };
                    };
               };
          };
          union() {
               if (IR > 0) {
                    arc(R=IR, A=A+1, O=O-0.5, sides=sides, X=X, Y=Y, IR=0);
               };
          };
     };
};

function lastIndex(v, last=-1) = last < 0 ? (len(v) + last) : last;

function valueAtIndex(v, index) = (index > (len(v) + 1)) ? (v) : (v[index]);

function sumRange(v, first=0, last=-1, index=0) = 0 + ((first >= lastIndex(v, last)) ? 0 : ((valueAtIndex(v[first], index)) + sumRange(v, first=first+1, last=last, index=index)));

module arcs(R_A, X=0, Y=0) {
     union() {
          for (i = [0:len(R_A)]) {
               start_angle = sumRange(R_A, last=i, index=1);
               arc(R_A[i][0], R_A[i][1], start_angle, X=X, Y=Y);
               // Consider having the smaller arcs overlap with adjacent larger arcs slightly to get rid of possible hidden edges in the model.
          };
     };
};

module circleXY(R, X=0, Y=0, IR=0) {
     difference() {
          translate([X, Y, 0]) {
               circle(R, center=true, $fn=24);
          };
          union() {
               if (IR > 0) {
                    circleXY(R=IR, X=X, Y=Y, IR=0);
               };
          };
     };
};

module circlePolar(R, theta=0, length=0) {
    rotate([0,0,theta]) {
        translate([length, 0, 0]) {
            circle(R, center=true, $fn=24);
        }
    }
}

module rotateAround(A, X=0, Y=0) {
     translate([X, Y, 0]) {
          rotate(A) {
               translate([-X, -Y, 0]) {
                    children();
               };
          };
     };
};

module cylinderAround(R, L, O=[0,0,0], IR=0, A=[0,0,0]) {
    translate(O){
    rotate(a=A){
    if (IR > 0) {
        difference() {
        cylinder(h=L, r=R, $fn=24, center=true);
        cylinder(h=L*1.1, r=IR, $fn=24, center=true);
            }
        } else {
        cylinder(h=L, r=R, $fn=24, center=true);
        }
}}}

module deepify(thickness) {
    translate([0,0,-thickness/2]) {
    linear_extrude(thickness) {
    children();
    }

    }

}
