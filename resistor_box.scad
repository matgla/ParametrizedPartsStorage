include <tray_storage.scad>

createStorage = false;
createBox = true;
boxOffset = 20;
blockerOffset = 3;
blockerRadius = 0.4;

slotWidth = 20;
slotHeight = 20.4; //11 for storage, 11.6 for box 
slotLength = 70;
wallSize = 0.5;
slotsRows = 5;
slotsColumns = 10;
handleLength = 5;
handleThickness = 1;
roundRadius = 1;
traySpacing = 0.2;

// 15x15
// 20.8x20.4
// 32.4x20.4

module createLine(columns, zOffset, width, length, height, rows, columns) {
    boxSpacing = wallSize*2;
    boxSize = width + 2*(boxSpacing + traySpacing);
    for (i = [0:columns]) {
        translate([i * boxSize, 0, zOffset]) {
            createBox([width + 2 * wallSize, length + wallSize * 2, height + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
                createSlots([width, length, height], rows, columns, wallSize, 0);
            } 
        }
    }
}

rotate([180, 0, 90]) {
//    columns = slotsColumns - 1;
//    boxSpacing = wallSize*2;
//    offset1 = 15 + 2*(boxSpacing + traySpacing);
//  
//    for (i = [0:1]) {
//        zOffset = (offset1 - wallSize) * i;
//        createLine(columns, zOffset, 15, slotLength, 15, slotsRows - 1, 7);
//    }
//
//    row2Width = 20.8;
//    offsetForRow2 = (offset1 - wallSize) * 2;
//    offset2 = row2Width + 2*(boxSpacing + 0);
//    for (i = [2:3]) {
//        zOffset = (offset2 - wallSize) * (i - 2) + offsetForRow2;
//        createLine(columns, zOffset, row2Width, slotLength, slotHeight, slotsRows - 1,  5);
//    }  
//    
//    row3Width = 32.4;
//    offsetForRow3 = (offset2 - wallSize) * 2 + offsetForRow2;
//    offset3 = slotWidth + 2*(boxSpacing + traySpacing);
//    for (i = [2:3]) {
//        zOffset = (offset3 - wallSize) * (i - 2) + offsetForRow3;
//        createLine(columns, zOffset, row3Width, slotLength, slotHeight, slotsRows - 1, 4 - 1);
//    }  

    
     //createLine(columns, 0, slotWidth, slotLength, slotHeight, 0, 1);
     createSlots([slotWidth, slotLength, slotHeight], 1, 1, wallSize, 0);
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
