
//// Draw each conveyor belts' respective item if there is one.
//if (ex_item_get_amount(creator.inv_building, 0) > 0) {
//	var item = ex_item_get_item(creator.inv_building, 0);
//	if (end_position == false) {
//		var x_pos = creator.x - creator.sprite_width/2 + obj_conveyor_manager.animation_frame * creator.image_xscale;
//	}
//	else {
//		var x_pos = creator.x - creator.sprite_width/2 + obj_conveyor_manager.animation_frame_max * creator.image_xscale;
//	}
//	x_pos -= sprite_get_width(item[? "sprite_index"])/2
//	//var y_pos = creator.y - 24 * creator.image_yscale;
//	var y_pos = creator.y - 32 * creator.image_yscale;
//	draw_sprite_ext(item[? "sprite_index"], item[? "image_index"], x_pos, y_pos, 1, 1, 0, -1, 1);
//}

//////if (creator.animation_frame == creator.animation_frame_max) {
////if (creator.animation_frame == 0) {
////    // code here
////	end_position = true;
////}
//if ((creator.animation_frame == 0 && creator.connector_exit == noone)) {
//	end_position = true;
//}
//else if (creator.animation_frame == 0 && creator.connector_exit.item_instance.end_position == true) {
//	end_position = true;
//}
//else {
//	end_position = false;
//	show_debug_message("FALSE")
//}


//// Draw each conveyor belts' respective item if there is one.
//if (ex_item_get_amount(creator.inv_building, 0) > 0) {
//	var item = ex_item_get_item(creator.inv_building, 0);
//	var x_pos = creator.x - creator.sprite_width/2 + obj_conveyor_manager.animation_frame * creator.image_xscale;
//	x_pos -= sprite_get_width(item[? "sprite_index"])/2
//	//var y_pos = creator.y - 24 * creator.image_yscale;
//	var y_pos = creator.y - 32 * creator.image_yscale;
//	draw_sprite_ext(item[? "sprite_index"], item[? "image_index"], x_pos, y_pos, 1, 1, 0, -1, 1);
//}

// Draw each conveyor belts' respective item if there is one.
for (var i = 0; i < ds_list_size(item_list); ++i) {
	if (ex_item_get_amount(creator.inv_building, i) > 0) {
		var item = ex_item_get_item(creator.inv_building, i);
		var current_item_x = ds_list_find_value(item_list, i)
		var x_pos = creator.x - creator.sprite_width/2 + current_item_x * creator.image_xscale;
		x_pos -= sprite_get_width(item[? "sprite_index"])/2
		//var y_pos = creator.y - 24 * creator.image_yscale;
		var y_pos = creator.y - 32 * creator.image_yscale;
		draw_sprite_ext(item[? "sprite_index"], item[? "image_index"], x_pos, y_pos, 1, 1, 0, -1, 1);
	}

}
