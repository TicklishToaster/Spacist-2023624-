animation_speed		= room_speed / 60 / 2;
animation_frame		= 0
animation_frame_max = 32;


conveyor_count = 0;
conveyor_list = ds_grid_create(0, 0);


// Redefine conveyor list contents whenever the total number of conveyor belts changes.
if (conveyor_count != instance_number(obj_conveyor_belt)) {
	// Set conveyor count to the number of conveyor belt instances.
	conveyor_count = instance_number(obj_conveyor_belt);
	// Overwrite conveyor list with a new grid data structure.
	conveyor_list = ds_grid_create(2, conveyor_count);
	
	// Iterate through all conveyor belts and add thier respective id and x position to conveyor list.
    for (var i = 0; i < conveyor_count; ++i) {
		ds_grid_set(conveyor_list, 0, i, instance_find(obj_conveyor_belt, i).id);
		ds_grid_set(conveyor_list, 1, i, instance_find(obj_conveyor_belt, i).x);
	}
	
	// Sort conveyor list in descending order using x positions.
	ds_grid_sort(conveyor_list, 1, false);
}