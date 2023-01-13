createStorage = false;
createBox = true;
boxOffset = 20;
blockerOffset = 4;
blockerRadius = 0.7;

module createStorage(slot_clearance) {
    slot_width = 15 + slot_clearance;
    slot_height = 10 + slot_clearance;
    slot_wall = 0.8;
    slot_length = 120;
    top_height = 2;
    bottom_height = 2;
    lock_offset = 2;
    back_height = 0.4 * slot_height;
    back_width= 0.5 * slot_width;
    round_radius = 2;
    slots_x = 10;
    slots_z = 5;
    for (z = [0 : slots_z - 1]) {
    for (x = [0 : slots_x - 1]) {
        translate([0, x * (slot_width+slot_wall), z * (slot_height + 2*slot_wall)]) {
            difference() {
                cube([slot_length + slot_wall, slot_width + slot_wall * 2, slot_height + slot_wall * 2]);
                translate([-0.001, slot_wall, slot_wall]) 
                    cube([slot_length, slot_width, slot_height]);
                translate([lock_offset, slot_wall, slot_wall + slot_wall/2])
                rotate([-90, 0, 0])
                    difference() {
                        $fn=100; 
                        cylinder(slot_width, slot_wall, slot_wall);
                    }
                    
                translate([lock_offset+10, slot_wall, slot_height + slot_wall - slot_wall/2])
                rotate([-90, 0, 0])
                    difference() {
                        $fn=100; 
                        cylinder(slot_width, slot_wall, slot_wall);
                    }
                translate([slot_length-slot_wall/2, (slot_width - back_width) / 2 + slot_wall, back_height + (slot_height-back_height) / 2 + slot_wall]) {
                    rotate([0, 90, 0])
                    minkowski() { 
                        $fn=100; 
                        cube([back_height, back_width, slot_wall*2]);
                        cylinder(r=round_radius, h=slot_wall);
                    }
                }
            }
        }
    }
}
}

module createStoragePart(boxDimensions, boxSpacing, trayOffset) {
    translate([0, 0, 0]) difference() {
        cube([boxDimensions[0] + boxSpacing * 2, boxDimensions[1] + boxSpacing * 2, boxDimensions[2] + boxSpacing * 2
        ]);
        translate([boxSpacing-trayOffset, -boxSpacing + trayOffset, boxSpacing - trayOffset]) cube([boxDimensions[0] + trayOffset*2, boxDimensions[1] + trayOffset*2, boxDimensions[2] + trayOffset*2]);

        holeSizeX = boxDimensions[0] * 0.7;
        holeOffsetX = (boxDimensions[0] - holeSizeX) / 2 + boxSpacing-trayOffset;
        holeSizeZ = boxDimensions[2] * 0.5;
        holeOffsetZ = (boxDimensions[2] - holeSizeZ + 3) / 2 + boxSpacing - trayOffset;

    translate([holeOffsetX, boxDimensions[1]-boxSpacing-0.1, holeOffsetZ])
    rotate([90, 0, 0]) 
    minkowski() {
            $fn=100; 
            cube([holeSizeX, boxSpacing*4, holeSizeZ]);
            rotate([0, 180, 0]) cylinder(r=boxSpacing*2, h=boxSpacing*4);
        }
        
    }

}

module createBox(boxDimensions, boxSpacing, roundRadius, handleLength, handleThickness, trayOffset) {
    $box = boxDimensions;
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
        translate([-boxSpacing, 0, -boxSpacing]) createStoragePart(boxDimensions, boxSpacing, trayOffset);
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


faceHuge = 50;
faceMedium = 25;
hugeBoxDimensions = [faceHuge, 180, 18];
mediumBoxDimensions = [faceMedium, 180, 18];

slotVgaDimensions = [46, 34, 18];
slotSdDimensions = [32, 32, 18];
slotSmallDimensions = [10, 8, 10];
slotSmallDimensions2 = [10, 20, 10];
slotSmallDimensions3 = [4, 4, 10];

smallBox = [15, 180, 15];
smallTray = [6, 6, 6];

spacing = 1.6;
offset = 0.4;

slot25x30x18 = [25, 30, 18];

trayLength = 180;
line0Height = 18;

slotHeight = 17.2;

/*createBox(boxDimensions, boxSpacing, roundRadius, handleLength, handleThickness, trayOffset) */
/*module createSlots(slot_dimensions, slots_rows, slots_columns, wall, offs) {*/


createLine(2, 0, [0, 36, 36, 32, 32, 32], 67) {
    createBox([12.2, 66.2, 12.2], 1.6, 2, 5, 1.2, 0) {
        createSlots([11, 65, 11], 1, 1, 0.3, 0);
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
