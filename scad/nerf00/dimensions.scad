charged = true;
$charged = true;
//$charged = false;
//$charged = ($t % 2 == 0);


// Sear disk dimensions
// sd_???
// radii (sd_?r)
sd_or = 0.5; // face outer radius
sd_ir = 0.4; // face inner radius
sd_ar = 0.05; // axle radius
// dependent
sd_pr = sd_or*1.5; // pushrod radius
sd_cr = sd_ir/1.25; // catch radius
// angles (sd_?a)
// Order (clockwise from top): fa, fta, sa, spa, pa, pca, ca
sd_fa = acos(sd_ir/sd_or); // face angle
sd_pa = 25; // pushrod angle
sd_ca = 85; // catch angle
// dependent
sd_fta = 90 - sd_fa; // face trailing angle
sd_tpa = 180-(sd_fa+sd_fta); // trail-to-pushrod angle
sd_pca = 180-(sd_ca+sd_pa); // pushrod-to-catch angle

complainUnless("The sear disk angles do not add up to 360!!1!", (sd_fa+sd_fta+sd_tpa+sd_pa+sd_pca+sd_ca) == 360);

sd_rotation = [0, 0, $charged ? 0 : sd_fa];
sd_thickness = 0.25;
sd_offset = [0,0,0];

// Sear catch dimensions
// sc_???
sc_ufh = sd_or; // upper front height
sc_lfh = sd_or*0.8; // lower front height
sc_urh = sd_or*0.8; // upper rear height
sc_lrh = sc_ufh + sc_lfh - sc_urh; // lower rear height
sc_lfw = sd_or*0.3; // lower front width
sc_lrw = sd_or*0.4; // lower rear width
sc_ufw = sd_or*0.5; // upper front width
sc_urw = sd_or*0.2; // upper rear width
sc_ar = .02; // axle radius
sc_ah = sc_urw + sc_ar; // axle horizontal offset
sc_av = sc_ufh - sc_urh; // axle vertical offset
sc_co = sc_ufw/3; // catch overlap - how much of the catch contacts the sear disk.

sc_ax = sc_lfw + sc_lrw - sc_ah; // (relative) axle x coordinate
sc_ay = sc_ufh - sc_urh - sc_av; // (relative) axle y coordinate

sc_offset = [-(sd_or + sc_ufw - sc_co),-sc_ufh,0];
sc_rotation = $charged ? 0 : 13;

complainUnless("Front and rear heights of the sear catch do not match!!1!",sc_ufh+sc_lfh == sc_lrh+sc_urh);

// Safety rod dimensions
// sr_???
sr_or = sc_co * 2; // safety rod outer radius
sr_length = 3;
sr_offset = [sc_offset[0]-sr_or, -1.5*sr_or, 0];
sr_rotation = [0, 0, $charged ? 0 : 90];

// plunger dimensions
// ph_??

// trigger dimensions
// tg_???

// receiver dimensions
// rc_???

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



module safetyOutline() {
     union() {
          arc(sf_or, sf_ta, sf_ba, IR=sf_sr);
          arc(sf_or, sf_da, sf_ba, IR=sf_dr);
     };
};
