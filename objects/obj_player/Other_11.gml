/// @description Toggle Grapple Mode

if (!state_grappling) {
	//obj_camera.bg_window_shift_x = obj_camera.bg_shift_x;
	state_grappling = true;
	obj_camera.target = obj_hook;
	//m = 0.2;
	//event_user(0);
} 
else if (state_grappling) {
	//obj_camera.bg_window_shift_x = obj_camera.bg_shift_x;
	state_aiming = false;
	state_grappling = false;
	state_retrieving = true;
	obj_camera.target = self;
	//m = 1;
	//event_user(0);
}

