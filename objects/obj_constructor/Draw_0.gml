// Draw active sprite.
if (active_mode) {
	draw_sprite_ext(sprite_active, animation_frame, x, y, image_xscale, image_yscale, 0, c_white, 1);
}
// Draw inactive sprite.
else if (!active_mode) {
	draw_sprite_ext(sprite_idle, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
}