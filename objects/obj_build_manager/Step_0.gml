// Build Controls /////////////////////////////////////////////////////////////
// Toggle build mode if a building item is currently selected.
var selected_item = ex_item_get_item(global.inv_toolbar, array_get_index(obj_inv_panel_toolbar.slots, obj_inv_panel_toolbar.selected_slot))
if (ds_exists(selected_item, ds_type_map)) {
	if (selected_item[? "type"] == "building") {
		//show_debug_message(selected_item[? "key"]);
		//show_debug_message(selected_item[? "type"]);
		//show_debug_message(selected_item[? "category"]);
		//show_debug_message("");
		
		state_building = true;
		current_building = obj_parent_building;
		
		// Determine building sprites and other building variables.
		var script_returned_list = select_building(selected_item[? "key"]);
		current_building_id				= script_returned_list[0];
		current_building_sprite			= script_returned_list[1];
		//current_building_sprite_misc	= script_returned_list[2];
		//current_building_sprite_active= script_returned_list[1];
		//current_building_sprite_idle	= script_returned_list[2];
		current_building_repeating		= script_returned_list[2];
		
		current_building_type = selected_item[? "category"];
		
		// Determine snapped position for building to be placed.
		snap_dist = 128;
		snap_x = floor(mouse_x / snap_dist) * snap_dist;
		if (sprite_get_width(current_building_sprite)*4/2 % snap_dist == 0) {
			//snap_x = floor(mouse_x / snap_dist) * snap_dist - 32 - 32;
			//snap_x = floor(mouse_x / snap_dist) * snap_dist + 32;
			snap_x = floor(mouse_x / snap_dist) * snap_dist - 64;
		}
		snap_y = room_height - 32 * 5;
		
		if (input_mouse1_click && !state_selected) {
			state_selected	= true;
			state_repeating = current_building_repeating;
			snap_x_origin	= snap_x + snap_dist/2;
			snap_y_origin	= snap_y;
			input_mouse1_click = false;
		}
		
		if (input_mouse2_click && state_selected) {
			state_selected	= false;
			state_repeating = false;
			snap_x_origin	= 0;
			snap_y_origin	= 0;
		}
	}
}
else if (!state_selected) {
	state_building = false;
	current_building = noone;
}


if (state_selected) {
	if (input_mouse1_click && !state_repeating) {		
		var new_building = instance_create_layer(snap_x_origin, snap_y_origin, "Industry", current_building_id);
		with (new_building) {
			x					= other.snap_x_origin;
			y					= other.snap_y_origin;
			sprite_alpha		= 1;
			animation_frame		= 0;
			animation_frame_max = sprite_get_number(sprite_index);
			build_mode			= false;
		}
		
		state_building = false;
		state_selected = false;
	}
	
	if (input_mouse1_click && state_repeating) {
		var building_sprite		= current_building_sprite;
		var building_width		= sprite_get_width(building_sprite)*4;
		var repeating_distance	= snap_x_origin - snap_x;
		var repeating_direction = (repeating_distance / abs(repeating_distance)) * -1;
		repeating_distance		= abs(floor(repeating_distance/building_width) * building_width);
		var tile_number			= repeating_distance/building_width;
		for (var i = 0; i < tile_number + 1; i += 1) {			
			var new_building =	instance_create_layer(snap_x_origin + (i*building_width*repeating_direction), snap_y_origin, 
								"Logistics", current_building_id, {conveyor_direction : repeating_direction});
			with (new_building) {
				x					= other.snap_x_origin + (i*building_width*repeating_direction);
				y					= other.snap_y_origin;
				sprite_alpha		= 1;
				animation_frame		= 0;
				animation_frame_max = sprite_get_number(sprite_index);
				build_mode			= false;
			}
		}
		
		state_building = false;
		state_selected = false;		
	}
}