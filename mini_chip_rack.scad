/*
 * Project Name: Parameterized Stackable Chip Rack
 * Description: Fully customizable, stackable rack for Poker Chips and Coins. Printable without supports.
 * 
 * Author: Matthias Manhertz
 * 
 * License:
 * This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) License.
 * 
 * You are free to:
 * - Share — copy and redistribute the material in any medium or format
 * - Adapt — remix, transform, and build upon the material.
 * 
 * Under the following terms:
 * - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
 * - NonCommercial — You may not use the material for commercial purposes.
 * - ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
 * 
 * Full License Text: https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
 * 
 * Please retain this header in all derivatives or distributions.
 *
 * Date: 09/16/2024
 */

/* [chip] */

// diameter of an individual chip (in mm)
diameter = 27;

// thickness of an individual chip (in mm)
thickness = 4.15;

// allow for this much tolerance per chip, so the fit isn't too tight (in mm)
tolerance = 0.05;



/* [rack] */

// thickness of the outer walls (in mm)
wall_thickness = 2;

// the number of rows of chips per rack
rows = 5; // [1:20]

// the number of chips that fit in one row
chips_per_row = 20; //[1:1:100]

// spacing between rows (in mm)
row_spacing = 2;

// how deep should the chips fit into the rack (in percent)
top_row_depth = 42; // [0:1:50]

// how deep should the chips fit into the bottom of a stacked rack (in percent)
bottom_row_depth = 25; // [0:1:70]

// how much of the wall should be cutout at the ends of the rows to make the centers of the chips more visible (in mm, must be less than chip diameter)
cutout_diameter = 0;


chip_rack(
    chip_diameter=diameter,
    chip_thickness=thickness,
    tolerance=tolerance,
    wall_thickness=wall_thickness,
    rows=rows,
    chips_per_row=chips_per_row,
    row_spacing=row_spacing,
    top_row_depth_percent=top_row_depth,
    bottom_row_depth_percent=bottom_row_depth,
    cutout_diameter=cutout_diameter
);


module chip_rack(
    chip_diameter,
    chip_thickness,
    tolerance,
    wall_thickness,
    rows,
    chips_per_row,
    row_spacing,
    top_row_depth_percent,
    bottom_row_depth_percent,
    cutout_diameter
) {
    diameter = chip_diameter + 2 * tolerance;
    thickness = chip_thickness + tolerance;
    cutout_diameter = min(chip_diameter, cutout_diameter);
    
    top_row_depth = top_row_depth_percent * chip_diameter / 100;
    bottom_row_depth = bottom_row_depth_percent * chip_diameter / 100;
    
    rack_height = top_row_depth + bottom_row_depth + wall_thickness;
    
    // if the top cutout is larger than the bottom cutout, we need to move the rack up and vice versa
    rack_offset = (top_row_depth - bottom_row_depth) / 2;
    
    rack_depth = thickness * chips_per_row + 2 * wall_thickness;
    rack_width = diameter * rows + row_spacing * (rows-1) + 2 * wall_thickness;
    row_width = diameter + row_spacing;
    
    // x coordinates relative to 0 for each of the rows
    row_offsets = [-row_width*(rows-1)/2:row_width:row_width*(rows-1)/2];
    
    rad = diameter/2;
    circumrad = rad * 1.082;
    cutoutrad = cutout_diameter/2;
    
    $fn=360;
    translate([0, 0, rack_height/2 - rack_offset]) // make sure the bottom is at z=0
    difference() {
        translate([0, 0, rack_offset]) cube([rack_width, rack_depth, rack_height], center=true);
        
        for(offset = row_offsets) {
            // top row
            translate([offset, 0, rad + wall_thickness/2]) rotate([90, 0, 0]) 
                cylinder(thickness*chips_per_row, rad, rad, center = true);
            // bottom row
            translate([offset, 0, -rad - wall_thickness/2]) rotate([90, 22.5, 0]) 
                cylinder(thickness*chips_per_row, circumrad, circumrad, center = true, $fn=8);
            // top row cutout
            translate([offset, 0, rad + wall_thickness/2]) rotate([90, 0, 0]) 
                cylinder(thickness*chips_per_row + 4 * wall_thickness, cutoutrad, cutoutrad, center = true);
        }
    }
}
