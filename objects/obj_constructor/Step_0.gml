
if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer == 0) {
	active_mode = true;
	switch (ex_item_get_key(inv_building, 0)) {
	    case "resource_limestone_chunk":
			recipe_timer = 2;
	        break;
	    case "resource_copper_ingot":
			recipe_timer = 2;
	        break;
	    case "resource_iron_ingot":
			recipe_timer = 3;
	        break;
	    case "resource_steel_ingot":
			recipe_timer = 4;
	        break;
	    case "resource_aluminium_ingot":
			recipe_timer = 3;
	        break;
	    case "resource_titanium_ingot":
			recipe_timer = 5;
	        break;
	    case "resource_gold_ingot":
			recipe_timer = 6;
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
		    case "resource_limestone_chunk":
				ex_item_remove(	inv_building, "resource_limestone_chunk", 1, 0)
				ex_item_add(	inv_building, "resource_concrete", 1, 1)
		        break;
		    case "resource_copper_ingot":
				ex_item_remove(	inv_building, "resource_copper_ingot", 1, 0)
				ex_item_add(	inv_building, "resource_copper_cable", 1, 1)
		        break;
		    case "resource_iron_ingot":
				ex_item_remove(	inv_building, "resource_iron_ingot", 1, 0)
				ex_item_add(	inv_building, "resource_iron_plate", 1, 1)
		        break;
		    case "resource_steel_ingot":
				ex_item_remove(	inv_building, "resource_steel_ingot", 1, 0)
				ex_item_add(	inv_building, "resource_steel_plate", 1, 1)
		        break;
		    case "resource_aluminium_ingot":
				ex_item_remove(	inv_building, "resource_aluminium_ingot", 1, 0)
				ex_item_add(	inv_building, "resource_aluminium_sheet", 1, 1)
		        break;
		    case "resource_titanium_ingot":
				ex_item_remove(	inv_building, "resource_titanium_ingot", 1, 0)
				ex_item_add(	inv_building, "resource_titanium_casing", 1, 1)
		        break;
		    case "resource_gold_ore":
				ex_item_remove(	inv_building, "resource_gold_ore", 1, 0)
				ex_item_add(	inv_building, "resource_gold_wire", 1, 1)
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