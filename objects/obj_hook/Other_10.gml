/// @description Enable Grapple Settings
/// Toggle Popup Camera, Popup Backgrounds and Asteroids Backgrounds.

//// Initialise Rope Object
//instance_create_layer(creator.x + creator.sprite_width/2, creator.y + creator.sprite_height/2, 
//	"Instances", obj_rope_player, {creator : obj_player});
		
// Enable Popup Backgrounds.
layer_set_visible("Window_Terrain_Foreground",	true);
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
