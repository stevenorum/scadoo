use <nerf_functions.scad>;
/* use <../functions.scad>; */

$fn=96;

$iota = .01;
inch = 1;
mm = 1/25.4;
charged = true;
$charged = true;
//$charged = false;
//$charged = ($t % 2 == 0);

cs_ors = (7/32)/2; // smaller compression spring outer radius
cs_irs = (5/32)/2; // smaller compression spring inner radius
cs_ls_short = 11/16; // also have the same diameter in 1 1/2 inch length
cs_ls_long = 1.5;
cs_orl = (1/4)/2; // larger compression spring outer radius
cs_irl = (3/16)/2; // larger compression spring inner radius
cs_ll = 13/32;
cs_thickness = 1/32;

// Sear disk dimensions
// sd_???
// radii (sd_?r)
sd_or = 0.6; // face outer radius
sd_ir = 0.4; // face inner radius
/* sd_ar = 0.0775/2; // axle radius */
// sd_ar = (2.5/25.4)/2; // axle radius
/* sd_ar = .125/2; // axle radius */
//sd_ar = 1.5*mm; // axle radius
sd_ar = 0.1;
// dependent
sd_pr = sd_or*1.5; // pushrod radius
sd_cr = sd_ir/1.25; // catch radius
sd_sr = sd_pr; // spring radius
// angles (sd_?a)
// Order (clockwise from top): fa, fta, sa, spa, pa, pca, ca
sd_fa = acos(sd_ir/sd_or); // face angle
sd_pa = 55; // pushrod angle
sd_ca = 85; // catch angle
// dependent
sd_fta = 120 - sd_fa; // face trailing angle
sd_sa = 15; // spring angle
sd_spa = 180-(sd_fa+sd_fta+sd_sa); // spring-to-pushrod angle
sd_pca = 180-(sd_ca+sd_pa); // pushrod-to-catch angle

sd_aor = sd_ar*3;

sds_sa = 90;
sds_ta = 120;
sds_ir = sd_cr-cs_ors;
sds_or = sds_ir+2*cs_ors+$iota;

rc_sds_sa = 140;
rc_sds_ta = 20;
rc_sds_ir = sds_ir + $iota;
rc_sds_or = sds_or - $iota;

complainUnless("The sear disk angles do not add up to 360!!1!", (sd_fa+sd_fta+sd_sa+sd_spa+sd_pa+sd_pca+sd_ca) == 360);

sd_rotation = [0, 0, $charged ? 0 : sd_fa];
sd_thickness = 0.25;
sd_offset = [0,0,0];

rc_inner_gap = sd_thickness + $iota;

rc_wall = 0.15;
/* rc_offset = [0,0,(rc_wall+sd_thickness)/2]; */
rc_offset = [0,0,(rc_wall+rc_inner_gap)/2];
rc_fx = -3;
rc_fy = -1.5;
rc_rx = 1.5;
rc_ry = 0.5;
rc_rt = 1;

rc_sr = 1/16;

// BARREL
// Not going to be printed, but need dimensions for sizing the printed parts.
// These measurements are for the carbon-fiber barrel.
br_or = 16*mm/2; // barrel outer radius, measured
br_ir = 13*mm/2; // barrel inner radius, measured
br_length = 16; // I think I have 18 or 20 inches of CF tube.  This number is guaranteed to change.

// SPRING
// Not going to be printed.  This is an AR buffer spring.
sp_or = 1/2;
sp_ir = 0.75/2;

// CYLINDER
// Not going to be printed, but need dimensions for sizing the printed parts.
/* cy_or = .83; // cylinder outer radius, canonical */
/* cy_wt = .14; // cylinder wall thickness, canonical */
/* cy_ir = cy_or - cy_wt; // cylinder inner radius */
/* cy_or = 1.665/2; // cylinder outer radius, measured, 1 1/4 pvc */
/* cy_ir = 1.365/2; // cylinder inner radius, measured, 1 1/4 pvc */
cy_or = 1.905/2 + $iota; // cylinder outer radius, measured, 1 1/2 pvc
cy_ir = 1.595/2; // cylinder inner radius, measured, 1 1/2 pvc
cy_wt = cy_or-cy_ir; // cylinder wall thickness
cy_length = 9;
cy_rside = 2;
cy_lshift = cy_length/2 - cy_rside;
cy_orientation = [0,90,0];
cy_origin = [0, cy_ir + sd_ir, 0];
cy_translate = [-cy_lshift, 0, 0];


