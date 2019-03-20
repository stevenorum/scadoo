use <../functions.scad>;
include <dimensions.scad>;
sf_color = ["orange",1.0];
sd_color = ["yellow",1.0];
sc_color = ["red", 1.0];
ph_color = ["blue",1.0];
tg_color = ["purple",1.0];
rc_color = ["black",0.5];

include <parts/safety.scad>;
include <parts/sear_disk.scad>;
include <parts/sear_catch.scad>;

color(ph_color[0], ph_color[1]) {
    include <parts/plunger.scad>;
};
color(tg_color[0], tg_color[1]) {
    //include <parts/trigger.scad>;
};
//color(rc_color[0], rc_color[1]) {include <parts/receiver.scad>};
include <parts/cylinder.scad>;
