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

var input_build_mode		= keyboard_check_pressed(ord("B"));

///////////////////////////////////////////////////////////////////////////////

// Friction ///////////////////////////////////////////////////////////////////
// Which form of acceleration/friction to apply
if (state_grounded) {
    temp_accel = ground_accel;
    temp_fric  = ground_fric;
} else {
    temp_accel = air_accel;
    temp_fric  = air_fric;
}

// Apply Friction
if (!input_right_hold && !input_left_hold) {
    x_speed = Approach(x_speed, 0, temp_fric);
}

// Gravity ////////////////////////////////////////////////////////////////////
if (!state_grounded) {
	if y_speed < 0 {
        // Rise Up
        y_speed = Approach(y_speed, max_y_speed, grav_rise);	
    }	
    else {
        // Fall Down
        y_speed = Approach(y_speed, max_y_speed, grav_fall);
    } 
}

// Movement Controls //////////////////////////////////////////////////////////
// Idle
if (!input_left_hold && !input_right_hold && !input_space_hold) {
	if (state_grounded && !state_charging && !state_jumping && !state_landing && !state_aiming && !state_grappling && !state_retrieving) {
		animation_id = animation_idle;
		animation_index = 0;
		animation_id_r = animation_idle_r;
		animation_index_r = 0;		
	}
}

