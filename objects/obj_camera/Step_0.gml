// Follow Target //////////////////////////////////////////////////////////////
if (instance_exists(target) && (!state_panning)) {
	// Set Camera Position
	camera_x = target.hotspot_x - (camera_width /2);
	camera_y = target.hotspot_y - (camera_height/2);
	camera_y = clamp(camera_y, 0, room_height - camera_height);
	x = camera_x;
	y = camera_y;
	
	if (target == obj_hook && (obj_hook.state_controlled || obj_hook.state_pulling)) {
		camera_y = clamp(camera_y, 0, 1280 - camera_height);
	}
}

// Pann Over To New Target
if (instance_exists(target) && (state_panning)) {
	// Pann from Origin Object to Target Object using sin(pann_coefficient) to move from 0% - 100% distance.
	camera_x = lerp(pann_origin_object.hotspot_x - (camera_width /2), pann_target_object.hotspot_x - (camera_width /2), dsin(pann_coefficient*90));
	camera_y = lerp(pann_origin_object.hotspot_y - (camera_height/2), pann_target_object.hotspot_y - (camera_height/2), dsin(pann_coefficient*90));
	camera_y = clamp(camera_y, 0, room_height - camera_height);
}

// Set Camera Pos /////////////////////////////////////////////////////////////
camera_set_view_pos(view_camera[0], camera_x, camera_y);
camera_set_view_pos(view_camera[1], obj_player.hotspot_x - view_get_wport(1)/2, obj_player.hotspot_y - view_get_hport(1)/2);


// Parallax Backgrounds ///////////////////////////////////////////////////////
// Parallax Background Layer 1 (Starfield Front)
layer_x("Parallax_1", bg_shift_x*0.70);
layer_x("Window_Parallax_1", bg_window_shift_x*0.70);
if (camera_y < room_height - camera_height) { layer_y("Parallax_1", bg_shift_y*0.70); }

// Parallax Background Layer 2 (Starfield Middle)
layer_x("Parallax_2", bg_shift_x*0.80);
layer_x("Window_Parallax_2", bg_window_shift_x*0.80);
if (camera_y < room_height - camera_height) { layer_y("Parallax_2", bg_shift_y*0.80);	}

// Parallax Background Layer 3 (Starfield Back)
layer_x("Parallax_3", bg_shift_x*0.90);
layer_x("Window_Parallax_3", bg_window_shift_x*0.90);
if (camera_y < room_height - camera_height) { layer_y("Parallax_3", bg_shift_y*0.90); }

// Parallax Background Layer 4 (Starfield Gradient Undertone)
layer_x("Parallax_4", bg_shift_x*0.60);
layer_x("Window_Parallax_4", bg_window_shift_x*0.60);
if (camera_y < room_height - camera_height) { layer_y("Parallax_4", bg_shift_y*0.60); }

// Move Asteroid Backgrounds Naturally
if (obj_player.state_grappling) {
	bg_asteroid_shift -= 0.5;
}

// Parallax Background Layer 1-4 (Asteroid Field)
layer_x("Asteroids_Parallax_1", bg_shift_x*0.60 + bg_asteroid_shift*0.60);
layer_x("Asteroids_Parallax_2", bg_shift_x*0.70 + bg_asteroid_shift*0.70);
layer_x("Asteroids_Parallax_3", bg_shift_x*0.50 + bg_asteroid_shift*0.50);
layer_x("Asteroids_Parallax_4", bg_shift_x*0.60 + bg_asteroid_shift*0.60);

//show_debug_message(panning_lerp_co)