// Apply the effects from the layer profile onto the original profile, targeting a range of layers.
ppfx_layer_apply(terrain_effects_id, terrain_layer_index, layer_get_id("Foreground"), layer_get_id("Foreground"), false);
ppfx_layer_apply(star_effects_id, star_layer_index, layer_get_id("Parallax_1"), layer_get_id("Parallax_2"), false);
ppfx_layer_apply(dist_star_effects_id, dist_star_layer_index, layer_get_id("Parallax_3"), layer_get_id("Parallax_3"), false);
//ppfx_layer_apply(space_effects_id, space_layer_index, layer_get_id("Background"), layer_get_id("Background"), false);