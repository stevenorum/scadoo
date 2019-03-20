module safety_2d() {
     union() {
          arc(sf_or, sf_ta, sf_ba, IR=sf_sr);
          arc(sf_or, sf_da, sf_ba, IR=sf_dr);
     };
};

module safety_3d() {
     difference() {
          deepify(sf_td) {
               safety_2d();
          };
          deepify(sf_nd) {
               difference() {
                    circleXY(sf_sr);
               };
          };
     };
};

color(sf_color[0], sf_color[1]) {
     translate(sf_offset) {
          safety_3d();
     };
};
