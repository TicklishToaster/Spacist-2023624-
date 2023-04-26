
if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer == 0) {
	active_mode = true;
	switch (ex_item_get_key(inv_building, 0)) {
	    case "resource_copper_ore":
			recipe_timer = 2;
	        break;
	    case "resource_iron_ore":
			recipe_timer = 2;
	        break;
	    case "resource_steel_debris":
			recipe_timer = 2;
	        break;
	    case "resource_bauxite_chunk":
			recipe_timer = 2;
	        break;
	    case "resource_titanium_debris":
			recipe_timer = 2;
	        break;
	    case "resource_gold_ore":
			recipe_timer = 2;
	        break;
	    default:
			recipe_timer = 0;
			active_mode = false;
	        break;
	}
}
else if (ex_item_get_amount(inv_building, 0) <= 0) {
	active_mode = false;
}


if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer > 0 && active_mode) {
	recipe_timer = clamp(recipe_timer - room_speed / 60 / 60, 0, recipe_timer);
}

if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer <= 0 && active_mode) {
	if (ex_item_get_amount(inv_building, 1) < 32) {
		switch (ex_item_get_key(inv_building, 0)) {
		    case "resource_copper_ore":
				ex_item_remove(	inv_building, "resource_copper_ore", 1, 0)
				ex_item_add(	inv_building, "resource_copper_ingot", 1, 1)
		        break;
		    case "resource_iron_ore":
				ex_item_remove(	inv_building, "resource_iron_ore", 1, 0)
				ex_item_add(	inv_building, "resource_iron_ingot", 1, 1)
		        break;
		    case "resource_steel_debris":
				ex_item_remove(	inv_building, "resource_steel_debris", 1, 0)
				ex_item_add(	inv_building, "resource_steel_ingot", 1, 1)
		        break;
		    case "resource_bauxite_chunk":
				ex_item_remove(	inv_building, "resource_bauxite_chunk", 1, 0)
				ex_item_add(	inv_building, "resource_aluminium_ingot", 1, 1)
		        break;
		    case "resource_titanium_debris":
				ex_item_remove(	inv_building, "resource_titanium_debris", 1, 0)
				ex_item_add(	inv_building, "resource_titanium_ingot", 1, 1)
		        break;
		    case "resource_gold_ore":
				ex_item_remove(	inv_building, "resource_gold_ore", 1, 0)
				ex_item_add(	inv_building, "resource_gold_ingot", 1, 1)
		        break;
		    default:
		        break;
		}
	}
}

if (instance_exists(target_conveyor_output)) {
	if (ex_inv_size(target_conveyor_output.inv_building) != 1) {
		ex_item_move(inv_building, 1, target_conveyor_output.inv_building, 1, -1, false);
	}
}