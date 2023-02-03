include <tray_storage.scad>

createStorage = true;
createBox = true;
blockerOffset = 3;
blockerRadius = 0.4;

slotLength = 38;
wallSize = 0.6;
slotsRows = 1;
slotsColumns = 1;
handleLength = 4;
handleThickness = 1;
roundRadius = 1;
traySpacing = 0.4;
boxSpacing = wallSize * 2;

// 178 width

module createFirstLine()
{
    firstLineSlotWidth = 9;
    firstLineHeight = firstLineSlotWidth;
    translate([0, 0, 0]) createBox([firstLineSlotWidth + 2 * wallSize, slotLength + wallSize * 2, firstLineSlotWidth + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([9, 38, 9], 1, 1, 0.6, wallSize);
    }
    inLineOffset = 9 + 2*(boxSpacing) + traySpacing;

    translate([inLineOffset, 0, 0]) createBox([firstLineHeight + 2 * wallSize, slotLength + wallSize * 2, firstLineHeight + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([10, 38, 10], 1, 1, 0.6, wallSize);
    }

    translate([inLineOffset * 2, 0, 0]) createBox([firstLineHeight + 2 * wallSize, slotLength + wallSize * 2, firstLineHeight + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([10, 38, 10], 1, 1, 0.6, wallSize);
    }
    
    translate([inLineOffset * 3, 0, 0]) createBox([8 + 2 * wallSize, slotLength + wallSize * 2, firstLineHeight + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([8, 38, 10], 1, 1, 0.6, wallSize);
    }
    
    smallerInLineOffset = 8 + 2*(boxSpacing) + traySpacing;
    nextInLineOffset = inLineOffset * 3 + smallerInLineOffset;
    translate([nextInLineOffset, 0, 0]) createBox([8 + 2 * wallSize, slotLength + wallSize * 2, firstLineHeight + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([8, 38, 10], 1, 1, 0.6, wallSize);
    }
    
    nextInLineOffset2 = nextInLineOffset + smallerInLineOffset;
    translate([nextInLineOffset2, 0, 0]) createBox([8 + 2 * wallSize, slotLength + wallSize * 2, firstLineHeight + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([8, 38, 10], 1, 1, 0.6, wallSize);
    }
    
    translate([nextInLineOffset2 + smallerInLineOffset, 0, 0]) createBox([9 + 2 * wallSize, slotLength + wallSize * 2, firstLineHeight + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([9, 38, 10], 1, 1, 0.6, wallSize);
    }
}

module createSecondLine() {
    secondLineSlotWidth = 18;
    
    inLineOffset2 = 18 + 2*(boxSpacing) + traySpacing;
    translate([0, 0, 0]) createBox([18 + 2 * wallSize, slotLength + wallSize * 2, 14 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([18, 38, 14], 1, 1, 0.6, wallSize);
    }
    translate([inLineOffset2, 0, 0]) createBox([18 + 2 * wallSize, slotLength + wallSize * 2, 14 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([18, 38, 14], 1, 1, 0.6, wallSize);
    }
    translate([inLineOffset2 * 2, 0, 0]) createBox([18 + 2 * wallSize, slotLength + wallSize * 2, 14 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([18, 38, 14], 1, 1, 0.6, wallSize);
    }
     
    translate([inLineOffset2 * 3, 0, 0]) createBox([18 + 2 * wallSize, slotLength + wallSize * 2, 14 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([18, 38, 14], 1, 1, 0.6, wallSize);
    }
}

module createThirdLine() { 
    thirdLineStart = boxSpacing*2 + 14 + boxSpacing * 2;
    thirdLineOffset = 14 + boxSpacing * 2 + traySpacing;
    
    for (i = [0:5])
    translate([thirdLineOffset*i, 0, 0]) createBox([11 + 2 * wallSize, slotLength + wallSize * 2, 10 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([11, 38, 11], 1, 1, 0.6, wallSize);
    }
}

rotate([180, 0, 90]) {
    // translate([0, 0, 0]) createFirstLine();
     translate([0, 0, 13]) createSecondLine();
     translate([0, 0, 0]) createThirdLine();
} 
