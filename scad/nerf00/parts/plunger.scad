module plunger_3d() {
     difference() {
          union() {
               cylinderAround(ph_fr, L=ph_ffl, O=ph_ffo, A=cy_orientation);
               cylinderAround(ph_fr, L=ph_frl, O=ph_fro, A=cy_orientation, IR=ph_ir);
               cylinderAround(ph_mr, L=ph_ml, O=ph_mo, A=cy_orientation, IR=ph_ir);
               cylinderAround(ph_rr, L=ph_rl, O=ph_ro, A=cy_orientation, IR=ph_ir);
               cylinderAround(ph_tr, L=ph_tl, O=ph_to, A=cy_orientation, IR=ph_ir);
          };
          union() {
               cylinderAround(cy_ir, L=ph_ol, O=(ph_ffo+ph_fro)/2, A=cy_orientation, IR=ph_fr-ph_od);
               cylinderAround(cy_ir, L=ph_ol, O=ph_ro, A=cy_orientation, IR=ph_fr-ph_od);
          };
     };
};

color(ph_color[0], ph_color[1]) {
     translate(ph_offset) {
          plunger_3d();
     };
};
