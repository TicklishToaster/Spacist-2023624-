// Movement & Collision ///////////////////////////////////////////////////////
var i;

// Vertical
for (i = 0; i < abs(y_speed); ++i) {
	// This will shift the player by a number of pixels equal to the integer of y_speed.
	// Example: y_speed = 5, move 5 pixels per frame.
    if (!place_meeting(x, y + sign(y_speed), obj_parent_solid)) {
        y += sign(y_speed);
		
		// Move parallax backgrounds only if camera is not at screen edge.
		if ((obj_camera.camera_y < room_height - obj_camera.camera_height) && (obj_camera.camera_y > obj_camera.camera_height/2)) {
			obj_camera.bg_shift_y += sign(y_speed);
		}
	}
    else {
        y_speed = 0;
        break;
    }
}

// Horizontal
for (i = 0; i < abs(x_speed); ++i) {
	// This will shift the hook by a number of pixels equal to the integer of x_speed.
	// Example: x_speed = 2, move 2 pixels per frame.	
    if (!place_meeting(x + sign(x_speed), y, obj_parent_solid)) {
        x += sign(x_speed);
		if (!state_grappling) {
			obj_camera.bg_shift_x += sign(x_speed);
		}
		else if (state_grappling) {
			grapple_distance += sign(x_speed);
		}
		obj_camera.bg_window_shift_x += sign(x_speed);
	}
    else {
		x_speed = 0;
        break;
    }
}