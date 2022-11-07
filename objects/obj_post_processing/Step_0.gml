//printme = false
//printme = ppfx_effect_get_parameter(layer_effects_id, PP_EFFECT.PANORAMA, PP_PANORAMA_DEPTH);
//printme = ppfx_layer_get_surface(layer_index, false)
//show_debug_message("DEBUG STATEMENT: " + string(printme));

if keyboard_check_pressed(ord("1")) {
	ppfx_effect_set_enable(layer_effects_id, PP_EFFECT.PANORAMA, true)
	ppfx_effect_set_enable(layer_effects_id, PP_EFFECT.LENS_DISTORTION, false)
}

if keyboard_check_pressed(ord("2")) {
	ppfx_effect_set_enable(layer_effects_id, PP_EFFECT.PANORAMA, false)
	ppfx_effect_set_enable(layer_effects_id, PP_EFFECT.LENS_DISTORTION, true)
}
