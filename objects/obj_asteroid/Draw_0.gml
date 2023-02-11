

// Draw Center ////////////////////////////////////////////////////////////////
draw_sprite_ext(sprite_index, -1,
	x, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);

// Draw Left //////////////////////////////////////////////////////////////////
draw_sprite_ext(sprite_index, -1,
	x+room_width*-1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Draw Right /////////////////////////////////////////////////////////////////
draw_sprite_ext(sprite_index, -1,
	x+room_width*+1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
