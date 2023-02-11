if (!creator.state_grappling) {
	show_debug_message("Not Grappling")
	exit;
}

// Input Variables ////////////////////////////////////////////////////////////
// Input WASD Controls
var input_up_press			= keyboard_check_pressed(ord("W"));
var input_up_hold			= keyboard_check(ord("W"));
var input_down_press		= keyboard_check_pressed(ord("S"));
var input_down_hold			= keyboard_check(ord("S"));
var input_left_press		= keyboard_check_pressed(ord("A"));
var input_left_hold			= keyboard_check(ord("A"));
var input_right_press		= keyboard_check_pressed(ord("D"));
var input_right_hold		= keyboard_check(ord("D"));

// Input Arrow Key Controls
var input_uparrow_press		= keyboard_check_pressed(vk_up);
var input_uparrow_hold		= keyboard_check(vk_up);
var input_downarrow_press	= keyboard_check_pressed(vk_down);
var input_downarrow_hold	= keyboard_check(vk_down);
var input_leftarrow_press	= keyboard_check_pressed(vk_left);
var input_leftarrow_hold	= keyboard_check(vk_left);
var input_rightarrow_press	= keyboard_check_pressed(vk_right);
var input_rightarrow_hold	= keyboard_check(vk_right);

// Input Mouse Controls
var input_mouse1_click		= mouse_check_button_pressed(mb_left);
var input_mouse1_hold		= mouse_check_button(mb_left);
var input_mouse1_release	= mouse_check_button_released(mb_left);
var input_mouse2_click		= mouse_check_button_pressed(mb_right);
var input_mouse2_hold		= mouse_check_button(mb_right);
var input_mouse2_release	= mouse_check_button_released(mb_right);
var input_mouse4_click		= mouse_check_button_pressed(mb_side1);
var input_mouse5_click		= mouse_check_button_pressed(mb_side2);

// Input Space Bar Controls
var input_space_press		= keyboard_check_pressed(vk_space);
var input_space_hold		= keyboard_check(vk_space);
var input_space_release		= keyboard_check_released(vk_space);

// Input Miscellaneous Controls
var input_shift_press		= keyboard_check_pressed(vk_shift);
var input_shift_hold		= keyboard_check(vk_shift);
var input_control_press		= keyboard_check_pressed(vk_control);
var input_control_hold		= keyboard_check(vk_control);

// Gravity ////////////////////////////////////////////////////////////////////
//if y_speed < 0 {
//    // Rise Up
//    y_speed = Approach(y_speed, max_y_speed, grav_rise);
//	// Prevent acceleration going above 0.
//	if y_speed > 0.0 {
//		y_speed = 0.0;
//	}
//}	
//else {
//    // Fall Down
//    y_speed = Approach(y_speed, max_y_speed, grav_fall);
//	if y_speed < 0.0 {
//		y_speed = 0.0;
//	}
//}

// Decelerate If Inactive
if (!state_controlled) {
	//x_speed = Approach(x_speed, 0, air_fric);
    y_speed = Approach(y_speed, 0, air_fric);
}
if (state_controlled && !input_up_hold && !input_down_hold) {
    y_speed = Approach(y_speed, 0, air_fric);
}
if (state_controlled && !input_right_hold && !input_left_hold) {
    x_speed = Approach(x_speed, 0, air_fric);
}

// Movement Controls //////////////////////////////////////////////////////////
// Default input only if state_controlled is true.
if (state_controlled && !state_launched && !state_pulling) {
	// Up
	if (input_up_hold && !input_down_hold) {
	    // Apply acceleration up
	    if (y_speed > 0)
	        y_speed = Approach(y_speed, 0, air_fric);   
	    y_speed = Approach(y_speed, -max_y_speed, air_accel);
	}

	// Down
	if (input_down_hold && !input_up_hold) {
	    // Apply acceleration down
	    if (y_speed < 0)
	        y_speed = Approach(y_speed, 0, air_fric);   
	    y_speed = Approach(y_speed, max_y_speed, air_accel);
	}

	// Left 
	if (input_left_hold && !input_right_hold) {
	    // Apply acceleration left
	    if (x_speed > 0)
	        x_speed = Approach(x_speed, 0, air_fric);   
	    x_speed = Approach(x_speed, -max_x_speed, air_accel);
	}

	// Right 
	if (input_right_hold && !input_left_hold) {
	    // Apply acceleration right
	    if (x_speed < 0)
	        x_speed = Approach(x_speed, 0, air_fric);   
	    x_speed = Approach(x_speed, max_x_speed, air_accel);
	}
}

