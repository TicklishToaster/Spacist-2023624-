// Declare Temp Variables /////////////////////////////////////////////////////
var input_left, input_right, input_up, input_down, input_jump, input_jump_hold, input_jump_release, 
	temp_accel, temp_fric, input_click_m1, input_click_m2, input_hold_m2, input_release_m2;
///////////////////////////////////////////////////////////////////////////////

// Input //////////////////////////////////////////////////////////////////////
input_left			= keyboard_check(ord("A"));
input_right			= keyboard_check(ord("D"));
input_up			= keyboard_check(ord("W"));
input_down			= keyboard_check(ord("S"));
input_jump			= keyboard_check_pressed(vk_space);
input_jump_hold		= keyboard_check(vk_space);
input_jump_release	= keyboard_check_released(vk_space);

input_click_m1		= mouse_check_button_pressed(mb_left);
input_click_m2		= mouse_check_button_pressed(mb_right);
input_hold_m2		= mouse_check_button(mb_right);
input_release_m2	= mouse_check_button_released(mb_right);

///////////////////////////////////////////////////////////////////////////////

// Which form of accel/fric to apply
if (state_grounded) {
    temp_accel = ground_accel;
    temp_fric  = ground_fric;
} else {
    temp_accel = air_accel;
    temp_fric  = air_fric;
}

