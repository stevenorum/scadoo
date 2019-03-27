use <../../functions.scad>;
include <../dimensions.scad>;

module bolt_3d_raw() {
     difference() {
          union() {
               cylinderAround(bh_or_cy, L=bh_l_cy, O=bh_o_cy, A=cy_orientation, IR=bh_ir);
               cylinderAround(bh_or_ch, L=bh_l_ch, O=bh_o_ch, A=cy_orientation, IR=bh_ir);
               cylinderAround(bh_or_br, L=bh_l_br, O=bh_o_br, A=cy_orientation, IR=bh_ir_br);

               /* difference() { */
               /*      cylinderAround(bh_or_ch, L=0.5, O=bh_o_ch - [bh_l_ch/2, 0, 0] + [0.25,0,0], A=cy_orientation); */
               /*      deepify(1) { */
               /*           rectangleRelative(bh_o_cy[0]-bh_l_cy/2-bh_l_ch-1, bh_o_cy[1], 2, 1); */
               /*      }; */
               /* }; */
               /* cylinderAround(ph_mr, L=ph_ml, O=ph_mo, A=cy_orientation, IR=ph_ir); */
               /* cylinderAround(ph_rr, L=ph_rl, O=ph_ro, A=cy_orientation, IR=ph_ir); */
               /* cylinderAround(ph_tr, L=ph_tl, O=ph_to, A=cy_orientation, IR=ph_ir); */
          };
          union() {
               cylinderAround(cy_ir, L=bh_ol_cy, O=bh_o_cy + [0.2, 0, 0], A=cy_orientation, IR=bh_or_cy-bh_od_cy);
               cylinderAround(cy_ir, L=bh_ol_cy, O=bh_o_cy - [0.2, 0, 0], A=cy_orientation, IR=bh_or_cy-bh_od_cy);
          };
     };
};

module bolt_3d() {
     translate(ph_offset) {
          bolt_3d_raw();
     };
};
