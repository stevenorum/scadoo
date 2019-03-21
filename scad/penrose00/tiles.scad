use <../functions.scad>;

spike = 1;
bump = 2;
$fn=24;

module tab(theta, c, L, type=1) {
     translate([c[0],c[1],0]) {
          rotate(90-theta) {
               X = L/8;
               Y = X/2;
               /* Y = L/32; */
               square([2*X, 4*Y/4], center=true);
               /* rectangleRelative(-X, -2*Y/3, 2*X, 4*Y/3); */
               if (type == 1) {
                    mirrorAdd([1,0,0]) {
                         rotateAround(45, X=X, Y=0) {
                              rectangleRelative(X/2,-Y,X,2*Y);
                         };
                    };
               };
               if (type == 2) {
                    mirrorAdd([1,0,0]) {
                         rectangleRelative(X/2,-1.5*Y,2*X/3,3*Y);
                    };
               };
          };
     };
};

module p3tile(theta, L, X=0, Y=0, tabs=false) {
    x1 = L*cos(theta/2);
    y1 = L*sin(theta/2);
    c = [X,Y];
    w = c-[x1, 0]; e = c+[x1, 0]; n = c+[0, y1]; s = c-[0, y1];
    nwa = -theta/2;
    nea = theta/2;
    swa = nea;
    sea = nwa;
    tl = 1.5;
    ts = 1;

    nnw = (tl*n+ts*w)/(tl+ts);
    wnw = (tl*w+ts*n)/(tl+ts);
    wsw = (tl*w+ts*s)/(tl+ts);
    ssw = (tl*s+ts*w)/(tl+ts);
    ene = (tl*e+ts*n)/(tl+ts);
    ese = (tl*e+ts*s)/(tl+ts);

    difference() {
        union() {
            polygon(points=[ w, n, e, s ]);
            if (tabs) {
                 if (theta == 36) {
                      tab(sea, ese, L, type=bump);
                      tab(nwa, wnw, L, type=spike);
                 };
                 if (theta == 72) {
                      tab(sea, ese, L, type=bump);
                      tab(swa, ssw, L, type=spike);
                 };
            };
        };
        union() {
            if (tabs) {
                 if (theta == 36) {
                      tab(swa, wsw, L, type=bump);
                      tab(nea, ene, L, type=spike);
                 };
                 if (theta == 72) {
                      tab(nwa, nnw, L, type=spike);
                      tab(nea, ene, L, type=bump);
                 };
            };
        };
    };
};

module p3tile1(L, X=0, Y=0, tabs=false) {
     p3tile(36, L, X, Y, tabs);
};

module p3tile2(L, X=0, Y=0, tabs=false) {
     p3tile(72, L, X, Y, tabs);
};

L = 3;
x=0;
union() {
     color("red")
     pull(-0.25) {
          p3tile1(L, tabs=true, X=-x);
     };
     color("yellow")
     pull(0.25) {
          p3tile1(L, tabs=false, X=-x);
     };
};

union() {
     color("red")
     pull(-0.25) {
          p3tile2(L, tabs=true, X=x);
     };
     color("yellow")
     pull(0.25) {
          p3tile2(L, tabs=false, X=x);
     };
};

//p3tile2(4, tabs=true, Y=-2);
