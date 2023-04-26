
var cl = camera_get_view_x(view_camera[0])
var ct = camera_get_view_y(view_camera[0])
       
var off_x = mouse_x - cl // x is the normal x position
var off_y = mouse_y - ct // y is the normal y position
       
// convert to gui
var off_x_percent = off_x / camera_get_view_width(view_camera[0])
var off_y_percent = off_y / camera_get_view_height(view_camera[0])
       
var gui_x = off_x_percent * display_get_gui_width()
var gui_y = off_y_percent * display_get_gui_height()


// Build Controls /////////////////////////////////////////////////////////////
// Toggle build mode if the blueprint tool is currently selected.
var selected_item = ex_item_get_item(global.inv_toolbar, array_get_index(obj_inv_panel_toolbar.slots, obj_inv_panel_toolbar.selected_slot))
if (ds_exists(selected_item, ds_type_map)) {
	if (selected_item[? "key"] == "tool_blueprint") {
		if (target_building_key != noone) {
			snap_x = floor(mouse_x / snap_dist) * snap_dist;
			if (sprite_get_width(target_building_sprite)*4/2 % snap_dist == 0) {
				snap_x = floor(mouse_x / snap_dist) * snap_dist - 64;
			}
			snap_y = room_height - 32 * 5;
			
			for (var i = 0; i < instance_number(obj_platform); ++i) {
				var target_platform = instance_find(obj_platform, i);
				var platform_w	= sprite_get_width(target_platform.sprite_index) * target_platform.platform_width;
				var platform_h = sprite_get_height(target_platform.sprite_index) * target_platform.platform_height;
				if (point_in_rectangle(mouse_x, mouse_y, 
					target_platform.x, 
					target_platform.y - platform_h - 32*4, 
					target_platform.x + platform_w, 
					target_platform.y - platform_h)) 
					{				
					snap_y = target_platform.y - platform_h;
					break;
				}
			}
			
			if (target_building_sprite == spr_conveyor_tube) {
				for (var i = 0; i < instance_number(obj_conveyor_tube); ++i) {
					var target_tube = instance_find(obj_conveyor_tube, i);
					if (point_in_rectangle(mouse_x, mouse_y, 
						target_tube.x - 32*2,
						target_tube.y - 32*4, 
						target_tube.x + 32*2, 
						target_tube.y - 0)) 
						{				
						snap_y = target_tube.y - 32*4
						break;
					}
				}
			}
			
			if (!collision_point(gui_x, gui_y, obj_building_button, true, true)) {			
				// Prepare selected building placement.
				if (input_mouse1_click && !state_build_selected) {
					state_build_selected	= true;
					snap_x_origin			= snap_x + snap_dist/2;
					snap_y_origin			= snap_y;
					input_mouse1_click		= false;
					//game_end()
				}
		
				// Cancel selected building placement.
				if (input_mouse2_click && state_build_selected) {
					state_build_selected	= false;
					snap_x_origin			= 0;
					snap_y_origin			= 0;
				}
			}
		}
	}
}


if (input_mouse1_click && state_build_selected == true) {
	if (target_building_repeating == false) {
		var target_layer = "Industry";
		if (target_building_sprite == spr_conveyor_tube) {
			target_layer = "Logistics";
		}
		
		
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
			var new_building = instance_create_layer(snap_x_origin, snap_y_origin, target_layer, target_building_obj);			
			state_build_selected = false;			
		}
	}
		
	if (target_building_repeating == true) {
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
					var new_building =	instance_create_layer(
						snap_x_origin + (i*building_width*repeating_direction), 
						snap_y_origin, 
						"Logistics", target_building_obj
					);
					state_build_selected = false;
				}
			}
		}
		
		if (target_building_sprite == spr_raised_platform) {			
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
				var new_building =	instance_create_layer(
					snap_x_origin, snap_y_origin, 
					"Industry_Misc", target_building_obj, {
						platform_width : tile_number_x,
						platform_height : tile_number_y,
						xx1 : snap_x_origin + 8, 
						yy1 : snap_y_origin - 8, 
						xx2 : snap_x_origin + sprite_get_width(target_building_sprite)  * tile_number_x - 8, 
						yy2 : snap_y_origin - sprite_get_height(target_building_sprite) * tile_number_y + 8}
				);
				state_build_selected = false;
			}
		}
	}
}


//if (ds_exists(selected_item, ds_type_map)) {
//	if (selected_item[? "key"] == "tool_demolish") {
//		var destroy_building = collision_point(mouse_x, mouse_y, obj_parent_building, true, false);
//		if (destroy_building != noone) {
//			if (destroy_building.sprite_index != spr_deconstructive_refinery_base) {
//			    instance_destroy(destroy_building)
//			}
//		}
//	}
//}