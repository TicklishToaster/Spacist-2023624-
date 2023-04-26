
if (ds_list_size(item_list) < ex_inv_size(creator.inv_building)) {
	//ds_list_sort(item_list, false);
	ds_list_add(item_list, 0);
	//ds_list_sort(item_list, false);
	//show_debug_message("YUP")
}


for (var i = 0; i < ds_list_size(item_list); ++i) {
	var current_item_x = ds_list_find_value(item_list, i)
	//ds_list_set(item_list, i, current_value + 1);
	//ds_list_set(item_list, i, clamp(current_value + 1, 0, 32*4 - i*32));
	//ds_list_set(item_list, i, clamp(current_item_x + 1, 0, 32*(4 - i)));
	//ds_list_set(item_list, i, clamp(current_item_x + 1, 0, 32 - (32/4)*i));
	ds_list_set(item_list, i, clamp(current_item_x + obj_conveyor_manager.animation_speed, 0, 32 - (32/4)*i));
	//show_debug_message(ds_list_find_value(item_list, i))
	
	if (ds_list_size(item_list) > 2) {
	    //show_debug_message(current_item_x)
	}
	//show_debug_message(current_item_x)
}
//show_debug_message("")


//item01 = [ex_item_get_item(creator.inv_building, 0), clamp(item01[1] + obj_conveyor_manager.animation_speed, 0, 32 - (8)*0)];
//item02 = [ex_item_get_item(creator.inv_building, 1), clamp(item02[1] + obj_conveyor_manager.animation_speed, 0, 32 - (8)*1)];
//item03 = [ex_item_get_item(creator.inv_building, 2), clamp(item03[1] + obj_conveyor_manager.animation_speed, 0, 32 - (8)*2)];
//item04 = [ex_item_get_item(creator.inv_building, 3), clamp(item04[1] + obj_conveyor_manager.animation_speed, 0, 32 - (8)*3)];