// Sear catch dimensions
// sc_???
sc_ufh = sd_or; // upper front height
sc_lfh = sd_or*0.8; // lower front height
sc_urh = sd_or*0.75; // upper rear height
sc_lrh = sc_ufh + sc_lfh - sc_urh; // lower rear height
sc_lfw = sd_or*0.3; // lower front width
sc_lrw = sd_or*0.4; // lower rear width
sc_ufw = sd_or*0.5; // upper front width
sc_urw = sd_or*0.2; // upper rear width
sc_ar = sd_ar; // axle radius
sc_ah = sc_urw + sc_ar; // axle horizontal offset
sc_av = sc_ufh - sc_urh; // axle vertical offset
sc_co = sc_ufw/3; // catch overlap - how much of the catch contacts the sear disk.
sc_co_gap = sc_ufw/3; // catch overlap gap - how much of a gap is there between the sear disk and the wall at the front of the catch
sc_flh = sc_co; // front lip height - bump up in front of the sear catch
/* sc_ax = sc_ufw * 2 / 3; // (relative) axle x coordinate */
/* sc_ay = sc_ufh  / 3; // (relative) axle y coordinate */
sc_ax = sc_lfw + sc_lrw - sc_ah; // (relative) axle x coordinate
sc_ay = sc_ufh - sc_urh - sc_av; // (relative) axle y coordinate
sc_aor = sc_ar*3;
sc_exc_angle = sd_fa+sd_fta+sd_sa+sd_spa+sd_pa+sd_pca/4;

scs_radius = cs_irs;
scs_orientation = [0,90,0];
scs_length = cs_ls_short/4;
scs_origin = [sc_lfw+sc_lrw, -sc_lrh+(cs_ors+cs_thickness)*2, 0];
sc_offset = [-(sd_or + sc_ufw - sc_co),-sc_ufh,0];
sc_rotation = $charged ? 0 : 10;
sc_aax = sc_ax + sc_offset[0];
sc_aay = sc_ay + sc_offset[1];

// Floating-point numbers are annoying to compare.
complainUnless("Front and rear heights of the sear catch do not match!!1!",abs(sc_ufh+sc_lfh - (sc_lrh+sc_urh))<0.0001);

scs_or = sc_lrh-cs_ors;
scs_ir = sc_lrh-3*cs_ors - $iota;
scs_sa = 115;
scs_ta = 60;
rc_scs_or = scs_or - $iota;
rc_scs_ir = scs_ir + $iota;
rc_scs_sa = scs_sa + 5;
rc_scs_ta = 10;


// Safety rod dimensions
// sr_???
sr_or = sc_co * 2.1; // safety rod outer radius
sr_length = sd_thickness + rc_wall*2;
sr_offset = [sc_offset[0]-sr_or, -1*sr_or, 0];
sr_rotation = [0, 0, $charged ? 0 : -90];
sr_hr = 1.1*sr_or; // safety handle radius
sr_hl = 3*sr_or; // safety handle length
sr_ht = sd_thickness; // safety handle thickness

// plunger dimensions
// ph_??
ph_ot = 0.11; // o-ring thickness
ph_ol = 0.1; // o-ring groove length
ph_od = 3*ph_ol/4; // o-ring groove depth
ph_margin = ph_ot-ph_od; // gap between cylinder wall and plunger
ph_catch_margin = .01;
ph_fl = sd_ir * 2 * sin(sd_fa/2); // plunger head front length
ph_ft = ph_fl; // face thickness
ph_ffl = ph_ft;
ph_frl = ph_fl-ph_ffl;
ph_ml = sd_or * sin(sd_fa) * 2; // middle length
ph_rl = sd_ir * 2 * sin(sd_fa/2); // rear length
ph_tl = ph_ml; // tail length
ph_fr = cy_ir - ph_margin; // front radius
plunger_outer_radius_front = cy_ir - ph_margin;
plunger_inner_radius_front = plunger_outer_radius_front - 5*mm;

