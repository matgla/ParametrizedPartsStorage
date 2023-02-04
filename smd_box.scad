wallSize = 0.4;
 /*   translate([holeOffsetX, holeOffsetY, holeOffsetZ])
    rotate([90, 0, 0]) 
    minkowski() {
            $fn=100; 
            cube([holeSizeX, holeSizeZ, holeSizeY]);
            rotate([0, 180, 0]) cylinder(r=boxSpacing, h=boxSpacing);
        }
        
    }*/
module getConnector(dimensions, handle, rounding) {
    translate([(dimensions[0]-handle[0])/2, dimensions[1], 0]) cube([handle[0], handle[1], dimensions[2]]);
    $fn=100; 

    translate([rounding, rounding, 0]) cube([dimensions[0]-2*rounding, dimensions[1]-2*rounding, dimensions[2]]); // ok
    translate([0, rounding, 0]) cube([rounding, dimensions[1] - 2*rounding, dimensions[2]]);//ok
    translate([dimensions[0]-rounding, rounding, 0]) cube([rounding, dimensions[1] - 2*rounding, dimensions[2]]);//ok
    translate([rounding, 0, 0]) cube([dimensions[0] -2*rounding, rounding, dimensions[2]]); // ok
    translate([rounding, dimensions[1]-rounding, 0]) cube([dimensions[0] - 2*rounding, rounding, dimensions[2]]); //ok
    
    translate([rounding, rounding, 0]) cylinder(r=rounding, h=dimensions[2]); // ok
    translate([rounding, dimensions[1] - rounding, 0]) cylinder(r=rounding, h=dimensions[2]); //ok 
    translate([dimensions[0]-rounding, rounding, 0]) cylinder(r=rounding, h=dimensions[2]); // ok
    translate([dimensions[0]-rounding, dimensions[1] - rounding*1, 0]) cylinder(r=rounding, h=dimensions[2]); // ok
}

module getBox(box, floorThickness) {
    difference() {
        cube(box);
        translate([wallSize, wallSize, floorThickness])cube([box[0]-wallSize*2, box[1]-wallSize*2, box[2]]);
    }
    translate([0, box[1]-2, 0]) {
        translate([(box[0]-box[0]/2)/2, 0, 0])cube([box[0]/2, 2, box[2]/2]);
    }
}



translate([3.5, -1.70, 0]) getConnector([3, 1, 4], [1, 0.80], 0.2);
rotate([0, 0, 90]) translate([3.5, -10-1.70, 0]) getConnector([3, 1, 4], [1, 0.80], 0.2);

difference() {
    getBox([10, 10, 10], 0.6);
    translate([3.5, 10-1.6, -0.1]) scale([1.1, 1.1, 1.1])getConnector([3, 1, 4], [1, 0.6], 0.2);
}


