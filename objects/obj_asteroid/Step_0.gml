if (!hook_attached && !state_grounded) {
	if variable_struct_exists(self, "row_speed") {
		x += row_direction * row_speed;
	}

	if variable_struct_exists(self, "rot_speed") {
		image_angle += rot_speed;
		//show_debug_message(string(rot_speed))
	}
}



// Room Wrap
move_wrap(true, false, 0);



// More Sprites

// Experiment with brown gradient

// Experiment with background blurry sprites.

// Seperate field into many rows of varying speeds.