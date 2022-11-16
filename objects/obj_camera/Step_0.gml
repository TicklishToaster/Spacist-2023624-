// Follow Target
if instance_exists(target){
	camera_x = target.x + target.sprite_width/2 - (camera_width/2);
	camera_y = target.y + target.sprite_height/2 - (camera_height/2);
	
	//camera_x = clamp(camera_x, 0, room_width-camera_width);
	//camera_y = clamp(camera_y, -camera_height*0.5, room_height - camera_height);
	if (room == Room1){
		camera_y = clamp(camera_y, -camera_height*0.5, room_height - camera_height);
	} else if (room == rm_asteroid_belt) {
		camera_y = clamp(camera_y, -camera_height*0.5, room_height + camera_height);
	}
}


// Set Camera Pos
camera_set_view_pos(view_camera[0], camera_x, camera_y);


// Parallax Background Layers X
layer_x("Parallax_1", bg_shift_x*0.70);
layer_x("Parallax_2", bg_shift_x*0.80);
layer_x("Parallax_3", bg_shift_x*0.90);
layer_x("Parallax_Glow", bg_shift_x*0.60);

// Parallax Background Layers Y	
if (room == Room1) {
	if (camera_y < room_height - camera_height) {
		layer_y("Parallax_1", bg_shift_y*0.70);
		layer_y("Parallax_2", bg_shift_y*0.80);
		layer_y("Parallax_3", bg_shift_y*0.90);
		layer_y("Parallax_Glow", bg_shift_y*0.60);
	}
} else if (room == rm_asteroid_belt) {
	if (camera_y > -camera_height*0.5) {
		layer_y("Parallax_1", bg_shift_y*0.70);
		layer_y("Parallax_2", bg_shift_y*0.80);
		layer_y("Parallax_3", bg_shift_y*0.90);
		layer_y("Parallax_Glow", bg_shift_y*0.60);
	}
}	
