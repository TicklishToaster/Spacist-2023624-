// Draw each conveyor belts' respective item if there is one.
for (var i = 0; i < ds_list_size(item_list); ++i) {
	if (ex_item_get_amount(creator.inv_building, i) > 0) {
		var item = ex_item_get_item(creator.inv_building, i);
		var current_item_x = ds_list_find_value(item_list, i)
		var x_pos = creator.x - creator.sprite_width/2 + current_item_x * creator.image_xscale;
		x_pos -= sprite_get_width(item[? "sprite_index"])/1
		//var y_pos = creator.y - 24 * creator.image_yscale;
		//var y_pos = creator.y - 32 * creator.image_yscale;
		var y_pos = creator.y - creator.sprite_height
		draw_sprite_ext(item[? "sprite_index"], item[? "image_index"], x_pos, y_pos, 2, 2, 0, -1, 1);
	}
}
//var x_pos = creator.x - creator.sprite_width/2 + current_item_x * creator.image_xscale;
//x_pos -= sprite_get_width(item[? "sprite_index"])/1

//var y_pos = creator.y - creator.sprite_height;
//if (item01[0] != -1) {
//	show_debug_message(item01[0])
//    draw_sprite_ext(item01[0][? "sprite_index"], item01[0][? "image_index"], (creator.x - creator.sprite_width/2) + item01[1] * 4 - sprite_get_width(item01[0][? "sprite_index"]), y_pos, 2, 2, 0, -1, 1);
//}
//if (item02[0] != -1) {
//    draw_sprite_ext(item02[0][? "sprite_index"], item02[0][? "image_index"], (creator.x - creator.sprite_width/2) + item02[1] * 4 - sprite_get_width(item02[0][? "sprite_index"]), y_pos, 2, 2, 0, -1, 1);
//}
//if (item03[0] != -1) {
//    draw_sprite_ext(item03[0][? "sprite_index"], item03[0][? "image_index"], (creator.x - creator.sprite_width/2) + item03[1] * 4 - sprite_get_width(item03[0][? "sprite_index"]), y_pos, 2, 2, 0, -1, 1);
//}
//if (item04[0] != -1) {
//    draw_sprite_ext(item04[0][? "sprite_index"], item04[0][? "image_index"], (creator.x - creator.sprite_width/2) + item04[1] * 4 - sprite_get_width(item04[0][? "sprite_index"]), y_pos, 2, 2, 0, -1, 1);
//}
//draw_sprite_ext(item01[0][? "sprite_index"], item01[0][? "image_index"], (creator.x - creator.sprite_width/2) - item01[1] * 4, y_pos, 2, 2, 0, -1, 1);
//draw_sprite_ext(item02[0][? "sprite_index"], item02[0][? "image_index"], (creator.x - creator.sprite_width/2) - item02[1] * 4, y_pos, 2, 2, 0, -1, 1);
//draw_sprite_ext(item03[0][? "sprite_index"], item03[0][? "image_index"], (creator.x - creator.sprite_width/2) - item03[1] * 4, y_pos, 2, 2, 0, -1, 1);
//draw_sprite_ext(item04[0][? "sprite_index"], item04[0][? "image_index"], (creator.x - creator.sprite_width/2) - item04[1] * 4, y_pos, 2, 2, 0, -1, 1);
