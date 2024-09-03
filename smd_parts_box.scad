// configuration 
box_width = 40;
box_depth = 80;
box_height = 10;

wall_thickness = 1.2;

side_thickness = 4;

lid_clearance = 0.1;
lid_thickness = 1.8;
lid_grid_height = 0.4;
upper_wall_height = 4;

// size in quantum of full grid units, where 1 = 1 unit
// unit is relative to box size and amount of slots, calculated to fit everything inside
rows = [2, 2, 2, 2, 2];
columns = [3, 3, 3, 2, 2];

function cumulativeSum(vec) = [for (sum=vec[0], i=1; i<=len(vec); newsum=sum+vec[i], nexti=i+1, sum=newsum, i=nexti) sum];

module renderGrid(rows, columns, width, depth, height) {
    rowsOffsets = cumulativeSum(rows);
    totalDepthInQuant = rowsOffsets[len(rows)-1];
    
    echo("Total: ", totalDepthInQuant);
    rowSize = (depth-wall_thickness - (totalDepthInQuant)*wall_thickness)/totalDepthInQuant + wall_thickness;
    echo("RowSize:", rowSize);
    for(i = [0: len(rowsOffsets) - 1]) {
        translate([0, rowsOffsets[i] * rowSize, 0]) cube([box_width-2*side_thickness, wall_thickness, height], center=false);
        columnSize = (width - 1.5*side_thickness) / columns[i];
        for (x = [0 : columns[i]]) {
            echo(x, columnSize, "RO: ", rowsOffsets[i], ", size: ", rowSize);
            translate([x * columnSize, rowsOffsets[i] * rowSize, 0]) {
                rotate([0, 0, 180]) cube([wall_thickness, rowSize * rows[i], height], center=false);
            }
        }
    };
}

module renderBox(dimensions) {
    width = dimensions[0];
    height = dimensions[2];
    depth = dimensions[1];
    
    difference() {
        cube([width, depth + side_thickness, height], center=false);    
        translate([side_thickness, wall_thickness, wall_thickness]) {
            cube([width - side_thickness*2, depth - 2 * wall_thickness, height], center=false);
        }
    }
    
    translate([0, 0, height]) cube([side_thickness, dimensions[1], upper_wall_height], center=false);
    translate([width-side_thickness, 0, height]) cube([side_thickness, dimensions[1], upper_wall_height], center=false);
    translate([0, depth - wall_thickness, height]) cube([width, side_thickness + wall_thickness, upper_wall_height], center = false);
}

module renderLidWithGrid() {
    translate([side_thickness-wall_thickness*2, 0, lid_thickness])renderGrid([2, 2], [2, 2], box_width, box_depth/2.5, lid_grid_height);
    translate([side_thickness-wall_thickness*2, box_depth/2.5-wall_thickness, lid_thickness])renderGrid([2, 2, 2, 2], [3, 3, 3, 3], box_width, box_depth-(box_depth/2.5)+wall_thickness, lid_grid_height);
}

module renderLid(dimensions) {
    width = dimensions[0];
    height = dimensions[2];
    depth = dimensions[1];
    
    cube([width, depth, height], center=false);
    translate([side_thickness + lid_clearance, 0, lid_thickness-lid_clearance*2]) cube([width - 2 * side_thickness -lid_clearance, wall_thickness*2, upper_wall_height - lid_thickness], center = false);
    
}

difference()
{    
    renderBox([box_width, box_depth, box_height]);
    // lid rail
    translate([side_thickness/2 - lid_clearance, -wall_thickness/2, box_height]) cube([box_width-side_thickness, box_depth, lid_thickness+lid_clearance], center=false);
    
//    translate([box_width - 1.5 * side_thickness + lid_clearance, -wall_thickness, box_height]) cube([side_thickness, box_depth, lid_thickness+lid_clearance], center=false);
    
    
}

translate([side_thickness, 0, wall_thickness])renderGrid([2, 2], [2, 2], box_width, box_depth/2.5, box_height-wall_thickness);
translate([side_thickness, box_depth/2.5-wall_thickness, wall_thickness])renderGrid([2, 2, 2, 2], [3, 3, 3, 3], box_width, box_depth-(box_depth/2.5)+wall_thickness, box_height-wall_thickness);

translate([box_width * 1.5, 0, 0])
{
    renderLid([box_width - side_thickness - 2*lid_clearance, box_depth - wall_thickness - lid_clearance*2, lid_thickness - lid_clearance * 2]);

    difference()
    {
        renderLidWithGrid();

        translate([0, box_depth-2*wall_thickness, 0]) cube([box_width, wall_thickness*3, box_height]);
        translate([box_width-2*side_thickness, -wall_thickness, 0]) cube([side_thickness*2, box_depth + wall_thickness * 2, box_height]);
        translate([0, -wall_thickness, 0]) cube([side_thickness+lid_clearance, box_depth + wall_thickness * 2, box_height]);
    }
}



