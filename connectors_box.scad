include <tray_storage.scad>

createStorage = true;
createBox = false;
blockerOffset = 3;
blockerRadius = 0.4;

slotWidth = 11;
slotHeight = 11; //11 for storage, 11.6 for box 
slotLength = 181;
wallSize = 0.6;
slotsRows = 1;
slotsColumns = 1;
handleLength = 8;
handleThickness = 1;
roundRadius = 1;
traySpacing = 0.4;

boxSpacing = wallSize * 2;
boxSize = 19 + 2*(boxSpacing);


module createLine(zOffset) {
    firstSlotWidth = 22;
    translate([0, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([21, 80, 19], 1, 1, 0.6, 0);
        createSlots([21, 99, 19], 1, 1, 0.6, -81);
    }
    firstBoxSize = firstSlotWidth + 2*(boxSpacing + traySpacing);
    echo("$firstBoxSize", firstBoxSize);

    translate([firstBoxSize, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 40, 19], 1, 1, 0.6, -140);
            createSlots([21, 36, 19], 1, 1, 0.6, -103);
            createSlots([21, 24, 19], 1, 1, 0.6, -78);
            createSlots([21, 25, 19], 1, 1, 0.6, -52);
            createSlots([10, 20, 19], 1, 2, 0.6, -31);
            createSlots([10, 30, 19], 1, 2, 0.6, 0);
    } 
    translate([firstBoxSize * 2, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 40, 19], 1, 1, 0.6, -140);
            createSlots([21, 36, 19], 1, 1, 0.6, -103);
            createSlots([21, 24, 19], 1, 1, 0.6, -78);
            createSlots([21, 25, 19], 1, 1, 0.6, -52);
            createSlots([10, 20, 19], 1, 2, 0.6, -31);
            createSlots([10, 30, 19], 1, 2, 0.6, 0);
    } 
    
    translate([firstBoxSize * 3, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 40, 19], 1, 1, 0.6, -140);
            createSlots([21, 36, 19], 1, 1, 0.6, -103);
            createSlots([21, 24, 19], 1, 1, 0.6, -78);
            createSlots([21, 25, 19], 1, 1, 0.6, -52);
            createSlots([10, 20, 19], 1, 2, 0.6, -31);
            createSlots([10, 30, 19], 1, 2, 0.6, 0);
    } 
    
    translate([firstBoxSize * 4, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 40, 19], 1, 1, 0.6, -140);
            createSlots([21, 36, 19], 1, 1, 0.6, -103);
            createSlots([21, 24, 19], 1, 1, 0.6, -78);
            createSlots([21, 25, 19], 1, 1, 0.6, -52);
            createSlots([10, 20, 19], 1, 2, 0.6, -31);
            createSlots([10, 30, 19], 1, 2, 0.6, 0);
    } 
    
    translate([firstBoxSize * 5, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 40, 19], 1, 1, 0.6, -140);
            createSlots([21, 36, 19], 1, 1, 0.6, -103);
            createSlots([21, 24, 19], 1, 1, 0.6, -78);
            createSlots([21, 25, 19], 1, 1, 0.6, -52);
            createSlots([10, 20, 19], 1, 2, 0.6, -31);
            createSlots([10, 30, 19], 1, 2, 0.6, 0);
    } 
    
    translate([firstBoxSize * 6, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 40, 19], 1, 1, 0.6, -140);
            createSlots([21, 36, 19], 1, 1, 0.6, -103);
            createSlots([21, 24, 19], 1, 1, 0.6, -78);
            createSlots([21, 25, 19], 1, 1, 0.6, -52);
            createSlots([10, 20, 19], 1, 2, 0.6, -31);
            createSlots([10, 30, 19], 1, 2, 0.6, 0);
    } 
}
// 178 width
rotate([180, 0, 90]) {
    createLine(0); 
    createLine(boxSize);
    createLine(boxSize * 2);
}
