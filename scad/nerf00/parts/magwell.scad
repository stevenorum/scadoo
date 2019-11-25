use <../../functions.scad>;
include <../dimensions.scad>;

module mag_catch_3d_sturdy() {
    union() {
        cylinderAround(R=mag_c8/2, IR=mag_c7/2, L=mag_c11+mag_c13, O=[0,0,0], center=false, innerFN=6);
        cylinderAround(R=mag_c8/2, IR=mag_c10/2, L=mag_c13, O=[0,0,mag_c11], center=false);
        cylinderAround(R=mag_c8/2, IR=mag_c9/2, L=mag_c12+mag_c13, O=[0,0,mag_c11], center=false);
        tab_length = mag_c6+(mag_c8-mag_c9)/2;
        rect_length = tab_length - magwell_sidewall_thickness;
        dims = [
            mag_c3+mag_c4,
            tab_length,
            mag_c1
            ];
        translate([0,dims[0]/2 + mag_c9/2,dims[0]/2]) {
            rotate([-90,0,0]){
                rotate([0,0,0]) {
                    x1 = dims[2]/2;
                    y1 = dims[0]/2;
                    deepify(dims[1]) {
                        polygon([
                                    [x1,y1],
                                    [x1,y1],
                                    [x1,-y1 + mag_catch_active_length],
                                    [-x1*0.75,-y1],
                                    [-x1,-y1],
                                    [-x1,-y1 + mag_catch_active_length],
                                    [-x1,y1]
                                    ]);
                    };
                    translate([0,0,-magwell_sidewall_thickness/2]){
                        deepify(rect_length) {
                            square([dims[2],dims[0]],center=true);
                        };
                    };
                };};
        };
    };
};

module mag_catch_3d_cylinders() {
    union() {
        cylinderAround(R=mag_c8/2, IR=mag_c7/2, L=mag_c11+mag_c13, O=[0,0,0], center=false, innerFN=6);
        cylinderAround(R=mag_c8/2, IR=mag_c10/2, L=mag_c13, O=[0,0,mag_c11], center=false);
        cylinderAround(R=mag_c8/2, IR=mag_c9/2, L=mag_c12+mag_c13, O=[0,0,mag_c11], center=false);
    };
};

module mag_catch_3d_catch(x_factor=1, y_factor=1, z_factor=1) {
    union() {
        tab_length = mag_c6+(mag_c8-mag_c9)/2;
        rect_length = tab_length - magwell_sidewall_thickness;
        dims = [
            mag_c3+mag_c4,
            tab_length,
            mag_c1
            ];
        translate([0,dims[0]/2 + mag_c9/2,dims[0]/2]) {
            rotate([-90,0,0]){
                rotate([0,0,0]) {
                    x1 = dims[2]/2;
                    y1 = dims[0]/2;
                    x_off = 0;
                    y_off = 0;
                    z_off = tab_length/2-(tab_length-rect_length);
                    e_x = 0.2;
                    e_y = mag_c3+mag_c4-mag_catch_active_length;
                    e_z = 0.25;
                    px1 = x1+x_off;
                    px2 = -x1 + x_off;
                    py1 = -y1 + (mag_catch_active_length*(1-y_factor)) + y_off;
                    py2 = -y1 + mag_catch_active_length+y_off;
                    py3 = py2+e_y;
                    pz1 = z_off-e_z;
                    pz2 = (dims[1]-rect_length)*(1-z_factor)+z_off;
                    pz3 = dims[1]-rect_length+z_off;
                    points = [
                        [px2,py1,pz2],
                        [px2,py1,pz1],
                        [px2,py2,pz3],
                        [px2,py3,pz3],
                        [px2,py3,pz1],
                        [px1,py2,pz2],
                        [px1,py2,pz1],
                        [px1,py3,pz2],
                        [px1,py3,pz1]
                        ];
                    faces = [
                        [0,1,4,3,2],
                        [0,2,5],
                        [0,5,6,1],
                        [2,3,7,5],
                        [5,7,8,6],
                        [3,4,8,7],
                        [1,6,8,4]
                        ];
                    polyhedron(points=points, faces=faces, convexity=10);
                };
            };
        };
    };
};



module mag_catch_3d_smooth() {
    union() {
        mag_catch_3d_catch();
        mag_catch_3d_cylinders();
    };
};

module mag_catch_3d() {
    mag_catch_3d_sturdy();
};

module mag_button_3d() {
    union() {
        cylinderAround(R=mag_b4/2, IR=mag_b3/2, L=mag_b7, O=[0,0,0], center=false);
        cylinderAround(R=mag_b4/2, IR=mag_b1/2, R2=(0.9)*mag_b4/2, IR2=mag_b1/2, L=mag_b6, O=[0,0,mag_b7], center=false);
        cylinderAround(R=mag_b2/2, IR=mag_b1/2, L=mag_b5+mag_b6, O=[0,0,mag_b7], center=false);
    };
};

