use <../../functionsA.scad>;
include <../dimensions.scad>;


rec_peg_or = 3.5*mm;
rec_peg_ir = 1.5*mm;
rec_l_x = rc_fx+0.25;
rec_r_x = rc_rx-0.5;
rec_t_y = cy_translate[1]+cy_origin[1]-cy_or-rc_offset[1];
rec_b_y = rc_fy+0.5;

trigger_top_height = 0.45;
trigger_top_width = 0.2;
trigger_bottom_height = 1;
trigger_bottom_width = 0.55;
trigger_wide_height = trigger_bottom_height + rec_peg_or*0;
trigger_wide_diff = trigger_wide_height-trigger_bottom_height;
trigger_height = trigger_bottom_height + trigger_top_height;
trig_offset = [
    rec_l_x+0.75+rec_peg_or,
    rec_b_y+rec_peg_or,
    0
    ];

module receiver_pin_cutouts() {
     // Screw holes to connect to other half
     circleXY(rc_sr, X=rc_fx+1/4, Y=rc_fy+1/4);
     /* circleXY(rc_sr, X=rc_fx+1/4, Y=rc_fy+1/4+1); */
     circleXY(rc_sr, X=rc_rx-1/4, Y=rc_fy+1/4);
     circleXY(rc_sr, X=rc_rx-1/4, Y=rc_fy+1/4+1);

     circleXY(rec_peg_ir, X=rec_l_x+rec_peg_or, Y=rec_b_y+rec_peg_or);
     circleXY(rec_peg_ir, X=rec_l_x+rec_peg_or, Y=rec_t_y-rec_peg_or);
     circleXY(rec_peg_ir, X=rec_r_x-rec_peg_or, Y=rec_b_y+rec_peg_or);
     circleXY(rec_peg_ir, X=rec_r_x-rec_peg_or, Y=rec_t_y-rec_peg_or);

    // safety hole
     /* translate(sr_offset) { */
     /*      safety_cutout_2d(); */
     /* }; */
     // axle pins
     /* translate(sd_offset) { */
     /*      sear_disk_subtract_2d(); */
     /* }; */
     circleXY(sft_hole_radius, X=sft_hole_offset[0], Y=sft_hole_offset[1]);
     /* translate(sc_offset) { */
     /*      sear_catch_subtract_2d(); */
     /* }; */
     /* translate(tg_offset) { */
     /*      trigger_subtract_2d(); */
     /* }; */
};


module safety_2d() {
     rotate([0,0,180]) {
          difference() {
               circleXY(sft_hole_radius);
               rectangle(-sft_hole_radius, sc_co*1.1-sft_hole_radius, sft_hole_radius, -sft_hole_radius);
          };
     };
};

module safety_cutout_2d() {
     circleXY(sr_or);
};

module safety_handle_2d() {
    rotate([0,0,-90]) {
        square([2*sr_hr, sr_hl], center=true);
        arc(sr_hr, 180, 90, X=0, Y=-sr_hl/2);
        arc(sr_hr, 180, 270, X=0, Y=sr_hl/2);
        polygon(points = [ [sr_hr, 0], [-sr_hr, 0], [0, -sr_hl] ]);
    };
};

module safety_3d_raw() {
     deepify(sr_length) {
          safety_2d();
     };
     translate([(sr_hl/2+sr_hr-sr_or), 0, sr_length/2]) {
          pull(sr_ht) {
               safety_handle_2d();
          };
     };
};

module safety_3d() {
     translate(sft_hole_offset) {
          rotate(sr_rotation) {
               safety_3d_raw();
          };
     };
};

module receiver_footprint() {
     cy = cy_translate[1]+cy_origin[1]-cy_or-rc_offset[1];
     union() {
          rectangle(rc_fx+0.25, rc_fy+0.5, rc_rx-0.5, cy-rc_wall);
          rectangle(rc_fx+0.25, rc_fy+0.5, rc_rx-0.5, cy);
     };
};

