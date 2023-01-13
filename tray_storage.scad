createStorage = true;
createBox = false;
boxOffset = 20;
blockerOffset = 4;
blockerRadius = 0.7;

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

spacing = 1.6;
offset = 0.4;

line0Height = 18;

slotWidth = 11;
slotHeight = 11;
slotLength = 65;
wallSize = 0.6;
slotsRows = 1;
slotsColumns = 1;
handleLength = 5;
handleThickness = 1.2;
roundRadius = 1;
traySpacing = 0.4;
/*createBox(boxDimensions, boxSpacing, roundRadius, handleLength, handleThickness, trayOffset) */
/*module createSlots(slot_dimensions, slots_rows, slots_columns, wall, offs) {*/

rotate([180, 0, 90]) {
createLine(wallSize * 3, 0, [0], slotLength + 4 * wallSize) {
    createBox([slotWidth + 2 * wallSize, slotLength + wallSize * 2, slotHeight + wallSize * 2], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([slotWidth, slotLength, slotHeight], slotsRows, slotsColumns, 0.3, 0);
    }
}
/*    createBox([36, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([32, 43, slotHeight], 4, 1, 0.8, 0);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 25, slotHeight], 6, 1, 0.8, 0);
        createSlots([30, 20, slotHeight], 1, 1, 0.8, -155);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 25, slotHeight], 6, 1, 0.8, 0);
        createSlots([30, 20, slotHeight], 1, 1, 0.8, -155);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 47, slotHeight], 3, 1, 0.8, 0);
        createSlots([30, 30, slotHeight], 1, 1, 0.8, -144);
    }
}
/*
createLine(2, -(18 + spacing + 0.4), [0, 36, 36, 32, 32, 32], trayLength) {
    createBox([36, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([16, 32, 18], 5, 2, 0.8, 0);
        createSlots([32, 10, 18], 1, 1, 0.8, -165);
    }
    createBox([36, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([32, 43, 18], 4, 1, 0.8, 0);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 25, 18], 6, 1, 0.8, 0);
        createSlots([30, 20, 18], 1, 1, 0.8, -155);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 25, 18], 6, 1, 0.8, 0);
        createSlots([30, 20, 18], 1, 1, 0.8, -155);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 47, 18], 3, 1, 0.8, 0);
        createSlots([30, 30, 18], 1, 1, 0.8, -144);
    }
}

createLine(2, -2*(18 + spacing + 0.4), [0, 36, 36, 32, 32, 32], trayLength) {
    createBox([36, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([16, 32, 18], 5, 2, 0.8, 0);
        createSlots([32, 10, 18], 1, 1, 0.8, -165);
    }
    createBox([36, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([32, 43, 18], 4, 1, 0.8, 0);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 25, 18], 6, 1, 0.8, 0);
        createSlots([30, 20, 18], 1, 1, 0.8, -155);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 25, 18], 6, 1, 0.8, 0);
        createSlots([30, 20, 18], 1, 1, 0.8, -155);
    }
    createBox([32, trayLength, 18], 1.6, 4, 8, 1.6, 0.4) {
        createSlots([30, 47, 18], 3, 1, 0.8, 0);
        createSlots([30, 30, 18], 1, 1, 0.8, -144);
    }
}
*/
}