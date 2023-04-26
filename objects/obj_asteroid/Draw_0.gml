// Draw Sprite ////////////////////////////////////////////////////////////////
for (var i = -1; i < 2; ++i) {
	draw_sprite_ext(item_sprite_index, item_sprite_frame,
		x+room_width*i, y,
		image_xscale, image_yscale,
		image_angle, item_colour, image_alpha);
}



//if (state_grounded && state_landed) {	
//	if (collision_point(mouse_x, mouse_y, obj_asteroid, true, false)) {
//		draw_set_font(fnt_poco);
//		draw_set_halign(fa_left);
//		draw_set_valign(fa_top);
//		//draw_text(mouse_x, mouse_y, "E: TAKE");
//		draw_text(mouse_x, mouse_y, "E: TAKE TO REFINERY");
//	}
//}