// Follow Target //////////////////////////////////////////////////////////////
if instance_exists(target){
	camera_x = target.x + target.sprite_width/2 - (camera_width/2);
	camera_y = target.y + target.sprite_height/2 - (camera_height/2);
	camera_y = clamp(camera_y, 0, room_height - camera_height);
}


// Set Camera Pos /////////////////////////////////////////////////////////////
camera_set_view_pos(view_camera[0], camera_x, camera_y);
camera_set_view_pos(view_camera[1], obj_player.x+64-view_get_wport(1)/2, obj_player.y-96);


// Parallax Backgrounds ///////////////////////////////////////////////////////
// Parallax Background Layer 1 (Starfield Front)
layer_x("Parallax_1", bg_shift_x*0.70);
layer_x("Window_Parallax_1", bg_window_shift_x*0.70);
if (camera_y < room_height - camera_height) {
	layer_y("Parallax_1", bg_shift_y*0.70); }

// Parallax Background Layer 2 (Starfield Middle)
layer_x("Parallax_2", bg_shift_x*0.80);
layer_x("Window_Parallax_2", bg_window_shift_x*0.80);
if (camera_y < room_height - camera_height) {
	layer_y("Parallax_2", bg_shift_y*0.80);	}

// Parallax Background Layer 3 (Starfield Back)
layer_x("Parallax_3", bg_shift_x*0.90);
layer_x("Window_Parallax_3", bg_window_shift_x*0.90);
if (camera_y < room_height - camera_height) {
	layer_y("Parallax_3", bg_shift_y*0.90); }

// Parallax Background Layer 4 (Starfield Gradient Undertone)
layer_x("Parallax_4", bg_shift_x*0.60);
layer_x("Window_Parallax_4", bg_window_shift_x*0.60);
if (camera_y < room_height - camera_height) {
	layer_y("Parallax_4", bg_shift_y*0.60); }


layer_x("Asteroids_Parallax_1", bg_shift_x*0.90)
layer_x("Asteroids_Parallax_2", bg_shift_x*0.70)
layer_x("Asteroids_Parallax_3", bg_shift_x*0.50)
layer_x("Asteroids_Parallax_4", bg_shift_x*0.60)

//layer_hspeed("Asteroids_Parallax_1", 5);