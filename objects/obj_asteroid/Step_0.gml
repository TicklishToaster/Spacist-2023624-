
// Row Speed
if (!hook_attached && !state_grounded && !state_returning) {
	if variable_struct_exists(self, "row_speed") {
		x -= row_speed;
	}

	if variable_struct_exists(self, "rotation_speed") {
		image_angle += rotation_speed;
	}
}

// Pann Camera When Landed
if (state_grounded && !state_landed) {
	show_debug_message("ASTEROID LANDED");
	state_landed = true;
	with (obj_camera) {
		target = obj_player;
		obj_camera_point_01.x = camera_x;
		obj_camera_point_01.y = camera_y;
		obj_camera_point_01.hotspot_x = obj_camera_point_01.x + (camera_width /2);
		obj_camera_point_01.hotspot_y = obj_camera_point_01.y + (camera_height/2);
		pann_camera(obj_camera_point_01, target, 0.01);
	}
	obj_player.state_suspended = false;
}



// Room Wrap
move_wrap(true, false, 0);