include <Chamfers-for-OpenSCAD/Chamfer.scad>;


function cumulativeSum(vec) = [for (sum=vec[0], i=1; i<=len(vec); newsum=sum+vec[i], nexti=i+1, sum=newsum, i=nexti) sum];
    
function cumulativeDepth(rows) = [for (sum=0, i=0; i<len(rows); newsum=sum+rows[i][1], nexti=i+1, sum=newsum, i=nexti) sum];


module renderGrid(dimensions, rows, columns, wall, side) {
    width = dimensions[0];
    depth = dimensions[1];
    height = dimensions[2];
    
    rowsOffsets = cumulativeSum(rows);
    totalDepthInQuant = rowsOffsets[len(rows)-1];
    
    rowSize = (depth-wall_thickness - (totalDepthInQuant)*wall)/totalDepthInQuant + wall;
    for(i = [0: len(rowsOffsets) - 1]) {
        translate([0, rowsOffsets[i] * rowSize, 0]) cube([width-2*side, wall, height], center=false);
        columnSize = (width - 1.5*side) / columns[i];
        for (x = [0 : columns[i]]) {
            translate([x * columnSize, rowsOffsets[i] * rowSize, 0]) {
                rotate([0, 0, 180]) cube([wall, rowSize * rows[i], height], center=false);
            }
        }
    };
}

module renderBoxBottom(dimensions, side, wall, upper_wall_height) {
    width = dimensions[0];
    height = dimensions[2];
    depth = dimensions[1];
    
    difference() {
        cube([width, depth + side, height], center=false);    
        translate([side, wall, wall]) {
            cube([width - side*2, depth - 2 * wall, height], center=false);
        }
    }
    
    translate([0, 0, height]) cube([side, depth, upper_wall_height], center=false);
    translate([width-side, 0, height]) cube([side, depth, upper_wall_height], center=false);
    translate([0, depth - wall, height]) cube([width, side + wall, upper_wall_height], center = false);
}

module renderLidWithGrid(layout, dimensions, wall, side) {
    lid_thickness = dimensions[2];
    depth = dimensions[1];
    width = dimensions[0];
    difference() {
        for (row = layout) {
            offset = row[3];
            echo("Offset: ", offset);
            translate([side-wall*2, offset, lid_thickness]) renderGrid([width, row[2], wall], row[0], row[1], wall, side);
            
//            translate([side-wall*2, depth/2.5-wall, lid_thickness])renderGrid([width, depth-(depth/2.5), wall], [2, 2, 2], [3, 3, 3], wall, side);

        }
        translate([side, depth-side, lid_thickness])cube([width, depth, wall], center=false);
    }
}

module renderLid(dimensions) {
    width = dimensions[0];
    height = dimensions[2];
    depth = dimensions[1];
    
    chamferCube([width, depth, height], [[0, 0, 1, 0], [0, 1, 1, 0], [0, 0, 0, 0]], lid_thickness+lid_clearance*2, center=false);
    translate([side_thickness + lid_clearance, 0, lid_thickness-lid_clearance*2]) cube([width - 2 * side_thickness -lid_clearance, wall_thickness*2, upper_wall_height - lid_thickness], center = false);
    
}

module renderBox(layout, dimensions, wall, side, lid, upper_wall_height) {
    lid_thickness = lid[0];
    lid_clearance = lid[1];
    width = dimensions[0];
    depth = dimensions[1];


    height = dimensions[2];
    difference() {    
        renderBoxBottom([width, depth, height], side, wall, upper_wall_height);
        // lid rail


        translate([side/2+lid_clearance, -wall/2, height]) chamferCube([width-side, depth+lid_thickness, lid_thickness], [[0, 0, 1, 0], [0, 1, 1, 0], [0, 0, 0, 0]], lid_thickness+lid_clearance, center=false);    
        
    }

    for (row = layout) {
        translate([side, row[3], wall])renderGrid([width, row[2], height-wall], row[0], row[1], wall, side);
    }
    translate([width * 1.5, 0, 0])
    {
        renderLid([width - side - 2*lid_clearance, depth - wall - lid_clearance*2, lid_thickness - lid_clearance * 2]);

        difference()
        {
            renderLidWithGrid(layout, [width, depth, lid_thickness], wall, side);

            translate([0, depth-2*wall, 0]) cube([width, wall*3, height]);
            translate([width-2*side, -wall, 0]) cube([side*2, depth + wall * 2, height]);
            translate([0, -wall, 0]) cube([side+lid_clearance, depth + wall * 2, height]);
        }
    }
}
