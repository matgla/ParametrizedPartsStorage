include <generic_shelf.scad>

wallSize = 0.4;
handleLength = 5;
handleThickness = 1;
spacing = 0.2;
blockerSize = 0.2;

shelfs = [
    [30, 30],
    [20, 20],
    [15, 12],
    [10, 10],
    [10, 10]
];

createShelf(shelfs, 120, 65, wallSize, handleThickness, handleLength, spacing, blockerSize, true, false, true);