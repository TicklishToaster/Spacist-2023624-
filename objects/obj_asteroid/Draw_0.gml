
// Draw Center ////////////////////////////////////////////////////////////////
draw_sprite_ext(sprite_index, sprite_frame,
	x, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);

// Draw Left //////////////////////////////////////////////////////////////////
draw_sprite_ext(sprite_index, sprite_frame,
	x+room_width*-1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Draw Right /////////////////////////////////////////////////////////////////
draw_sprite_ext(sprite_index, sprite_frame,
	x+room_width*+1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
