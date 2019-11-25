use <../functions.scad>;
include <dimensions.scad>;
rc_color = ["black",0.5];
rc_color = ["orange",1.0];
sr_color = ["orange",1.0];
sd_color = ["yellow",1.0];
sc_color = ["red", 1.0];
ph_color = ["blue",1.0];
bh_color = ["orange",1.0];
tg_color = ["purple",1.0];
ce_color = ["lime",0.5];
ci_color = ["white",0.2];
mw_color = ["magenta",1.0];

include <parts/new_receiver.scad>;
/*include <parts/sear_disk.scad>;
include <parts/sear_catch.scad>;
include <parts/safety.scad>;
include <parts/trigger.scad>;
include <parts/receiver.scad>;*/
include <parts/plunger.scad>;
include <parts/bolt.scad>;
include <parts/cylinder.scad>;
include <parts/magwell.scad>;
include <parts/muzzle_brake.scad>;

scale([25.4,25.4,25.4]) {
color(mw_color[0], mw_color[1]) {
    //magwell_3d();
    //magwell_3d_raw();
    //magwell_top_3d_raw();
    //magwell_barrel_3d_raw();
    //magwell_catch_3d_raw();
    //mag_catch_3d_sturdy();
    //mag_catch_3d();
    //mag_button_3d();
    //muzzle_brake_3d_raw();
    //magwell_barrel_connector_3d_raw();
};

color(sc_color[0], sc_color[1]) {
    //sear_catch_rod_3d();
     //sear_catch_3d();
};

color(sd_color[0], sd_color[1]) {
     //sear_disk_3d();
};

color(tg_color[0], tg_color[1]) {
     //trigger_3d();
};

color(sr_color[0], sr_color[1]) {
     //safety_3d();
};

color(ph_color[0], ph_color[1]) {
    //plunger_3d();
};

color(bh_color[0], bh_color[1]) {
    //bolt_3d();
};

color(ci_color[0], ci_color[1]){
    //cylinder_interior_3d();
};

color(ce_color[0], ce_color[1]){
    //cylinder_exterior_3d();
    //cylinder_exterior_3d();
};

color(rc_color[0], rc_color[1]) {
 //receiver_right_side();
 //receiver_left_side();
 //receiver_front_cylinder_holder();
 //receiver_rear_cylinder_holder();
};


//receiver_right_side();
//receiver_left_side();
//safety_3d();
color(sd_color[0], sd_color[1]) {
//sear_disk_3d();
};
color(sc_color[0], sc_color[1]) {
//sear_catch_rod_3d();
    };
color(tg_color[0], tg_color[1]) {
    trigger_3d();
};

};





echo("sd_ir - (cy_or-cy_ir):");
echo(sd_ir - (cy_or-cy_ir));
echo("sr_or:");
echo(sr_or);
echo("rc_inner_gap:");
echo(rc_inner_gap);