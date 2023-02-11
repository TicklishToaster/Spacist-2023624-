//// Words
//if (!state_falling) {
//	img_rot = creator.aim_angle;
//} else {
//	img_rot = lock_rot;
//}

// Grapple Animation //////////////////////////////////////////////////////////
img_index = clamp(img_index + img_speed, 0, 4.9);

// If no object is attached and grapple animation finished, reverse animation.
if (!instance_exists(attached_object) && img_index >= 2.9) {
	img_speed = -0.10;
}

//// If object is attached and grapple animation partly finished, slow animation.
//if (instance_exists(attached_object) && img_index >= 2.9 && img_index < 3.9) {
//	img_speed = 0.03;
//}

// If object is attached and grapple animation finished, stop animation.
if (instance_exists(attached_object) && img_index >= 4.9) {
	img_speed = 0;
	img_index = 4;
}


// DEBUGGING CODE
//draw_line_width(
//	0, 0, 
//	0, creator.grapple_mode_height, 
//	4);
//draw_line_width(
//	room_width, 0, 
//	room_width, creator.grapple_mode_height, 
//	4);
	

//draw_line_width(
//	horizontal_origin + horizontal_limit, 0, 
//	horizontal_origin + horizontal_limit, creator.grapple_mode_height, 
//	2);
	
//draw_line_width(
//	horizontal_origin - horizontal_limit, 0, 
//	horizontal_origin - horizontal_limit, creator.grapple_mode_height, 
//	2);	
	
//draw_line_width(
//	horizontal_origin + horizontal_limit, creator.grapple_mode_height - 256, 
//	horizontal_origin - horizontal_limit, creator.grapple_mode_height - 256, 
//	2);
	
//draw_line_width(
//	horizontal_origin + horizontal_limit, creator.grapple_mode_height/2, 
//	horizontal_origin - horizontal_limit, creator.grapple_mode_height/2, 
//	2);
	
//draw_line_width(
//	horizontal_origin + horizontal_limit, 1280 - obj_camera.camera_height, 
//	horizontal_origin - horizontal_limit, 1280 - obj_camera.camera_height, 
//	2);	