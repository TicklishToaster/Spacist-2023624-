/// @description Insert description here
// You can write your code in this editor

if (hook_attached) {
	var x_speed = hook_parent.x_speed;
	var y_speed = hook_parent.y_speed;
	// Vertical
	for (i = 0; i < abs(y_speed); ++i) {
		// This will shift this object by a number of pixels equal to the integer of y_speed.
		// Example: y_speed = 5, move 5 pixels per frame.
		if (!place_meeting(x, y + sign(y_speed), obj_floor)) {
			y += sign(y_speed);
		}
		else {
			hook_parent.max_y_speed = 0;
			hook_parent.y_speed = 0;
			hook_parent.grav_fall = 0;
		}
	}

	// Horizontal
	for (i = 0; i < abs(x_speed); ++i) {
		if (!place_meeting(x, y + sign(y_speed), obj_floor)) {		
			x += sign(x_speed);
		}
	}
}