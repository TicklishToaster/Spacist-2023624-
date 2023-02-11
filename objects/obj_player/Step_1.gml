// Check if player is state_grounded.
state_grounded = place_meeting(x, y + 1, obj_floor);
if (state_grounded) {
	grounded_ypos = y;
	jump_distance = 1;
}
else {
	jump_distance = grounded_ypos - y;
	//show_debug_message(jump_distance);
}

// Update Hotspot (Center of Player Sprite)
hotspot_x = x + sprite_width / 2;
hotspot_y = y + sprite_height/ 2;

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

//// Update Grapple Edge (Tip of the Grapple Launcher)
//var orgi_x = x + sprite_get_xoffset(spr_player_rope_launcher)*image_xscale;
//var orgi_y = y + sprite_get_yoffset(spr_player_rope_launcher);

////var my_point = point_direction(orgi_x, orgi_y, sprite);
////var my_dist = point_distance();
//var my_x = lengthdir_x(sprite_get_width(spr_player_rope_launcher), aim_angle+90)/2.5;
//var my_y = lengthdir_y(sprite_get_height(spr_player_rope_launcher), aim_angle+90)/2.5;

//draw_line_width_colour(orgi_x, orgi_y, orgi_x + my_x, orgi_y + my_y, 5, c_orange, c_white)