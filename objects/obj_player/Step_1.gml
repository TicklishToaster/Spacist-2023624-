// Input Variables ////////////////////////////////////////////////////////////
// Input WASD Controls
input_up_press			= keyboard_check_pressed(ord("W"));
input_up_hold			= keyboard_check(ord("W"));
input_down_press		= keyboard_check_pressed(ord("S"));
input_down_hold			= keyboard_check(ord("S"));
input_left_press		= keyboard_check_pressed(ord("A"));
input_left_hold			= keyboard_check(ord("A"));
input_right_press		= keyboard_check_pressed(ord("D"));
input_right_hold		= keyboard_check(ord("D"));

// Input Arrow Key Controls
input_uparrow_press		= keyboard_check_pressed(vk_up);
input_uparrow_hold		= keyboard_check(vk_up);
input_downarrow_press	= keyboard_check_pressed(vk_down);
input_downarrow_hold	= keyboard_check(vk_down);
input_leftarrow_press	= keyboard_check_pressed(vk_left);
input_leftarrow_hold	= keyboard_check(vk_left);
input_rightarrow_press	= keyboard_check_pressed(vk_right);
input_rightarrow_hold	= keyboard_check(vk_right);

// Input Mouse Controls
input_mouse1_click		= mouse_check_button_pressed(mb_left);
input_mouse1_hold		= mouse_check_button(mb_left);
input_mouse1_release	= mouse_check_button_released(mb_left);
input_mouse2_click		= mouse_check_button_pressed(mb_right);
input_mouse2_hold		= mouse_check_button(mb_right);
input_mouse2_release	= mouse_check_button_released(mb_right);
input_mouse4_click		= mouse_check_button_pressed(mb_side1);
input_mouse5_click		= mouse_check_button_pressed(mb_side2);

// Input Space Bar Controls
input_space_press		= keyboard_check_pressed(vk_space);
input_space_hold		= keyboard_check(vk_space);
input_space_release		= keyboard_check_released(vk_space);

// Input Miscellaneous Controls
input_shift_press		= keyboard_check_pressed(vk_shift);
input_shift_hold		= keyboard_check(vk_shift);
input_control_press		= keyboard_check_pressed(vk_control);
input_control_hold		= keyboard_check(vk_control);

input_build_mode		= keyboard_check_pressed(ord("B"));


///////////////////////////////////////////////////////////////////////////////
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