module receiver_plate(thickness=0) {
     plate_thickness = (thickness <= 0) ? rc_wall : thickness;
     deepify(plate_thickness) {
          difference() {
               receiver_footprint();
               receiver_pin_cutouts();
          };
     };
};
module remove_from_sides() {
     union() {
          cylinderExterior();
     };
};

module receiver_spring_blocks() {
     deepify(rc_inner_gap) {
         safety_block_length = safety_01+safety_02+safety_13+safety_12+safety_11+safety_10;
         safety_block_origin_x = -1*(safety_block_length+sd_or);
         cy = cy_translate[1]+cy_origin[1]-cy_or-rc_offset[1];
         rectangleRelative(safety_block_origin_x,cy,safety_block_length,-safety_14);
         rectangleRelative(safety_block_origin_x + safety_01 + safety_02,cy-safety_14-safety_16,safety_spring_block_length,-safety_04);
         rectangleRelative(safety_block_origin_x+safety_01+safety_02,cy-safety_14-safety_block_height-$iota,safety_block_length-(safety_01+safety_02),-safety_14);
         rectangleRelative(safety_block_origin_x,cy-safety_14-safety_16,safety_spring_block_length + safety_01 + safety_02,-safety_04);

         circleXY(sd_ar-$iota/2);
         circleXY(rec_peg_or, X=rec_l_x+rec_peg_or, Y=rec_b_y+rec_peg_or, IR=rec_peg_ir);
         circleXY(rec_peg_or, X=rec_l_x+rec_peg_or, Y=rec_t_y-rec_peg_or, IR=rec_peg_ir);
         circleXY(rec_peg_or, X=rec_r_x-rec_peg_or, Y=rec_b_y+rec_peg_or, IR=rec_peg_ir);
         circleXY(rec_peg_or, X=rec_r_x-rec_peg_or, Y=rec_t_y-rec_peg_or, IR=rec_peg_ir);
         circleXY(rec_peg_or, X=rec_l_x+0.75+rec_peg_or, Y=rec_b_y+rec_peg_or);
         arc(rc_sds_or, rc_sds_ta, rc_sds_sa, IR=rc_sds_ir); // spring for sear disk
                    /*          [sd_ir, sd_fa], */
                    /* [sd_or, sd_fta], */
                    /* [sd_or, sd_sa], */
                    /* [sd_or, sd_spa], */
                    /* [sd_or, sd_pa], */
                    /* [sd_cr, sd_pca], */
                    /* [sd_or, sd_ca] */
         arc(R=sd_or+0.15, IR=sd_or+0.01, O=90-sd_sa, A=sd_sa+sd_spa+90);
         /* arcs( */
         /*     [ */
         /*         [sd_ir, sd_fa], */
         /*         [sd_or, sd_fta], */
         /*         [sd_or, sd_sa], */
         /*         [sd_or, sd_spa], */
         /*         [sd_or, sd_pa], */
         /*         [sd_cr, sd_pca], */
         /*         [sd_or, sd_ca] */
         /*         ], */
         /*     X=0, */
         /*     Y=0 */
         /*     ); */
         /* arc(rc_scs_or, rc_scs_ta, rc_scs_sa, IR=rc_scs_ir, X=sc_aax, Y=sc_aay); // spring for sear catch */
         /* arc(rc_tgs_ogr, rc_tgs_ta, rc_tgs_sa, IR=rc_tgs_igr, X=tg_aax, Y=tg_aay); // spring for trigger */
     };
};

