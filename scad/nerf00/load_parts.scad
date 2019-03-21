use <../functions.scad>;
include <dimensions.scad>;
sr_color = ["orange",1.0];
sd_color = ["yellow",1.0];
sc_color = ["red", 1.0];
ph_color = ["blue",1.0];
tg_color = ["purple",1.0];
rc_color = ["black",0.5];

include <parts/sear_disk.scad>;
include <parts/sear_catch.scad>;
include <parts/safety.scad>;

include <parts/plunger.scad>;
include <parts/trigger.scad>;
//include <parts/receiver.scad>;
include <parts/cylinder.scad>;
