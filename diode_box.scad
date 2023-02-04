include <tray_storage.scad>

createStorage = true;
createBox = true;
blockerOffset = 3;
blockerRadius = 0.25;

slotLength = 38;
wallSize = 0.3;
slotsRows = 1;
slotsColumns = 1;
handleLength = 4;
handleThickness = 0.8;
roundRadius = 1;
traySpacing = 0.3;
boxSpacing = wallSize * 2;

module createLine(slotWidth, slotHeight, n) {
    boxWidth = slotWidth + boxSpacing;
    boxLength = slotLength + boxSpacing;
    boxHeight = slotHeight + boxSpacing;
    offset = boxWidth + boxSpacing + 2 * traySpacing;
    
    for (i = [0:n-1]) {
        translate([offset*i, 0, 0]) createBox([boxWidth, boxLength, boxHeight],         roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([slotWidth, slotLength, slotHeight], 1, 1, 0.6, 3*wallSize);
        }
    }    
}

nextLineOffset = 2*boxSpacing + 2*traySpacing;

rotate([180, 0, 90]) {
    translate([0, 0, 0]) createLine(19, 15, 7);
    secondLineZOffset = -(9 + nextLineOffset);
    translate([0, 0, secondLineZOffset]) createLine(12.76, 9, 10);
    thirdLineZOffset = secondLineZOffset - (9 + nextLineOffset);
    translate([0, 0, thirdLineZOffset]) createLine(11.436, 9, 11);
} 
