module safety_2d() {
     difference() {
          circleXY(sr_or);
          rectangle(-sr_or, sc_co-sr_or, sr_or, -sr_or);
     };
};

module safety_3d() {
     deepify(sr_length) {
          safety_2d();
     };
};

color(sr_color[0], sr_color[1]) {
     translate(sr_offset) {
          rotate(sr_rotation) {
               safety_3d();
          }
     };
};
