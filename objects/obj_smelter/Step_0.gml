

////ex_item_add(inv_building, "resource_copper_cable", 1, 0);
//if (connection_exit.target_conveyor != noone) {
//	ex_item_move(inv_building, 0, connection_exit.target_conveyor.inv_building, -1);
//}


//if (connection_entrance.target_conveyor != noone) {
//	ex_item_move(inv_building, 0, connection_exit.target_conveyor.inv_building, -1);
//}

if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer == 0) {
	active_mode = true;
	switch (ex_item_get_key(inv_building, 0)) {
	    case "resource_copper_ore":
			recipe_timer = 2;
	        break;
	    case "resource_iron_ore":
			recipe_timer = 4;
	        break;
	    case "resource_gold_ore":
			recipe_timer = 8;
	        break;
	    default:
			recipe_timer = 0;
			active_mode = false;
	        break;
	}
}

if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer > 0 && active_mode) {
	recipe_timer = clamp(recipe_timer - room_speed / 60 / 60, 0, recipe_timer);
}

if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer <= 0 && active_mode) {
	switch (ex_item_get_key(inv_building, 0)) {
	    case "resource_copper_ore":
			ex_item_remove(	inv_building, "resource_copper_ore", 1, 0)
			ex_item_add(	inv_building, "resource_copper_ingot", 1, 1)
	        break;
	    case "resource_iron_ore":
			ex_item_remove(	inv_building, "resource_iron_ore", 1, 0)
			ex_item_add(	inv_building, "resource_iron_ingot", 1, 1)
	        break;
	    case "resource_gold_ore":
			ex_item_remove(	inv_building, "resource_gold_ore", 1, 0)
			ex_item_add(	inv_building, "resource_gold_ingot", 1, 1)
	        break;
	    default:
	        break;
	}
}


show_debug_message(active_mode)
show_debug_message(recipe_timer)
show_debug_message(ex_item_get_key(inv_building, 0))
show_debug_message("")