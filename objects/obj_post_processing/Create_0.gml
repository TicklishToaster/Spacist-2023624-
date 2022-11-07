////////// *THIS IS FOR APPLYING EFFECTS TO THE WHOLE SCREEN* ////////////////////
//// Disable the application surface. *REQUIRED*
//ppfx_application_render_init();

//// Create the ppfx system.
//ppfx_id = ppfx_create();

//// Create all effects to be loaded into a profile.
//var effects = [
//	new pp_panorama(false, 0.3),
//	new pp_lens_distortion(true, -0.3),
//	new pp_scanlines(false)
//];
//main_profile = ppfx_profile_create("Main", effects);

//// Load the profile, allowing the contained effects to be called.
//ppfx_profile_load(ppfx_id, main_profile);


////////// *THIS IS FOR APPLYING EFFECTS TO A SPECIFIC ROOM LAYER* ////////////////////
// Create the profile and all desired effects.
layer_effects_id = ppfx_create();
var foreground_profile = ppfx_profile_create("Terrain Curve Effect", [
	new pp_panorama(true, 0.1),
	new pp_lens_distortion(false, -0.1),
	new pp_scanlines(false),
]);

// Load the profile, allowing the contained effects to be called.
ppfx_profile_load(layer_effects_id, foreground_profile);

// Create a layer profile to target a specific layer.
layer_index = ppfx_layer_create();

// Apply the effects from the layer profile onto the original profile, targeting a range of layers.
ppfx_layer_apply(layer_effects_id, layer_index, layer_get_id("Foreground"), layer_get_id("Foreground"), false);


////////// *THIS IS FOR APPLYING EFFECTS TO THE WHOLE SCREEN* ////////////////////
//// Disable the application surface. *REQUIRED*
//ppfx_application_render_init();

//// Create the ppfx system.
//ppfx_id = ppfx_create();

//// Create all effects to be loaded into a profile.
//var effects = [
//	new pp_panorama(false, 0.3),
//	new pp_lens_distortion(false, -0.3),
//	new pp_scanlines(false)
//];
//main_profile = ppfx_profile_create("Main", effects);

//// Load the profile, allowing the contained effects to be called.
//ppfx_profile_load(ppfx_id, main_profile);

//lens_distort_id = ppfx_create();
//// disable auto-draw of this system - because we will draw it manually, using the area functions!
//ppfx_set_draw_enable(lens_distort_id, false);
//var _profile_distort = ppfx_profile_create("Lens Distort", [
//    new pp_lens_distortion(true, -0.1),
//	new pp_palette_swap(false),
//]);
//ppfx_profile_load(lens_distort_id, _profile_distort);