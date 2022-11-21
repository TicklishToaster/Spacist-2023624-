// Declare Temp Variables /////////////////////////////////////////////////////
var input_left, input_right, input_up, input_down, input_jump, input_jump_release, temp_accel, temp_fric;
///////////////////////////////////////////////////////////////////////////////

// Input //////////////////////////////////////////////////////////////////////
input_left			= keyboard_check(ord("A"));
input_right			= keyboard_check(ord("D"));
input_up			= keyboard_check(ord("W"));
input_down			= keyboard_check(ord("S"));
input_jump			= keyboard_check_pressed(vk_space);
input_jump_release	= keyboard_check_released(vk_space);

input_click_m1		= mouse_check_button_pressed(mb_left);
input_click_m2		= mouse_check_button_pressed(mb_right);

///////////////////////////////////////////////////////////////////////////////

// Which form of accel/fric to apply
// Apply air accel/fric.
temp_accel = air_accel;
temp_fric  = air_fric;


// Gravity ////////////////////////////////////////////////////////////////////
if y_speed < 0 {
    // Rise Up
    y_speed = Approach(y_speed, max_y_speed, grav_rise);	
}	
else {
    // Fall Down
    y_speed = Approach(y_speed, max_y_speed, grav_fall);
}

///////////////////////////////////////////////////////////////////////////////
// Up
if (input_up && !input_down) {
    // Apply acceleration up
    if (y_speed > 0)
        y_speed = Approach(y_speed, 0, temp_fric);   
    y_speed = Approach(y_speed, -max_y_speed, temp_accel);
}

// Down
if (input_down && !input_up) {
    // Apply acceleration down
    if (y_speed < 0)
        y_speed = Approach(y_speed, 0, temp_fric);   
    y_speed = Approach(y_speed, max_y_speed, temp_accel);
}

// Left 
if (input_left && !input_right) {
    // Apply acceleration left
    if (x_speed > 0)
        x_speed = Approach(x_speed, 0, temp_fric);   
    x_speed = Approach(x_speed, -max_x_speed, temp_accel);
}

// Right 
if (input_right && !input_left) {
    // Apply acceleration right
    if (x_speed < 0)
        x_speed = Approach(x_speed, 0, temp_fric);   
    x_speed = Approach(x_speed, max_x_speed, temp_accel);
}

// Friction
if (!input_right && !input_left)
    x_speed = Approach(x_speed, 0, temp_fric); 
  

// Toggle Popup Camera & Background.
if (y < room_height - obj_player.grapple_mode_height - sprite_get_height(spr_grapple)/2) && (obj_player.grapple_mode) {
	layer_set_visible("Window_Terrain_Foreground", true);
	layer_set_visible("Window_Parallax_1", true);
	layer_set_visible("Window_Parallax_2", true);
	layer_set_visible("Window_Parallax_3", true);
	layer_set_visible("Window_Parallax_4", true);
	view_visible[1] = true;
} else if (y > room_height - obj_player.grapple_mode_height - sprite_get_height(spr_grapple)/2) && (obj_player.grapple_mode) {
	layer_set_visible("Window_Terrain_Foreground", false);
	layer_set_visible("Window_Parallax_1", false);
	layer_set_visible("Window_Parallax_2", false);
	layer_set_visible("Window_Parallax_3", false);
	layer_set_visible("Window_Parallax_4", false);
	view_visible[1] = false;	
}