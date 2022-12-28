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

module createBox(boxDimensions, boxSpacing, roundRadius, handleLength, handleThickness) {
    for (i = [0 : $children - 1]) {
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
            }
            $previousSize = [0, 0, 0];
            translate([0, ($previousSize[1] + boxSpacing) * i, 0]) children(i);
            echo($previousSize);
        }
    }
}

module createSlots(box_dimensions, slot_dimensions, slots_rows, slots_columns, wall, handle_thickness, handle_length, round_radius) {
    side_wall = (box_dimensions[0] - slot_dimensions[0] * (slots_columns)) / (slots_columns + 1);
    slots_length = (slot_dimensions[1] + wall) * slots_rows;
    slots_offset = box_dimensions[1] - slots_length - 2 * wall;
    echo ($previousSize)
    for (y = [0:slots_columns-1]) {
        for (x = [0:slots_rows-1]) {
            translate([side_wall + (side_wall + slot_dimensions[0]) * y, slots_offset + wall + (wall+slot_dimensions[1]) * x, -0.01]) {
                 cube(slot_dimensions);
            }
        }
    }
    $previousSize = slot_dimensions;
}

module createLine(spacing, line_height, faces) {
    $childWidth = 10;
    nextPositionX = 0;
    for (i = [0 : $children - 1]) {
        translate([nextPositionX, 0, line_height]) {
            children(i);
            echo("Child with in parent: ", $childWidth);
            nextPositionX = nextPositionX + $childWidth + spacing;
        }
        echo("Next position: ", nextPositionX);
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

createLine(2, 1.8) {
    createBox(hugeBoxDimensions, 1.6, 4, 15, 1.6) {
        createSlots(hugeBoxDimensions, slotVgaDimensions, 5, 1, 0.8, 1.6, 15, 4);
    }
    createBox(hugeBoxDimensions, 1.6, 4, 15, 1.6) {
        createSlots(hugeBoxDimensions, slotSdDimensions, 5, 1, 0.8, 1.6, 15, 4);
    }
    createBox(mediumBoxDimensions, 1.6, 4, 15, 1.6) {
        createSlots(mediumBoxDimensions, slotSmallDimensions, 10, 2, 0.8, 1.6, 15, 4);
        createSlots(mediumBoxDimensions, slotSmallDimensions2, 2, 2, 0.8, 1.6, 15, 4);
    }
    createBox(mediumBoxDimensions, 1.6, 4, 15, 1.6) {
        createSlots(mediumBoxDimensions, slotSmallDimensions, 10, 2, 0.8, 1.6, 15, 4);
        createSlots(mediumBoxDimensions, slotSmallDimensions2, 2, 2, 0.8, 1.6, 15, 4);
    }
}
//createStorage(0.1);



 
