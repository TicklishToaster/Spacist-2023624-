/// @description Disable Grapple Settings
/// Toggle Popup Camera, Popup Backgrounds and Asteroids Backgrounds.
		
// Halt Horizontal Movement
x_speed = 0;		
		
//// Destroy Rope Object.
//instance_destroy(obj_rope_player);
		
// Destroy all Asteroids except the one attached to the hook.
with (obj_asteroid) {
	if (!hook_attached) {
		//show_debug_message(self);
		instance_destroy();
	}
}
				
// Disable Popup Backgrounds.
layer_set_visible("Window_Terrain_Foreground",	false);
layer_set_visible("Window_Parallax_1",			false);
layer_set_visible("Window_Parallax_2",			false);
layer_set_visible("Window_Parallax_3",			false);
layer_set_visible("Window_Parallax_4",			false);
layer_set_visible("Window_Parallax_Canvas",		false);
view_visible[1] = false;
		
// Disable Asteroids Backgrounds.
//layer_set_visible("Asteroids_Layer",		false);
layer_set_visible("Asteroids_Parallax_1",	false);
layer_set_visible("Asteroids_Parallax_2",	false);
layer_set_visible("Asteroids_Parallax_3",	false);
layer_set_visible("Asteroids_Parallax_4",	false);
layer_set_visible("Asteroids_Gradient",		false);



