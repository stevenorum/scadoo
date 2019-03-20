union() {
     deepify(2) {
          rectangle(-3, cylinderOrigin[1]+cylinderOR, 1.5, cylinderOrigin[1]+cylinderOR+receiverWallThickness);
     };
     difference() {
          deepify(2) {
               rectangle(1.25, cylinderOrigin[1]-cylinderOR-receiverWallThickness, 1.5, cylinderOrigin[1]+cylinderOR+receiverWallThickness);
               rectangle(-3, cylinderOrigin[1]-cylinderOR-receiverWallThickness, -2.75, cylinderOrigin[1]+cylinderOR+receiverWallThickness);
          };
          union() {
               cylinderAround(cylinderOR, L=10, O=cylinderOrigin, A=cylinderOrientation);
          };
     };
     translate([0,0,searDiskThickness/2 + receiverWallThickness/2]) {
          deepify(receiverWallThickness) {
               difference() {
                    union() {
                         rectangle(-4, -2, 2, cylinderOrigin[1]-cylinderOR);
                    };
                    union() {
                         // safety hole
                         safetyOutline();
                         // sear disk axle
                         circle(searAR, $fn=24);
                         // sear catch axle
                         circleXY(searAR, searCatchPivot[0], searCatchPivot[1]);
                         translate(triggerOrigin) {
                              // trigger top guide hole - need to add guide rod
                              rectangle(-.5,.525,-.25,.65);
                              rectangle(0.25,.525,.5,.65);
                              // trigger bottom guide hole - need to add guide rod
                              rectangle(0.75, .25, 1, .375);
                         };
                    };
               };
          };
     };
};
