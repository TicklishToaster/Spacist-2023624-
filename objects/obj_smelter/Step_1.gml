// Inherit the parent event
event_inherited();

// Reset connecting conveyor belt holders if instances no longer exist.
if (!instance_exists(target_conveyor_input)) {
	target_conveyor_input = noone;
}
if (!instance_exists(target_conveyor_output)) {
	target_conveyor_output = noone;
}


//if (ex_item_get_amount(inv_building, 0) > 0 && recipe_timer == 0) {
//	switch (ex_item_get_key(inv_building, 0)) {
//	    case "copper_ore":
//			recipe_timer = 2;
//	        break;
//	    case "iron_ore":
//			recipe_timer = 4;
//	        break;
//	    case "gold_ore":
//			recipe_timer = 8;
//	        break;
//	    default:
//			recipe_timer = 0;
//	        break;
//	}
//}