//// Redefine conveyor list contents whenever the total number of conveyor belts changes.
//if (conveyor_count != instance_number(obj_conveyor_belt)) {
//	// Set conveyor count to the number of conveyor belt instances.
//	conveyor_count = instance_number(obj_conveyor_belt);
//	// Overwrite conveyor list with a new grid data structure.
//	conveyor_list = ds_grid_create(2, conveyor_count);
	
//	// Iterate through all conveyor belts and add thier respective id and x position to conveyor list.
//    for (var i = 0; i < conveyor_count; ++i) {
//		ds_grid_set(conveyor_list, 0, i, instance_find(obj_conveyor_belt, i).id);
//		ds_grid_set(conveyor_list, 1, i, instance_find(obj_conveyor_belt, i).x);
//	}
	
//	// Sort conveyor list in descending order using x positions.
//	ds_grid_sort(conveyor_list, 1, false);
//}

// Redefine conveyor list contents whenever the total number of conveyor belts changes.
if (conveyor_count != instance_number(obj_conveyor_belt)) {
	conveyor_count = instance_number(obj_conveyor_belt);
	conveyor_list = ds_grid_create(2, conveyor_count);
	
    for (var i = 0; i < conveyor_count; ++i) {
		ds_grid_set(conveyor_list, 0, i, instance_find(obj_conveyor_belt, i).id);
		ds_grid_set(conveyor_list, 1, i, instance_find(obj_conveyor_belt, i).x);
	}

	
	//for (var i = 0; i < conveyor_count; ++i) {
	//    show_debug_message(string(ds_grid_get(conveyor_list, 0, i)) + " | " + string(ds_grid_get(conveyor_list, 1, i)));
	//}
	
	ds_grid_sort(conveyor_list, 1, false);
	
	//show_debug_message("NEW")
	//show_debug_message("")	
	//for (var i = 0; i < conveyor_count; ++i) {
	//    show_debug_message(string(ds_grid_get(conveyor_list, 0, i)) + " | " + string(ds_grid_get(conveyor_list, 1, i)));
	//}
	//show_debug_message("")	
	//show_debug_message("")
}