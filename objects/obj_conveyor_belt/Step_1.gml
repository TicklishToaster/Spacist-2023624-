//// Inherit the parent event
//event_inherited();


///// @description Animation 
//animation_speed		= room_speed / 60 / 2;
//animation_frame		= clamp(animation_frame + animation_speed * conveyor_direction, 0, animation_frame_max);

//if (conveyor_direction == 1 && animation_frame >= animation_frame_max) {
//	animation_frame = 0;
//}
//else if (conveyor_direction == -1 && animation_frame <= 0) {
//	animation_frame = animation_frame_max;
//}


///// @description Animation 
//animation_speed		= room_speed / 60 / 4;
//animation_frame		= clamp(animation_frame + animation_speed, 0, animation_frame_max);

//if (animation_frame >= animation_frame_max) {
//	animation_frame = 0;
//}

//for (var i = 0; i < ex_inv_max_size(inv_building); ++i) {
//    // code here
//	if (ex_item_get_amount(inv_building, i) <= 0 && ex_inv_size(inv_building) != i + 1) {
//	    // code here
//		ex_inv_sort(inv_building, EX_COLS.index, true);
//	}
//}
//var sort_list = false
//for (var i = 0; i < ex_inv_size(inv_building); ++i) {
//    // code here
//	show_debug_message(ex_inv_size(inv_building))
//	show_debug_message(i)
//	show_debug_message("check")
//	if (ex_item_get_amount(inv_building, i) <= 0) {
//		sort_list = true;
//		var target_index = i;
//		show_debug_message("HAPPEN")
//		break;
//	}
//	//else {
//	//    // code here
//	//}
	
//	//if (ex_item_get_amount(inv_building, i) <= 0 && ex_inv_size(inv_building) != i + 1) {
//	//    // code here
//	//	ex_inv_sort(inv_building, EX_COLS.index, true);
//	//}
//}
//if (sort_list) { 
//	ex_inv_sort(inv_building, EX_COLS.index, true);
//	ds_list_delete(item_instance.item_list, target_index);
//}

//ex_inv_sort(inv_building, EX_COLS.index, true);


//var sort_list = false
//for (var i = 0; i < ex_inv_size(inv_building); ++i) {
//	if (ex_item_get_amount(inv_building, i) <= 0) {
//		sort_list = true;
//		var target_index = i;
//		break;
//	}
//}
//if (sort_list) { 
//	ex_inv_sort(inv_building, EX_COLS.index, true);
//	ds_list_delete(item_instance.item_list, target_index);
//}