# Parameterized Stackable Chip Rack

## Description

3D printing files for a fully customizable, stackable rack for poker chips and coins.
Printable without supports on printers that can do 45° overhangs and a few cm (depending on chip size) of bridges.

This rack was inspired by the the effort of Rubén Torres on BGG to bring Ceramic Mini Chips to the masses.
I created this model while waiting for my shipment.

The rack can be configure to have any number of rows of chips and any number of chips per row.

The rows can be configured to have any depth up to 50% of the chip diameter (any more and the row would get narrower at the top and the chips wouldn't fit in.)

You can also have "bottom rows" on the underside of the rack, so the racks can stack.
The bottom rows aren't rounded but have 45° walls (and bridges at the top) for easier printing on most 3D printers.
If you don't want stacking, you can configure the bottom_row_depth to be 0%.

You can configure the "top rows" can be configured to 0% depth to create a sort of lid.
(The current version has no provisions to have the lids snap or stay shut.)

The accompanying mini_chip_rack.json file has some example settings.

## Parameters

These parameters are customizable using the thingiverse / OpenScad customizer. 

### Diameter 
The diameter of an individual chip (in mm) that should fit into the rack.
Needs to be a positive number.

### Thickness
The thickness of an individual chip (in mm) that should fit into the rack.
Needs to be a positive number.

### Tolerance
Allow for this much tolerance per chip, so the fit isn't too tight (in mm).
Tolerance is applied once per chip in the "thickness direction" and twice in the "diameter direction".
While technically possible, this should not be a negative number. Zero is fine.

### Wall Thickness
The thickness of the outer walls (in mm).
Also applies to the bottom of the rack, when bottom_row_depth is 0.
Also applies to the layer between the top and bottom rows.
Needs to be a positive number.

### Rows
The number of rows of chips per rack
Needs to be a positive integer number.

### Chips Per Row
The number of chips that fit in one row
Needs to be a positive integer number.

### Row Spacing
The spacing between rows (in mm). This sets the actual space between the chips.
The space between the indentations in the rack can be larger, depending on the row depth.
Should be >= 0 for the rack to function properly.

### Top Row Depth
How deep should the chips fit into the rack in percent of the chip diameter.
Can be configured to have any depth up to 50% of the chip diameter (any more and the row would get narrower at the top and the chips wouldn't fit in.)
The value must be non-negative.

### Bottom Row Depth
How deep should the chips fit into the bottom of a stacked rack in percent of the chip diameter.
Values less than about 25% are possible but will lead to less stable stacking.
Values up to about 70% are possible.
A value of 0% will print a rack with a flat bottom.

### Cutout Diameter
How much of the wall should be cutout at the ends of the rows to make the centers of the chips more visible (in mm).
Must be less than chip diameter. 
Larger values will be treated as equal to chip_diameter and the resulting rack will not have walls to keep the chips in.
This might be useful to print rack insert for existing boxes.
A value of zero will result in a straight wall without cutouts.