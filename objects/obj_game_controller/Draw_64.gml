///@desc DEBUG ITEM MENU

// DO NOT SAVE THE CONTENTS OF A CSV FILE WHILE GAME MAKER IS OPEN
// DO NOT SAVE THE CONTENTS OF A CSV FILE WHILE GAME MAKER IS OPEN
// DO NOT SAVE THE CONTENTS OF A CSV FILE WHILE GAME MAKER IS OPEN
// DO NOT SAVE THE CONTENTS OF A CSV FILE WHILE GAME MAKER IS OPEN

// DEBUG MENU /////////////////////////////
if (!show_file_contents) {
	exit;
}

// Set draw text alignment to the left.
draw_set_halign(fa_left);

// Set the spacing between each cell.
var cell_spacing = 128;

var ww = ds_grid_width(file_grid);
var hh = ds_grid_height(file_grid);
var xx = 32;
var yy = scroll_y;
for (var row = 0; row < ww; row++;)
{
    for (var column = 2; column < hh; column++;)
    {
		if (yy > 64) {
			draw_text(xx, yy, string(file_grid[# row, column]));
		}
        yy += 32;
    }
	
    yy = scroll_y;
	
	switch (row) {
		case 0:
			xx += cell_spacing*3;
			break;
		case 3:
			xx += cell_spacing*2;
			break;
		case 6:
			xx += cell_spacing*2;
			break;
		default:
			xx += cell_spacing*1;
	}
}

var xx = 32;
var yy = 32;
// Always draw text for the keys.
for (var row = 0; row < ww; row++;)
{
    draw_text_colour(xx, yy, string(file_grid[# row, 0]), c_blue, c_blue, c_blue, c_blue, 255);
	draw_text_colour(xx, yy + 32, string(file_grid[# row, 1]), c_blue, c_blue, c_blue, c_blue, 255);
	
    switch (row) {
	case 0:
		xx += cell_spacing*3;
		break;
	case 3:
		xx += cell_spacing*2;
		break;
	case 6:
		xx += cell_spacing*2;
		break;
	default:
		xx += cell_spacing*1;
	}
}