ph_mr = cy_ir - ph_catch_margin - (sd_or-sd_ir); // middle radius
ph_rr = cy_ir - ph_margin; // rear radius
ph_ir = sp_or; // inner radius - this is currently perfect
ph_tr = ph_ir+0.1; // tail radius

ph_offset = [-(ph_fl + ph_ml) + ($charged ? 0 : -ph_rl), 0, 0];

ph_ffo = cy_origin + [ph_ffl/2,0,0];
ph_fro = ph_ffo + [(ph_ffl+ph_frl)/2,0,0];
ph_mo = ph_fro + [(ph_frl+ph_ml)/2,0,0];
ph_ro = ph_mo + [(ph_ml)/2 + ph_rl/2,0,0];
ph_to = ph_ro + [(ph_rl)/2 + ph_tl/2,0,0];


// bolt dimensions
// bh_??
bh_ot_cy = ph_ot; // o-ring thickness
bh_ol_cy = ph_ol; // o-ring groove length
bh_od_cy = ph_od; // o-ring groove depth
bh_margin = ph_margin;
bh_or_cy = ph_fr; // outer radius, cylinder section
bh_or_ch = 5/16; // outer radius, chamber section
bh_wall_thickness = .1;
bh_ir = bh_or_ch - bh_wall_thickness;
bh_l_ch = 4;
bh_l_cy = 0.75;
bh_o_cy = cy_origin + [-1, 0, 0];
bh_o_ch = bh_o_cy + [-(bh_l_cy+bh_l_ch)/2, 0, 0];
bh_ft_cy = ph_ft;

bh_l_br = 1;
bh_or_br = br_ir - $iota; // OR of the part that goes into the barrel.  I still need to add the oring stuff to this part.
bolt_outer_radius_barrel = 12*mm/2;
bolt_oring_radius_barrel = 10.5*mm/2;
bolt_oring_length_barrel = 1.5*mm;
bolt_inner_radius_barrel = 8*mm/2;

bh_ir_br = bh_or_br*0.75;
bh_o_br = bh_o_ch + [-(bh_l_ch+bh_l_br)/2, 0, 0];

bolt_handle_diameter = 0;
bolt_handle_radius = bolt_handle_diameter/2;
bolt_handle_length = 1;
bolt_handle_bend_angle = 60;
bolt_handle_bend_length = 0.5;
bolt_handle_ball_radius = 0.35;

bh_offset = [ph_offset[0] + ($charged ? 0.5 : -(bh_l_ch + bh_l_br)+1), 0, 0];




// trigger dimensions
// tg_???

/* tg_tl = sc_ufh + sc_lfh; */
tg_tl = (sc_urh + sc_lrh + 0.1)/2;
tg_tw = 0.3;

tg_bl = 0.3;
tg_bh = 0.2;

tg_ar = sd_ar;
tg_ax = tg_tw/2;
tg_ay = -tg_tl/4;

tg_aor = tg_ar*3; // trigger axle outer radius

tg_pd = 2*tg_tw; // trigger pull depth (how wide the trigger itself is, not the trigger pull distance)
tg_ph = 1.25; // trigger pull height (how tall the visible part of the trigger is)
tg_cr = 1; // trigger curvature radius
tg_cd = tg_pd/2; // trigger curvature depth

tg_sf = 0.5;
tg_sh = abs(tg_ay) * 2;

tgs_or = 1;
tgs_ogr = tgs_or - cs_ors;
tgs_igr = tgs_ogr - 2*cs_ors - $iota;
tgs_sa = 240;
tgs_ta = 90;

tgs_la = 15;
tga_ta = 15;

