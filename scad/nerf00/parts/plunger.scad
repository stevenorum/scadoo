translate([plungerDirection*plungerSegmentLength,0,0]) {
     difference() {
          union() {
               cylinderAround(plungerMR, L=plungerSegmentLength, O=tailPlungerSegmentOrigin, A=cylinderOrientation, IR=plungerIR);
               cylinderAround(plungerOR, L=plungerSegmentLength, O=rearPlungerSegmentOrigin, A=cylinderOrientation, IR=plungerIR);
               cylinderAround(plungerMR, L=plungerMiddleSegmentLength, O=middlePlungerSegmentOrigin, A=cylinderOrientation, IR=plungerIR);
               cylinderAround(plungerOR, L=plungerSegmentLength, O=frontPlungerSegmentOrigin, A=cylinderOrientation);
          };
          union() {
               // O-ring grooves
               cylinderAround(plungerOR+plungerWallGap, L=2*plungerWallGap, O=rearPlungerSegmentOrigin, A=cylinderOrientation, IR=plungerOR-plungerWallGap);
               cylinderAround(plungerOR+plungerWallGap, L=2*plungerWallGap, O=frontPlungerSegmentOrigin, A=cylinderOrientation, IR=plungerOR-plungerWallGap);
          };
     };
};
