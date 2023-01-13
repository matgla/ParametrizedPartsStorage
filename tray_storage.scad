

module createStoragePart(boxDimensions, trayOffset, wallSize) {
    boxSpacing = wallSize * 2;
    xSize = boxDimensions[0] + boxSpacing * 2;
    ySize = boxDimensions[1] + boxSpacing;
    zSize = boxDimensions[2] + boxSpacing * 2;
    translate([0, 0, 0]) difference() {
        cube([xSize, ySize, zSize]);
        translate([boxSpacing-trayOffset, -boxSpacing + trayOffset, boxSpacing - trayOffset]) cube([boxDimensions[0] + trayOffset*2, boxDimensions[1] + trayOffset*2, boxDimensions[2] + trayOffset*2]);

        holeSizeX = xSize * 0.5;
        holeOffsetX = (xSize - holeSizeX) / 2;
        holeSizeZ = zSize * 0.5;
        holeOffsetZ = (zSize - holeSizeZ) / 2;
        holeSizeY = ySize;
        holeOffsetY = ySize;

    translate([holeOffsetX, holeOffsetY, holeOffsetZ])
    rotate([90, 0, 0]) 
    minkowski() {
            $fn=100; 
            cube([holeSizeX, holeSizeZ, holeSizeY]);
            rotate([0, 180, 0]) cylinder(r=boxSpacing, h=boxSpacing);
        }
        
    }

}

module createBox(boxDimensions, roundRadius, handleLength, handleThickness, trayOffset, wallSize) {
    $box = boxDimensions;
    boxSpacing = wallSize * 2;
    if (createBox)
    {
        difference() {
            translate([0, 0, 0]) {
            // Draw handle
                translate([roundRadius, -handleLength + roundRadius, boxDimensions[2] - handleThickness]) {
                    $fn=100;
                    minkowski() {
                        cube([boxDimensions[0] - roundRadius * 2, handleLength-roundRadius, handleThickness-0.1]);
                        cylinder(r=roundRadius, h=0.1);
                    }
                }
                cube(boxDimensions);
                $fn=100; 
                blockerTrim = boxDimensions[2] * 0.4;
                blockerLength = boxDimensions[2]-blockerTrim;
                
                for (i = [0 : 1]) {
                    translate([i * boxDimensions[0], blockerOffset, blockerTrim/2]) sphere(blockerRadius);
                    translate([i * boxDimensions[0], blockerOffset, blockerLength+blockerTrim/2]) sphere(blockerRadius);
                    translate([i * boxDimensions[0], blockerOffset, blockerTrim/2]) cylinder(blockerLength, blockerRadius, blockerRadius);
                }
            }
            for (i = [0 : $children - 1]) {
                children(i);
            }
        }
    }
  
    if (createStorage) {
        translate([-boxSpacing, 0, -boxSpacing]) createStoragePart(boxDimensions, trayOffset, wallSize);
    }

}

module createSlots(slot_dimensions, slots_rows, slots_columns, wall, offs) {
    side_wall = ($box[0] - slot_dimensions[0] * (slots_columns)) / (slots_columns + 1);
    slots_length = (slot_dimensions[1] + wall) * slots_rows;
    slots_offset = $box[1] - slots_length - 2 * wall;
    for (y = [0:slots_columns-1]) {
        for (x = [0:slots_rows-1]) {
            translate([side_wall + (side_wall + slot_dimensions[0]) * y, slots_offset + wall + (wall+slot_dimensions[1]) * x + offs, -0.01]) {
                 cube(slot_dimensions);
            }
        }
    }
}

function partialSum(arg, start, end) = start != end ? arg[start] + partialSum(arg, start + 1, end) : arg[start]; 

module createLine(spacing, line_height, faces, boxLength) {
    childrenSize = $children - 1;
    for (i = [0 : childrenSize]) {

        translate([partialSum(faces, 0, i) + i * spacing + i * boxOffset, 0, line_height]) 
            children(i);
        
    }
}
