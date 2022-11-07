// Follow Target
if instance_exists(target){
	camera_x = target.x + target.sprite_width/2 - (camera_width/2);
	camera_y = target.y + target.sprite_height/2 - (camera_height/2);
	
	//camera_x = clamp(camera_x, 0, room_width-camera_width);
	camera_y = clamp(camera_y, 0, room_height - camera_height);

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


// Background Shift
if obj_player.x > room_width{
	bg_shift += 1;
}

if obj_player.x < 0 { 
	bg_shift -= 1;
}


// Parallax Background Layer 1
layer_x("Parallax_1", (camera_x+room_width*bg_shift)*0.70);
layer_y("Parallax_1", camera_y*0.70);

// Parallax Background Layer 2
layer_x("Parallax_2", (camera_x+room_width*bg_shift)*0.80);
layer_y("Parallax_2", camera_y*0.80);

// Parallax Background Layer 3
layer_x("Parallax_3", (camera_x+room_width*bg_shift)*0.90);
layer_y("Parallax_3", camera_y*0.90);

// Parallax Background Glow Layer
layer_x("Parallax_Glow", (camera_x+room_width*bg_shift)*0.60);
layer_y("Parallax_Glow", camera_y*0.60);