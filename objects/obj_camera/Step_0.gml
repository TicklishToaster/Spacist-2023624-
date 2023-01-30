// Follow Target //////////////////////////////////////////////////////////////
if (instance_exists(target) && !state_panning) {
	var target_x = target.x + target.sprite_width /2 - (camera_width /2);
	var target_y = target.y + target.sprite_height/2 - (camera_height/2);
	camera_x = target_x;
	camera_y = target_y;
	camera_y = clamp(camera_y, 0, room_height - camera_height);
}

if (instance_exists(target) && state_panning) {
	var target_x = target.x + target.sprite_width /2 - (camera_width /2);
	var target_y = target.y + target.sprite_height/2 - (camera_height/2);
	camera_x = lerp(camera_x, target_x, panning_lerp_co);
	camera_y = lerp(camera_y, target_y, panning_lerp_co);	
	camera_y = clamp(camera_y, 0, room_height - camera_height);
	
	// If camera position reaches at or near target position, disable panning.
	if (camera_x <= target_x + 2 && camera_x >= target_x - 2) && (camera_y <= target_y + 2 && camera_y >= target_y - 2) {
		state_panning = false;
	}
}

// Set Camera Pos /////////////////////////////////////////////////////////////
camera_set_view_pos(view_camera[0], camera_x, camera_y);
camera_set_view_pos(view_camera[1], obj_player.hotspot_x - view_get_wport(1)/2, obj_player.hotspot_y - view_get_hport(1)/2);

//camera_set_view_pos(view_camera[1], obj_player.hotspot_x- sprite_get_width(obj_player)/2, obj_player.hotspot_y - sprite_get_height(obj_player)/2);
//camera_set_view_pos(view_camera[1], obj_player.hotspot_x-view_get_wport(1)/2, obj_player.hotspot_y - sprite_get_height(obj_player)/2);
//camera_set_view_size(view_camera[1], 240, 240);

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


// Parallax Background Layer 1 (Asteroid Field)
layer_x("Asteroids_Parallax_1", bg_shift_x*0.60)
// Parallax Background Layer 2 (Asteroid Field)
layer_x("Asteroids_Parallax_2", bg_shift_x*0.70)
// Parallax Background Layer 3 (Asteroid Field)
layer_x("Asteroids_Parallax_3", bg_shift_x*0.50)
// Parallax Background Layer 4 (Asteroid Field)
layer_x("Asteroids_Parallax_4", bg_shift_x*0.60)