module sear_catch_rod_3d_raw() {
    /* safety_block_length = safety_01+safety_02+safety_13+safety_12+safety_11+safety_10; */
    /* safety_block_height = safety_06+safety_07+safety_08; */
    /* safety_block_origin_x = -1*(safety_block_length+sd_or); */
    /* safety_block_origin_y = cy_translate[1]+cy_origin[1]-cy_or-rc_offset[1]-safety_14; */
    /* ul_x = safety_block_origin_x; */
    /* ul_y = safety_block_origin_y; */
    /* ll_x = ul_x; */
    /* ll_y = ul_y-(safety_06+safety_07+safety_08); */
    /* ur_x = ul_x + safety_block_length; */
    /* ur_y = ul_y; */
    /* lr_x = ur_x; */
    /* lr_y = ll_y; */
    deepify(sd_thickness) {
        difference() {
            union() {
                /* rectangleRelative(sft_ul_x-1,sft_ll_y,safety_block_length,safety_block_height/2); */
                /* rectangleRelative(sft_ul_x-1,sft_ll_y+safety_block_height/2,0.25,-0.75); */
                rectangleRelative(sft_ul_x,sft_ll_y,safety_block_length,safety_block_height-$iota);
                /* rectangleRelative(sft_ul_x,sft_ul_y-safety_block_height+safety_08,safety_block_length+safety_09*0.75-$iota,safety_07); */
                polygon([
                            [sft_ul_x,sft_ul_y-safety_06],
                            [sft_ur_x+safety_09*0.75-$iota,sft_ul_y-safety_06],
                            [sft_ur_x+safety_09*0.75-$iota,sft_ll_y+safety_08],
                            [sft_lr_x,sft_ll_y]
                            ]);
            };
            union() {
                translate(trig_offset) {
                    translate([trigger_top_width*.125,trigger_top_height/2,0]) {
                        square([trigger_top_width*1.25,trigger_top_height+trigger_top_width+$iota], center=true);
                    };
                };
                rectangleRelative(
                    sft_ul_x-$iota,
                    sft_ll_y+safety_17-$iota,
                    safety_01+safety_02+safety_03+$iota,
                    safety_04+$iota
                    );
                rectangleRelative(sft_ur_x-safety_10-safety_11,sft_ll_y+safety_19,safety_11,safety_05);
            };
        };
    };
};

module sear_catch_rod_3d() {
    sc_offset = [0,0,0];
    translate(sc_offset) {
        sear_catch_rod_3d_raw();
    };
};

module receiver_axle_pins() {
     deepify(rc_inner_gap) {
          translate(sd_offset) {
               sear_disk_axle_2d();
          };
          translate(sc_offset) {
               sear_catch_axle_2d();
          };
          translate(tg_offset) {
               trigger_axle_2d();
          };
     };
};

module receiver_right_side() {
     union() {
          translate(-1*rc_offset) {
               receiver_plate();
          };
          receiver_spring_blocks();
     };
};

module receiver_left_side() {
     union() {
          translate(rc_offset) {
               receiver_plate();
          };
     };
};

module receiver_front_cylinder_holder() {
     intersection() {
          difference() {
               union() {
                    receiver_plate(thickness=rc_inner_gap);
                    rc_cy_origin = [0, cy_origin[1], cy_origin[2]];
                    cylinderAround(cy_or+rc_wall, L=rc_rt, O=rc_cy_origin + [rc_fx+rc_rt/2, 0, 0], A=cy_orientation, IR=cy_or);
               };
               cylinderExterior();
          };
          deepify(10){
               rectangle(rc_fx-1/2, -100, rc_fx+1/2, 100);
          };
     };

};

module receiver_rear_cylinder_holder() {
     intersection() {
          difference() {
               union() {
                    receiver_plate(thickness=rc_inner_gap);
                    cylinderAround(cy_or+rc_wall, L=rc_rt, O=[rc_rx-rc_rt/2, cy_origin[1], cy_origin[2]], A=cy_orientation, IR=cy_or);
               };
               cylinderExterior();
          };
          deepify(10){
               rectangle(rc_rx-1/2, -100, rc_rx+1/2, 100);
          };
     };

};

module sear_disk_add_2d() {
     difference() {
     union() {
          arcs(
               [
                    [sd_ir, sd_fa],
                    [sd_or, sd_fta],
                    [sd_or, sd_sa],
                    [sd_or, sd_spa],
                    [sd_or, sd_pa],
                    [sd_cr, sd_pca],
                    [sd_or, sd_ca]
                    ]
               );
          circleXY(sd_aor);
     };
     union() {
          arc(sds_or, sds_ta, sds_sa, IR=sds_ir);
     };
     };
}