rc_tgs_sa = tgs_sa + tgs_la + 10;
rc_tgs_ta = 10;
rc_tgs_ogr = tgs_ogr - $iota;
rc_tgs_igr = tgs_igr + $iota;

tg_offset = [sc_offset[0] - tg_bl - tg_tw + sc_lfw, -tg_tl, 0];
tg_rotation = [0, 0, $charged ? -5 : 10];

tg_aax = tg_offset[0] + tg_ax;
tg_aay = tg_offset[1] + tg_ay;

// receiver dimensions
// rc_???

brake_innerRadius = mm*14/2; 
brake_innerFitRadius = mm*16.25/2;
brake_outerRadius = mm*22/2;
brake_outerFrontRadius = mm*22/2;
brake_totalLength = 1;


barrel_innerRadius = 13.25/2*mm;
barrel_innerFitRadius = 16.25/2*mm;
barrel_outerRadius = 18/2*mm;
barrel_outerFrontRadius = 22/2*mm;
barrel_funnel_radius = 0.35;
barrel_funnel_length = 0.5;
/* barrel_fit_length = 1; */
barrel_fit_length = 1;
/* magazine_height = 4.5; */
magazine_height = 1.5;

magazine_front_trapezoid_length = 0.5; // I on diagram
magazine_front_trough_length = 0.085; // J on diagram
magazine_front_behind_trough_length = 0.195 - magazine_front_trough_length; // K on diagram
magazine_front_section_length = magazine_front_trapezoid_length + magazine_front_trough_length + magazine_front_behind_trough_length; // O on diagram
magazine_center_section_length = 1.82; // L on diagram
magazine_rear_trough_length = 0.195; // M on diagram
magazine_rear_trapezoid_length = magazine_front_trapezoid_length; // N on diagram
magazine_rear_section_length = magazine_rear_trough_length + magazine_rear_trapezoid_length; // P on diagram
magazine_trough_trough_distance = 1.925; // Q on diagram
/* magazine_length = 3.2; */
magazine_length = magazine_front_section_length + magazine_center_section_length + magazine_rear_section_length;

magazine_front_rear_width = 0.725; // B,G on diagram
magazine_basic_width = 0.86; // A,D,H on diagram
magazine_trough_width = 0.76; // C,F on diagram
magazine_center_width = 1.025; // E on diagram


magcut_trough_length_gap = 0.02;
magcut_trough_width_gap = 0.01;
magcut_width_gap = 0.01;
magcut_front_trapezoid_length = magazine_front_trapezoid_length + magcut_trough_length_gap; // I on diagram
magcut_front_before_trough_buffer_length = magcut_trough_length_gap; // J on diagram
magcut_front_trough_length = magazine_front_trough_length - 2*magcut_trough_length_gap; // J on diagram
magcut_front_behind_trough_buffer_length = magcut_trough_length_gap; // K on diagram
magcut_front_behind_trough_length = magazine_front_behind_trough_length-magcut_trough_length_gap; // K on diagram
magcut_front_section_length = magcut_front_trapezoid_length + magcut_front_before_trough_buffer_length + magcut_front_trough_length + magcut_front_behind_trough_buffer_length + magcut_front_behind_trough_length; // O on diagram
magcut_center_section_length = magazine_center_section_length + 2*magcut_trough_length_gap; // L on diagram

magcut_rear_before_trough_buffer_length = 0; // J on diagram
magcut_rear_trough_length = magazine_rear_trough_length - 2*magcut_trough_length_gap; // J on diagram
magcut_rear_behind_trough_buffer_length = magcut_trough_length_gap; // K on diagram

/* magcut_rear_trough_length = 0.195 - 2*magcut_trough_length_gap; // M on diagram */
magcut_rear_trapezoid_length = magcut_front_trapezoid_length; // N on diagram
magcut_rear_section_length = magcut_rear_before_trough_buffer_length + magcut_rear_behind_trough_buffer_length + magcut_rear_trough_length + magcut_rear_trapezoid_length; // P on diagram

