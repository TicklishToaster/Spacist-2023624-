
/*-------------------------------------------------------------------------------------------------
	These functions are independent, so if you delete them from the asset, nothing will happen.
-------------------------------------------------------------------------------------------------*/

/// @ignore
function __ppfx_layer() constructor {
	_room_size_based = false;
	_top_layer = -1;
	_bottom_layer = -1;
	_top_method = -1;
	_bottom_method = -1;
	_ppf_index = undefined;
	_cam_index = -1;
	_surface = -1;
	_surf_x = 0;
	_surf_y = 0;
	_surf_w = 2;
	_surf_h = 2;
	_surf_vw = 0;
	_surf_vh = 0;
	_render_enable = true;
	_use_ppfx = true;
	_is_ready = false;
}

/// @desc Create post-processing layer id to be used by the other functions
/// @returns {Struct}
function ppfx_layer_create() {
	return new __ppfx_layer();
}

/// @desc Checks if a previously created post-processing layer exists.
/// @param {any} pp_layer_index description
/// @returns {bool} description
function ppfx_layer_exists(pp_layer_index) {
	return (is_struct(pp_layer_index) && instanceof(pp_layer_index) == "__ppfx_layer");
}

/// @desc This function deletes a previously created post-processing layer, freeing memory.
/// @param {Struct} pp_layer_index The returned variable by ppfx_layer_create()
/// @returns {undefined}
function ppfx_layer_destroy(pp_layer_index) {
	__ppf_exception(!ppfx_layer_exists(pp_layer_index), "Post-processing layer does not exist.");
	__ppf_surface_delete(pp_layer_index._surface);
	delete pp_layer_index;
}

/// @desc This function applies post-processing to one or more layers. You only need to call this ONCE in an object's Create Event.
/// Make sure the top layer is above the bottom layer in order. If not, it may not render correctly.
/// Please note: You CANNOT select a range to which the layer has already been in range by another system. This will give an unbalanced surface stack error. If you want to use more effects, just add more effects to the profile.
/// @param {Struct} pp_index The returned variable by ppfx_create(). You can use -1, noone or undefined, to not use a post-processing system, this way you can render the layer content on the surface only.
/// @param {Struct} pp_layer_index The returned variable by ppfx_layer_create()
/// @param {Id.Layer} top_layer_id The top layer, in the room editor
/// @param {Id.Layer} bottom_layer_id The bottom layer, in the room editor
/// @param {bool} room_size_based If true, the system will use room size to render effects (requires more GPU resources).
/// While off, uses camera position and size.
/// @param {bool} draw_layer If false, the layer will not draw and the layer content will still be rendered to the surface.
/// @returns {undefined}
function ppfx_layer_apply(pp_index, pp_layer_index, top_layer_id, bottom_layer_id, room_size_based=false, draw_layer=true) {
	__ppf_exception(!ppfx_layer_exists(pp_layer_index), "Post-processing layer does not exist.");
	__ppf_exception(!layer_exists(top_layer_id) || !layer_exists(bottom_layer_id), "One of the layers does not exist in the current room.");
	if (layer_get_depth(top_layer_id) > layer_get_depth(bottom_layer_id)) {
		__ppf_trace("WARNING: Inverted layer range order. Failed to render on layers: " + layer_get_name(top_layer_id) + ", " + layer_get_name(bottom_layer_id));
	}
	with(pp_layer_index) {
		// run once
		_use_ppfx = !__ppf_is_undefined(pp_index);
		//__ppf_exception(_use_ppfx && !ppfx_exists(pp_index), "Post-processing system does not exist.");
		if (_use_ppfx) ppfx_set_draw_enable(pp_index, draw_layer);
		_top_layer = top_layer_id;
		_bottom_layer = bottom_layer_id;
		_ppf_index = pp_index;
		_room_size_based = room_size_based;
		// run every step
		_top_method = function() {
			if (!_render_enable) exit;
			if (event_type == ev_draw && event_number == 0) {
				_cam_index = view_camera[view_current];
				if (_room_size_based) {
					_surf_x = 0;
					_surf_y = 0;
					_surf_w = room_width;
					_surf_h = room_height;
					_surf_vw = _surf_w;
					_surf_vh = _surf_h;
				} else {
					_surf_x = camera_get_view_x(_cam_index);
					_surf_y = camera_get_view_y(_cam_index);
					_surf_w = camera_get_view_width(_cam_index);
					_surf_h = camera_get_view_height(_cam_index);
					_surf_vw = view_get_wport(view_current);
					_surf_vh = view_get_hport(view_current);
				}
				if !surface_exists(_surface) _surface = surface_create(_surf_vw, _surf_vh);
				surface_set_target(_surface);
				draw_clear_alpha(c_black, 0);
				//gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				if (!_room_size_based) camera_apply(_cam_index);
			}
		}
		_bottom_method = function() {
			if (!_render_enable) exit;
			if (event_type == ev_draw && event_number == 0) {
				if (surface_exists(_surface)) {
					//gpu_set_blendmode(bm_normal);
					surface_reset_target();
					if (_use_ppfx) ppfx_draw(_surface, _surf_x, _surf_y, _surf_w, _surf_h, _surf_vw, _surf_vh, _ppf_index);
					_is_ready = true;
				}
			}
		}
		layer_script_begin(_bottom_layer, _top_method);
		layer_script_end(_top_layer, _bottom_method);
	}
}

