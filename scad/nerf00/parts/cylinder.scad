// CYLINDER - will actually be PVC.
//color("white", alpha=0.2){ // Cylinder interior
//     cylinderAround(cylinderIR, L=10, O=cylinderOrigin, A=cylinderOrientation);
//};

color("lime", alpha=0.5){ // Cylinder exterior
     cylinderAround(cylinderOR, L=10, O=cylinderOrigin, IR=cylinderIR, A=cylinderOrientation);
};