module magwell_barrel_connector_3d_raw() {
    union() {
        x0 = -(magwell_length/2-magwell_sidewall_thickness);
        y0 = 0;
        z0 = magwell_height/2+barrel_funnel_radius;
        cylinderAround(
            /* R=magwell_sidewall_thickness+barrel_funnel_radius, */
            R=magwell_width/2,
            IR=barrel_innerRadius,
            R2=magwell_width/2,
            IR2=barrel_funnel_radius,
            L=barrel_funnel_length,
            O=[-(magwell_length/2+barrel_funnel_length-magwell_sidewall_thickness),y0,z0],
            A=[0,90,0], center=false);
        cylinderAround(
            /* R2=barrel_funnel_radius+magwell_sidewall_thickness, */
            R2=magwell_width/2,
            R=barrel_innerFitRadius+magwell_sidewall_thickness,
            IR=barrel_innerFitRadius,
            L=barrel_fit_length,
            O=[-(magwell_length/2+barrel_funnel_length+barrel_fit_length-magwell_sidewall_thickness),y0,z0],
            A=[0,90,0], center=false);
        cylinderAround(
            R=barrel_innerFitRadius+magwell_sidewall_thickness,
            IR=barrel_innerFitRadius,
            R2=magwell_width/2,
            IR2=barrel_funnel_radius,
            L=barrel_fit_length+barrel_funnel_length,
            O=[-(magwell_length/2+barrel_funnel_length+barrel_fit_length-magwell_sidewall_thickness),y0,z0],
            A=[0,90,0], center=false);
        support_height = magwell_width;
        difference() {
            union() {
                translate([-magwell_length/2+magwell_sidewall_thickness,0,magwell_height/2-magwell_width+barrel_funnel_radius]) {
                    rotate([-90,90,0]) {
                        deepify(magwell_width) {
                            polygon([
                                        [0,0],
                                        [-support_height,0],
                                        [-support_height,barrel_funnel_length],
                                        [0,barrel_funnel_length],
                                        [magwell_width,0]
                                        ]);
                        };
                    };
                };
                /* pull(support_height, liftby=(magwell_height/2-magwell_width+barrel_funnel_radius)) { */
                /*     rectangleRelative(x0,y0-magwell_width/2,-barrel_funnel_length,magwell_width); */
                /* }; */
            };
            union() {
                cylinderAround(
                    R=barrel_innerRadius,
                    R2=barrel_funnel_radius,
                    L=barrel_funnel_length,
                    O=[-(magwell_length/2+barrel_funnel_length-magwell_sidewall_thickness),y0,z0],
                    A=[0,90,0], center=false);
            };
        };
    };
};

