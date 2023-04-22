/// @description Insert description here
// You can write your code in this editor

//for (var i = 0; i < ex_inv_max_size(creator.inv_building); ++i) {
//    // code here
	
//}

//if (ds_list_size(item_list) > ex_inv_max_size(creator.inv_building)) {
//    // code here
//	ds_list_delete(item_list, 0);
//}
//else if (ds_list_size(item_list) < ex_inv_max_size(creator.inv_building)) {
//    // code here
//	ds_list_add(item_list, 0);
//}
if (ds_list_size(item_list) < ex_inv_size(creator.inv_building)) {
    // code here
	ds_list_add(item_list, 0);
}

for (var i = 0; i < ds_list_size(item_list); ++i) {
	var current_item_x = ds_list_find_value(item_list, i)
	//ds_list_set(item_list, i, current_value + 1);
	//ds_list_set(item_list, i, clamp(current_value + 1, 0, 32*4 - i*32));
	//ds_list_set(item_list, i, clamp(current_item_x + 1, 0, 32*(4 - i)));
	ds_list_set(item_list, i, clamp(current_item_x + 1, 0, 32 - (32/4)*i));
	//show_debug_message(ds_list_find_value(item_list, i))
}
//show_debug_message("")