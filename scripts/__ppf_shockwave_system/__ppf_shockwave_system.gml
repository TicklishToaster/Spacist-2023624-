
/*-------------------------------------------------------------------------------------------------
	These functions are independent, so if you delete them from the asset, it will not interfere
	with other features of PPFX.
-------------------------------------------------------------------------------------------------*/

/// @ignore
function __shockwave_system() constructor {
	_surface = -1;
}

/// @desc Create shockwave system id to be used by the other functions.
/// @returns {Struct} Shockwave system id.
function shockwave_create() {
	__ppf_trace("Shockwave system created. From: " + object_get_name(object_index));
	return new __shockwave_system();
}

/// @desc Check if shockwave system exists
/// @param {Struct} system_index The returned variable by shockwave_create().
/// @returns {Bool}
function shockwave_exists(system_index) {
	return (is_struct(system_index) && instanceof(system_index) == "__shockwave_system");
}

/// @desc Destroy shockwave system, freeing it from memory.
/// @param {Struct} system_index The returned variable by shockwave_create().
function shockwave_free(system_index) {
	__ppf_exception(!shockwave_exists(system_index), "Shockwaves system does not exist.");
	__ppf_surface_delete(system_index._surface);
}

/// @desc Render shockwave surface. Please note that this will not draw the surface, only generate the content.
/// Basically this function will call the Draw Event of the objects in the array and draw them on the surface.
/// @param {Struct} pp_index The returned variable by ppfx_create().
/// @param {Struct} system_index The returned variable by shockwave_create().
/// @param {Array<Asset.GMObject>} objects_array Distortion objects array that will be used to call the Draw Event. Example: [obj_shockwave].
/// @param {Id.Camera} camera Your current active camera id. You can use view_camera[0].
function shockwave_render(pp_index, system_index, objects_array, camera) {
	__ppf_exception(!ppfx_exists(pp_index), "Post-processing system does not exist.");
	__ppf_exception(!shockwave_exists(system_index), "Shockwaves system does not exist.");
	with(system_index) {
		var _cam = camera;
		var _camw = camera_get_view_width(_cam);
		var _camh = camera_get_view_height(_cam);
		var _sx = pp_index._pp_render_vw/_camw, _sy = pp_index._pp_render_vh/_camh;
		var _ww = _camw*_sx, _hh = _camh*_sy;
		// generate distortion surface
		if (_ww > 0 && _hh > 0) {
			if !surface_exists(_surface) {
				_surface = surface_create(_ww, _hh);
				// send "normal map" texture to ppfx (you only need to reference it once - when the surface is created, for example)
				ppfx_effect_set_parameter(pp_index, PP_EFFECT.DISPLACEMAP, PP_DISPLACEMAP_TEXTURE, surface_get_texture(_surface));
			}
			surface_set_target(_surface);
			// draw normal map background (fix drawing buffer)
			draw_set_color(make_color_rgb(128, 128, 255));
			draw_rectangle(0, 0, _ww, _hh, false);
			draw_set_color(c_white);
			// draw normal map sprites to distort screen
			camera_apply(_cam);
			var i = 0, isize = array_length(objects_array);
			repeat(isize) {
				with(objects_array[i]) event_perform(ev_draw, 0);
				++i;
			}
			surface_reset_target();
		}
	}
}

/// @desc Create a new shockwave instance.
/// @param {Real} x The horizontal X position the object will be created at.
/// @param {Real} y The vertical Y position the object will be created at.
/// @param {String, Id.Layer} layer_id The layer ID (or name) to assign the created instance to.
/// @param {Real} type The shockwave shape (image_index).
/// @param {Real} scale The shockwave size (default: 1).
/// @param {Real} scale_speed The speed at which the shockwave scale will change.
/// @param {Real} alpha_speed The speed at which the shockwave alpha will change.
/// @param {Asset.GMObject} object The object to be created.
/// @returns {Id.Instance} Instance id.
function shockwave_instance_create(x, y, layer_id, type=0, scale=1, scale_speed=1, alpha_speed=1, object=__obj_ppf_shockwave) {
	var _inst = instance_create_layer(x, y, layer_id, object, {
		visible : false,
		index : type,
		scale : scale,
		scale_spd : 0.02 * scale_speed,
		alpha_spd : 0.03 * alpha_speed,
	});
	return _inst;
}

/// @desc Get the surface used in the shockwave system. Used for debugging generally.
/// @param {Struct} system_index description
function shockwave_get_surface(system_index) {
	__ppf_exception(!shockwave_exists(system_index), "Shockwaves system does not exist.");
	return system_index._surface;
}
