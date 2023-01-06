///@desc DEBUG MENU CONTROLS
// DEBUG MENU CONTROLS ////////////////////////////////////////////////////////

if (keyboard_check_pressed(ord("Z"))) {
	show_file_contents = !show_file_contents;
}

if (show_file_contents) {
	if (mouse_wheel_up()) {
		scroll_y += 32;
	}

	if (mouse_wheel_down()) {
		scroll_y -= 32;
	}
}


