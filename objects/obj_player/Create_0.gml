// Global Variable Lever //////////////////////////////////////////////////////
m = 1;

// Movement Vars //////////////////////////////////////////////////////////////
x_speed = 0;
y_speed = 0;

max_x_speed	= 5.5  * m;
max_y_speed	= 9.0  * m;

jump_height	= 10.0 * m;
jump_release_timer = 0;
jump_distance = 0;

grounded	= false;
grounded_ypos = 0;

grav_rise	= 0.10 * m;
grav_fall	= 0.10 * m;

// Acceleration & Friction Vars ///////////////////////////////////////////////
ground_accel = 1.00 * m;
ground_fric  = 2.00 * m;
air_accel    = 0.75 * m;
air_fric     = 0.10 * m;

// Sprite Vars ////////////////////////////////////////////////////////////////
animation_idle		= spr_player_idle;
animation_idle_r	= spr_player_idle_right;
animation_invis		= spr_player_invis;
animation_shadow	= spr_player_shadow;

animation_walk		= spr_player_walk;
animation_walk_r	= spr_player_walk_right;
animation_walk_t	= spr_player_walk_tracks;
animation_walk_tr	= spr_player_walk_tracks_reverse;

animation_jump_r	= spr_player_jump_ready;
animation_jump_l	= spr_player_jump_landing;
animation_jump_20	= spr_player_jump_20_power;
animation_jump_40	= spr_player_jump_40_power;
animation_jump_60	= spr_player_jump_60_power;
animation_jump_80	= spr_player_jump_80_power;
animation_jump_100	= spr_player_jump_100_power;
animation_jump_r_r	= spr_player_jump_ready_right;
animation_jump_l_r	= spr_player_jump_landing_right;
animation_jump_20_r	= spr_player_jump_20_power_right;
animation_jump_40_r	= spr_player_jump_40_power_right;
animation_jump_60_r	= spr_player_jump_60_power_right;
animation_jump_80_r	= spr_player_jump_80_power_right;
animation_jump_100_r= spr_player_jump_100_power_right;

animation_grapple_aim		= spr_player_rope_aiming;
animation_grapple_aim_r		= spr_player_rope_aiming_right;
animation_grapple_launcher	= spr_player_rope_launcher;
animation_grapple_launched	= spr_player_rope_launched;
animation_grapple_looking	= spr_player_rope_looking;

animation_id = animation_idle;
animation_index = 0;

animation_id_t = animation_walk_t;
animation_index_t = 0;

animation_id_r = animation_idle_r;
animation_index_r = 0;

// States /////////////////////////////////////////////////////////////////////
default_physics	= [4.00, 9.00, 0.10, 0.10, 0.75, 0.10];
grapple_physics	= [0.50, 9.00, 0.10, 0.10, 0.75, 0.10];

state_suspended = false;
state_grounded	= false;
state_moving	= false;
state_charging	= false;
state_jumping	= false;
state_landing	= false;
jump_cancel = false;

state_aiming	= false;
state_grappling = false;
state_retrieving= false;
aim_cancel = false;

//state_building	= false;
//current_building = noone;
//current_building_sprite_active = noone;
//current_building_sprite_idle = noone;
//current_building_repeating = false;

show_states = function() {
	show_debug_message("state_suspended: "	+ string(state_suspended));
	show_debug_message("state_grounded: "	+ string(state_grounded));
	show_debug_message("state_moving: "		+ string(state_moving));
	show_debug_message("state_charging: "	+ string(state_charging));
	show_debug_message("state_jumping: "	+ string(state_jumping));
	show_debug_message("state_landing: "	+ string(state_landing));
	show_debug_message("state_aiming: "		+ string(state_aiming));
	show_debug_message("state_grappling: "	+ string(state_grappling));
	show_debug_message("state_retrieving: " + string(state_retrieving));
}

// Misc ///////////////////////////////////////////////////////////////////////
hotspot_x = x + sprite_width;
hotspot_y = y + sprite_height;

grapple_origin_x = x;
grapple_origin_y = x;
grapple_hotspot_x = x;
grapple_hotspot_y = y;

depth = 101;
aim_angle_target = 90;
aim_angle = 0;
grapple_mode_height = 1280;
grapple_distance = 0;
grapple_object = noone;

grapple_camera_height = room_height - 1024*1.5;

// Physics Settings Method
set_phys = function(phys) {
	max_x_speed	= phys[0];
	max_y_speed	= phys[1];
	grav_rise	= phys[2];
	grav_fall	= phys[3];
	air_accel	= phys[4];
	air_fric	= phys[5];
}
///////////////////////////////////////////////////////////////////////////////