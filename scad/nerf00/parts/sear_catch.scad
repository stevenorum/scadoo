module sear_catch_2d() {
     difference() {
          union() {
               rectangle(0, 0, sc_ufw, sc_ufh);
               rectangleRelative(sc_lfw, sc_ufh-sc_urh, sc_lrw, -sc_lrh);
               arc(max(sc_ax, sc_ay), 90, 180, X=sc_ax, Y=sc_ay);
          };
          union() {
               circleXY(sd_cr, X=-1*sc_offset[0], Y=-1*sc_offset[1]);
               circleXY(sc_ar, X=sc_ax, Y=sc_ay);
               /* arc(sc_av+sc_ah, 90, 180, IR=max(sc_av, sc_ah), X=sc_ax, Y=sc_ay); */
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
     /* deepify(searDiskThickness) { */
     /*      rotateAround(triggerCatchAngle, searCatchPivot[0], searCatchPivot[1]) { */
     /*           difference() { */
     /*                union() { */
     /*                     rectangle(-searOR*1.4, 0, -searIR, -searOR*1.1); */
     /*                     rectangle(-searOR*1.1, -searIR/1.8, -searIR/2, -searOR*2); */
     /*                     arc(searOR*1.4+searCatchPivot[0], 90, 180, X=searCatchPivot[0], Y=searCatchPivot[1]); */
     /*                }; */
     /*                union() { */
     /*                     circleXY(searAR, searCatchPivot[0], searCatchPivot[1]); */
     /*                     arc(searIR/1.2, 65, 180); */
     /*                }; */
     /*           }; */
     /*      }; */
     /* }; */
};
