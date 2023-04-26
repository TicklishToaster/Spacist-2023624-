
// Draw Sprite ////////////////////////////////////////////////////////////////
for (var i = -1; i < 2; ++i) {
	draw_sprite_ext(sprite_default, animation_frame,
		x+room_width*i, y,
		image_xscale, image_yscale,
		image_angle, -1, image_alpha);
	draw_sprite_ext(sprite_overlay, animation_frame,
		x+room_width*i, y,
		image_xscale, image_yscale,
		image_angle, -1, image_alpha);
}