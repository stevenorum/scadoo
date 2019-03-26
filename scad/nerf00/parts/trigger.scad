use <../../functions.scad>;
include <../dimensions.scad>;

module trigger_2d_add() {
     difference() {
          union() {
               rectangleRelative(0, 0, tg_tw, -tg_tl);
               rectangleRelative(tg_tw, -tg_tl, tg_bl, tg_bh);
               rectangleRelative(-tg_pd/2, -tg_tl, tg_pd, -tg_ph);
               polygon([[0,0],[-tg_pd/2, -tg_tl],[0,-tg_tl]]);
               rectangleRelative(0,0,-tg_sf,-tg_sh);
               arc(tgs_or, tgs_ta, tgs_sa, X=tg_ax, Y=tg_ay);
          };
          union(){
               arc(tg_cr, 90, 45, X=tg_cd-tg_cr-tg_pd/2, Y=-tg_tl-tg_ph/2);
               // round off the corner nearest the sear catch and safety
               arc(abs(tg_ax) + abs(tg_ay), 90, X=tg_ax, Y=tg_ay, IR=max(abs(tg_ax),abs(tg_ay)));
               arc(tgs_or-cs_ors, tgs_ta-20, tgs_sa+10, IR=tgs_or-3*cs_ors-$iota, X=tg_ax, Y=tg_ay);
          };
     };

};

module trigger_2d_subtract() {
          union(){
               circleXY(tg_ar, X=tg_ax, Y=tg_ay); // pivot axle
          };
};

module trigger_2d() {
     difference() {
          trigger_2d_add();
          trigger_2d_subtract();
     };
};

module trigger_3d_raw() {
     deepify(sd_thickness) {
          trigger_2d();
     };
};

module trigger_3d() {
     translate(tg_offset) {
          rotateAround(tg_rotation, X=tg_ax, Y=tg_ay) {
               trigger_3d_raw();
          };
     };
};
