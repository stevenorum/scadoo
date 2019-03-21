module sear_catch_2d() {
     difference() {
          union() {
               rectangle(0, 0, sc_ufw, sc_ufh);
               rectangleRelative(0, sc_ufh, sc_ufw-sc_co, sc_flh);
               rectangleRelative(sc_lfw, sc_ufh-sc_urh, sc_lrw, -sc_lrh);
               arc(max(sc_ax, sc_ay), 90, 180, X=sc_ax, Y=sc_ay);
          };
          union() {
               circleXY(sd_cr, X=-1*sc_offset[0], Y=-1*sc_offset[1]);
               circleXY(sc_ar, X=sc_ax, Y=sc_ay);
          };
     };
};

module sear_catch_3d() {
     deepify(sd_thickness) {
          sear_catch_2d();
     };
};

color(sc_color[0], sc_color[1]) {
     translate(sc_offset) {
          rotateAround(sc_rotation, X=sc_ax, Y=sc_ay) {
               sear_catch_3d();
          };
     };
};