magcut_trough_trough_distance = 1.925 + 2*magcut_trough_length_gap; // Q on diagram
/* magcut_length = 3.2; */
magcut_length = magcut_front_section_length + magcut_center_section_length + magcut_rear_section_length;

magcut_front_rear_width = magazine_front_rear_width; // B,G on diagram
magcut_basic_width = magazine_basic_width; // A,D,H on diagram
magcut_trough_width = magazine_trough_width + magcut_trough_width_gap*2; // C,F on diagram
magcut_center_width = magazine_center_width; // E on diagram


magwell_front_guide_length = 0.075;
magwell_front_guide_depth = 0;
magwell_front_guide_offset = 0;

magwell_rear_guide_length = 0;
magwell_rear_guide_depth = 0;
magwell_rear_guide_offset = 0;

magwell_hole_length = 3.25;
magwell_hole_width = 1.0;
magwell_hole_front_taper_length = 0.5;
magwell_hole_front_taper_width = 0.725;
magwell_hole_rear_taper_length = 0.5;
magwell_hole_rear_taper_width = 0.725;
magwell_sidewall_thickness = 0.1;
magwell_width = magwell_hole_width + 2*magwell_sidewall_thickness;

/* mag_catch_spring_od = 0.26; */
/* mag_catch_spring_id = 0.20; */
/* mag_catch_spring_loose = 0.4; */
/* mag_catch_spring_tight = 0.125; */
//0.385/0.315 0.75/0.175
mag_catch_spring_od = 0.390;
mag_catch_spring_id = 0.310;
mag_catch_spring_travel = 0.2;
mag_catch_spring_tight = 0.125;
mag_catch_spring_loose = mag_catch_spring_tight + mag_catch_spring_travel;//0.61
/* mag_catch_spring_travel = (mag_catch_spring_loose - mag_catch_spring_tight); */
mag_catch_height = .175;
mag_catch_depth = 0.1;
mag_catch_rod_thickness = 0.19;











mag_c8 = mag_catch_spring_od+2*magwell_sidewall_thickness;
mag_c9 = mag_catch_spring_id;
mag_b2 = mag_c9;
mag_b4 = mag_c8;

/* magwell_rear_assembly_length = magwell_sidewall_thickness + magwell_catch_rod_thickness; // Contains the mag-hold catch and the release button, for example. */
magwell_rear_assembly_length = mag_c8 + 2*magwell_sidewall_thickness; // Contains the mag-hold catch and the release button, for example.
magwell_length = magwell_hole_length + magwell_sidewall_thickness + magwell_rear_assembly_length;
magwell_top_length = magwell_hole_length + 2*magwell_sidewall_thickness;
magwell_length_difference = magwell_length-magwell_top_length;
// bottom should be 3.3 inches below the line of the bolt
/* magwell_height = 3.3 - cy_origin[1]; */


mag_notch_top_to_ridge = 0.95;
//magwell_height = max(mag_notch_top_to_ridge+0.5, 1);
magwell_bottom_height = mag_notch_top_to_ridge + 0.5;
magwell_height_to_bullet_hole = 2.675;
/* magwell_height_over_bullet = 0.25; */
magwell_height_over_bullet = 0;
magwell_height = magwell_height_to_bullet_hole + magwell_height_over_bullet;
magwell_sidewall_height = barrel_funnel_radius;
echo("barrel_funnel_radius:");
echo(barrel_funnel_radius);
magwell_vertical_notch_height = 3.0;
magwell_circle_diameter = barrel_funnel_radius*2;
/* magwell_circle_diameter = 0.7; */
magwell_circle_generous_length = magcut_center_section_length;
/* magwell_circle_generous_length = 1.9; */
mc_buffer = 0.01;

m2_diameter = 2*(1/25.4);
m2_washer_diameter = m2_diameter * 2;
m2_washer_height = 0.5*(1/25.4);
m2_nut_diameter = 4.5*(1/25.4);
m2_nut_height = 1.75*(1/25.4);
m2_head_diameter = 3.75*(1/25.4);
m2_head_height = 2*(1/25.4);

