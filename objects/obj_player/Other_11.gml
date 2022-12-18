/// @description Toggle Rope Mode

if (!grapple_mode) {
	//obj_camera.bg_window_shift_x = obj_camera.bg_shift_x;
	grapple_mode = true;
	obj_camera.target = obj_hook;
	m = 0.2;
	event_user(0);
} 
else if (grapple_mode) {
	//obj_camera.bg_window_shift_x = obj_camera.bg_shift_x;
	grapple_mode = false;
	obj_camera.target = self;
	m = 1;
	event_user(0);
}


