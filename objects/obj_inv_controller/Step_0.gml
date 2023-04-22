///@desc	handle user input


/*
	TOGGLE INVENTORIES
*/

if(keyboard_check_pressed(ord("I"))) {	
	if(inventory_is_open) { 
		event_user(INV_CONTROLLER_EVENTS.close_toggable_inventories);
	}
	else {
		event_user(INV_CONTROLLER_EVENTS.open_toggable_inventories);
	}
}

if (keyboard_check_pressed(ord("E"))) {
	if (collision_point(mouse_x, mouse_y, obj_parent_building, true, true)) {
		var target_inventory = collision_point(mouse_x, mouse_y, obj_parent_building, true, true);
		
		if (target_inventory.inv_building != -1) {		
			// Close every other open building inventory if they do not belong to the selected building.
			for (var i = 0; i < instance_number(obj_parent_building); i += 1) {
				if (instance_find(obj_parent_building, i) != target_inventory) {
					
					// Set foriegn inventories to close.
					instance_find(obj_parent_building, i).inv_open = false;
					
					// Close building inventory.
					ex_ui_panel_close(instance_find(obj_parent_building, i).inv_building_ui);
				}
			}
		
			// Open selected building inventory if it is currently closed.
			if (!target_inventory.inv_open) {
				// Set inventory to open.
				target_inventory.inv_open = true;
			
				// Open building inventory.
				ex_ui_panel_open(target_inventory.inv_building, target_inventory.inv_building_ui, 
				obj_camera.camera_width/2, 
				obj_camera.camera_height/2, layer);

			
			}
			// Close selected building inventory if it is currently open.
			else if (target_inventory.inv_open) {
				// Set inventory to close.
				target_inventory.inv_open = false;			
			
				// Close building inventory
				ex_ui_panel_close(target_inventory.inv_building_ui);
			}
		}
		else {
			// Close every other open building inventory if they do not belong to the selected building.
			for (var i = 0; i < instance_number(obj_parent_building); i += 1) {
				if (instance_find(obj_parent_building, i) != target_inventory) {
					
					// Check if building has an inventory.
					if (instance_find(obj_parent_building, i).inv_building != -1) {						
						// Set foriegn inventories to close.
						instance_find(obj_parent_building, i).inv_open = false;
					
						// Close building inventory.
						ex_ui_panel_close(target_inventory.inv_building_ui);
					}
				}
			}		
		}
	}
	
	
	
	else {
	// Close every other open building inventory if no building is selected.
		for (var i = 0; i < instance_number(obj_parent_building); i += 1) {
			// Set foriegn inventories to close.
			instance_find(obj_parent_building, i).inv_open = false;
					
			// Close building inventory.
			ex_ui_panel_close(instance_find(obj_parent_building, i).inv_building_ui);
			//ex_ui_panel_close(obj_inv_panel_building);
		}
	}
}

/*
	SAVE INVENTORIES
	
	Save all the player inventories to a single file in the sandbox.
*/

//if(keyboard_check_pressed(ord("S"))) {
//	var _file = file_text_open_write("ex/player_inventory.json");
//	file_text_write_string(_file, ex_inv_write(global.inv_mouse)); //inv_mouse
//	file_text_writeln(_file);
//	file_text_write_string(_file, ex_inv_write(global.inv_backpack)); //inv_player
//	file_text_writeln(_file);
//	file_text_write_string(_file, ex_inv_write(global.inv_toolbar)); //inv_toolbar
//	file_text_writeln(_file);
//	file_text_write_string(_file, ex_inv_write(global.inv_equipment)); //inv_equipment
//	file_text_writeln(_file);
//	//file_text_write_string(_file, ex_inv_write(global.inv_craft)); //inv_craft
//	//file_text_close(_file);
//	show_message_async("Inventories saved");
//}

/*
	LOAD INVENTORIES
	
	Load the player inventories from file
*/

if(keyboard_check_pressed(ord("L"))) {
	if(file_exists("ex/player_inventory.json")) {
		
		//destroy all current inventories, we are replacing them with the saved data
		event_user(INV_CONTROLLER_EVENTS.destroy_inventories);
		
		//read the file
		var _file = file_text_open_read("ex/player_inventory.json");
		global.inv_mouse = ex_inv_read(file_text_read_string(_file));
		file_text_readln(_file);
		global.inv_backpack = ex_inv_read(file_text_read_string(_file));
		file_text_readln(_file);
		global.inv_toolbar = ex_inv_read(file_text_read_string(_file));
		file_text_readln(_file);
		global.inv_equipment = ex_inv_read(file_text_read_string(_file));
		//file_text_readln(_file);
		//global.inv_craft = ex_inv_read(file_text_read_string(_file));
		
		//open the inventory panels again
		event_user(INV_CONTROLLER_EVENTS.open_static_inventories);
		if(inventory_is_open) {
			inventory_is_open = false;
			//event_user(INV_CONTROLLER_EVENTS.open_toggable_inventories);
		}
		
		show_message_async("Inventories loaded");
		
	}
}