// Special input only if state_launched is true.
if (state_launched && !state_controlled && !state_pulling) {
	// Pull Down
	//if (input_down_hold && !input_up_hold) {
	//    // Apply acceleration down
	//    if (y_speed < 0)
	//        y_speed = Approach(y_speed, 0, air_fric);   
	//    y_speed = Approach(y_speed, max_y_speed, 0.10);
	//}
}

// Special input only if state_pulling is true.
if (state_pulling && !state_launched && !state_controlled) {
	// Pull Down
	if (input_down_hold && !input_up_hold) {
	    // Apply acceleration down
	    if (y_speed < 0)
	        y_speed = Approach(y_speed, 0, air_fric);   
	    y_speed = Approach(y_speed, max_y_speed, 0.10);
	}
}

// Grappling Controls /////////////////////////////////////////////////////////
if (input_space_press || input_mouse1_click) {
	// If No Object Is Grabbed
	if (state_controlled && img_index <= 0) {
		// Play Grab Animation
		img_index = 0;
		img_speed = 0.10;
		
		// Check if overlapping an asteroid.
		if (place_meeting(x + room_wrap_x, y, obj_asteroid)) {
			attached_object = instance_place(x + room_wrap_x, y, obj_asteroid);
			
			// Set Grabbed Object Values
			with (attached_object) {
				hook_parent = obj_hook;
				hook_attached = true;
			}
			
			// Change Movement State			
			state_controlled = false;
			state_pulling = true;
			set_phys(launch_physics);
			
			// Halt Movement
			x_speed = 0;
			y_speed = 0;
			
			// Lock image rotation.
			lock_rot = img_rot;
		}
	}
	
	// Else If An Object Is Grabbed
	else if (state_pulling && img_index >= 4) {
		// Play Grab Animation
		img_index = 4;
		img_speed = -0.10;
		
		// Remove Grabbed Object Values
		with (attached_object) {
			hook_parent = noone;
			hook_attached = false;
		}
		attached_object = noone;
		
		// Change Movement State
		state_controlled = true;
		state_pulling = false;
		set_phys(move_physics);
		
		// Halt Movement
		x_speed = 0;
		y_speed = 0;
	}
}

 //State Conditions ///////////////////////////////////////////////////////////
// Change movement state when 1st target height is reached.
if (y < creator.grapple_mode_height - 128) {
	if (state_launched && !state_controlled && !state_pulling && !state_retrieving) {
		show_debug_message("1st Target Height Threshold Reached");
		// Change Movement State
		state_launched = false;		
		set_phys(approach_physics);
	}
}

// Change movement state when 2nd target height is reached.
if (y < creator.grapple_mode_height/2) {
	if (!state_controlled && !state_launched && !state_pulling && !state_retrieving) {
		show_debug_message("2nd Target Height Threshold Reached");
		// Change Movement State
		//state_launched = false;
		state_controlled = true;
		set_phys(move_physics);
	}
}

