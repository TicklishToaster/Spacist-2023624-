///func		draw_snap_to_grid()

function draw_snap_to_grid() {
	// Draw snap to grid.
	var grid_offset_y = -32*7;
	draw_set_alpha(0.3);
	
	// Draw Horizontal Lines
	for (var i = 0; i < room_height/32 + 1; i += 1) {
		var draw_width = 1;
		if (i % 8 == 0) {draw_width = 3;}
		
		draw_line_width(
			0, 
			room_height - (32 * i) - grid_offset_y, 
			room_width, 
			room_height - (32 * i) - grid_offset_y,
			draw_width
		);
	}
	
	// Draw Vertical Lines
	for (var i = 0; i < room_width/32 + 1; i += 1) {
		var draw_width = 1;
		if (i % 8 == 0) {draw_width = 3;}
		
		draw_line_width(
			(32 * i), 
			0, 
			(32 * i), 
			room_height,
			draw_width
		);		
	}
	draw_set_alpha(1.0);
}