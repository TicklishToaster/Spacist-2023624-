// Draw Default
draw_sprite_ext(sprite_index, image_index,
	x, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Draw Up
draw_sprite_ext(sprite_index, image_index,
	x, y+room_height*1,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);

// Draw Down
draw_sprite_ext(sprite_index, image_index,
	x, y+room_height*-1,
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