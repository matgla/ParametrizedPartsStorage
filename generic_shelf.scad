include <tray_storage.scad>

createStorage = true;
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

shelfs = [
    [15, 15],
    [20, 20],
    [32, 20]
];

function cumulativeHeight(rows) = [for (row=rows[0], i=1; i<=len(rows); newsum=sum+row[i][1], nexti=i+1, sum=newsum, i=nexti) sum];


module createLine(columns, zOffset, width, length, height, rows, columns) {
    boxSpacing = wallSize*2;
    boxSize = width + 2*(boxSpacing + traySpacing);
    for (i = [0:columns]) {
        translate([cumulativeHeight(shelfs[i:]), 0, zOffset]) {
            createBox([width + 2 * wallSize, length + wallSize * 2, height + wallSize], roundRadius, handleLength, handleThickness, traySpacing, wallSize) {
                createSlots([width, length, height], rows, columns, wallSize, 0);
            } 
        }
    }
}

// (boxDimensions, roundRadius, handleLength, handleThickness, trayOffset, wallSize)
    
// shelfs, array of 3 element vectors, 
// 0 - width, 2 - height
module createShelf(shelfs, width, length, wallSize, handleThickness, handleLength) {
    for (i = [0: len(shelfs)]) {
        height = height + shelfs[i][1];
        translate([0, 0, height]) createStoragePart([shelfs[i][0], length, shelfs[i][1]], 0.8, 0.8, 4, 1, 0.8, wallSize) {
           
        }

    }
}

createShelf(shelfs, 160, 65, wallSize, handleThickness, handleLength);