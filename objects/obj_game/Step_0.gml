// Initialize input variables
var input_restart, input_quit;

input_restart   = keyboard_check_pressed(ord("R"));
input_quit      = keyboard_check_pressed(vk_escape);

// Restart application
if (input_restart)
    game_restart();
    
// Close application
if (input_quit)
    game_end();


// Enable Popup Window & Asteroids Layer
if (obj_player.state_grappling && view_visible[1] == false && obj_hook.y < obj_player.grapple_camera_height - sprite_get_height(spr_grapple)/2) {
	// Enable Popup Window
	view_visible[1] = true;
	
	// Enable Popup Backgrounds.
	layer_set_visible("Window_Terrain_Foreground",	true);
	layer_set_visible("Terrain_Foreground",			false);
	layer_set_visible("Window_Parallax_1",			true);
	layer_set_visible("Window_Parallax_2",			true);
	layer_set_visible("Window_Parallax_3",			true);
	layer_set_visible("Window_Parallax_4",			true);
	layer_set_visible("Window_Parallax_Canvas",		true);
		
	// Enable Asteroids Backgrounds.
	layer_set_visible("Asteroids_Parallax_1",	true);
	layer_set_visible("Asteroids_Parallax_2",	true);
	layer_set_visible("Asteroids_Parallax_3",	true);
	layer_set_visible("Asteroids_Parallax_4",	true);
	layer_set_visible("Asteroids_Gradient",		true);
}

// Disable Popup Window & Asteroids Layer
else if (!obj_player.state_grappling && view_visible[1] == true) {
	// Disable Popup Window
	view_visible[1] = false;
	
	// Disable Popup Backgrounds.
	layer_set_visible("Window_Terrain_Foreground",	false);
	layer_set_visible("Terrain_Foreground",			true);
	layer_set_visible("Window_Parallax_1",			false);
	layer_set_visible("Window_Parallax_2",			false);
	layer_set_visible("Window_Parallax_3",			false);
	layer_set_visible("Window_Parallax_4",			false);
	layer_set_visible("Window_Parallax_Canvas",		false);

	// Disable Asteroids Backgrounds.
	layer_set_visible("Asteroids_Parallax_1",	false);
	layer_set_visible("Asteroids_Parallax_2",	false);
	layer_set_visible("Asteroids_Parallax_3",	false);
	layer_set_visible("Asteroids_Parallax_4",	false);
	layer_set_visible("Asteroids_Gradient",		false);	
}