m3_diameter = 3*(1/25.4);
m3_washer_diameter = 6.5*(1/25.4);
m3_washer_height = 0.6*(1/25.4);
m3_nut_diameter = 5.5*(1/25.4);
m3_nut_diagonal = 6.2*(1/25.4);
m3_nut_height = 2.4*(1/25.4);
m3_head_diameter = 5.5*(1/25.4);
m3_head_height = 3*(1/25.4);


mag_catch_active_length = mag_catch_spring_travel*3/4;
mag_c1 = mag_catch_height*3/2;
mag_c2 = mag_c1*.75;
mag_c4 = (1/6)*mag_catch_active_length;
mag_c3 = mag_catch_active_length+magwell_sidewall_thickness + (magcut_center_width-magcut_trough_width)/2 - mag_c4;
mag_c5 = 0;//(mag_c3 + mag_c4)*(1/3);
mag_c6 = magwell_sidewall_thickness + mag_catch_depth;
//mag_c7 = m3_washer_diameter;
mag_c7 = m3_nut_diagonal;
mag_c10 = m3_diameter;
//mag_c11 = m3_nut_height + m3_washer_height;
mag_c13 = magwell_sidewall_thickness;
//mag_c12 = m3_diameter;
mag_c11 = (mag_c3 + mag_c4 + mag_c5 - mag_c13)/2;
mag_c12 = (mag_c3 + mag_c4 + mag_c5 - mag_c13)/2;

mag_b1 = m3_diameter;
mag_b3 = max(m3_head_diameter, m3_washer_diameter)*1.1;
mag_b7 = m3_head_height;
//mag_b5 = magwell_sidewall_thickness;
mag_b6 = mag_catch_spring_travel;
//mag_b6 = 0;
mag_b5 = magwell_width - mag_c11 - mag_c13 - mag_b6;
/* mag_b5 + mag_b6 = magwell_width - mag_c11 - mag_c13 - mag_b7; */
mag_a1 = mag_c6*1.05;
mag_a2 = mag_c8*1.05;
mag_a3 = mag_c3+mag_c4;
mag_a4 = mag_c3+mag_c4+mag_c5;
// a5=
mag_a5 = mag_b5-mag_c12-mag_catch_spring_loose;
mag_a6 = magwell_width-mag_a4-mag_a5;
mag_a7 = mag_a2;
mag_a8 = mag_b2*1.05;
mag_a9 = mag_c1*1.05;

mag_catch_center_height = mag_notch_top_to_ridge - mag_c1/2;
mag_catch_center_height_over_half = mag_catch_center_height - magwell_height/2;

echo("mag_b5:");
echo(mag_b5);
echo("spring wall thickness:");
echo(mag_a5);
echo("spring loose space:");
echo(mag_b5-mag_a5-mag_c12);
echo("spring travel:");
echo(mag_catch_spring_travel);
echo("catch length:");
echo(mag_c3+mag_c4);
echo("button_diameter:");
echo(mag_b4);
echo("mag_c11:");
echo(mag_c11);
echo("mag_c12:");
echo(mag_c12);
echo("mag_c13:");
echo(mag_c13);
echo("shaft_sidewall (in mm):");
echo((mag_b2-mag_b1)/2*25.4);
echo("mag_catch_active_length:");
echo(mag_catch_active_length);
//echo("spring space:");
//echo(mag_b5-mag_c12);
echo("screw length (in mm):");
echo((mag_b5+mag_b6+mag_c11+m3_nut_height+m3_washer_height)*25.4);

/* magwell_height = 2; */

magwell_offset = [cy_translate[0]-cy_length/2-magwell_length/2,-magwell_height/2,0];
magwell_rotation = [-90,0,0];

barrel_feed_diameter = 0;
barrel_feed_length = 0;






safety_06 = (sd_ir - (cy_or-cy_ir))/2;
safety_07 = (1/3)*(sd_or-safety_06);
safety_08 = (2/3)*(sd_or-safety_06);
safety_05 = (3/5)*(safety_06+safety_07+safety_08);
/* safety_09 = safety_catch_length; */
safety_09 = safety_05/3;
safety_catch_length = sd_or-sd_cr;
safety_block_height = safety_06+safety_07+safety_08;

