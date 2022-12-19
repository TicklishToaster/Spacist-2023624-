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
	grapple_hotspot_x = grapple_origin_x + lengthdir_x(sprite_get_width(spr_player_rope_launcher), aim_angle+90) / 4.5;
	grapple_hotspot_y = grapple_origin_y + lengthdir_y(sprite_get_height(spr_player_rope_launcher), aim_angle+90) / 4.5;
}

// Draw Center ////////////////////////////////////////////////////////////////
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

//var input_hold_m2 = mouse_check_button(mb_right);
//if (input_hold_m2 && !grapple_mode) {
//	//draw_line_width_color(hotspot_x, hotspot_y, mouse_x, mouse_y, 5, c_white, c_white)
//	draw_line_width_colour(x+sprite_get_xoffset(animation_id_r)*image_xscale, y+sprite_get_yoffset(animation_id_r), mouse_x, mouse_y, 5, c_white, c_white)
//}

//draw_line_width_colour(grapple_origin_x, grapple_origin_y, grapple_hotspot_x, grapple_hotspot_y, 5, c_orange, c_white)