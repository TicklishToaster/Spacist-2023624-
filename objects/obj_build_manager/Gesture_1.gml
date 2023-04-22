//// Build Mode /////////////////////////////////////////////////////////////////
//if (state_building) {
//	// Draw grid outline.
//	draw_snap_to_grid();
	
//	//var building_scale	= 4;
//	//var building_sprite = current_building_sprite_idle;
//	var building_sprite = current_building_sprite;
//	var building_width	= sprite_get_width(building_sprite)*4;
//	var building_height = sprite_get_height(building_sprite)*4;
	
	
//	if (conveyor_connecting) {
//		draw_circle(snap_x, snap_y, 5, false)
//	}
	
	
//	if (!state_selected) {
//		draw_sprite_ext(building_sprite, 0, snap_x + snap_dist/2, snap_y, 4, 4, 0, c_white, 0.7);
		
//		//draw_rectangle(
//		//	snap_x - building_width/2 - 32, 
//		//	snap_y, 
//		//	snap_x + building_width/2 + 32, 
//		//	snap_y - building_height, 
//		//	true);
		
//		//draw_line_width(snap_x, snap_y, snap_x, snap_y - building_height, 3);
//		////draw_line_width(snap_x + building_width/2, snap_y, snap_x + building_width/2, snap_y - building_height, 3);
//		//draw_line_width(snap_x + snap_dist, snap_y, snap_x + snap_dist, snap_y - building_height, 3);
		
//	}
	
//	if (state_selected) {
//		//if (collision_point(snap_x_origin, snap_y_origin-32, obj_building_connector, false, false)) {
//		//	draw_circle(snap_x_origin, snap_y_origin, 5, false)
//		//	show_debug_message(collision_point(snap_x_origin, snap_y_origin-32, obj_building_connector, false, false))
//		//}
		
//		if (!state_repeating) {
//			draw_sprite_ext(building_sprite, 0, snap_x_origin, snap_y_origin, 4, 4, 0, c_white, 0.7);
//		}
	
//		if (state_repeating) {
//			draw_sprite_ext(building_sprite, 0, snap_x_origin, snap_y_origin, 4, 4, 0, c_white, 0.7);
		
//			var repeating_distance	= snap_x_origin - snap_x;
//			var repeating_direction = (repeating_distance / abs(repeating_distance)) * -1;
//			repeating_distance		= abs(floor(repeating_distance/building_width) * building_width);
//			var tile_number			= repeating_distance/building_width;	
//			var repeat_snap_x = ceil(snap_x/repeating_distance) * repeating_distance;		
		
//			for (var i = 1; i < tile_number + 1; i += 1) {
//				draw_sprite_ext(building_sprite, 0, 
//					snap_x_origin + (i*building_width*repeating_direction), 
//					snap_y, 
//					4, 4, 0, c_white, 0.7);
//			}
//		}
//	}
//}