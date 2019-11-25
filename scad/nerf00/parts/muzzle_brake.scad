use <../../functions.scad>;
include <../dimensions.scad>;

module muzzle_brake_3d_raw() {
    difference() {
        union() {
            cylinderAround(brake_outerRadius, brake_totalLength, O=[0,0,0], IR=brake_innerFitRadius);
            cylinderAround(brake_outerRadius, 1, O=[0,0,1/2], IR=brake_innerRadius, R2=brake_outerRadius);
        };
        union() {
            brakeRadius = 2.5*mm;
            /* cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,-1/8], A=[0,90,0]); */
            /* cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,-1/8], A=[60,90,0]); */
            /* cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,-1/8], A=[120,90,0]); */
            /* cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,-2.7*1/8], A=[30,90,0]); */
            /* cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,-2.7*1/8], A=[90,90,0]); */
            /* cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,-2.7*1/8], A=[150,90,0]); */
            
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,1/4], A=[0,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,1/4], A=[60,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,1/4], A=[120,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,2*1/4], A=[30,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,2*1/4], A=[90,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,2*1/4], A=[150,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,3*1/4], A=[0,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,3*1/4], A=[60,90,0]);
            cylinderAround(brakeRadius, brake_outerFrontRadius*3, O=[0,0,3*1/4], A=[120,90,0]);
        };
    };
};
