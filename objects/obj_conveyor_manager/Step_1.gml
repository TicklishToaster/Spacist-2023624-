/// @description Animation 
animation_speed		= room_speed / 60 / 2;
animation_frame		= clamp(animation_frame + animation_speed, 0, animation_frame_max);

if (animation_frame >= animation_frame_max) {
	animation_frame = 0;
	//animation_frame = animation_frame_max;
}

//animation_frame = 0;


//if (conveyor_count != instance_number(obj_conveyor_belt)) {
//	conveyor_count = instance_number(obj_conveyor_belt);
//	conveyor_list = ds_grid_create(2, conveyor_count);
	
//    for (var i = 0; i < conveyor_count; ++i) {
//		ds_grid_set(conveyor_list, 0, i, instance_find(obj_conveyor_belt, i).id);
//		ds_grid_set(conveyor_list, 1, i, instance_find(obj_conveyor_belt, i).x);
//	}

	
//	for (var i = 0; i < conveyor_count; ++i) {
//	    show_debug_message(string(ds_grid_get(conveyor_list, 0, i)) + " | " + string(ds_grid_get(conveyor_list, 1, i)));
//	}
	
//	ds_grid_sort(conveyor_list, 1, false);
	
//	show_debug_message("NEW")
//	show_debug_message("")	
//	for (var i = 0; i < conveyor_count; ++i) {
//	    show_debug_message(string(ds_grid_get(conveyor_list, 0, i)) + " | " + string(ds_grid_get(conveyor_list, 1, i)));
//	}
//	show_debug_message("")	
//	show_debug_message("")
//}