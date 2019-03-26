use <../../functions.scad>;
include <../dimensions.scad>;

module plunger_3d_raw() {
     difference() {
          union() {
               cylinderAround(ph_fr, L=ph_ffl, O=ph_ffo, A=cy_orientation);
               cylinderAround(ph_mr, L=ph_ml, O=ph_mo, A=cy_orientation, IR=ph_ir);
               cylinderAround(ph_rr, L=ph_rl, O=ph_ro, A=cy_orientation, IR=ph_ir);
               cylinderAround(ph_tr, L=ph_tl, O=ph_to, A=cy_orientation, IR=ph_ir);
          };
          union() {
               cylinderAround(cy_ir, L=ph_ol, O=ph_ffo, A=cy_orientation, IR=ph_fr-ph_od);
               cylinderAround(cy_ir, L=ph_ol, O=ph_ro, A=cy_orientation, IR=ph_fr-ph_od);
          };
     };
};

module plunger_3d() {
     translate(ph_offset) {
          plunger_3d_raw();
     };
};