// Gravity ////////////////////////////////////////////////////////////////////
if (!state_grounded) {
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

// Idle ///////////////////////////////////////////////////////////////////////
if (!input_left && !input_right && !input_jump_hold) {
	if (state_grounded && !state_charging && !state_jumping && !state_landing && !state_aiming && !state_grappling && !state_retrieving) {
		animation_id = animation_idle;
		animation_index = 0;
		animation_id_r = animation_idle_r;
		animation_index_r = 0;		
	}
}

// Moving /////////////////////////////////////////////////////////////////////
if (input_left || input_right) {
	// Move Left 
	if (input_left && !input_right) {
	    // Apply acceleration left
	    if (x_speed > 0) {
	        x_speed = Approach(x_speed, 0, temp_fric);
		}
	    x_speed = Approach(x_speed, -max_x_speed, temp_accel);
	}

	// Move Right 
	if (input_right && !input_left) {
	    // Apply acceleration right
	    if (x_speed < 0) {
	        x_speed = Approach(x_speed, 0, temp_fric);
		}
	    x_speed = Approach(x_speed, max_x_speed, temp_accel);
	}	
	
	// Torso Animation
	if (state_grounded && !state_jumping && !state_charging && !state_landing && !state_aiming && !state_retrieving && abs(x_speed) >= 0.4) {
		// Left 
		if (input_left && !input_right) {
			// Adjust Sprite Direction
			if (image_xscale != -1) {
				x+=sprite_width;
				image_xscale = -1;		
			}		
		}

		// Right 
		if (input_right && !input_left) {
			// Adjust Sprite Direction
			if (image_xscale != 1) {
				x+=sprite_width;
				image_xscale = 1;
			}
		}
		
		if (abs(x_speed) >= 0.4 && state_grounded) {
			animation_id = animation_walk;
			animation_index = clamp(animation_index + 0.2, 0, 7.9);
			animation_id_r = animation_walk_r;
			animation_index_r = clamp(animation_index_r + 0.2, 0, 7.9);
			if (animation_index >= 7.9) {
				animation_index = 0;
				animation_index_r = 0;
			}
		}		
	}
	
	// Tracks Animation
	if (state_grounded && abs(x_speed) >= 0.2) {
		var track_speed = 0.1;
		if (!state_charging && !state_aiming && !state_grappling) {
			track_speed = 0.2;
		}
		
		if (abs(x_speed) >= 0.2 && state_grounded) {
			animation_index_t = clamp(animation_index_t + track_speed, 0, 7.9);
		}	
	
		if (animation_index_t >= 7.9) {
			animation_index_t = 0;
		}	
	
		if (state_charging || state_grappling) {
			// Left 
			if (image_xscale == -1) {
				if (x_speed <= -0.2) {
					animation_id_t = animation_walk_t;
				}
				else if (x_speed >= 0.2 && animation_id_t != animation_walk_tr) {
					animation_id_t = animation_walk_tr;
					animation_index_t = abs(animation_index_t - 7);	
				}		
			}
			// Right
			if (image_xscale == 1) {
				if (x_speed >= 0.2) {
					animation_id_t = animation_walk_t;
				}
				else if (x_speed <= -0.2 && animation_id_t != animation_walk_tr) {
					animation_id_t = animation_walk_tr;
					animation_index_t = abs(animation_index_t - 7);	
				}	
			}
		}
	}
}

// Jumping ////////////////////////////////////////////////////////////////////
// Hold and Release Jump Controls.
if (input_jump) {
	if (state_grounded && !state_charging && !state_jumping && !state_landing && !state_aiming && !state_grappling && !state_retrieving && !jump_cancel) {
		// Toggle Jumping Variables.
		state_charging = true;
		if (animation_id != animation_jump_r) {
			animation_id = animation_jump_r;
			animation_index = 0;
			animation_id_r = animation_jump_r_r;
			animation_index_r = 0;
		}
	}
}

// If animation is charging and the animation is unfinished. 
if (input_jump_hold) {
	if (state_charging && !state_jumping && !state_landing && !state_retrieving) {
		if (animation_id == animation_jump_r && animation_index < 6.9) {
			animation_index = clamp(animation_index + 0.2, 0, 6.9);
			animation_index_r = clamp(animation_index_r + 0.2, 0, 6.9);
			// If animation is readying.
			if (animation_id == animation_jump_r) {
				// Change to first jump power animation if readying animation complete.
				if (animation_index >= 6.9) {
					animation_id = animation_jump_20;
					animation_id_r = animation_jump_20_r;
					animation_index = 0;
					animation_index_r = 0;
				}
			}
		}
		else if (animation_id != animation_jump_r) {
			// If charge timer has reached 20%.
			if (jump_release_timer >= 0.5) {animation_id = animation_jump_20; 
				animation_id_r = animation_jump_20_r;}
			// If charge timer has reached 40%.
			if (jump_release_timer >= 1.0) {animation_id = animation_jump_40;
				animation_id_r = animation_jump_40_r;}
			// If charge timer has reached 60%.
			if (jump_release_timer >= 1.5) {animation_id = animation_jump_60;
				animation_id_r = animation_jump_60_r;}
			// If charge timer has reached 80%.
			if (jump_release_timer >= 2.0) {animation_id = animation_jump_80;
				animation_id_r = animation_jump_80_r;}
			// If charge timer has reached 100%.
			if (jump_release_timer >= 2.5) {animation_id = animation_jump_100;
				animation_id_r = animation_jump_100_r;}
				
			animation_index = 0;
			animation_index_r = 0;
		}		
		jump_release_timer += (room_speed / 60) / 60;
		max_x_speed = slow_physics[0]
	}
}

// Release input and jump up.
if (input_jump_release) {
	if (state_charging && !state_jumping && !state_landing) {
		// Cancel jump animation if released early.
		if (animation_id == animation_jump_r) {
			jump_cancel = true;
		}
		else if (animation_id != animation_jump_r) {
			// If charge timer has reached 20%.
			if (jump_release_timer >= 0.5) {y_speed = -3.0;}
			// If charge timer has reached 40%.
			if (jump_release_timer >= 1.0) {y_speed = -6.0;}
			// If charge timer has reached 60%.
			if (jump_release_timer >= 1.5) {y_speed = -9.0;}
			// If charge timer has reached 80%.
			if (jump_release_timer >= 2.0) {y_speed = -12.0;}
			// If charge timer has reached 100%.
			if (jump_release_timer >= 2.5) {y_speed = -15.0;}
			
			state_grounded = false;
			state_charging = false;
			state_jumping = true;
			animation_index = 0;
			animation_index_r = 0;
			max_x_speed = default_physics[0]
			jump_release_timer = 0;				
		}
	}
}

// If jump is canceled, or if landing normally, regress jump animation into idle animation.
if (!input_jump_hold) || (state_grounded) {
	// If jump is canceled, or if landing normally, regress jump animation into idle animation.
	if (jump_cancel && state_charging && !state_jumping && !state_landing) || (state_landing && !state_jumping && !state_charging) {
		
		if (animation_id == animation_jump_r) {
			animation_index = clamp(animation_index - 0.2, 0, sprite_get_number(animation_jump_r)-0.1);
			animation_index_r = clamp(animation_index_r - 0.2, 0, sprite_get_number(animation_jump_r_r)-0.1);
			// When unreadying animation is finished.
			if (animation_index <= 0.0) {
				animation_index = 0;
				animation_index_r = 0;
				state_charging = false;
				state_jumping = false;
				state_landing = false;
				jump_cancel = false;
				max_x_speed = default_physics[0];
				jump_release_timer = 0;
			}
		}
		
		else if (animation_id == animation_jump_l) {
			animation_index = clamp(animation_index + 0.2, 0, 14.9);
			animation_index_r = clamp(animation_index_r + 0.2, 0, 14.9);
			// When landing animation is finished.
			if (animation_index >= 14.9) {
				//animation_index = 0;
				state_charging = false;
				state_jumping = false;
				state_landing = false;
				jump_cancel = false;
				max_x_speed = default_physics[0];
				jump_release_timer = 0;				
			}
		}
	}
}

// If jumping up, play jumping animation.
if (!state_charging && state_jumping && !state_landing) {
	if (animation_id != animation_jump_r) {
		animation_index = clamp(animation_index + 0.4, 0, sprite_get_number(animation_id)-0.1);
		animation_index_r = clamp(animation_index_r + 0.4, 0, sprite_get_number(animation_id)-0.1);
	}	
	
	// Check if landing and set variables.
	if (y >= grounded_ypos) && (animation_index >= sprite_get_number(animation_id)-0.1) {
		state_jumping = false;
		state_landing = true;	
		animation_id = animation_jump_l;
		animation_index = 0;
		animation_id_r = animation_jump_l_r;
		animation_index_r = 0;		
		//show_debug_message("YESSSSSSSSSSSSSSSSS")
	}
}

// Grapple Controls ///////////////////////////////////////////////////////////
// Start Grapple Animation & Get Direction
if (input_hold_m2) {
	if (!state_grappling && !state_retrieving && !state_charging && !state_jumping && !state_landing && !aim_cancel) {
		if (!state_aiming) {
			state_aiming = true;
			max_x_speed = slow_physics[0]
		}
		
		if (animation_id != animation_grapple_aim) {
			animation_id = animation_grapple_aim;
			animation_index = 0;
			animation_id_r = animation_grapple_aim_r;
			animation_index_r = 0;	
		}		
		
		// Get the direction between the grapple launcher and the mouse position.
		var aim_direction = point_direction(grapple_hotspot_x, grapple_hotspot_y, mouse_x, clamp(mouse_y, 0, y));
		
		// Limit the angles the grapple launcher can turn between.
		aim_direction = clamp(aim_direction, 60, 120);
		
		animation_index = clamp(animation_index + 0.3, 0, 4.9);
		animation_index_r = clamp(animation_index_r + 0.3, 0, 4.9);
		
		if (animation_index >= 4.9) {
			animation_id_r = animation_grapple_launcher;
			animation_index_r = 0;
			aim_angle = lerp(aim_angle, aim_direction-90, 0.15);
		}
	}
}

// Trigger Grapple Launch.
if (input_hold_m2 && input_click_m1) {
	if (animation_id_r == animation_grapple_launcher) {
		// Create Rope Object	
		instance_create_layer(grapple_hotspot_x, grapple_hotspot_y, "Instances", obj_rope, {creator : obj_player, depth : -100});
		
		// Create 2nd Rope Object
		instance_create_layer(grapple_hotspot_x, grapple_hotspot_y, "Instances", obj_rope_origin, {creator : obj_player, depth : -100});
			
		// Create Hook Object
		instance_create_layer(grapple_hotspot_x, grapple_hotspot_y - sprite_get_height(spr_grapple)/2, "Instances", obj_hook, {creator : obj_player});
	
		// Toggle Grapple Mode
		event_user(1);
	
		// Generate Asteroid Field
		generate_asteroid_field()
		
		// Throw Grapple
		with (obj_hook) {
			adjust_physics_vars(self, thrown_physics[0], thrown_physics[1], thrown_physics[2], thrown_physics[3], thrown_physics[4], thrown_physics[5]);
			var throw_x = lengthdir_x(max_x_speed, aim_direction);
			var throw_y = lengthdir_y(max_y_speed, aim_direction);
			x_speed = throw_x;
			y_speed = throw_y;
		}
	}
}

// Words
if (!input_hold_m2) {
	if (state_grappling) {
		if (animation_id != animation_grapple_launched) {
			animation_id = animation_grapple_launched;
			animation_index = 0;			
		}
		animation_index = clamp(animation_index + 0.2, 0, 4.9);
		
		// Get the direction between the grapple launcher and the hook position.
		var aim_direction = point_direction(grapple_hotspot_x, grapple_hotspot_y, obj_hook.x, obj_hook.y);
		
		// Limit the angles the grapple launcher can turn between.
		aim_direction = clamp(aim_direction, 60, 120);
		
		aim_angle = lerp(aim_angle, aim_direction-90, 0.05);	
	}
	
	if (instance_exists(obj_hook) && state_retrieving) {
		if (animation_id != animation_grapple_aim) {
			animation_id = animation_grapple_aim;
			animation_index = 0;
		}
		
		// Get the direction between the grapple launcher and the hook position.
		var aim_direction = point_direction(grapple_hotspot_x, grapple_hotspot_y, obj_hook.x, obj_hook.y);
		
		//aim_angle = lerp(aim_angle, aim_direction-90, 0.05);
		aim_angle = aim_direction-90;
	}
	
	if (!instance_exists(obj_hook) && state_retrieving) {
		state_retrieving = false;
		animation_id_r = animation_invis;
		aim_angle = 0;
		max_x_speed = default_physics[0]
	}
}

if (input_click_m2) {
	if (instance_exists(obj_asteroid) && state_retrieving && !state_aiming && !state_grappling) {
		if (obj_asteroid.state_grounded) {
			obj_asteroid.hook_attached = false;
			with (obj_rope) {
				constraints_iterations = 1;
				recall_rope = true;
				alarm[0] = 1;
			}
		}
	}	
}

// Cancel Grapple Launch
if (input_release_m2) {
	if (state_aiming && !state_grappling) {
		aim_angle = 0;
		aim_cancel = true;
		
		animation_id = animation_grapple_aim;
		animation_index = 4.9;
		animation_id_r = animation_grapple_aim_r;
		animation_index_r = 4.9;			
	}
}

// Regress aiming animation back into idle.
if (aim_cancel) {
	if (state_aiming && aim_cancel) {
		animation_index = clamp(animation_index - 0.3, 0, 4.9);
		animation_index_r = clamp(animation_index_r - 0.3, 0, 4.9);
		
		if (animation_index <= 0) {
			aim_cancel = false;
			state_aiming = false;
			max_x_speed = default_physics[0]
		}
	}
}

// Toggle grapple mode if an asteroid has been pulled below the threshold.
if (state_grappling && obj_hook.object_attached != 0) {
	if (obj_hook.y > room_height - grapple_mode_height - sprite_get_height(spr_grapple)/2) {
		event_user(1);
	}
}

// Friction ///////////////////////////////////////////////////////////////////
if (!input_right && !input_left)
    x_speed = Approach(x_speed, 0, temp_fric);

// Room Wrap //////////////////////////////////////////////////////////////////
move_wrap(true, false, 0);
