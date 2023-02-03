include <tray_storage.scad>

createStorage = false;
createBox = true;
blockerOffset = 3;
blockerRadius = 0.6;

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
            createSlots([10.5, 30, 19], 1, 2, 0.6, -150);
            createSlots([21, 20, 19], 1, 1, 0.6, -129);
            createSlots([21, 16, 19], 1, 1, 0.6, -112);
            createSlots([21, 14, 19], 1, 1, 0.6, -97);
            createSlots([21, 16, 19], 1, 1, 0.6, -80);
            createSlots([21, 40, 19], 1, 1, 0.6, -39);
            createSlots([21, 20, 19], 1, 1, 0.6, -18);
            createSlots([21, 20, 19], 1, 1, 0.6, 0);
    } 
    
    translate([firstBoxSize * 3, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 105, 19], 1, 1, 0.6, -75);
            createSlots([21, 74, 19], 1, 1, 0.6, 0);
    } 
    
    translate([firstBoxSize * 4, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 105, 19], 1, 1, 0.6, -75);
            createSlots([21, 74, 19], 1, 1, 0.6, 0);
    } 
    
    
    translate([firstBoxSize * 5, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 85, 19], 1, 1, 0.6, -95);
            createSlots([10.5, 60, 19], 1, 2, 0.6, -34);
            createSlots([10.5, 33, 19], 1, 2, 0.6, 0);
    } 
    
    translate([firstBoxSize * 6, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 90, 19], 1, 1, 0.6, -90);
            createSlots([21, 89, 19], 1, 1, 0.6, 0);
    } 
    translate([firstBoxSize * 7, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
            createSlots([21, 54, 19], 1, 1, 0.6, -126);
            createSlots([21, 15, 19], 1, 1, 0.6, -110);
            createSlots([21, 15, 19], 1, 1, 0.6, -94);
            createSlots([21, 15, 19], 1, 1, 0.6, -78);
            createSlots([10.5, 65, 19], 1, 2, 0.6, -12);
            createSlots([10.5, 11, 19], 1, 2, 0.6, 0);
    } 
    translate([firstBoxSize * 8, 0, zOffset]) createBox([firstSlotWidth + 2 * wallSize, slotLength + wallSize * 2, 19 + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
        createSlots([21, 26, 19], 1, 1, 0.6, -154);
        createSlots([21, 21, 19], 1, 1, 0.6, -132);
        createSlots([21, 33, 19], 1, 1, 0.6, -98);
        createSlots([21, 31, 19], 1, 1, 0.6, -66Q);
        createSlots([21, 32, 19], 1, 1, 0.6, -33);
        createSlots([21, 32, 19], 1, 1, 0.6, 0);
    } 
}
// 178 width
rotate([180, 0, 90]) {
    createLine(0); 
   // createLine(boxSize);
}