module sear_disk_subtract_2d() {
     circleXY(sd_ar);
}

module sear_disk_axle_2d() {
     circleXY(sd_ar-$iota);
}

module sear_disk_2d() {
     rotate(sd_rotation) {
          difference() {
               sear_disk_add_2d();
               sear_disk_subtract_2d();
          };
     };
};

module sear_disk_3d_raw() {
     deepify(sd_thickness) {
          sear_disk_2d();
     };
};

module sear_disk_3d() {
     translate(sd_offset) {
          sear_disk_3d_raw();
     };
};

module sear_catch_add_2d() {
     // I know I'm using difference() in something named add,
     // but the point of this method is to give the overall outer border of the object.
     // The subtraction in here is part of that.
     // The stuff down in the subtract method is an interior axle hole.
     difference() {
          union() {
               rectangle(0, 0, sc_ufw, sc_ufh);
               rectangleRelative(0, sc_ufh, sc_ufw-sc_co-sc_co_gap, sc_flh);
               /* rectangleRelative(sc_lfw, sc_ufh-sc_urh, sc_lrw, -sc_lrh); */
               arc(max(sc_ax, sc_ay), 90, 180, X=sc_ax, Y=sc_ay);
               arc(sc_lrh, 85, 105, X=sc_ax, Y=sc_ay);
               /* circleXY(sc_aor, X=sc_ax, Y=sc_ay); */
               circleXY(scs_ir, X=sc_ax, Y=sc_ay);
               arc(scs_or, scs_ta, scs_sa, IR=scs_ir, X=sc_ax, Y=sc_ay);
               // TODO: clean up this logic and refactor out into a function.
               H = scs_ir*1.6;
               A = scs_ir;
               theta = acos(A/H);
               rx = sc_ax-sin(theta)*A;
               ry = sc_ay-cos(theta)*A;
               polygon([
                    [sc_ax, sc_ay],
                    /* [sc_ax-scs_ir, sc_ay], */
                    [rx, ry],
                    [sc_ax, sc_ay-H]
                    ]);
               /* arc(scs_ir, 270, 90, IR=scs_ir, X=sc_ax, Y=sc_ay); */
          };
          union() {
               polygon([[sc_ufw-sc_co-sc_co_gap, sc_ufh],[sc_ufw-sc_co-sc_co_gap, sc_ufh*0.95],[sc_ufw, sc_ufh]]);
               circleXY(sd_cr, X=-1*sc_offset[0], Y=-1*sc_offset[1]);
               x_corn = sc_ufw + sc_offset[0];
               y_corn = sc_ufh - sc_urh + sc_offset[1];
               echo(x_corn);
               echo(y_corn);
               /* exc_angle = atan(x_corn/y_corn); */
               exc_angle = sc_exc_angle;
               exc_radius = sqrt(x_corn*x_corn+y_corn*y_corn);
               arc((exc_radius+sd_or)/2, exc_angle, X=-1*sc_offset[0], Y=-1*sc_offset[1]);
               arc(scs_or, scs_ta, scs_sa, IR=scs_ir, X=sc_ax, Y=sc_ay);
          };
     };
};

module sear_catch_subtract_2d() {
     union() {
          circleXY(sc_ar, X=sc_ax, Y=sc_ay);
     };
};

module sear_catch_axle_2d() {
     union() {
          circleXY(sc_ar-$iota, X=sc_ax, Y=sc_ay);
     };
}

module sear_catch_2d() {
     difference() {
          sear_catch_add_2d();
          sear_catch_subtract_2d();
     };
};

module sear_catch_3d_raw() {
     union() {
          deepify(sd_thickness) {
               sear_catch_2d();
          };
          /* cylinderAround(scs_radius, L=scs_length, O=scs_origin, A=scs_orientation); */
     };
};

module sear_catch_3d() {
     translate(sc_offset) {
          rotateAround(sc_rotation, X=sc_ax, Y=sc_ay) {
               sear_catch_3d_raw();
          };
     };
};

