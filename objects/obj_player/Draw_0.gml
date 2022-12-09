var input_hold_m2 = mouse_check_button(mb_right);
if (input_hold_m2 && !grapple_mode) {
	draw_line_width_color(hotspot_x, hotspot_y, mouse_x, mouse_y, 5, c_white, c_white)
}


// Draw Default
draw_sprite_ext(sprite_index, image_index,
	x, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);

// Draw Left
draw_sprite_ext(sprite_index, image_index,
	x+room_width*-1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);

// Draw Right
draw_sprite_ext(sprite_index, image_index,
	x+room_width*1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);