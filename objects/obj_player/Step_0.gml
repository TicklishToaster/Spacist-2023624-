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

///////////////////////////////////////////////////////////////////////////////

// Which form of accel/fric to apply
if (grounded) {
    temp_accel = ground_accel;
    temp_fric  = ground_fric;
} else {
    temp_accel = air_accel;
    temp_fric  = air_fric;
}

// Gravity ////////////////////////////////////////////////////////////////////
if (!grounded) {
	if y_speed < 0 {
        // Rise Up
        y_speed = Approach(y_speed, max_y_speed, grav_rise);
		//show_debug_message("Y 1: "+string(y_speed))		
    }	
    else {
        // Fall Down
        y_speed = Approach(y_speed, max_y_speed, grav_fall);
		//show_debug_message("Y 2: "+string(y_speed))
    } 
}

///////////////////////////////////////////////////////////////////////////////

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
  
// Jump
if (input_jump) {
    if (grounded) {        
		y_speed = -jump_height;
    }
} 
else {
    // Check if short jump.
    if (input_jump_release) {
        if (y_speed < 0 && y_speed >= -jump_height) {
			//y_speed *= 0.25;
			jump_release_timer = 60;
		}
	}
	
	// Decrease height gain if short jump.	
	if jump_release_timer > 0 {
		if y_speed < 0 {
			y_speed = lerp(y_speed, 0, 0.1)
			jump_release_timer = clamp(jump_release_timer-2, 0, 60);
		} 
		else {
			jump_release_timer = 0;
		}
	}
}