include <tray_storage.scad>

createStorage = true;
createBox = false;
boxOffset = 20;
blockerOffset = 3;
blockerRadius = 0.4;

slotWidth = 11;
slotHeight = 11; //11 for storage, 11.6 for box 
slotLength = 65;
wallSize = 0.6;
slotsRows = 1;
slotsColumns = 1;
handleLength = 5;
handleThickness = 1;
roundRadius = 1;
traySpacing = 0.4;

boxSpacing = wallSize*2;
boxSize = slotWidth + 2*(boxSpacing + traySpacing);


module createLine(columns, zOffset) {
    for (i = [0:columns]) {
        translate([i * boxSize, 0, zOffset]) {
            createBox([slotWidth + 2 * wallSize, slotLength + wallSize * 2, slotHeight + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
                createSlots([slotWidth, slotLength, slotHeight], slotsRows, slotsColumns, 0.3, 0);
            } 
        }
    }
}

rotate([180, 0, 90]) {
    columns = 10;
    for (i = [0:2 ]) {
        zOffset = (boxSize - wallSize) * i;
        createLine(columns, zOffset);
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