// Retrieve grapple hook when object is pulled below target height.
if (y > creator.grapple_mode_height && instance_exists(attached_object)) {
	if (state_pulling && !state_launched && !state_controlled && !state_retrieving) {
		show_debug_message("1st Target Falling Condition Met");		
		// Update Attached Object
		creator.grapple_object = attached_object;
		var object_offset = attached_object.sprite_width;
		//var object_offset = obj_camera.camera_width/2;
		if (room_wrap_x > 0) {
			x = 0 + object_offset;
			attached_object.x = 0 + object_offset;
		} 
		else if (room_wrap_x < 0) {
			x = room_width - object_offset;
			attached_object.x = room_width - object_offset;	
		}		
		
		// Change Movement State
		state_pulling = false;
		state_retrieving = true;
		set_phys(launch_physics);
		
		// Change & Pann Camera Target
		obj_camera.target = attached_object;
		with (obj_camera) {
			obj_camera_point_01.x = camera_x;
			obj_camera_point_01.y = camera_y;
			obj_camera_point_01.hotspot_x = obj_camera_point_01.x + (camera_width /2);
			obj_camera_point_01.hotspot_y = obj_camera_point_01.y + (camera_height/2);
			pann_camera(obj_camera_point_01, target, 0.01);
		}
		
		// Retrieve Grapple Hook
		return_angle = point_direction(x, y, creator.grapple_origin_x, creator.grapple_origin_y);
		//var return_angle = point_direction(x, y, creator.grapple_origin_x, creator.grapple_origin_y);
		//x_speed = lengthdir_x(max_x_speed, return_angle);
		y_speed = lengthdir_y(max_y_speed, return_angle);		
		
		//// Remove Grabbed Object Values
		//with (attached_object) {
		//	hook_parent = noone;
		//	hook_attached = false;
		//	state_returning = true;
		//	layer = layer_get_id("Instances");
		//}
		//attached_object = noone;
		
		//// Retrieve Grapple Hook
		//var return_angle = point_direction(x, y, creator.grapple_origin_x, creator.grapple_origin_y);
		//x_speed = lengthdir_x(max_x_speed*2, return_angle);
		//y_speed = lengthdir_y(max_y_speed*2, return_angle);
	}
}
// Retrieve grapple hook when object is pulled below target height.
if (y > creator.grapple_mode_height*1.2 && instance_exists(attached_object)) {
	if (state_retrieving && !state_launched && !state_controlled && !state_pulling) {
		show_debug_message("2nd Target Falling Condition Met");		
		
		// Remove Grabbed Object Values
		with (attached_object) {
			hook_parent = noone;
			hook_attached = false;
			state_returning = true;
			layer = layer_get_id("Instances");
		}
		attached_object = noone;
		
		// Retrieve Grapple Hook
		set_phys(fall_physics);
		//var return_angle = point_direction(x, y, creator.grapple_origin_x, creator.grapple_origin_y);
		x_speed = lengthdir_x(max_x_speed, return_angle);
		y_speed = lengthdir_y(max_y_speed, return_angle);
	}
}

// Delete grapple hook and chain when returned to the player.
if (instance_exists(obj_grapple_chain) && state_retrieving) {
	//if (place_meeting(x, y, creator) || point_distance(x, y, creator.hotspot_x, creator.hotspot_y) < 64) {
	if (place_meeting(x, y + sign(y_speed), obj_floor) || y + sign(y_speed) > 3520 || point_distance(x, y, creator.hotspot_x, creator.hotspot_y) < 64) {
		// Set Creator States
		creator.state_retrieving = true;
		creator.state_suspended  = true;
		creator.grapple_distance = horizontal_distance - creator.grapple_distance;
	
		// Destroy Self and Grapple Chain
		instance_destroy(obj_grapple_chain);
		instance_destroy(self);
	
		// Destroy all objects in the asteroid layer except the one retreived.
		with (obj_asteroid) {
			if (!state_returning) {
				instance_destroy();
			}
		}
	}
}

//show_debug_message("Horiztonal Dist: " + string(horizontal_distance))


//// Change movement state when target height is reached.
//if (y < creator.grapple_mode_height/2) {
//	if (state_controlled || state_launched && !state_pulling && !state_retrieving) {
//		with (obj_camera) {
//			obj_camera_point_01.x = camera_x;
//			obj_camera_point_01.hotspot_x = obj_camera_point_01.x + (camera_width/2);
			
//			if ((camera_y > 1280 - camera_height) && !state_panning) {
//				var target_y = clamp((target.hotspot_y - (camera_height/2)), 0, 1280 - camera_height);
//				if (target_y < camera_y) {
//					pann_camera(obj_hook, obj_camera_point_01, 0.01);
//				}
//			}
//			else if ((camera_y <= 1280 - camera_height) && state_panning && pann_target_object == obj_camera_point_01) {	
//				obj_camera_point_02.x = camera_x;
//				obj_camera_point_02.y = camera_y;
//				obj_camera_point_02.hotspot_x = obj_camera_point_02.x + (camera_width /2);
//				obj_camera_point_02.hotspot_y = obj_camera_point_02.y + (camera_height/2);
//				pann_camera(obj_camera_point_02, obj_hook, 0.01);
//			}
//		}
//	}
//}


//// Change movement state when grapple is attached to object.
//if (instance_exists(attached_object) && state_controlled && !state_launched && !state_pulling && !state_retrieving) {
//	state_controlled = false;
//	state_pulling = true;
//	set_phys(launch_physics);
//}

//// Change movement state when attached object is grounded.
//if (instance_exists(attached_object) && attached_object.state_grounded = true && state_retrieving && !state_grounded) {
//	state_retrieving = false;
//	state_grounded = true;
//	set_phys(grounded_physics);
//	x_speed = 0;
//	y_speed = 0;
//}

