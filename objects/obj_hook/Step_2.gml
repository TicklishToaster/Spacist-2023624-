// Movement & Collision ///////////////////////////////////////////////////////
var i;

// Vertical
for (i = 0; i < abs(y_speed); ++i) {
	// Stop movement and exit loop if at room edge.
	if (state_controlled) {
		//if ((y + sign(y_speed) <= 128) || (y + sign(y_speed) >= creator.grapple_mode_height + 256)) {
		if ((y + sign(y_speed) <= 128) || (y + sign(y_speed) >= creator.grapple_mode_height)) {
			y_speed = 0;
			break;
		}
	}
	
	// This will shift the hook and any attached object by a number of pixels equal to the integer of y_speed.
	// Example: y_speed = 5, move 5 pixels per frame.
	if (!place_meeting(x, y + sign(y_speed), obj_floor)) {
	    y += sign(y_speed);
		if (instance_exists(attached_object)) {
			attached_object.y += sign(y_speed);
		}
				
		// Move parallax backgrounds if grapple is above a certain threshold.
		if (obj_camera.target.y < room_height - creator.grapple_mode_height && !state_retrieving) {
			// Move parallax backgrounds only if camera is not at screen edge.
			if ((obj_camera.camera_y < room_height - obj_camera.camera_height) && (obj_camera.camera_y > obj_camera.camera_height/2)) {
				obj_camera.bg_shift_y += sign(y_speed);
			}
		}
	}	
	else {
	    y_speed = 0;
	    break;
	}
}

// Horizontal
for (i = 0; i < abs(x_speed); ++i) {
	// Stop movement and exit loop if at horizontal edge.
	if (state_controlled) {
		if ((horizontal_distance + sign(x_speed) <= -horizontal_limit) || (horizontal_distance + sign(x_speed) >= +horizontal_limit)) {
			x_speed = 0;
			break;
		}
	}	

	// This will shift the hook and any attached object by a number of pixels equal to the integer of x_speed.
	// Example: x_speed = 2, move 2 pixels per frame.
	if (!place_meeting(x + sign(x_speed), y, obj_floor)) {
		x += sign(x_speed);
		if (instance_exists(attached_object)) {
			attached_object.x += sign(x_speed);
		}		
		horizontal_distance += sign(x_speed);
		
		// Move parallax backgrounds if grapple is above a certain threshold.
		if (obj_camera.target.y < room_height - creator.grapple_mode_height/2 && !state_retrieving) {
			obj_camera.bg_shift_x += sign(x_speed);
		}
	}	
	else {
		x_speed = 0;
		break;
	}
}



//show_debug_message("");
//show_debug_message("XPos: " + string(x));
//show_debug_message("Dist: " + string(abs(horizontal_distance)));
//show_debug_message("H-Origin:" + string(horizontal_origin));
////show_debug_message("U-Limit: " + string(horizontal_origin +horizontal_limit));
//show_debug_message("U-Limit: " + string(+horizontal_limit));
////show_debug_message("L-Limit: " + string(horizontal_origin -horizontal_limit));
//show_debug_message("L-Limit: " + string(-horizontal_limit));