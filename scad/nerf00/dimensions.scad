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
sd_sr = sd_ir/1.5; // safety radius
sd_pr = sd_or*1.5; // pushrod radius
sd_cr = sd_ir/1.25; // catch radius
// angles (sd_?a)
// Order (clockwise from top): fa, fta, sa, spa, pa, pca, ca
sd_fa = acos(sd_ir/sd_or); // face angle
sd_pa = 20; // pushrod angle
sd_ca = 85; // catch angle
sd_sa = 20; // safety angle
// dependent
sd_fta = 90 - sd_fa; // face trailing angle
sd_spa = 180-(sd_fa+sd_fta+sd_sa); // safety-to-pushrod angle
sd_pca = 180-(sd_ca+sd_pa); // pushrod-to-catch angle

complainUnless("The sear disk angles do not add up to 360!!1!", (sd_fa+sd_fta+sd_sa+sd_spa+sd_pa+sd_pca+sd_ca) == 360);

sd_rotation = [0, 0, $charged ? 0 : sd_fa];
sd_thickness = 0.25;
sd_offset = [0,0,0];

// Safety dimensions
// sf_???
// radii (sf_?r)
sf_gr = (sd_or-sd_sr)/10; // safety gap radius - a small margin to make it easier to engage
sf_or = sd_or + 0.25; // safety outer radius
sf_sr = sd_or; // safety support inner radius
sf_dr = sd_sr + sf_gr; // safety disk inner radius
// angles (sf_?a)
sf_ga = 3; // safety gap angle - a small margin to make it easier to engage
sf_sa = 30; // safety support angle
sf_ba = sd_fa + sd_fta + sf_ga; // safety beginning angle
sf_da = sd_sa - 2*sf_ga; // safety disk angle
sf_ta = sf_da + sf_sa; // safety total angle
// other dimensions
sf_nd = sd_thickness * 1.05; // safety notch dimension - width of the slot through which the sear disk turns when the safety is off
sf_td = 3; // 
sf_offset = [0, 0, $charged ? sf_nd : 0];

// Sear catch dimensions
// sc_???
sc_ufh = sd_or; // upper front height
sc_lfh = sd_or*0.9; // lower front height
sc_urh = sd_or*0.8; // upper rear height
sc_lrh = sc_ufh + sc_lfh - sc_urh; // lower rear height
sc_lfw = sd_or*0.2; // lower front width
sc_lrw = sd_or*0.5; // lower rear width
sc_ufw = sd_or*0.5; // upper front width
sc_urw = sd_or*0.2; // upper rear width
sc_ar = .02; // axle radius
sc_ah = sc_urw + sc_ar; // axle horizontal offset
sc_av = sc_ufh - sc_urh; // axle vertical offset

sc_ax = sc_lfw + sc_lrw - sc_ah; // (relative) axle x coordinate
sc_ay = sc_ufh - sc_urh - sc_av; // (relative) axle y coordinate

sc_offset = [-(sd_or + sc_ufw/2),-sc_ufh,0];
sc_rotation = $charged ? 0 : 13;

complainUnless("Front and rear heights of the sear catch do not match!!1!",sc_ufh+sc_lfh == sc_lrh+sc_urh);

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
