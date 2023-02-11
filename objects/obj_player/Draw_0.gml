// Update Hotspot (Center of Player Sprite)
hotspot_x = x + sprite_width/2;
hotspot_y = y + sprite_height/2;

// Update Scale and Blending of Shadow Sprite
var shadow_scale = clamp(128/jump_distance, 0, 1);

// Update Grapple Origin (Center of Grapple Launcher)
if (state_grappling || state_aiming || state_retrieving) {
	grapple_origin_x = x + sprite_get_xoffset(spr_player_rope_launcher)*image_xscale;
	grapple_origin_y = y + sprite_get_yoffset(spr_player_rope_launcher);
}

// Update Grapple Hotspot (Tip of the Grapple Launcher)
if (state_grappling || state_aiming || state_retrieving) {
	grapple_hotspot_x = grapple_origin_x + lengthdir_x(sprite_get_width(spr_player_rope_launcher), aim_angle+90)  / 1 + 50;
	grapple_hotspot_y = grapple_origin_y + lengthdir_y(sprite_get_height(spr_player_rope_launcher), aim_angle+90) / 1 + 50;
}

// Draw Center ////////////////////////////////////////////////////////////////
// Grapple Chain
with (obj_grapple_chain) {
	x = creator.grapple_origin_x;
	y = creator.grapple_origin_y;
	var chain_len = point_distance(x, y, obj_hook.x, obj_hook.y) / sprite_get_height(spr_chain);
	var chain_ang = point_direction(x, y, obj_hook.x, obj_hook.y);

	draw_sprite_ext(spr_chain, -1,
		x, y,
		image_xscale, chain_len,
		chain_ang-90, image_blend, image_alpha);
}

// Grapple Hook
with (obj_hook) {
	draw_sprite_ext(sprite_index, img_index, x, y, 1, 1, img_rot, -1, 1);
}


// Draw Center ////////////////////////////////////////////////////////////////
// Shadow
draw_sprite_ext(animation_shadow, -1,
	x+(128-32)*image_xscale, grounded_ypos+(210-32),
	shadow_scale, shadow_scale,
	image_angle, image_blend, shadow_scale);

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
	(x+(128-32)*image_xscale) + room_width*-1, grounded_ypos+(210-32),
	shadow_scale, shadow_scale,
	image_angle, image_blend, shadow_scale);

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
	(x+(128-32)*image_xscale) + room_width*1, grounded_ypos+(210-32),
	shadow_scale, shadow_scale,
	image_angle, image_blend, shadow_scale);
	
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

// DEBUGGING CODE
//var throw_x = lengthdir_x(3.0*20, aim_angle_target);
//var throw_y = lengthdir_y(3.0*20, aim_angle_target);
//var nx = grapple_origin_x + throw_x;
//var ny = grapple_origin_y + throw_y;

//draw_line_width(grapple_origin_x, grapple_origin_y, nx, ny, 3);