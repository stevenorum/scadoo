use <../../functions.scad>;
include <../dimensions.scad>;

module cylinderExterior() {
     cylinderAround(cy_or, L=12, O=cy_origin, A=cy_orientation);
};

module cylinder_interior_3d() {
     cylinderAround(cy_ir, L=10+$iota, O=cy_origin, A=cy_orientation);
};

module cylinder_exterior_3d() {
     cylinderAround(cy_or, L=10, O=cy_origin, IR=cy_ir, A=cy_orientation);
};
