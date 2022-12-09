// Actual collision checks + movement
var i;

// Vertical
for (i = 0; i < abs(y_speed); ++i) {
	// This will shift the hook by a number of pixels equal to the integer of y_speed.
	// Example: y_speed = 5, move 5 pixels per frame.
	if (!place_meeting(x, y + sign(y_speed), obj_floor)) {
	    y += sign(y_speed);
		// Move parallax backgrounds only if camera is not at screen edge.
		if ((obj_camera.camera_y < room_height - obj_camera.camera_height) && 
			(obj_camera.camera_y > obj_camera.camera_height/2)) {
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
	if (!place_meeting(x + sign(x_speed), y, obj_floor)) {
		x += sign(x_speed);
		obj_camera.bg_shift_x += sign(x_speed);
	}
	else {
		x_speed = 0;
		break;
	}
}