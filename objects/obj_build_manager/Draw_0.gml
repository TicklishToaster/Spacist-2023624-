
// Build Mode /////////////////////////////////////////////////////////////////
var selected_item = ex_item_get_item(global.inv_toolbar, array_get_index(obj_inv_panel_toolbar.slots, obj_inv_panel_toolbar.selected_slot))
if (ds_exists(selected_item, ds_type_map)) {
	// Draw grid outline.
	if (selected_item[? "key"] == "tool_blueprint") {	
		draw_snap_to_grid();
	}
	
	if (selected_item[? "key"] == "tool_blueprint" && target_building_sprite != noone) {
		if (!state_build_selected && target_building_sprite != spr_raised_platform) {			
			draw_sprite_ext(target_building_sprite, 0, snap_x + snap_dist/2, snap_y, 4, 4, 0, c_white, 0.7);
		}
		else if (!state_build_selected && target_building_sprite == spr_raised_platform) {			
			draw_sprite_ext(target_building_sprite, 0, snap_x + snap_dist/2, snap_y, 1, 1, 0, c_white, 0.7);
		}
		if (state_build_selected && !target_building_repeating) {
			var collision_list = ds_list_create();
			var building_overlap = collision_rectangle_list(
				snap_x_origin - sprite_get_width(target_building_sprite)  * 2, 
				snap_y_origin - sprite_get_height(target_building_sprite) * 2, 
				snap_x_origin + sprite_get_width(target_building_sprite)  * 2,
				snap_y_origin - 4,
				obj_parent_building, false, true, collision_list, false
			);
			
			var validate = true;
			for (var i = 0; i < building_overlap; ++i) {
				var target = ds_list_find_value(collision_list, i);				
				if (target.sprite_index != spr_conveyor_belt && target.sprite_index != spr_raised_platform) {
					validate = false;
					break;
				}
			}
			if (validate == true) {
				draw_sprite_ext(target_building_sprite, 0, snap_x_origin, snap_y_origin, 4, 4, 0, c_lime, 0.7);			
			}
			if (validate != true) {
				draw_sprite_ext(target_building_sprite, 0, snap_x_origin, snap_y_origin, 4, 4, 0, c_orange, 0.7);			
			}
		}

		if (state_build_selected && target_building_repeating) {
			if (target_building_sprite == spr_conveyor_belt) {
				var building_width		= sprite_get_width(target_building_sprite)*4;
				var repeating_distance	= snap_x_origin - snap_x;
				var repeating_direction = (repeating_distance / abs(repeating_distance)) * -1;
				repeating_distance		= abs(floor(repeating_distance/building_width) * building_width);
				var tile_number			= repeating_distance/building_width;
			
				for (var i = 0; i < tile_number + 1; i += 1) {				
					var building_overlap = collision_rectangle(
						snap_x_origin - sprite_get_width(target_building_sprite)  * 2 + (i*building_width*repeating_direction), 
						snap_y_origin - sprite_get_height(target_building_sprite) * 2, 
						snap_x_origin + sprite_get_width(target_building_sprite)  * 2 + (i*building_width*repeating_direction),
						snap_y_origin + 0,
						obj_conveyor_belt, false, true
					);
			
					if (building_overlap == noone) {
						draw_sprite_ext(target_building_sprite, 0, 
							snap_x_origin + (i*building_width*repeating_direction), 
							snap_y, 
							4, 4, 0, c_lime, 0.7);
					}
					else {
						draw_sprite_ext(target_building_sprite, 0, 
							snap_x_origin + (i*building_width*repeating_direction), 
							snap_y, 
							4, 4, 0, c_orange, 0.7);
					}
				}
			}
			
			if (target_building_sprite == spr_raised_platform) {
				//var collision_list = ds_list_create();
				//var building_overlap = collision_rectangle_list(
				//	snap_x_origin, 
				//	snap_y_origin, 
				//	snap_x_origin + sprite_get_width(target_building_sprite)  * 1,
				//	snap_y_origin - sprite_get_height(target_building_sprite) * 1,
				//	obj_parent_building, false, true, collision_list, false
				//);
		
				//var validate = true;			
				//for (var i = 0; i < building_overlap; ++i) {
				//	var target = ds_list_find_value(collision_list, i);
				//	if (target.sprite_index == spr_raised_platform) {
				//		validate = false;
				//		break;
				//	}
				//}	
			
				var building_width		= sprite_get_width(target_building_sprite)*1;
				var repeating_distance	= snap_x_origin - snap_x;
				var repeating_direction = (repeating_distance / abs(repeating_distance)) * -1;
				repeating_distance		= abs(floor(repeating_distance/building_width) * building_width);
				var tile_number_x		= floor(repeating_distance/building_width);
				
				var snap_ym = (floor(mouse_y / snap_dist) * snap_dist);
				var building_height		= sprite_get_height(target_building_sprite)*1;
				var repeating_distance	= snap_y_origin - snap_ym;
				var repeating_direction = (repeating_distance / abs(repeating_distance)) * -1;
				repeating_distance		= abs(floor(repeating_distance/building_height) * building_height);
				var tile_number_y		= floor(repeating_distance/building_height);
				
				tile_number_x = max(tile_number_x, 1);
				tile_number_y = max(tile_number_y, 1);					
				
				var collision_list = ds_list_create();
				var building_overlap = collision_rectangle_list(
					snap_x_origin + 8, 
					snap_y_origin - 8, 
					snap_x_origin + sprite_get_width(target_building_sprite)  * tile_number_x - 8,
					snap_y_origin - sprite_get_height(target_building_sprite) * tile_number_y + 8,
					obj_parent_building, true, true, collision_list, false
				);
		
				var validate = true;			
				for (var i = 0; i < building_overlap; ++i) {
					var target = ds_list_find_value(collision_list, i);
					if (target.sprite_index == spr_raised_platform) {
						var overlap_check = rectangle_in_rectangle(
							snap_x_origin + 8, 
							snap_y_origin - 8, 
							snap_x_origin + sprite_get_width(target_building_sprite)  * tile_number_x - 8,
							snap_y_origin - sprite_get_height(target_building_sprite) * tile_number_y + 8,
							target.xx1,
							target.yy1,
							target.xx2,
							target.yy2
						);
						if (overlap_check != 0) {
							validate = false;
							break;
						}						
					}
				}
				if (validate == true) {
					draw_sprite_ext(target_building_sprite, -1, 
						snap_x_origin, snap_y_origin, 
						tile_number_x, tile_number_y,
						0, c_lime, 0.7
					);
				}
				if (validate == false) {
					draw_sprite_ext(target_building_sprite, -1, 
						snap_x_origin, snap_y_origin, 
						tile_number_x, tile_number_y,
						0, c_orange, 0.7
					);
				}			
			}
		}
	}
}

//for (var i = 0; i < instance_number(obj_platform); ++i) {
//	// code here
//	var target_platform = instance_find(obj_platform, i);
//	var platform_width	= sprite_get_width(target_platform.sprite_index)  * target_platform.image_xscale;
//	var platform_height = sprite_get_height(target_platform.sprite_index) * target_platform.image_yscale;
//	draw_rectangle(
//		target_platform.x, 
//		target_platform.y - platform_height - 32*4, 
//		target_platform.x + platform_width, 
//		target_platform.y - platform_height - 0, 
//		false
//	);
//}