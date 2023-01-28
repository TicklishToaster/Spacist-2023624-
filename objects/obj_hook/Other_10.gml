/// @description Enable Grapple Settings
/// Toggle Popup Camera, Popup Backgrounds and Asteroids Backgrounds.

//// Initialise Rope Object
//instance_create_layer(creator.grapple_hotspot_x, creator.grapple_hotspot_y, 
//	"Instances", obj_rope_origin, {creator : obj_player});

// Set Origin Rope Visibility
obj_rope_origin.animation_visible = true;
		
// Enable Popup Backgrounds.
layer_set_visible("Window_Terrain_Foreground",	true);
layer_set_visible("Terrain_Foreground",			false);
layer_set_visible("Window_Parallax_1",			true);
layer_set_visible("Window_Parallax_2",			true);
layer_set_visible("Window_Parallax_3",			true);
layer_set_visible("Window_Parallax_4",			true);
layer_set_visible("Window_Parallax_Canvas",		true);
view_visible[1] = true;	
		
// Enable Asteroids Backgrounds.
//layer_set_visible("Asteroids_Layer",		true);
layer_set_visible("Asteroids_Parallax_1",	true);
layer_set_visible("Asteroids_Parallax_2",	true);
layer_set_visible("Asteroids_Parallax_3",	true);
layer_set_visible("Asteroids_Parallax_4",	true);
layer_set_visible("Asteroids_Gradient",		true);		
