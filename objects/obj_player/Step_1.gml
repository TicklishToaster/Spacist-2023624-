// Check if player is grounded.
grounded = place_meeting(x, y + 1, obj_parent_solid);
if (grounded) {
	grounded_ypos = y;
}

// Update Hotspot (Center of Player Sprite)
hotspot_x = x + sprite_width/2;
hotspot_y = y + sprite_height/2;



// Declare Temp Variables /////////////////////////////////////////////////////
var input_left, input_right, input_up, input_down, 
	input_jump, input_jump_release, input_click_m1, input_click_m2, input_hold_m2;
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
// Idle
if (!jumped) {
	if (abs(x_speed) < 0.5) {
		animation_id = player_idle;
	}
}

// Walking
if (!jumped && !grapple_mode) {
	// Left 
	if (input_left && !input_right) {
		// Adjust Sprite Direction
		if (image_xscale != -1) {
			x+=sprite_width;
			image_xscale = -1;		
		}
		if (abs(x_speed) >= 0.5 && grounded) {
			if (animation_id != player_walk) {
				animation_id = player_walk;
			}
		}
	}

	// Right 
	if (input_right && !input_left) {
		// Adjust Sprite Direction
		if (image_xscale != 1) {
			x+=sprite_width;
			image_xscale = 1;
		}
		if (abs(x_speed) >= 0.5 && grounded) {
			if (animation_id != player_walk) {
				animation_id = player_walk;
			}
		}	
	}

	if (animation_id == player_walk) {
		animation_index = clamp(animation_index + 0.2, 0, 16.9);
		if (animation_index >= 16.9) {
			animation_index = 0;
		}
	}
}


// Jumping
if (input_jump && grounded) {
	if (animation_id != player_jump) {
		animation_id = player_jump;
		animation_index = 0;
		jumped = true;
	}
}

if (jumped) {
	if (animation_index < 7.9) {
		animation_index = clamp(animation_index+0.5, 0, 7.9);
	}
	
	if (y_speed < 0) {
		animation_index = clamp(animation_index+0.2, 0, 10.9);	
	}
	
	else if (y_speed > 0) {
		animation_index = clamp(animation_index+0.2, 10, 14.9);
	}
	
	if (!input_jump && grounded && animation_index > 7) {
		animation_index = clamp(animation_index+0.5, 15, 20.9);
		if (animation_index == 20.9) {
			jumped = false;
			jump_cancel = false;
			animation_index = 0;
		}
	}
}

// Grappling
if (input_hold_m2 && !grapple_mode) {	
	if (input_click_m1) {
		animation_index = 0;
		animation_index2 = 0;
	}
}

if (grapple_mode) {
	if (animation_id != player_rope) {
		animation_id = player_rope;
	}
		
	// Up
	if (obj_hook.y_speed < 0) {
		animation_index = clamp(animation_index + 0.2, 0, 12.9);
		if (animation_index >= 12.9) {
			animation_index = 0;
		}
	}

	// Down
	if (obj_hook.y_speed > 0) {
		animation_index = clamp(animation_index - 0.2, 0, 12.9);
		if (animation_index <= 0) {
			animation_index = 12.9;
		}
	}	
	
	// Left 
	if (input_left && !input_right) {
		if (abs(x_speed) >= 0.1) {
			animation_index2 = clamp(animation_index2 + 0.1, 0, 12.9);
			if (animation_index2 >= 12.9) {
				animation_index2 = 0;
			}
		}
	}

	// Right 
	if (input_right && !input_left) {
		if (abs(x_speed) >= 0.1) {
			animation_index2 = clamp(animation_index2 - 0.1, 0, 12.9);
			if (animation_index2 <= 0) {
				animation_index2 = 12.9;
			}
		}	
	}
}

//// Hold and Release Jump Controls.
//if (jumped) {
//	//var height = abs(point_distance(x, y, x, grounded_ypos));
//	//show_debug_message(height/50);		
//	//show_debug_message(animation_index);
//	if (animation_index < 3.9) {
//		animation_index = clamp(animation_index+0.2, 0, 3.9);
		
//		if (jump_cancel) {
//			animation_index = clamp(animation_index-0.4, 0, 3.9);
//			if (animation_index <= 0) {
//				jumped = false;
//				jump_cancel = false;
//				animation_index = 0;
//				exit;
//			}
//		}
		
//		if (input_jump_release) {
//			jump_cancel = true;
//		}
//	}
	
//	if (y_speed < 0) {
//		animation_index = clamp(animation_index+0.2, 0, 10.9);	
//	}
	
//	else if (y_speed > 0) {
//		animation_index = clamp(animation_index+0.2, 10, 14.9);
//	}
	
//	if (!input_jump && grounded && animation_index > 7) {
//		animation_index = clamp(animation_index+0.5, 15, 20.9);
//		if (animation_index == 20.9) {
//			jumped = false;
//			jump_cancel = false;
//			animation_index = 0;
//		}
//	}
//}

//show_debug_message("Jumped: " + string(jumped))
//show_debug_message("Jump Cancel: " + string(jump_cancel))



