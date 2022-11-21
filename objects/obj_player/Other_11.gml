/// @description Toggle Rope Mode
// You can write your code in this editor

if (!grapple_mode) {
	//obj_camera.bg_window_shift_x = obj_camera.bg_shift_x;
	grapple_mode = true;
	m = 0.2;
	event_user(0);
} else if (grapple_mode) {
	//obj_camera.bg_window_shift_x = obj_camera.bg_shift_x;
	grapple_mode = false;
	m = 1;
	event_user(0);
}


