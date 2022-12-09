if (!creator.grapple_mode) {
	exit;
}

// Declare Temp Variables /////////////////////////////////////////////////////
var input_left, input_right, input_up, input_down, input_grab, input_grab_release, temp_accel, temp_fric;
///////////////////////////////////////////////////////////////////////////////

// Input //////////////////////////////////////////////////////////////////////
input_left			= keyboard_check(ord("A"));
input_right			= keyboard_check(ord("D"));
input_up			= keyboard_check(ord("W"));
input_down			= keyboard_check(ord("S"));
input_grab			= keyboard_check_pressed(vk_space);
input_grab_release	= keyboard_check_released(vk_space);

//input_click_m1		= mouse_check_button_pressed(mb_left);
//input_click_m2		= mouse_check_button_pressed(mb_right);

///////////////////////////////////////////////////////////////////////////////

// Apply air accel/fric.
temp_accel = air_accel;
temp_fric  = air_fric;

// Gravity ////////////////////////////////////////////////////////////////////
if y_speed < 0 {
    // Rise Up
    y_speed = Approach(y_speed, max_y_speed, grav_rise);
	// Prevent acceleration going above 0.
	if y_speed > 0.0
		y_speed = 0.0;
}	
else {
    // Fall Down
    y_speed = Approach(y_speed, max_y_speed, grav_fall);
}

///////////////////////////////////////////////////////////////////////////////
// Input only if move_state is true.
if (move_state) {
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
}

// Special input if fall_state is true.
if (fall_state) {
	// Pull Down
	if (input_down && !input_up) {
	    // Apply acceleration down
	    if (y_speed < 0)
	        y_speed = Approach(y_speed, 0, temp_fric);   
	    y_speed = Approach(y_speed, max_y_speed, 0.10 * m);
	}
}

// Friction
if (!input_right && !input_left)
    x_speed = Approach(x_speed, 0, temp_fric); 
  

// Change Movement State
if (y < 1024 && !move_state && !fall_state) {
	thrown_state = false;
	move_state = true;
	adjust_physics_vars(self, move_physics[0], move_physics[1], move_physics[2], move_physics[3], move_physics[4], move_physics[5]);
}


// Grapple Grab
if (input_grab) {
	img_index = 0;
	img_speed = 0.25;

	if (place_meeting(x, y, obj_asteroid)) {
		object_attached = instance_place(x, y, obj_asteroid);
		with (object_attached) {
			hook_parent = obj_hook;
			hook_attached = true;
		}
		adjust_physics_vars(self, fall_physics[0], fall_physics[1], fall_physics[2], fall_physics[3], fall_physics[4], fall_physics[5]);
		move_state = false;
		fall_state = true;
	}
}

// Grapple Animation
img_index = clamp(img_index + img_speed, 0, 2.9);

if (object_attached == 0 && img_index >= 2.9) {
	img_index = 0;
	img_speed = 0;
}
else if (object_attached != 0 && img_index >= 2.9) {
	img_speed = 0;
}


// Enable Grapple Settings
if (y < room_height - obj_player.grapple_mode_height - sprite_get_height(spr_grapple)/2) && (obj_player.grapple_mode) {
	if (!camera_state) {
		// Toggle Camera State
		camera_state = true;
				
		event_user(0);
	}
}

// Disable Grapple Settings
else if (y > room_height - obj_player.grapple_mode_height - sprite_get_height(spr_grapple)/2) && (obj_player.grapple_mode) {
	if (camera_state) {
		// Toggle Camera State
		camera_state = false;		
		event_user(1);
	}	
}