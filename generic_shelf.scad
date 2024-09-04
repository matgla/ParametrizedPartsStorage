include <tray_storage.scad>


function cumulativeHeight(rows, wallThickness) = [for (sum=0, i=0; i<len(rows); newsum=sum+rows[i][1], nexti=i+1, sum=newsum, i=nexti) sum];

function cumulativeWidth(rows, wallThickness) = [for (sum=0, i=0; i<len(rows); newsum=sum+rows[i][0], nexti=i+1, sum=newsum, i=nexti) sum];
   

function fullHeight(rows, wallThickness) = [for (sum=rows[0][1], i=1; i<=len(rows); newsum=sum+rows[i][1], nexti=i+1, sum=newsum, i=nexti) sum];

module createShelfSlot(dimensions, wallThickness) {
    backSize = dimensions[0] / 3;
    difference() {
        cube(dimensions);
        translate([wallThickness, -wallThickness, wallThickness]) cube([dimensions[0] - wallThickness*2, dimensions[1], dimensions[2] - wallThickness*2]);
        translate([backSize, wallThickness*4, backSize]) {
            $fn=30;
            rotate([-90, 0, 0]) minkowski() {
                rotate([90, 0, 0]) cube([dimensions[0]-2*backSize, dimensions[1], dimensions[2]-backSize*2]);
                cylinder(r=backSize/2, h=wallThickness);
            }
        }
    }
}

module createBlocker(blockerSize, blockerHeight) {
    cylinder(r=blockerSize, blockerHeight);
    $fn=30;
    translate([0, 0, blockerHeight])sphere(blockerSize);
}

module createDrawer(dimensions, wallSize, handleLength, handleThickness, spacing, blockerSize) {
    difference() {
        translate([0, 0, 0]) {
            cube(dimensions);
            $fn=30;
            handleRadius = 4;
            translate([handleRadius/2, -handleLength+handleRadius/2, 0]) {
                minkowski() {
                    cube([dimensions[0]-handleRadius, handleLength, handleThickness]);
                    cylinder(r=handleRadius/2, h=handleThickness/100000);
                }
            }
            translate([0, dimensions[1] * 0.05, dimensions[2] * 0.1]) {
                translate([0, 0, 0]) createBlocker(blockerSize*2, dimensions[2] * 0.8);
                translate([dimensions[0], 0, 0]) createBlocker(blockerSize*2, dimensions[2] * 0.8);
            } 
        }
        translate([wallSize, wallSize, wallSize]) cube([dimensions[0] - wallSize*2, dimensions[1] - wallSize * 2, dimensions[2] + wallSize]);
    }

}


module createShelf(shelfs, width, length, wallSize, handleThickness, handleLength, spacing, blockerSize, drawShelf, drawDrawers, drawSingleDrawers) {
    shelfHeight = fullHeight(shelfs, wallSize)[len(shelfs)-1];
    rotate([0, 0, 0]) {
        if (drawShelf) {
            difference() {
                cube([width+2*wallSize, length, shelfHeight+2*wallSize]);
                translate([wallSize, -wallSize, wallSize]) cube([width, length + wallSize*2, shelfHeight]);
            }
        }
        translate([wallSize, 0, wallSize]) {
            for (i = [0: len(shelfs) - 1]) {
                height = cumulativeHeight(shelfs, wallSize)[i];
                columns = width / shelfs[i][0];    
                for (x = [0: columns - 1]) {
                    xoffset = (shelfs[i][0]) * x;
                    translate([xoffset, 0, height]) {
                        dimensions = [shelfs[i][0], length, shelfs[i][1]];
                        if (drawShelf) {
                            createShelfSlot(dimensions, wallSize);
                        }
                        drawerDimensions = [shelfs[i][0] - 2*(wallSize + spacing), length - wallSize * 2 - spacing, shelfs[i][1] - 2 * (wallSize + spacing)]; 
                        if (drawDrawers) {
                            translate([wallSize+spacing, 0, wallSize+spacing]) createDrawer(drawerDimensions, wallSize*2, handleLength, handleThickness, spacing, blockerSize);
                        }
                        
                        if (drawSingleDrawers && x == 0) {
                            translate([width + cumulativeWidth(shelfs, wallSize)[i] + wallSize * 8, 0, -height]) createDrawer(drawerDimensions, wallSize*2, handleLength, handleThickness, spacing, blockerSize);
                        }
                    }
                }
            }
        }
    }
}

