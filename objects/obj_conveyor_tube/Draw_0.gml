// Draw conveyor sprite using conveyor manager frames.
if (sprite_index != -1) {
	//draw_sprite_ext(sprite_misc, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);	
	draw_sprite_ext(sprite_index, obj_conveyor_manager.animation_frame, x, y, image_xscale, image_yscale, 0, c_white, 1);
	//draw_sprite_ext(sprite_misc, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
}


//// DEBUG
////if (connector_entrance != noone) {
////	draw_text(x, y - sprite_height/2, string(id))
////	//draw_text(x-sprite_width/2, y - sprite_height/1 + 8, string(connector_entrance))
////	draw_text(x-sprite_width/2 + 8, y - 8, string(connector_entrance))
////}
//if (connector_exit != noone) {
//	draw_text(x, y - sprite_height/4, string(id))
//	//draw_text(x+sprite_width/2, y - sprite_height/1 + 16, string(connector_exit))
//	draw_text(x+sprite_width/2 - 8, y - 16, string(connector_exit))
//}

////if (connector_building != noone) {
////	draw_text(x, y - sprite_height/2, string(id))
////	draw_text(x, y + sprite_height/2, string(connector_building))
////}

