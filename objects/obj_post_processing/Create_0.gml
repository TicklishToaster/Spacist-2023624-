// Store profiles and layers into an array for Clean Up.
ppfx_ids = []
ppfx_layer_ids = []


// Create the profile and all desired effects.
terrain_effects_id = ppfx_create();
ppfx_ids[0] = terrain_effects_id;
var terrain_profile = ppfx_profile_create("Terrain Curve Effect", [
	new pp_panorama(true, 0.1),
	new pp_lens_distortion(false, -0.1)
]);

star_effects_id = ppfx_create();
ppfx_ids[1] = star_effects_id;
var star_profile = ppfx_profile_create("Star Glow Effect", [
	new pp_bloom(true, 5, 0.40, 3+1),
	//new pp_sunshafts(true, [0.5, 0.5], 0.3 - 0.3, 0.5, 2.0, 0.6, 0.25)
	new pp_vignette(true, 1-0.4, 0.6, 0.15 + 0.4, 1.10 - 0.30)
]);

dist_star_effects_id = ppfx_create();
ppfx_ids[2] = star_effects_id;
var distant_star_profile = ppfx_profile_create("Star Glow Effect", [
	new pp_vignette(true, 1-0.4, 0.6, 0.15 + 0.4, 1.10 - 0.00)
]);

space_effects_id = ppfx_create();
ppfx_ids[3] = space_effects_id;
var space_profile = ppfx_profile_create("Background Fog Effect", [
	new pp_mist(true, 0.1, 1, 1, 0.1, 0, 0.63)
]);


// Load the profile, allowing the contained effects to be called.
ppfx_profile_load(terrain_effects_id, terrain_profile);
ppfx_profile_load(star_effects_id, star_profile);
ppfx_profile_load(dist_star_effects_id, distant_star_profile);
ppfx_profile_load(space_effects_id, space_profile);


// Create layer profiles to target a specific layer.
terrain_layer_index = ppfx_layer_create();
ppfx_layer_ids[0] = terrain_layer_index;

star_layer_index = ppfx_layer_create();
ppfx_layer_ids[1] = star_layer_index;

dist_star_layer_index = ppfx_layer_create();
ppfx_layer_ids[2] = dist_star_layer_index;

space_layer_index = ppfx_layer_create();
ppfx_layer_ids[3] = space_layer_index;