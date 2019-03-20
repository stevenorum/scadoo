deepify(searDiskThickness) {
     translate(triggerOffset) {
          union() {
               difference() {
                    union() {
                         arc(0.6, 180, IR=0.4);
                         rectangle(0,0,1,.5);
                         rectangle(-1,.25,1,.75);
                         rectangle(0.25, 0, 1.45, .5);
                    };
                    union() {
                         arc(0.4, 360); // Not needed for the trigger arc, but necessary to cut off some rectangle bits.
                         arc(.5, 180, IR=.25, X=1.2, Y=.25);
                         rectangle(0,0,-2, .4);
                         rectangle(-.75,.525,.75,.65);
                         rectangle(0.5, .25, 1.25, .375);
                    };
               };
          };
     };
};
