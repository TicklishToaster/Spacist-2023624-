// Declare Temp Variables /////////////////////////////////////////////////////
var input_left, input_right, input_up, input_down, input_jump, input_jump_release, temp_accel, temp_fric, input_click_m1, input_click_m2, input_hold_m2;
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
input_hold_m2		= mouse_check_button(mb_right);

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
 
// Disable jumping if in grapple mode.
if (!grapple_mode) {
	// Jump
	if (input_jump) {
	    if (grounded) {        
			y_speed = -jump_height;
	    }
	} 	
	else {
	    // Check if short jump.
	    if (input_jump_release){
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
}

// Friction
if (!input_right && !input_left)
    x_speed = Approach(x_speed, 0, temp_fric);

// Room Wrap
move_wrap(true, false, 0);

// Grapple Controls
if (input_hold_m2 && !grapple_mode) {
	var aim_direction = point_direction(hotspot_x, hotspot_y, mouse_x, mouse_y);
	
	if (input_click_m1) {
		// Create Rope Object	
		instance_create_layer(hotspot_x, hotspot_y - sprite_get_height(spr_grapple)/2, "Instances", obj_rope, {creator : obj_player});
	
		// Create Hook Object
		instance_create_layer(hotspot_x, hotspot_y - sprite_get_height(spr_grapple)/2, "Instances", obj_hook, {creator : obj_player});
	
		// Toggle Rope Mode
		event_user(1);
	
		// Generate Asteroid Field
		generate_asteroid_field()
		
		// Throw Grapple
		with (obj_hook) {
			//event_user(2);
			adjust_physics_vars(self, thrown_physics[0], thrown_physics[1], thrown_physics[2], thrown_physics[3], thrown_physics[4], thrown_physics[5]);
			//adjust_physics_vars(obj_hook, thrown_physics);
			var throw_x = lengthdir_x(max_x_speed, aim_direction);
			var throw_y = lengthdir_y(max_y_speed, aim_direction);
			
			show_debug_message(throw_x);
			show_debug_message(throw_y);
			
			x_speed = throw_x;
			y_speed = throw_y;
			
			
		}
	}
}

// Words
if (grapple_mode == true && obj_hook.object_attached != 0) {
	if (obj_hook.y > room_height - grapple_mode_height - sprite_get_height(spr_grapple)/2) {
		event_user(1);
	}
}

// Room Wrap
move_wrap(true, false, 0);



// DEBUG CONTROLS - DELETE LATER
if (keyboard_check_direct(ord("J"))) {
	//room_goto(Room1);
	var offset = 0;
	for (i = 0; i < abs(y_speed); ++i) {
	    offset += sign(y_speed);
	}
	y = 0 + offset;	
}

// DEBUG CONTROLS - DELETE LATER
if (keyboard_check_direct(ord("K"))) {
	//y += -10;
	y_speed = -10;
}