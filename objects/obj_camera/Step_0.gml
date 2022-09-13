// Follow Target
if instance_exists(target){
	camera_x = target.x - (camera_width/2);
	camera_y = target.y - (camera_height/2);
	
	camera_x = clamp(camera_x, 0, room_width-camera_width);
	camera_y = clamp(camera_y, 0, room_height-camera_height);
}


// Set Camera Pos
camera_set_view_pos(view_camera[0], camera_x, camera_y);


// Trigger Camera Shake
camera_x += random_range(-camera_shake, camera_shake);
camera_y += random_range(-camera_shake, camera_shake);

if camera_shake > 0 {
	camera_shake -= 0.2;
	if camera_shake < 0 {camera_shake = 0;}
}


// Parallax Background Layer 0
layer_x("Parallax_0", camera_x*0.90);
layer_y("Parallax_0", camera_y*0.90);
show_debug_message("X: " + string(camera_x))
show_debug_message("Y: " + string(camera_y))

// Parallax Background Layer 1
layer_x("Parallax_1", camera_x*0.80);
layer_y("Parallax_1", camera_y*0.80);

// Parallax Background Layer 2
layer_x("Parallax_2", camera_x*0.70);
layer_y("Parallax_2", camera_y*0.70);

// Parallax Background Layer 3
layer_x("Parallax_3", camera_x*0.60);
layer_y("Parallax_3", camera_y*0.60);