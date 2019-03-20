module sear_disk_2d() {
     rotate(sd_rotation) {
          difference() {
               union() {
                    arcs(
                         [
                              [sd_ir, sd_fa],
                              [sd_or, sd_fta],
                              [sd_or, sd_tpa],
                              [sd_pr, sd_pa],
                              [sd_cr, sd_pca],
                              [sd_or, sd_ca]
                              ]
                         );
               };
               circleXY(sd_ar);
          };
     };
};

module sear_disk_3d() {
     deepify(sd_thickness) {
          sear_disk_2d();
     };
};

color(sd_color[0], sd_color[1]) {
     translate(sd_offset) {
          sear_disk_3d();
     };
};