safety_spring_diameter = 0.260;
safety_spring_length_loose = 0.40;
safety_spring_length_tight = 0.125;
safety_spring_block_length = 0.15;
safety_spring_hole_length = safety_spring_length_tight + safety_09 + safety_spring_block_length;
/* safety_spring_block_length = safety_spring_hole_length-safety_09-safety_spring_length_tight; */


safety_01 = safety_catch_length;
safety_02 = safety_catch_length;
safety_03 = safety_spring_hole_length;
safety_04 = safety_spring_diameter;
safety_10 = (1/5)*(safety_06+safety_07+safety_08);
safety_11 = safety_05*1.0;
safety_12 = safety_10;
safety_13 = safety_03;
safety_14 = safety_06;
safety_15 = safety_14;
safety_16 = 0;
safety_17 = safety_block_height-safety_04-safety_16;
safety_18 = (safety_block_height-safety_05)/2;
safety_19 = safety_block_height-safety_05-safety_18;


complainUnless("Safety measurements don't add up properly!!1!", safety_14 + safety_06 == sd_ir - (cy_or-cy_ir));
complainUnless("Safety measurements don't add up properly!!1!", safety_07 + safety_08 + safety_15 == sd_or);


safety_block_length = safety_01+safety_02+safety_13+safety_12+safety_11+safety_10;
sft_ul_x = -1*(safety_block_length+sd_or);
sft_ul_y = cy_translate[1]+cy_origin[1]-cy_or-rc_offset[1]-safety_14;
sft_ll_x = sft_ul_x;
sft_ll_y = sft_ul_y-(safety_06+safety_07+safety_08);
sft_ur_x = sft_ul_x + safety_block_length;
sft_ur_y = sft_ul_y;
sft_lr_x = sft_ur_x;
sft_lr_y = sft_ll_y;

sft_hole_offset = [sft_ur_x-safety_10-safety_11/2,sft_ur_y-safety_18-safety_05/2,0];
sft_hole_radius = (safety_05-$iota)/2;







searOR = 0.5;
searCatchHeight = .1;
searIR = searOR - searCatchHeight;
searCatchAngle = acos(searIR/searOR);
searDiskThickness = 0.25;
searAR = 0.05;

searDiskPushrodAngle = 15;
searDiskPushrodLength = searOR*1.75;

cylinderOR = 0.83;
cylinderWall = 0.14;
cylinderIR = cylinderOR - cylinderWall;

plungerWallGap = 0.02;
plungerWallThickness = 0.1;
plungerSegmentLength = searIR * 2 * sin(searCatchAngle/2);
plungerMiddleSegmentLength = searOR * sin(searCatchAngle);
plungerOR = cylinderIR - plungerWallGap;
plungerMR = plungerOR - searCatchHeight;
plungerIR = plungerMR - plungerWallThickness;

searCatchPivot = [-searIR, -searOR];

triggerPivot = [];


receiverWallThickness = .25;
cylinderOrientation = [0,90,0];
cylinderOrigin = [0, cylinderIR + searIR, 0];
triggerOrigin = [-2, -1.25, 0];
tailPlungerSegmentOrigin = cylinderOrigin + [3*plungerSegmentLength/2,0,0];
rearPlungerSegmentOrigin = cylinderOrigin + [plungerSegmentLength/2,0,0];
middlePlungerSegmentOrigin = cylinderOrigin-[plungerMiddleSegmentLength/2,0,0];
frontPlungerSegmentOrigin = cylinderOrigin-[plungerMiddleSegmentLength+plungerSegmentLength/2,0,0];


triggerCatchAngle = charged ? 0 : 13;
plungerDirection = $charged ? 0 : -1;
safetyPosition = charged ? searDiskThickness*1.5 : 0;
triggerChargeOffset = charged ? [0,0,0] : [.1,0,0];

triggerOffset = triggerOrigin + triggerChargeOffset;
