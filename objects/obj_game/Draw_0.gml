

if (obj_player.state_building) {
	var grid_offset_y = 160-32;
	var grid_offset_y = 0;
	draw_set_alpha(0.3);
	
	// Draw Horizontal Lines
	for (var i = 0; i < room_height/32 + 1; i += 1) {
		var draw_width = 1;
		if (i % 10 == 0) {draw_width = 3;}
		
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
		if (i % 10 == 0) {draw_width = 3;}
		
		draw_line_width(
			(32 * i), 
			0, 
			(32 * i), 
			room_height,
			draw_width
		);		
	}
	
	var snap_x = floor(mouse_x/32)*32;
	var snap_y = ceil(mouse_y/32)*32;
	
	show_debug_message(obj_player.current_building.sprite_width)
	
	draw_sprite_ext(obj_player.current_building.sprite_index, -1, snap_x, snap_y, 8, 8, 0, -1, 1);	
	
	//var transparent_building = draw_sprite_ext(obj_player.current_building, -1, mouse_x, mouse_y, 1, 1, 0, -1, 1);
	//with (transparent_building) {
	//	place_snapped(32, 32);
	//}
	
	draw_set_alpha(1.0);
}











////DEBUGGING CODE
//draw_line_width(
//	0, 0, 
//	0, creator.grapple_mode_height, 
//	4);
//draw_line_width(
//	room_width, 0, 
//	room_width, creator.grapple_mode_height, 
//	4);
	

//draw_line_width(
//	horizontal_origin + horizontal_limit, 0, 
//	horizontal_origin + horizontal_limit, creator.grapple_mode_height, 
//	2);
	
//draw_line_width(
//	horizontal_origin - horizontal_limit, 0, 
//	horizontal_origin - horizontal_limit, creator.grapple_mode_height, 
//	2);	
	
//draw_line_width(
//	horizontal_origin + horizontal_limit, creator.grapple_mode_height - 256, 
//	horizontal_origin - horizontal_limit, creator.grapple_mode_height - 256, 
//	2);
	
//draw_line_width(
//	horizontal_origin + horizontal_limit, creator.grapple_mode_height/2, 
//	horizontal_origin - horizontal_limit, creator.grapple_mode_height/2, 
//	2);
	
//draw_line_width(
//	horizontal_origin + horizontal_limit, 1280 - obj_camera.camera_height, 
//	horizontal_origin - horizontal_limit, 1280 - obj_camera.camera_height, 
//	2);	

//var row_height = 196;
//for (var row = 1; row < 6; ++row) {
//	draw_line_width(0, row*row_height, room_width, row*row_height, 4);
//}