module magwell_3d_raw() {
    difference() {
        union() {
            magwell_barrel_connector_3d_raw();
            translate([-(magwell_length-magwell_top_length)/2,0,0]) {
                deepify(magwell_height) {
                    square([magwell_top_length, magwell_width], center=true);
                };
                /* pull(magwell_sidewall_height, liftby=magwell_height/2) { */
                /*     difference() { */
                /*         square([magwell_top_length, magwell_width], center=true); */
                /*         union() { */
                /*         square([magwell_top_length, magwell_circle_diameter], center=true); */
                /*         square([magwell_circle_generous_length, magwell_width], center=true); */
                        
                /*         }; */
                /*     }; */
                /* }; */
            };
            translate([0,0,-(magwell_height-magwell_bottom_height)/2]) {
                deepify(magwell_bottom_height) {
                    square([magwell_length, magwell_width], center=true);
                };
            };
            /* translate([0,0,0]) { */
            /*     deepify(magwell_height) { */
            /*         square([magwell_length, rc_inner_gap], center=true); */
            /*     }; */
            /* }; */
            x0=-magwell_length/2;
            y0=magwell_width/2;
            /* z0=magwell_height/2-magwell_height_over_bullet; */
            z0=magwell_height/2;
            pull(magwell_sidewall_height + magwell_height_over_bullet, liftby=z0) {
                rectangleRelative(x0,y0,magwell_top_length, -magwell_sidewall_thickness);
                rectangleRelative(x0,-y0,magwell_top_length, magwell_sidewall_thickness);
            };
            /* mag_cover_origin = [-(magwell_length/2+barrel_funnel_length+barrel_fit_length-magwell_sidewall_thickness),y0,z0]; */
            mag_cover_origin = [0,0,z0+barrel_funnel_radius];
/* mag_cover_origin = [0,0,z0]; */
            translate(mag_cover_origin) {
            difference() {
                union() {
                    /* cylinderAround( */
                    /*     R=magwell_width/2, */
                    /*     IR=magwell_width/2-magwell_sidewall_thickness, */
                    /*     L=magwell_top_length,O=[-(magwell_length-magwell_top_length)/2,0,0], */
                    /*     A=[0,90,0], center=true); */
                    bump_length = (magwell_top_length-magwell_circle_generous_length)/2;
                    cylinderAround(
                        R=magwell_width/2,
                        IR=barrel_funnel_radius,
                        L=bump_length,
                        /* O=[-(magwell_length-magwell_top_length)/2,0,0], */
                        O=[-bump_length/2 + 2*(magwell_length-magwell_top_length),0,0],
                        A=[0,90,0], center=true);
                    cylinderAround(
                        R=magwell_width/2,
                        IR=barrel_funnel_radius,
                        L=bump_length,
                        /* O=[-(magwell_length-magwell_top_length)/2,0,0], */
                        O=[
                            bump_length/2 - magwell_length/2,
                            ,0,0],
                        A=[0,90,0], center=true);
                };
                union() {
                    pull(-magwell_width/2) {
                        square([magwell_length,magwell_width], center=true);
                    };
                };
            };
            };
        };
        union() {
            translate([magwell_length/2-magwell_sidewall_thickness-mag_a7/2,0,mag_catch_center_height_over_half]) {
                cylinderAround(R=mag_a8/2, L=magwell_width, O=[0,0,0], A=[90,0,0], center=true);
                cylinderAround(R=mag_a2/2, L=mag_a4, O=[0,-1*(magwell_width/2-mag_a4/2),0], A=[90,0,0], center=true);
                cylinderAround(R=mag_a7/2, L=mag_a6, O=[0,(magwell_width/2-mag_a6/2),0], A=[90,0,0], center=true);
                deepify(mag_a9) {
                    mag_tl = mag_a1 + mag_a2/2;
                    translate([-mag_tl/2,(mag_a3/2-magwell_width/2),0]) {
                        square([mag_tl, mag_a3], center=true);
                    };
                };
            };
            deepify(magwell_height) {
                sections = [
                    [magcut_front_rear_width],
                    magcut_front_trapezoid_length,
                    [magcut_basic_width],
                    magcut_front_before_trough_buffer_length,
                    [magcut_trough_width],
                    magcut_front_trough_length,
                    [magcut_trough_width],
                    magcut_front_behind_trough_buffer_length,
                    [magcut_basic_width],
                    magcut_front_behind_trough_length,
                    [magcut_basic_width],
                    0,
                    [magcut_center_width],
                    magcut_center_section_length,
                    [magcut_center_width],
                    0,
                    [magcut_basic_width],
                    magcut_rear_before_trough_buffer_length,
                    [magcut_trough_width],
                    magcut_rear_trough_length,
                    [magcut_trough_width],
                    magcut_rear_behind_trough_buffer_length,
                    [magcut_basic_width],
                    magcut_rear_trapezoid_length,
                    [magcut_front_rear_width]
                    ];
                /* translate([(magwell_sidewall_thickness-magwell_rear_assembly_length)/2,0,0]) { */
                translate([(magwell_sidewall_thickness-magwell_rear_assembly_length)/2 - magcut_length/2,0,0]) {
                    linear_mirrored(sections=sections);
                };
            };
        };
    };
};

module magwell_catch_3d_raw() {
    difference() {
        union() {
            magwell_3d_raw();
        };
        union() {
            translate([-(magwell_rear_assembly_length+magcut_rear_section_length+magcut_center_section_length/4),0,0]) {
                deepify(magwell_height) {
                    square([magwell_length, magwell_width], center=true);
                };
            };
        };
    };
};

module magwell_top_3d_raw() {
    difference() {
        union() {
            magwell_3d_raw();
        };
        union() {
            pull(magwell_height, liftby=-1*(magwell_height/2 + magwell_width/2)) {
                square([magwell_length*2, magwell_width], center=true);
            };
        };
    };
};

module magwell_barrel_3d_raw() {
    difference() {
        union() {
            magwell_3d_raw();
        };
        union() {
            /* x_offset = -(magwell_rear_assembly_length+magcut_rear_section_length+magcut_center_section_length/4); */
            x_offset = (magcut_front_section_length + magwell_sidewall_thickness + magcut_center_section_length/6);
            translate([x_offset,0,0]) {
                deepify(magwell_height*2) {
                    square([magwell_length, magwell_width], center=true);
                };
            };
        };
    };
};

module magwell_3d() {
    translate(magwell_offset) {
        rotate(magwell_rotation) {
            magwell_3d_raw();
        };
    };
};