/// @desc This function gets the surface used in the PPFX layer system.
/// @param {Struct} pp_layer_index The returned variable by ppfx_layer_create().
/// @param {Bool} with_effects If true, it will return the surface of the layer with the effects applied. False is without the effects.
/// @returns {Id.Surface} Surface index.
function ppfx_layer_get_surface(pp_layer_index, with_effects=true) {
	__ppf_exception(!ppfx_layer_exists(pp_layer_index), "Post-processing layer does not exist.");
	return with_effects ? ppfx_get_render_surface(pp_layer_index._ppf_index) : pp_layer_index._surface;
}

/// @desc Toggle whether layer system can render on layer.
/// If disabled, nothing will be rendered to the surface. That is, the layer will be drawn without the effects.
/// @param {Struct} pp_layer_index The returned variable by ppfx_layer_create().
/// @param {real} enable Will be either true (enabled, the default value) or false (disabled). The rendering will toggle if nothing or -1 is entered.
/// @returns {undefined}
function ppfx_layer_set_render_enable(pp_layer_index, enable=-1) {
	__ppf_exception(!ppfx_layer_exists(pp_layer_index), "Post-processing layer does not exist.");
	if (enable == -1) {
		pp_layer_index._render_enable ^= 1;
	} else {
		pp_layer_index._render_enable = enable;
	}
}

/// @desc This function checks if the post-processing layer is ready to render, which allows you to get its surface safely (especially in HTML5).
/// @param {Struct} pp_layer_index The returned variable by ppfx_layer_create().
/// @returns {undefined}
function ppfx_layer_is_ready(pp_layer_index) {
	return pp_layer_index._is_ready;
}

/// @desc This function defines a new range of layers from an existing ppfx layer system.
/// Make sure the top layer is above the bottom layer in order. If not, it may not render correctly.
/// Please note: You CANNOT select a range to which the layer has already been in range by another system. This will give an unbalanced surface stack error. If you want to use more effects, just add more effects to the profile.
/// @param {Struct} pp_layer_index The returned variable by ppfx_layer_create()
/// @param {Id.Layer} top_layer_id The top layer, in the room editor
/// @param {Id.Layer} bottom_layer_id The bottom layer, in the room editor
function ppfx_layer_set_range(pp_layer_index, top_layer_id, bottom_layer_id) {
	__ppf_exception(!ppfx_layer_exists(pp_layer_index), "Post-processing layer does not exist.");
	__ppf_exception(!layer_exists(top_layer_id) || !layer_exists(bottom_layer_id), "One of the layers does not exist in the current room.");
	if (layer_get_depth(top_layer_id) > layer_get_depth(bottom_layer_id)) {
		__ppf_trace("WARNING: Inverted layer range order. Failed to render on layers: " + layer_get_name(top_layer_id) + ", " + layer_get_name(bottom_layer_id));
	}
	with(pp_layer_index) {
		__ppf_surface_delete(_surface);
		layer_script_begin(_bottom_layer, -1);
		layer_script_end(_top_layer, -1);
		_top_layer = top_layer_id;
		_bottom_layer = bottom_layer_id;
		layer_script_begin(_bottom_layer, _top_method);
		layer_script_end(_top_layer, _bottom_method);
	}
}
