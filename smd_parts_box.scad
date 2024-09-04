include <generic_box.scad>;


// configuration 
width = 40;
depth = 80;
height = 10;

wall_thickness = 0.8;

side_thickness = 3.6;

lid_clearance = 0.1;
lid_thickness = 1.8;
lid_grid_height = 0.4;
upper_wall_height = 2;

// size in quantum of full grid units, where 1 = 1 unit
// unit is relative to box size and amount of slots, calculated to fit everything inside
rows = [2, 2, 2, 2, 2];
columns = [3, 3, 3, 2, 2];
layout = [[[2, 2], [2, 2], depth/2.5, 0], [[2, 2, 2, 2], [3, 3, 3, 3], depth-(depth/2.5), depth/2.5]];


renderBox(layout, [width, depth, height], wall_thickness, side_thickness, [lid_thickness, lid_clearance], upper_wall_height);