// Prevent Movement If State_Suspended
if (!state_suspended) {
	// Moving
	if (input_left_hold || input_right_hold) {
		// Move Left 
		if (input_left_hold && !input_right_hold) {
			// Apply acceleration left
			if (x_speed > 0) {
			    x_speed = Approach(x_speed, 0, temp_fric);
			}
			x_speed = Approach(x_speed, -max_x_speed, temp_accel);
		}

		// Move Right 
		if (input_right_hold && !input_left_hold) {
			// Apply acceleration right
			if (x_speed < 0) {
			    x_speed = Approach(x_speed, 0, temp_fric);
			}
			x_speed = Approach(x_speed, max_x_speed, temp_accel);
		}
	
		// Torso Animation
		if (state_grounded && !state_jumping && !state_charging && !state_landing && !state_aiming && !state_retrieving && abs(x_speed) >= 0.4) {
			// Left 
			if (input_left_hold && !input_right_hold) {
				// Adjust Sprite Direction
				if (image_xscale != -1) {
					x+=sprite_width;
					image_xscale = -1;		
				}		
			}

			// Right 
			if (input_right_hold && !input_left_hold) {
				// Adjust Sprite Direction
				if (image_xscale != 1) {
					x+=sprite_width;
					image_xscale = 1;
				}
			}
		
			// Set Animation Loop
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
		
			// Set Animation Loop
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

	// Charge Jumping
	if (input_space_press) {
		if (state_grounded && !state_charging && !state_jumping && !state_landing && !state_aiming && !state_grappling && !state_retrieving && !jump_cancel) {
			// Toggle Charge Jump Variables & Charging Animation.
			state_charging = true;
			if (animation_id != animation_jump_r) {
				animation_id = animation_jump_r;
				animation_index = 0;
				animation_id_r = animation_jump_r_r;
				animation_index_r = 0;
			}
		}
	}
}

// If animation is charging and the animation is unfinished. 
if (input_space_hold) {
	if (state_charging && !state_jumping && !state_landing && !state_retrieving) {
		// Set Animation Loop.
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
		// Set to the charge jump animation proportionate to time spent charging.
		else if (animation_id != animation_jump_r) {
			// If charge timer has reached 20%.
			if (jump_release_timer >= 0.5) {
				animation_id = animation_jump_20; 
				animation_id_r = animation_jump_20_r;
			}
			// If charge timer has reached 40%.
			if (jump_release_timer >= 1.0) {
				animation_id = animation_jump_40;
				animation_id_r = animation_jump_40_r;
			}
			// If charge timer has reached 60%.
			if (jump_release_timer >= 1.5) {
				animation_id = animation_jump_60;
				animation_id_r = animation_jump_60_r;
			}
			// If charge timer has reached 80%.
			if (jump_release_timer >= 2.0) {
				animation_id = animation_jump_80;
				animation_id_r = animation_jump_80_r;
			}
			// If charge timer has reached 100%.
			if (jump_release_timer >= 2.5) {
				animation_id = animation_jump_100;
				animation_id_r = animation_jump_100_r;
			}
				
			animation_index = 0;
			animation_index_r = 0;
		}
		jump_release_timer += (room_speed / 60) / 60;
		set_phys(grapple_physics);
	}
}

// Release input and jump up.
if (input_space_release) {
	if (state_charging && !state_jumping && !state_landing) {
		// Cancel jump animation if released early.
		if (animation_id == animation_jump_r) {
			jump_cancel = true;
		}
		// Set the jump speed in proportion to time spent charging.
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
			
			// Set jumping variables.
			state_grounded = false;
			state_charging = false;
			state_jumping = true;
			
			animation_index = 0;
			animation_index_r = 0;
			
			set_phys(default_physics);
			jump_release_timer = 0;				
		}
	}
}

// If jump is canceled, or if landing normally, regress jump animation into idle animation.
if (!input_space_hold) || (state_grounded) {
	if (jump_cancel && state_charging && !state_jumping && !state_landing) || (state_landing && !state_jumping && !state_charging) {
		// If jump is canceled.
		if (animation_id == animation_jump_r) {
			animation_index = clamp(animation_index - 0.2, 0, sprite_get_number(animation_jump_r)-0.1);
			animation_index_r = clamp(animation_index_r - 0.2, 0, sprite_get_number(animation_jump_r_r)-0.1);
			// Reset jumping variables when unreadying animation is finished.
			if (animation_index <= 0.0) {
				animation_index = 0;
				animation_index_r = 0;
				state_charging = false;
				state_jumping = false;
				state_landing = false;
				jump_cancel = false;
				set_phys(default_physics);
				jump_release_timer = 0;
			}
		}
		// If landing normally.
		else if (animation_id == animation_jump_l) {
			animation_index = clamp(animation_index + 0.2, 0, 14.9);
			animation_index_r = clamp(animation_index_r + 0.2, 0, 14.9);
			// Reset jumping variables when unreadying animation is finished.
			if (animation_index >= 14.9) {
				state_charging = false;
				state_jumping = false;
				state_landing = false;
				jump_cancel = false;
				set_phys(default_physics);
				jump_release_timer = 0;				
			}
		}
	}
}

// If jumping up, play jumping animation.
if (state_jumping && !state_charging && !state_landing) {
	// Set Animation Loop.
	if (animation_id != animation_jump_r) {
		animation_index = clamp(animation_index + 0.4, 0, sprite_get_number(animation_id)-0.1);
		animation_index_r = clamp(animation_index_r + 0.4, 0, sprite_get_number(animation_id)-0.1);
	}	
	
	// Check if landing and set jump variables.
	if (y >= grounded_ypos) && (animation_index >= sprite_get_number(animation_id)-0.1) {
		state_jumping = false;
		state_landing = true;	
		animation_id = animation_jump_l;
		animation_index = 0;
		animation_id_r = animation_jump_l_r;
		animation_index_r = 0;		
	}
}

// Grapple Controls ///////////////////////////////////////////////////////////
// Initiate Grapple Animation
if ((input_shift_press || input_mouse2_click) && !instance_exists(obj_hook)) {
	if (!state_grappling && !state_retrieving && !state_charging && !state_jumping && !state_landing && !aim_cancel) {
		// Start Grapple Animation.
		if (!state_aiming) {
			state_aiming = true;
			set_phys(grapple_physics);
		}
		
		// Set Animation Variables.
		if (animation_id != animation_grapple_aim) {
			animation_id = animation_grapple_aim;
			animation_index = 0;
			animation_id_r = animation_grapple_aim_r;
			animation_index_r = 0;	
		}		
	}
}

// Cancel Grapple Animation
if (input_mouse2_release) {
	if (state_aiming && !state_grappling) {
		aim_angle = 0;
		aim_angle_target = 90;
		aim_cancel = true;
		
		animation_id = animation_grapple_aim;
		animation_index = 4.9;
		animation_id_r = animation_grapple_aim_r;
		animation_index_r = 4.9;			
	}
}

// Update Grapple Launcher Angle
if ((input_shift_hold || input_mouse2_hold) && !instance_exists(obj_hook)) {
	if (state_aiming && !state_grappling && !state_retrieving && !state_charging && !state_jumping && !state_landing && !aim_cancel) {
		// Rotate grapple launcher anti-clockwise.
		if (input_leftarrow_hold || input_mouse5_click || mouse_wheel_up()) {
			aim_angle_target = clamp(aim_angle_target + 5, 70, 110);
			//aim_angle_target = clamp(aim_angle_target + 5, 45, 135);
		}
		
		// Rotate grapple launcher clockwise.
		if (input_rightarrow_hold || input_mouse4_click || mouse_wheel_down()) {
			aim_angle_target = clamp(aim_angle_target - 5, 70, 110);
			//aim_angle_target = clamp(aim_angle_target - 5, 45, 135);
		}
		
		// Play the "grapple launcher readying" animation sequence.
		animation_index = clamp(animation_index + 0.3, 0, 4.9);
		animation_index_r = clamp(animation_index_r + 0.3, 0, 4.9);
		
		// If animation sequence is finished, update the grapple launcher angle.
		if (animation_index >= 4.9) {
			animation_id_r = animation_grapple_launcher;
			animation_index_r = 0;
			aim_angle = lerp(aim_angle, aim_angle_target-90, 0.20);
		}
	}
}

// Trigger Grapple Launch
if ((input_shift_hold || input_mouse2_hold) && (input_space_press || input_mouse1_click) && !instance_exists(obj_hook)) {
	if (state_aiming && animation_id_r == animation_grapple_launcher) {		
		// Create Hook Object.
		instance_create_layer(grapple_origin_x, grapple_origin_y - sprite_get_height(spr_grapple)/2, "Instances", obj_hook, {creator : obj_player});		
		
		// Create Rope Object.
		instance_create_layer(grapple_origin_x, grapple_origin_y, "Instances", obj_grapple_chain, {creator : obj_player, depth : -100});		
		
		// Set Grapple Variables
		state_grappling = true;
		
		// Set Camera Variables
		//obj_camera.state_panning = true;
		obj_camera.target = obj_hook;
		obj_camera.bg_asteroid_shift = 0;
		with (obj_camera) {			
			pann_camera(obj_player, obj_hook, 0.005);
		}
		
		// Throw Grapple
		with (obj_hook) {		
			// max_y_speed is intentionally set on both.
			x_speed = lengthdir_x(max_y_speed, creator.aim_angle_target);
			y_speed = lengthdir_y(max_y_speed, creator.aim_angle_target);
			horizontal_origin = x;
		}
		
		// Set Grapple Animation
		animation_id = animation_grapple_launched;
		animation_index = 0;
		
		// Generate Asteroid Field
		generate_asteroid_field();		
	}
}

// Set Torso Animation & Grapple Launcher Angle (After Launch)
if (instance_exists(obj_hook)) {
	// If grapple was just launched, play "grapple launched" animation.
	if (state_grappling && animation_id == animation_grapple_launched) {
		animation_index = clamp(animation_index + 0.2, 0, 4.9);
		if (animation_index >= 4.9) {
			animation_id = animation_grapple_looking;
			animation_index = 2;
		}
	}
	
	// If "grapple launched" animation complete, angle grapple launcher towards hook object.
	else if (state_grappling) {	
		// Get the direction between the grapple launcher and the hook position.
		var aim_direction = point_direction(grapple_origin_x, grapple_origin_y, obj_hook.x, obj_hook.y);
		
		// Rotate the grapple launcher toward the hook object.
		aim_angle = aim_direction-90;
		
		// Set player "grapple looking" animation frame.
		if (aim_direction > 60 ) {animation_index = 3;}
		if (aim_direction > 80 ) {animation_index = 2;}
		if (aim_direction > 100) {animation_index = 1;}
	}
	
	//if (aim_angle > 0 && image_xscale == 1) {
	//	image_xscale = -1;
	//	x -= sprite_width - sprite_get_yoffset(spr_player_rope_launcher);
	//}
	//if (aim_angle < 0 && image_xscale == -1) {
	//	image_xscale = 1;
	//	x += sprite_get_yoffset(spr_player_rope_launcher);		
	//}
	//show_debug_message(aim_angle)
	//show_debug_message(grapple_origin_x)
}

// Regress Aiming Animation (Aim Cancel)
if (!instance_exists(obj_hook)) {
	if (aim_cancel && state_aiming) {
		animation_index = clamp(animation_index - 0.3, 0, 4.9);
		animation_index_r = clamp(animation_index_r - 0.3, 0, 4.9);
		
		if (animation_index <= 0) {
			aim_cancel = false;
			state_aiming = false;
			set_phys(default_physics);
		}
	}
}

// Check Grapple Retrieved
if (!instance_exists(obj_hook)) {
	if (state_retrieving) {
		// Set States & Animations to Default
		state_aiming = false;
		state_grappling = false;
		state_retrieving = false;
		animation_id_r = animation_invis;
		aim_angle = 0;
		aim_angle_target = 90;
		set_phys(default_physics);
		show_states();
		
		// Relocate position if too far or too close to the falling asteroid.
		show_debug_message(grapple_distance);
		show_debug_message(obj_camera.camera_width/4);
		if (abs(grapple_distance) > obj_camera.camera_width/4) {
			if (grapple_distance > 0) {
				//x = grapple_object.x - obj_camera.camera_width/2 + sprite_width/2;
				x = grapple_object.x - obj_camera.camera_width/4;
				//x+=sprite_width;
				image_xscale = 1;
			}
			if (grapple_distance < 0) {
				//x = grapple_object.x + obj_camera.camera_width/2 + sprite_width/2;
				x = grapple_object.x + obj_camera.camera_width/4;
				//x+=sprite_width;
				image_xscale = -1;				
			}
		}
		else if (abs(grapple_distance) < grapple_object.sprite_width*2) {
			if (grapple_distance > 0) {
				x = grapple_object.x - grapple_object.sprite_width*2;
				//x+=sprite_width;
				image_xscale = 1;
			}
			if (grapple_distance < 0) {
				x = grapple_object.x + grapple_object.sprite_width*2;
				//x+=sprite_width;
				image_xscale = -1;
			}
		}
		
		grapple_distance = 0;
	}
}

// Enable Popup Window & Asteroids Layer
if (state_grappling && view_visible[1] == false && obj_hook.y < grapple_camera_height - sprite_get_height(spr_grapple)/2) {
	// Enable Popup Window
	view_visible[1] = true;
	
	// Enable Popup Backgrounds.
	layer_set_visible("Window_Terrain_Foreground",	true);
	layer_set_visible("Terrain_Foreground",			false);
	layer_set_visible("Window_Parallax_1",			true);
	layer_set_visible("Window_Parallax_2",			true);
	layer_set_visible("Window_Parallax_3",			true);
	layer_set_visible("Window_Parallax_4",			true);
	layer_set_visible("Window_Parallax_Canvas",		true);
		
	// Enable Asteroids Backgrounds.
	layer_set_visible("Asteroids_Parallax_1",	true);
	layer_set_visible("Asteroids_Parallax_2",	true);
	layer_set_visible("Asteroids_Parallax_3",	true);
	layer_set_visible("Asteroids_Parallax_4",	true);
	layer_set_visible("Asteroids_Gradient",		true);
}

// Disable Popup Window & Asteroids Layer
else if (!state_grappling && view_visible[1] == true) {
	// Disable Popup Window
	view_visible[1] = false;
	
	// Disable Popup Backgrounds.
	layer_set_visible("Window_Terrain_Foreground",	false);
	layer_set_visible("Terrain_Foreground",			true);
	layer_set_visible("Window_Parallax_1",			false);
	layer_set_visible("Window_Parallax_2",			false);
	layer_set_visible("Window_Parallax_3",			false);
	layer_set_visible("Window_Parallax_4",			false);
	layer_set_visible("Window_Parallax_Canvas",		false);

	// Disable Asteroids Backgrounds.
	layer_set_visible("Asteroids_Parallax_1",	false);
	layer_set_visible("Asteroids_Parallax_2",	false);
	layer_set_visible("Asteroids_Parallax_3",	false);
	layer_set_visible("Asteroids_Parallax_4",	false);
	layer_set_visible("Asteroids_Gradient",		false);	
}


// Build Controls /////////////////////////////////////////////////////////////
// Toggle build mode if a building item is currently selected.
var selected_item = ex_item_get_item(global.inv_toolbar, array_get_index(obj_inv_panel_toolbar.slots, obj_inv_panel_toolbar.selected_slot))
if (ds_exists(selected_item, ds_type_map)) {
	if (selected_item[? "type"] == "building") {
		state_building = true;
		show_debug_message(selected_item[? "key"]);
		show_debug_message(selected_item[? "type"]);
		show_debug_message("");
		
		if (selected_item[? "key"] = "building_smelter") {
			//current_building = instance_create_layer(x, y, "Instances", obj_smelter)
			//current_building = obj_smelter;
			current_building = obj_parent_building;
			current_building.sprite_index = spr_smelter;
		}
		
		if (selected_item[? "key"] = "building_constructor") {
			//current_building = instance_create_layer(x, y, "Instances", obj_constructor)
			//current_building = obj_constructor;
			current_building = obj_parent_building;
			current_building.sprite_index = spr_constructor;			
		}
		
		if (selected_item[? "key"] = "building_conveyor_belt_mk1") {
			//current_building = instance_create_layer(x, y, "Instances", obj_conveyor_belt)
			//current_building = obj_conveyor_belt;
			current_building = obj_parent_building;
			current_building.sprite_index = spr_conveyor_belt;			
		}
		
		show_debug_message(current_building)
	}	
}
else {
	state_building = false;
	current_building = noone;
}


// Room Wrap //////////////////////////////////////////////////////////////////
if (!state_grappling) {
	move_wrap(true, false, 0);
}
