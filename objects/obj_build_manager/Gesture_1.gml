///// @description OLD
//// You can write your code in this editor


//var cl = camera_get_view_x(view_camera[0])
//var ct = camera_get_view_y(view_camera[0])
       
//var off_x = mouse_x - cl // x is the normal x position
//var off_y = mouse_y - ct // y is the normal y position
       
//// convert to gui
//var off_x_percent = off_x / camera_get_view_width(view_camera[0])
//var off_y_percent = off_y / camera_get_view_height(view_camera[0])
       
//var gui_x = off_x_percent * display_get_gui_width()
//var gui_y = off_y_percent * display_get_gui_height()


//// Build Controls /////////////////////////////////////////////////////////////
//// Toggle build mode if the blueprint tool is currently selected.
//var selected_item = ex_item_get_item(global.inv_toolbar, array_get_index(obj_inv_panel_toolbar.slots, obj_inv_panel_toolbar.selected_slot))
//if (ds_exists(selected_item, ds_type_map)) {
//	if (selected_item[? "key"] == "tool_blueprint") {
//		if (target_building_key != noone) {
//			snap_x = floor(mouse_x / snap_dist) * snap_dist;
//			if (sprite_get_width(target_building_sprite)*4/2 % snap_dist == 0) {
//				snap_x = floor(mouse_x / snap_dist) * snap_dist - 64;
//			}
//			snap_y = room_height - 32 * 5;
			
			
//			if (!collision_point(gui_x, gui_y, obj_building_button, true, true)) {			
//				// Prepare selected building placement.
//				if (input_mouse1_click && !state_build_selected) {
//					state_build_selected	= true;
//					snap_x_origin			= snap_x + snap_dist/2;
//					snap_y_origin			= snap_y;
//					input_mouse1_click		= false;
//					//game_end()
//				}
		
//				// Cancel selected building placement.
//				if (input_mouse2_click && state_build_selected) {
//					state_build_selected	= false;
//					snap_x_origin			= 0;
//					snap_y_origin			= 0;
//				}
//			}
//		}
//	}
//}

////else if (!state_build_selected == false) {
////	state_building = false;
////	current_building = noone;
////}



//if (input_mouse1_click && state_build_selected == true) {
//	if (target_building_repeating == false) {		
//		var collision_list = ds_list_create();
//		var building_overlap = collision_rectangle_list(
//			snap_x_origin - sprite_get_width(target_building_sprite)  * 2, 
//			snap_y_origin - sprite_get_height(target_building_sprite) * 2, 
//			snap_x_origin + sprite_get_width(target_building_sprite)  * 2,
//			snap_y_origin + 0,
//			obj_parent_building, false, true, collision_list, false
//		);
		
//		var validate = true;
//		for (var i = 0; i < building_overlap; ++i) {
//			var target = ds_list_find_value(collision_list, i);
//			if (target.sprite_index != spr_conveyor_belt) {
//				validate = false;
//			}
//		}
		
//		if (validate == true) {
//			var new_building = instance_create_layer(snap_x_origin, snap_y_origin, "Industry", target_building_obj);			
//			state_build_selected = false;			
//		}
//	}
		
//	if (target_building_repeating == true) {
//		//var building_overlap = collision_rectangle(
//		//	snap_x_origin - sprite_get_width(target_building_sprite)  * 2, 
//		//	snap_y_origin - sprite_get_height(target_building_sprite) * 2, 
//		//	snap_x_origin + sprite_get_width(target_building_sprite)  * 2,
//		//	snap_y_origin + 0,
//		//	obj_conveyor_belt, false, true
//		//);
		
//		//var building_sprite		= current_building_sprite;
//		var building_width		= sprite_get_width(target_building_sprite)*4;
//		var repeating_distance	= snap_x_origin - snap_x;
//		var repeating_direction = (repeating_distance / abs(repeating_distance)) * -1;
//		repeating_distance		= abs(floor(repeating_distance/building_width) * building_width);
//		var tile_number			= repeating_distance/building_width;
		
		
		
//		for (var i = 0; i < tile_number + 1; i += 1) {
//			var building_overlap = collision_rectangle(
//				snap_x_origin - sprite_get_width(target_building_sprite)  * 2 + (i*building_width*repeating_direction), 
//				snap_y_origin - sprite_get_height(target_building_sprite) * 2, 
//				snap_x_origin + sprite_get_width(target_building_sprite)  * 2 + (i*building_width*repeating_direction),
//				snap_y_origin + 0,
//				obj_conveyor_belt, false, true
//			);
			
//			if (building_overlap == noone) {
//				var new_building =	instance_create_layer(
//					snap_x_origin + (i*building_width*repeating_direction), 
//					snap_y_origin, 
//					"Logistics", target_building_obj
//					//"Logistics", target_building_obj, 
//					//{conveyor_direction : repeating_direction}
//				);
//				state_build_selected = false;
//			}
//		}
		
//		//if (target_overlap == noone) {
//		//	//var building_sprite		= current_building_sprite;
//		//	var building_width		= sprite_get_width(target_building_sprite)*4;
//		//	var repeating_distance	= snap_x_origin - snap_x;
//		//	var repeating_direction = (repeating_distance / abs(repeating_distance)) * -1;
//		//	repeating_distance		= abs(floor(repeating_distance/building_width) * building_width);
//		//	var tile_number			= repeating_distance/building_width;
		
		
		
//		//	for (var i = 0; i < tile_number + 1; i += 1) {
//		//		var new_building =	instance_create_layer(
//		//			snap_x_origin + (i*building_width*repeating_direction), 
//		//			snap_y_origin, 
//		//			"Logistics", target_building_obj, 
//		//			{conveyor_direction : repeating_direction}
//		//		);
//		//	}
//		//	state_build_selected = false;
//		//}
//	}
//}
