// Update Hotspot (Center of Player Sprite)
hotspot_x = x + sprite_width/2;
hotspot_y = y + sprite_height/2;

// Update Grapple Origin (Center of Grapple Launcher)
if (state_grappling || state_aiming || state_retrieving) {
	grapple_origin_x = x + sprite_get_xoffset(spr_player_rope_launcher)*image_xscale;
	grapple_origin_y = y + sprite_get_yoffset(spr_player_rope_launcher);
}

// Update Grapple Hotspot (Tip of the Grapple Launcher)
if (state_grappling || state_aiming || state_retrieving) {
	grapple_hotspot_x = grapple_origin_x + lengthdir_x(sprite_get_width(spr_player_rope_launcher), aim_angle+90) / 1;
	grapple_hotspot_y = grapple_origin_y + lengthdir_y(sprite_get_height(spr_player_rope_launcher), aim_angle+90) / 1;
}

// Draw Center ////////////////////////////////////////////////////////////////
if (!state_jumping){
	// Shadow
	draw_sprite_ext(animation_shadow, -1,
		x, y,
		image_xscale, image_yscale,
		image_angle, image_blend, image_alpha);
}
// Main Body
draw_sprite_ext(animation_id, animation_index,
	x, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Tracks
draw_sprite_ext(animation_id_t, animation_index_t,
	x, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Right Arm
if (state_aiming && animation_index >= 4.9) || (state_grappling || state_retrieving) {
	draw_sprite_ext(animation_id_r, animation_index_r,
		grapple_origin_x, grapple_origin_y,
		image_xscale, image_yscale,
		aim_angle, image_blend, image_alpha);
} else {
	draw_sprite_ext(animation_id_r, animation_index_r,
		x, y,
		image_xscale, image_yscale,
		image_angle, image_blend, image_alpha);
}

// Draw Left //////////////////////////////////////////////////////////////////
// Shadow
draw_sprite_ext(animation_shadow, -1,
	x+room_width*-1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);

// Main Body
draw_sprite_ext(animation_id, animation_index,
	x+room_width*-1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Tracks
draw_sprite_ext(animation_id_t, animation_index_t,
	x+room_width*-1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
		
// Right Arm
if (state_aiming && animation_index >= 4.9) || (state_grappling || state_retrieving) {
	draw_sprite_ext(animation_id_r, animation_index_r,
		grapple_origin_x+room_width*-1, grapple_origin_y,
		image_xscale, image_yscale,
		aim_angle, image_blend, image_alpha);
} else {
	draw_sprite_ext(animation_id_r, animation_index_r,
		x+room_width*-1, y,
		image_xscale, image_yscale,
		image_angle, image_blend, image_alpha);
}

// Draw Right /////////////////////////////////////////////////////////////////
// Shadow
draw_sprite_ext(animation_shadow, -1,
	x+room_width*1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Main Body
draw_sprite_ext(animation_id, animation_index,
	x+room_width*1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
	
// Tracks	
draw_sprite_ext(animation_id_t, animation_index_t,
	x+room_width*1, y,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha);
		
// Right Arm
if (state_aiming && animation_index >= 4.9) || (state_grappling || state_retrieving) {
	draw_sprite_ext(animation_id_r, animation_index_r,
		grapple_origin_x+room_width*1, grapple_origin_y,
		image_xscale, image_yscale,
		aim_angle, image_blend, image_alpha);
} else {
	draw_sprite_ext(animation_id_r, animation_index_r,
		x+room_width*1, y,
		image_xscale, image_yscale,
		image_angle, image_blend, image_alpha);
}