module trigger_add_2d() {
     difference() {
          union() {
               difference() {
                    rectangleRelative(0, 0, tg_tw, -tg_tl);
                    arc(abs(tg_ax) + abs(tg_ay), 90, X=tg_ax, Y=tg_ay, IR=max(abs(tg_ax),abs(tg_ay)));
               };
               rectangleRelative(tg_tw, -tg_tl, tg_bl, tg_bh);
               rectangleRelative(-tg_pd/2, -tg_tl, tg_pd, -tg_ph);
               polygon([[0,0],[-tg_pd/2, -tg_tl],[0,-tg_tl]]);
               /* rectangleRelative(0,0,-tg_sf,-tg_sh); */
               /* arc(tgs_or, tgs_ta, tgs_sa, X=tg_ax, Y=tg_ay); */
               circleXY(tg_aor, X=tg_ax, Y=tg_ay);
               rectangleRelative(tg_ax, tg_ay, tg_aor, -(tg_tl+tg_ay));
               rectangleRelative(tg_ax, tg_ay, -tg_aor, tg_aor);
          };
          union() {
               /* rectangleRelative(tg_tw, -tg_tl, tg_bl, tg_bh); */
               polygon([
                            [tg_tw+tg_bl,tg_bh/2-tg_tl],
                            [tg_tw+tg_bl,tg_bh-tg_tl],
                            [tg_tw+tg_bl-tg_bh/2,tg_bh-tg_tl]]);
               arc(tg_cr, 90, 45, X=tg_cd-tg_cr-tg_pd/2, Y=-tg_tl-tg_ph/2);
               // round off the corner nearest the sear catch and safety
               arc(tgs_or-cs_ors, tgs_ta-20, tgs_sa+10, IR=tgs_or-3*cs_ors-$iota, X=tg_ax, Y=tg_ay);
          };
     };

};

module trigger_subtract_2d() {
     union(){
          circleXY(tg_ar, X=tg_ax, Y=tg_ay); // pivot axle
     };
};

module trigger_axle_2d() {
     union(){
          circleXY(tg_ar-$iota, X=tg_ax, Y=tg_ay); // pivot axle
     };
}

module trigger_2d_old() {
     difference() {
          trigger_add_2d();
          trigger_subtract_2d();
     };
};

module trigger_2d() {
    difference() {
        union() {
            circleXY(trigger_bottom_width/2, X=0, Y=0);
            circleXY(trigger_top_width/2, X=0, Y=trigger_top_height);
            translate([0,(trigger_top_height-trigger_bottom_height)/2,0]) {
                square([min(trigger_top_width, trigger_bottom_width),trigger_height], center=true);
            };
            translate([0,trigger_top_height/2,0]) {
                square([trigger_top_width,trigger_top_height], center=true);
            };
            translate([0,trigger_wide_diff-trigger_wide_height/2,0]) {
                square([trigger_bottom_width,trigger_wide_height], center=true);
            };
            /* square([0.5,2], center=true); */
    /* trig_offset = [ */
    /*     rec_l_x+0.75+rec_peg_or-tg_ax, */
    /*     rec_b_y+rec_peg_or-tg_ay */
    /*     ,0 */
    /*     ]; */
    /* translate(trig_offset) { */
    /*     rotateAround(tg_rotation, X=tg_ax, Y=tg_ay) { */
    /*         trigger_3d_raw(); */
    /*     }; */
    /* }; */

        };
        union() {
            circleXY(rec_peg_or+$iota/2, X=0, Y=0);
            circleXY(trigger_top_height*0.9, X=-trigger_top_height, Y=-(trigger_top_height+rec_peg_or));
            circleXY(trigger_bottom_height*2, IR=trigger_bottom_height, X=0, Y=0);
        };
    };
     /* difference() { */
     /*      trigger_add_2d(); */
     /*      trigger_subtract_2d(); */
     /* }; */
};

module trigger_3d_raw() {
     deepify(sd_thickness) {
          trigger_2d();
     };
};

module trigger_3d() {
    translate(trig_offset) {
        trigger_3d_raw();
    };
};
