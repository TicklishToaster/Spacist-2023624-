
#macro PPFX_VERSION "v2.2"
#macro PPFX_RELEASE_DATE "October, 6, 2022"

show_debug_message("Post-Processing FX " + PPFX_VERSION + " | " + "Copyright (C) 2022 FoxyOfJungle");


// ppfx system shaders
#macro __PPF_SH_BASE __ppf_sh_render_base
#macro __PPF_SH_FXAA __ppf_sh_render_fxaa
#macro __PPF_SH_SUNSHAFTS __ppf_sh_render_sunshafts
#macro __PPF_SH_BLOOM_PRE_FILTER __ppf_sh_render_bloom_pre_filter
#macro __PPF_SH_BLOOM __ppf_sh_render_bloom
#macro __PPF_SH_DOF_COC __ppf_sh_render_dof_coc
#macro __PPF_SH_DOF_BOKEH __ppf_sh_render_dof_bokeh
#macro __PPF_SH_DOF __ppf_sh_render_dof
#macro __PPF_SH_MOTION_BLUR __ppf_sh_render_motion_blur
#macro __PPF_SH_RADIAL_BLUR __ppf_sh_render_radial_blur
#macro __PPF_SH_COLOR_GRADING __ppf_sh_render_color_grading
#macro __PPF_SH_PALETTE_SWAP __ppf_sh_render_palette_swap
#macro __PPF_SH_KAWASE_BLUR __ppf_sh_render_kawase_blur
#macro __PPF_SH_GAUSSIAN_BLUR __ppf_sh_render_gaussian_blur
#macro __PPF_SH_CHROMABER __ppf_sh_render_chromaber
#macro __PPF_SH_FINAL __ppf_sh_render_final

#macro __PPF_SH_DS_BOX4 __ppf_sh_ds_box4
#macro __PPF_SH_DS_BOX13 __ppf_sh_ds_box13
#macro __PPF_SH_US_TENT9 __ppf_sh_us_tent9

#macro __PPF_SH_GNMSK __ppf_sh_generic_mask
#macro __PPF_SH_SPRMSK __ppf_sh_sprite_mask

#region verify compatibility
if (PPFX_CFG_HARDWARE_CHECKING) {
	if (!shaders_are_supported() && !__ppf_assert_and_func_array(shader_is_compiled, [
		__PPF_SH_DS_BOX4, __PPF_SH_DS_BOX13, __PPF_SH_US_TENT9, __PPF_SH_GNMSK, __PPF_SH_SPRMSK,
		__PPF_SH_BASE, __PPF_SH_FXAA, __PPF_SH_MOTION_BLUR, __PPF_SH_RADIAL_BLUR, __PPF_SH_CHROMABER, __PPF_SH_BLOOM_PRE_FILTER, __PPF_SH_BLOOM, __PPF_SH_COLOR_GRADING, __PPF_SH_PALETTE_SWAP, __PPF_SH_KAWASE_BLUR, __PPF_SH_GAUSSIAN_BLUR, __PPF_SH_FINAL, 
	])) {
		var _info = os_get_info(), _gpu = "", _is64 = "";
		switch(os_type) {
			case os_windows:
			case os_uwp: _gpu = "GPU: " + string(_info[? "video_adapter_description"]) + " | Dedicated Memory: " + string(_info[? "video_adapter_dedicatedvideomemory"]/1024/1024) + "MB"; break;
			case os_android: _gpu = "OpenGL: " + string(_info[? "GL_VERSION"]) + "\nGLSL: " + string(_info[? "GL_SHADING_LANGUAGE_VERSION"]) + "\nRenderer: " + string(_info[? "GL_RENDERER"]); break;
			case os_ios:
			case os_tvos:
			case os_linux:
			case os_macosx: _gpu = string(_info[? "gl_vendor_string"]) + " | " + string(_info[? "gl_renderer_string"]) + " | " + string(_info[? "gl_version_string"]); break;
			case os_xboxseriesxs: _gpu = string(_info[? "video_d3d12_currentrt"]); break;
			default: _gpu = "Unknown Device."; break;
		}
		_is64 = "is64bit: " + string(_info[? "is64bit"]) + " | ";
		var _trace = "\"Post-Processing FX\" will not work. Device not supported.\n\n" + _is64 + _gpu;
		__ppf_trace(_trace);
		show_message_async(_trace);
	}
}
#endregion

/// @desc Create post-processing system id to be used by the other functions.
/// @returns {struct} Post-Processing system id.
function ppfx_create() {
	__ppf_trace("System created. From: " + object_get_name(object_index));
	return new __ppfx_system();
}

/// @desc Check if post-processing system exists.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @returns {bool} description.
function ppfx_exists(pp_index) {
	return (is_struct(pp_index) && instanceof(pp_index) == "__ppfx_system");
}

/// @desc Destroy post-processing system.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @returns {undefined}
function ppfx_destroy(pp_index) {
	if ppfx_exists(pp_index) {
		__ppf_trace("System deleted. From: " + object_get_name(object_index));
		pp_index.__cleanup();
		delete pp_index;
	}
}

/// @desc Toggle whether the post-processing system can draw.
/// Please note that if disabled, it may still be rendered if rendering is enabled (will continue to demand GPU).
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} enable Will be either true (enabled, the default value) or false (disabled). The drawing will toggle if nothing or -1 is entered.
/// @returns {undefined}
function ppfx_set_draw_enable(pp_index, enable=-1) {
	__ppf_exception(!ppfx_exists(pp_index), "Post-processing system does not exist.");
	if (enable == -1) {
		pp_index._pp_draw_enabled ^= 1;
	} else {
		pp_index._pp_draw_enabled = enable;
	}
}

/// @desc Toggle whether the post-processing system can render.
/// Please note that if enabled, it can render to the surface even if not drawing!
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} enable Will be either true (enabled, the default value) or false (disabled). The rendering will toggle if nothing or -1 is entered.
/// @returns {undefined}
function ppfx_set_render_enable(pp_index, enable=-1) {
	__ppf_exception(!ppfx_exists(pp_index), "Post-processing system does not exist.");
	if (enable == -1) {
		pp_index._pp_render_enabled ^= 1;
	} else {
		pp_index._pp_render_enabled = enable;
	}
}

/// @desc Returns true if post-processing system drawing is enabled, and false if not.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @returns {bool}
function ppfx_is_draw_enabled(pp_index) {
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	return pp_index._pp_draw_enabled;
}

/// @desc Returns true if post-processing system rendering is enabled, and false if not.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @returns {bool}
function ppfx_is_render_enabled(pp_index) {
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	return pp_index._pp_render_enabled;
}

/// @desc Defines the overall draw intensity of the post-processing system.
/// The global intensity defines the interpolation between the original image and with the effects applied.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} value Intensity, 0 for none (default image), and 1 for full.
/// @returns {undefined}
function ppfx_set_global_intensity(pp_index, value) {
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	pp_index._pp_global_intensity = value;
}

/// @desc Get the overall draw intensity of the post-processing system.
/// The global intensity defines the interpolation between the original image and with the effects applied.
/// This function returns a value between 0 and 1.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @returns {real} Value between 0 and 1.
function ppfx_get_global_intensity(pp_index) {
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	return pp_index._pp_global_intensity;
}

/// @desc This function modifies the final rendering resolution of the post-processing system, based on a percentage (0 to 1).
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} resolution Value from 0 to 1 that is multiplied internally with the final resolution of the system's final rendering view.
/// @returns {real} Value between 0 and 1.
function ppfx_set_render_resolution(pp_index, resolution) {
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	pp_index._pp_render_res = clamp(resolution, 0.01, 1);
}

/// @desc Returns the post-processing system rendering percentage (0 to 1).
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} resolution Value from 0 to 1 that is multiplied internally with the final resolution of the system's final rendering view.
/// @returns {real} Normalized size.
function ppfx_get_render_resolution(pp_index, resolution) {
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	return pp_index._pp_render_res;
}

/// @desc Returns the post-processing system final rendering surface.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @returns {Id.Surface} Surface index.
function ppfx_get_render_surface(pp_index) {
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	return pp_index._pp_stack_surface[pp_index._pp_surf_index];
}

/// @desc Create a profile with predefined effects.
/// You can create multiple profiles with different effects and then load them in real time.
/// @param {string} name Profile name. It only serves as a cosmetic and nothing else.
/// @param {array} effects_array Array with all effects structs.
/// @returns {struct} Profile struct.
function ppfx_profile_create(name, effects_array) {
	__ppf_exception(!is_string(name), "Invalid profile name.");
	__ppf_exception(!is_array(effects_array), "Parameter is not an array containing effects.");
	var _profile = {
		profile_name : name,
		settings : {},
		idd : sha1_string_utf8(get_timer()),
	}
	var i = 0, isize = array_length(effects_array);
	repeat(isize) {
		_profile.settings[$ effects_array[i].effect_name] = effects_array[i].sets;
		++i;
	}
	return _profile;
}

/// @desc This function loads a previously created profile.
/// Which means that the post-processing system will apply the settings of the effects contained in the profile, showing them consequently.
/// If you use the same post-processing system throughout the game and want to load different profiles later, you will need to reference the default profile, otherwise the effects settings will not update correctly.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {struct} profile_index Profile id created with ppfx_profile_create().
/// @returns {undefined}
function ppfx_profile_load(pp_index, profile_index) {
	gml_pragma("forceinline");
	__ppf_exception(!ppfx_exists(pp_index), "System does not exist.");
	__ppf_exception(!is_struct(profile_index), "Profile Index is not a struct.");
	if (pp_index._pp_current_profile != profile_index.idd) {
		__ppf_struct_copy(pp_index._pp_cfg_default, pp_index._pp_cfg);
		__ppf_struct_copy(profile_index.settings, pp_index._pp_cfg);
		__ppf_trace("Profile loaded: " + string(profile_index.profile_name));
		pp_index._pp_current_profile = profile_index.idd;
	}
}

/// @desc Get the name of the profile, created with ppfx_profile_create().
/// @param {struct} profile_index Profile id created with ppfx_profile_create().
/// @returns {string} Profile name.
function ppfx_profile_get_name(profile_index) {
	__ppf_exception(!is_struct(profile_index), "Profile Index is not a struct.");
	return profile_index.profile_name;
}

/// @desc Set the name of the profile, created with ppfx_profile_create().
/// @param {struct} profile_index Profile id created with ppfx_profile_create().
/// @param {string} name New profile name.
/// @returns {undefined}
function ppfx_profile_set_name(profile_index, name) {
	__ppf_exception(!is_struct(profile_index), "Profile Index is not a struct.");
	__ppf_exception(!is_string(name), "Invalid profile name.");
	profile_index.profile_name = name;
}

/// @desc This function toggles the effect rendering.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} effect_index Effect index. Use the enumerator, example: PP_EFFECT.BLOOM.
/// @param {real} enable Will be either true (enabled) or false (disabled). The rendering will toggle if nothing or -1 is entered.
/// @returns {undefined}
function ppfx_effect_set_enable(pp_index, effect_index, enable=-1) {
	gml_pragma("forceinline");
	__ppf_exception(!ppfx_exists(pp_index), "Post-processing system does not exist.");
	var _ef = pp_index._pp_effects_names[effect_index];
	__ppf_exception(variable_struct_names_count(pp_index._pp_cfg[$ _ef]) <= 1, "It is not possible to toggle an effect that does not exist in the profile.");
	if (enable == -1) {
		pp_index._pp_cfg[$ _ef].enabledd ^= 1;
	} else {
		pp_index._pp_cfg[$ _ef].enabledd = enable;
	}
}

/// @desc Returns true if effect rendering is enabled, and false if not.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} effect_index Effect index. Use the enumerator, example: PP_EFFECT.BLOOM.
/// @returns {bool}
function ppfx_effect_is_enabled(pp_index, effect_index) {
	gml_pragma("forceinline");
	__ppf_exception(!ppfx_exists(pp_index), "Post-processing system does not exist.");
	var _ef = pp_index._pp_effects_names[effect_index];
	return pp_index._pp_cfg[$ _ef].enabledd;
}

/// @desc Modify various parameters (settings) of an effect.
/// Use this if you want to modify an effect's attributes in real-time.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} effect_index Effect index. Use the enumerator, example: PP_EFFECT.BLOOM.
/// @param {array} params_array Array with the effect parameters. Use the pre-defined macros, for example: PP_BLOOM_COLOR.
/// @param {array} values_array Array with parameter values, must be in the same order.
/// @returns {undefined}
function ppfx_effect_set_parameters(pp_index, effect_index, params_array, values_array) {
	gml_pragma("forceinline");
	var _st = pp_index._pp_cfg[$ pp_index._pp_effects_names[effect_index]];
	var _struct_vars = variable_struct_get_names(_st);
	var _len_st = array_length(_struct_vars);
	var _len_vars = array_length(params_array);
	var i = 0;
	repeat(_len_st) {
		var j = 0;
		repeat(_len_vars) {
			if (_struct_vars[i] == params_array[j]) {
				_st[$ params_array[j]] = values_array[j];
			}
			++j;
		}
		++i;
	}
}

/// @desc Modify a single parameter (setting) of an effect.
/// Use this to modify an effect's attribute in real-time.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} effect_index Effect index. Use the enumerator, example: PP_EFFECT.BLOOM.
/// @param {string} param Parameter macro. Example: PP_BLOOM_COLOR.
/// @param {any} value Parameter value. Example: make_color_rgb_ppfx(255, 255, 255).
/// @returns {undefined}
function ppfx_effect_set_parameter(pp_index, effect_index, param, value) {
	gml_pragma("forceinline");
	pp_index._pp_cfg[$ pp_index._pp_effects_names[effect_index]][$ param] = value;
}

/// @desc Get a single parameter (setting) value of an effect.
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @param {real} effect_index Effect index. Use the enumerator, example: PP_EFFECT.BLOOM.
/// @param {string} param Parameter macro. Example: PP_BLOOM_COLOR.
/// @returns {any}
function ppfx_effect_get_parameter(pp_index, effect_index, param) {
	gml_pragma("forceinline");
	return pp_index._pp_cfg[$ pp_index._pp_effects_names[effect_index]][$ param];
}



/// @desc Draw post-processing system on screen.
/// @param {Id.Surface} surface Render surface to copy from. (You can use application_surface).
/// @param {real} x Horizontal X position of rendering.
/// @param {real} y Vertical Y position of rendering.
/// @param {real} w Width of the stretched game view.
/// @param {real} h Height of the stretched game view.
/// @param {real} view_w Width of your game view (Can use camera or window width, for example).
/// @param {real} view_h Height of your game view (Can use camera or window height, for example).
/// @param {struct} pp_index The returned variable by ppfx_create().
/// @returns {undefined}
function ppfx_draw(surface, x, y, w, h, view_w, view_h, pp_index) {
	__ppf_exception(!surface_exists(surface), "Surface does not exist.");
	__ppf_exception(surface == application_surface && event_number != ev_draw_post && event_number != ev_gui_begin, "Failed to draw using application_surface.\nIt can only be drawn in the Post-Draw or Draw GUI Begin event.");
	__ppf_exception(!ppfx_exists(pp_index), "Post-processing system does not exist.");
	var _sys_blendenable = gpu_get_blendenable();
	var _sys_blendmode = gpu_get_blendmode();
	var _sys_depth_disable = surface_get_depth_disable();
	with(pp_index) {
		// sets
		if (_pp_render_enabled) {
			surface_depth_disable(true);
			
			// time
			_pp_time += PPFX_CFG_SPEED;
			if (PPFX_CFG_TIMER > 0 && _pp_time > PPFX_CFG_TIMER) _pp_time = 0;
			
			// pos and size (read-only)
			_pp_render_x = x;
			_pp_render_y = y;
			_pp_render_vw = view_w;
			_pp_render_vh = view_h;
			
			// resize render resolution
			view_w *= _pp_render_res;
			view_h *= _pp_render_res;
			view_w -= frac(view_w);
			view_h -= frac(view_h);
			
			// delete stuff, to be updated
			if (_pp_render_old_res != _pp_render_res) {
				__cleanup();
				_pp_render_old_res = _pp_render_res;
			}
			
			#region stack 0 - base
			_pp_surf_index = 0;
			if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
				_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
			}
			surface_set_target(_pp_stack_surface[_pp_surf_index]) {
				draw_clear_alpha(c_black, 0);
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				
				shader_set(__PPF_SH_BASE);
				shader_set_uniform_f(__PPF_SU.base_main.pos_res, x, y, view_w, view_h);
				shader_set_uniform_f(__PPF_SU.base_main.time_n_intensity, _pp_time, _pp_global_intensity);
				shader_set_uniform_f_array(__PPF_SU.base_main.enabledd, [
					_pp_cfg.rotation.enabledd,
					_pp_cfg.zoom.enabledd,
					_pp_cfg.shake.enabledd,
					_pp_cfg.lens_distortion.enabledd,
					_pp_cfg.pixelize.enabledd,
					_pp_cfg.swirl.enabledd,
					_pp_cfg.panorama.enabledd,
					_pp_cfg.sine_wave.enabledd,
					_pp_cfg.glitch.enabledd,
					_pp_cfg.displacemap.enabledd,
					_pp_cfg.white_balance.enabledd,
				]);
				
				// > effect: rotation
				if (_pp_cfg.rotation.enabledd) {
					shader_set_uniform_f(__PPF_SU.rotation.angle, _pp_cfg.rotation.angle);
				}
				// > effect: zoom
				if (_pp_cfg.zoom.enabledd) {
					shader_set_uniform_f(__PPF_SU.zoom.amount, _pp_cfg.zoom.amount);
					shader_set_uniform_f_array(__PPF_SU.zoom.center, _pp_cfg.zoom.center);
				}
				// > effect: shake
				if (_pp_cfg.shake.enabledd) {
					shader_set_uniform_f(__PPF_SU.shake.speedd, _pp_cfg.shake.speedd);
					shader_set_uniform_f(__PPF_SU.shake.magnitude, _pp_cfg.shake.magnitude);
					shader_set_uniform_f(__PPF_SU.shake.hspeedd, _pp_cfg.shake.hspeedd);
					shader_set_uniform_f(__PPF_SU.shake.vspeedd, _pp_cfg.shake.vspeedd);
				}
				// > effect: lens_distortion
				if (_pp_cfg.lens_distortion.enabledd) {
					shader_set_uniform_f(__PPF_SU.lens_distortion.amount, _pp_cfg.lens_distortion.amount);
				}
				// > effect: pixelize
				if (_pp_cfg.pixelize.enabledd) {
					shader_set_uniform_f(__PPF_SU.pixelize.amount, _pp_cfg.pixelize.amount);
					shader_set_uniform_f(__PPF_SU.pixelize.squares_max, _pp_cfg.pixelize.squares_max);
					shader_set_uniform_f(__PPF_SU.pixelize.steps, _pp_cfg.pixelize.steps);
				}
				// > effect: swirl
				if (_pp_cfg.swirl.enabledd) {
					shader_set_uniform_f(__PPF_SU.swirl.angle, _pp_cfg.swirl.angle);
					shader_set_uniform_f(__PPF_SU.swirl.radius, _pp_cfg.swirl.radius);
					shader_set_uniform_f_array(__PPF_SU.swirl.center, _pp_cfg.swirl.center);
				}
				// > effect: panorama
				if (_pp_cfg.panorama.enabledd) {
					shader_set_uniform_f(__PPF_SU.panorama.depthh, _pp_cfg.panorama.depthh);
					shader_set_uniform_f(__PPF_SU.panorama.is_horizontal, _pp_cfg.panorama.is_horizontal);
				}
				// > effect: sine_wave
				if (_pp_cfg.sine_wave.enabledd) {
					shader_set_uniform_f_array(__PPF_SU.sine_wave.frequency, _pp_cfg.sine_wave.frequency);
					shader_set_uniform_f_array(__PPF_SU.sine_wave.amplitude, _pp_cfg.sine_wave.amplitude);
					shader_set_uniform_f(__PPF_SU.sine_wave.speedd, _pp_cfg.sine_wave.speedd);
				}
				// > effect: glitch
				if (_pp_cfg.glitch.enabledd) {
					shader_set_uniform_f(__PPF_SU.glitch.speedd, _pp_cfg.glitch.speedd);
					shader_set_uniform_f(__PPF_SU.glitch.block_size, _pp_cfg.glitch.block_size);
					shader_set_uniform_f(__PPF_SU.glitch.interval, _pp_cfg.glitch.interval);
					shader_set_uniform_f(__PPF_SU.glitch.intensity, _pp_cfg.glitch.intensity);
					shader_set_uniform_f(__PPF_SU.glitch.peak_amplitude1, _pp_cfg.glitch.peak_amplitude1);
					shader_set_uniform_f(__PPF_SU.glitch.peak_amplitude2, _pp_cfg.glitch.peak_amplitude2);
				}
				// > effect: displacemap
				if (_pp_cfg.displacemap.enabledd) {
					shader_set_uniform_f(__PPF_SU.displacemap.amount, _pp_cfg.displacemap.amount);
					shader_set_uniform_f(__PPF_SU.displacemap.zoom, _pp_cfg.displacemap.zoom);
					shader_set_uniform_f(__PPF_SU.displacemap.angle, _pp_cfg.displacemap.angle);
					shader_set_uniform_f(__PPF_SU.displacemap.speedd, _pp_cfg.displacemap.speedd);
					texture_set_stage(__PPF_SU.displacemap.texture, _pp_cfg.displacemap.texture);
				}
				// > effect: white_balance
				if (_pp_cfg.white_balance.enabledd) {
					shader_set_uniform_f(__PPF_SU.white_balance.temperature, _pp_cfg.white_balance.temperature);
					shader_set_uniform_f(__PPF_SU.white_balance.tint, _pp_cfg.white_balance.tint);
				}
				draw_surface_stretched(surface, 0, 0, view_w, view_h);
				shader_reset();
				gpu_set_blendmode(bm_normal);
				
				surface_reset_target();
			}
			#endregion
			
			#region stack 1 - fxaa
			if (_pp_cfg.fxaa.enabledd) {
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_FXAA);
					shader_set_uniform_f(__PPF_SU.fxaa.resolution, view_w, view_h);
					shader_set_uniform_f(__PPF_SU.fxaa.strength, _pp_cfg.fxaa.strength);
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region stack 2 - sunshafts
			if (_pp_cfg.sunshafts.enabledd) {
				// sets
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				var _ds = clamp(_pp_cfg.sunshafts.downscale, 0.1, 1);
				var _ww = view_w*_ds, _hh = view_h*_ds;
				
				if (_pp_sunshaft_downscale != _ds) {
					__ppf_surface_delete(_pp_sunshaft_small_surface);
					_pp_sunshaft_downscale = _ds;
				}
				
				var _source = _pp_stack_surface[_pp_surf_index];
				if !surface_exists(_pp_sunshaft_small_surface) {
					_pp_sunshaft_small_surface = surface_create(_ww, _hh);
				}
				surface_set_target(_pp_sunshaft_small_surface);
				draw_clear_alpha(c_black, 0);
				draw_surface_stretched(_source, 0, 0, _ww, _hh);
				surface_reset_target();
				
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_SUNSHAFTS);
					texture_set_stage(__PPF_SU.sunshafts.base_tex, surface_get_texture(_pp_sunshaft_small_surface));
					shader_set_uniform_f(__PPF_SU.sunshafts.base_res, view_w, view_h);
					shader_set_uniform_f(__PPF_SU.sunshafts.time_n_intensity, _pp_time, _pp_global_intensity);
					
					shader_set_uniform_f_array(__PPF_SU.sunshafts.position, _pp_cfg.sunshafts.position);
					shader_set_uniform_f(__PPF_SU.sunshafts.center_smoothness, _pp_cfg.sunshafts.center_smoothness);
					shader_set_uniform_f(__PPF_SU.sunshafts.threshold, _pp_cfg.sunshafts.threshold);
					shader_set_uniform_f(__PPF_SU.sunshafts.intensity, _pp_cfg.sunshafts.intensity);
					shader_set_uniform_f(__PPF_SU.sunshafts.dimmer, _pp_cfg.sunshafts.dimmer);
					shader_set_uniform_f(__PPF_SU.sunshafts.scattering, _pp_cfg.sunshafts.scattering);
					shader_set_uniform_f(__PPF_SU.sunshafts.noise_enable, _pp_cfg.sunshafts.noise_enable);
					shader_set_uniform_f(__PPF_SU.sunshafts.rays_tiling, _pp_cfg.sunshafts.rays_tiling);
					shader_set_uniform_f(__PPF_SU.sunshafts.rays_speed, _pp_cfg.sunshafts.rays_speed);
					shader_set_uniform_f(__PPF_SU.sunshafts.dual_textures, _pp_cfg.sunshafts.dual_textures);
					
					texture_set_stage(__PPF_SU.sunshafts.world_tex, _pp_cfg.sunshafts.world_tex);
					texture_set_stage(__PPF_SU.sunshafts.sky_tex, _pp_cfg.sunshafts.sky_tex);
					texture_set_stage(__PPF_SU.sunshafts.noise_tex, _pp_cfg.sunshafts.noise_tex);
					gpu_set_tex_repeat_ext(__PPF_SU.sunshafts.noise_tex, true);
					
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					surface_reset_target();
				}
				gpu_set_blendmode(bm_normal);
			}
			#endregion
			
			#region stack 3 - bloom
			if (_pp_cfg.bloom.enabledd) {
				// sets
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter(true);
				
				var _ww = view_w, _hh = view_h;
				var _iterations = clamp(_pp_cfg.bloom.iterations, 2, 8);
				var _reduce_banding = _pp_cfg.bloom.reduce_banding;
				var _hq_d = __PPF_PASS_DS_BOX4, _hq_u = __PPF_PASS_US_TENT9;
				
				if (_pp_cfg.bloom.high_quality) {
					_hq_d = __PPF_PASS_DS_BOX13;
					_hq_u = __PPF_PASS_US_TENT9;
				}
				
				// > pre filter
				var _source = _pp_stack_surface[_pp_surf_index]; 
				if !surface_exists(_pp_bloom_surface[0]) {
					_pp_bloom_surface[0] = surface_create(_ww, _hh); // temporary surface
				}
				var _current_destination = _pp_bloom_surface[0];
				__ppf_surface_blit(_source, _current_destination, __PPF_PASS_BLOOM_PREFILTER, {
					ww : _ww,
					hh : _hh,
					threshold : _pp_cfg.bloom.threshold,
					intensity : _pp_cfg.bloom.intensity,
				});
				var _current_source = _current_destination;
				
				// downsampling
				var i = 1; // there is already a texture in slot 0
				repeat(_iterations) {
					_ww /= 2;
					_hh /= 2;
					_ww -= frac(_ww);
					_hh -= frac(_hh);
					if (min(_ww, _hh) < 2) break;
					if !surface_exists(_pp_bloom_surface[i]) {
						_pp_bloom_surface[i] = surface_create(_ww, _hh);
					}
					_current_destination = _pp_bloom_surface[i];
					__ppf_surface_blit(_current_source, _current_destination, _hq_d, {
						ww : _ww,
						hh : _hh,
						rb : _reduce_banding,
					});
					_current_source = _current_destination;
					++i;
				}
				
				// upsampling
				gpu_set_blendmode(bm_one);
				var l = i - 2;
				repeat(_iterations) { // 7, 6, 5, 4, 3, 2, 1, 0
					_current_destination = _pp_bloom_surface[l];
					__ppf_surface_blit(_current_source, _current_destination, _hq_u, {
						ww : surface_get_width(_current_destination),
						hh : surface_get_height(_current_destination),
						rb : _reduce_banding,
					});
					_current_source = _current_destination;
					--l;
				}
				gpu_set_blendmode(bm_normal);
				_pp_bloom_final_texture = surface_get_texture(_current_destination); // bloom-only tex
				
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_BLOOM);
					shader_set_uniform_f(__PPF_SU.bloom.resolution, view_w, view_h);
					shader_set_uniform_f(__PPF_SU.bloom.time_n_intensity, _pp_time, _pp_global_intensity);
					shader_set_uniform_f(__PPF_SU.bloom.threshold, _pp_cfg.bloom.threshold);
					shader_set_uniform_f(__PPF_SU.bloom.intensity, _pp_cfg.bloom.intensity);
					shader_set_uniform_f_array(__PPF_SU.bloom.colorr, _pp_cfg.bloom.colorr);
					shader_set_uniform_f(__PPF_SU.bloom.dirt_enable, _pp_cfg.bloom.dirt_enable);
					shader_set_uniform_f(__PPF_SU.bloom.dirt_intensity, _pp_cfg.bloom.dirt_intensity);
					shader_set_uniform_f(__PPF_SU.bloom.dirt_scale, _pp_cfg.bloom.dirt_scale);
					texture_set_stage(__PPF_SU.bloom.bloom_tex, _pp_bloom_final_texture);
					texture_set_stage(__PPF_SU.bloom.dirt_tex, _pp_cfg.bloom.dirt_texture);
					gpu_set_tex_repeat_ext(__PPF_SU.bloom.dirt_tex, false);
					shader_set_uniform_f(__PPF_SU.bloom.debug, _pp_cfg.bloom.debug);
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region stack 4 - depth of field
			if (_pp_cfg.depth_of_field.enabledd) {
				// sets
				var _source = _pp_stack_surface[_pp_surf_index];
				
				// coc
				var _ww = view_w, _hh = view_h;
				if !surface_exists(_pp_dof_surface[0]) _pp_dof_surface[0] = surface_create(_ww, _hh); 
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter(false);
				__ppf_surface_blit(_source, _pp_dof_surface[0], __PPF_PASS_DOF_COC, {
					lens_distortion_enable : _pp_cfg.lens_distortion.enabledd,
					lens_distortion_amount : _pp_cfg.lens_distortion.enabledd ? _pp_cfg.lens_distortion.amount : 0,
					radius : _pp_cfg.depth_of_field.radius,
					focus_distance : _pp_cfg.depth_of_field.focus_distance,
					focus_range : _pp_cfg.depth_of_field.focus_range,
					use_zdepth : _pp_cfg.depth_of_field.use_zdepth,
					zdepth_tex : _pp_cfg.depth_of_field.zdepth_tex,
				});
				gpu_set_tex_filter(true);
				
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				// pre filter
				_ww = view_w/2; _hh = view_h/2; // half res
				if !surface_exists(_pp_dof_surface[1]) _pp_dof_surface[1] = surface_create(_ww, _hh);
				__ppf_surface_blit_alpha(_source, _pp_dof_surface[1], __PPF_PASS_DS_BOX13, {
					ww : _ww,
					hh : _hh,
					rb : false,
				});
				
				// bokeh
				if !surface_exists(_pp_dof_surface[2]) _pp_dof_surface[2] = surface_create(_ww, _hh);
				__ppf_surface_blit_alpha(_pp_dof_surface[1], _pp_dof_surface[2], __PPF_PASS_DOF_BOKEH, {
					ww : _ww,
					hh : _hh,
					time : _pp_time,
					global_intensity : _pp_global_intensity,
					radius : _pp_cfg.depth_of_field.radius,
					intensity : _pp_cfg.depth_of_field.intensity,
					shaped : _pp_cfg.depth_of_field.shaped,
					blades_aperture : _pp_cfg.depth_of_field.blades_aperture,
					blades_angle : _pp_cfg.depth_of_field.blades_angle,
					debug : _pp_cfg.depth_of_field.debug,
					coc_tex : surface_get_texture(_pp_dof_surface[0]),
				});
				
				// post filter
				//_ww /= 2; _hh /= 2;
				if !surface_exists(_pp_dof_surface[3]) _pp_dof_surface[3] = surface_create(_ww, _hh);
				__ppf_surface_blit_alpha(_pp_dof_surface[2], _pp_dof_surface[3], __PPF_PASS_US_TENT9, {
					ww : _ww,
					hh : _hh,
					rb : false,
				});
				
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_DOF);
					texture_set_stage(__PPF_SU.depth_of_field.final_coc_tex, surface_get_texture(_pp_dof_surface[0]));
					texture_set_stage(__PPF_SU.depth_of_field.final_dof_tex, surface_get_texture(_pp_dof_surface[3]));
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					surface_reset_target();
				}
				gpu_set_tex_filter(_cur_aa_filter);
				gpu_set_blendmode(bm_normal);
			}
			#endregion
			
			#region stack 5 - motion blur
			if (_pp_cfg.motion_blur.enabledd) {
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_MOTION_BLUR);
					shader_set_uniform_f(__PPF_SU.motion_blur.time_n_intensity, _pp_time, _pp_global_intensity);
					shader_set_uniform_f(__PPF_SU.motion_blur.angle, _pp_cfg.motion_blur.angle);
					shader_set_uniform_f(__PPF_SU.motion_blur.radius, _pp_cfg.motion_blur.radius);
					shader_set_uniform_f_array(__PPF_SU.motion_blur.center, _pp_cfg.motion_blur.center);
					shader_set_uniform_f(__PPF_SU.motion_blur.mask_power, _pp_cfg.motion_blur.mask_power);
					shader_set_uniform_f(__PPF_SU.motion_blur.mask_scale, _pp_cfg.motion_blur.mask_scale);
					shader_set_uniform_f(__PPF_SU.motion_blur.mask_smoothness, _pp_cfg.motion_blur.mask_smoothness);
					texture_set_stage(__PPF_SU.motion_blur.overlay_texture, _pp_cfg.motion_blur.overlay_texture);
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region stack 6 - radial blur
			if (_pp_cfg.blur_radial.enabledd) {
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
			 		shader_set(__PPF_SH_RADIAL_BLUR);
					shader_set_uniform_f(__PPF_SU.blur_radial.time_n_intensity, _pp_time, _pp_global_intensity);
					shader_set_uniform_f(__PPF_SU.blur_radial.radius, _pp_cfg.blur_radial.radius);
					shader_set_uniform_f_array(__PPF_SU.blur_radial.center, _pp_cfg.blur_radial.center);
					shader_set_uniform_f(__PPF_SU.blur_radial.inner, _pp_cfg.blur_radial.inner);
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region stack 7 - color grading
			_pp_surf_index++;
			if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
				_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
			}
			surface_set_target(_pp_stack_surface[_pp_surf_index]) {
				draw_clear_alpha(c_black, 0);
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				
				shader_set(__PPF_SH_COLOR_GRADING);
				shader_set_uniform_f(__PPF_SU.color_grading.pos_res, x, y, view_w, view_h);
				shader_set_uniform_f(__PPF_SU.color_grading.time_n_intensity, _pp_time, _pp_global_intensity);
				shader_set_uniform_f_array(__PPF_SU.color_grading.enabledd, [
					_pp_cfg.lens_distortion.enabledd,
					_pp_cfg.lut3d.enabledd,
					_pp_cfg.shadow_midtone_highlight.enabledd,
					_pp_cfg.exposure.enabledd,
					_pp_cfg.brightness.enabledd,
					_pp_cfg.saturation.enabledd,
					_pp_cfg.contrast.enabledd,
					_pp_cfg.tone_mapping.enabledd,
					_pp_cfg.lift_gamma_gain.enabledd,
					_pp_cfg.hue_shift.enabledd,
					_pp_cfg.colorize.enabledd,
					_pp_cfg.posterization.enabledd,
					_pp_cfg.invert_colors.enabledd,
					_pp_cfg.texture_overlay.enabledd,
					_pp_cfg.border.enabledd,
				]);
				
				// > [d] effect: lens_distortion
				if (_pp_cfg.lens_distortion.enabledd) {
					shader_set_uniform_f(__PPF_SU.lens_distortion.amount_c, _pp_cfg.lens_distortion.amount);
				}
				// > effect: lut3d
				if (_pp_cfg.lut3d.enabledd) {
					texture_set_stage(__PPF_SU.lut3d.tex_lookup, _pp_cfg.lut3d.texture);
					shader_set_uniform_f(__PPF_SU.lut3d.intensity, _pp_cfg.lut3d.intensity);
					shader_set_uniform_f_array(__PPF_SU.lut3d.size, _pp_cfg.lut3d.size);
					shader_set_uniform_f(__PPF_SU.lut3d.squares, _pp_cfg.lut3d.squares);
				}
				// > effect: shadow_midtone_highlight
				if (_pp_cfg.shadow_midtone_highlight.enabledd) {
					shader_set_uniform_f_array(__PPF_SU.shadow_midtone_highlight.shadow_color, _pp_cfg.shadow_midtone_highlight.shadow_color);
					shader_set_uniform_f_array(__PPF_SU.shadow_midtone_highlight.midtone_color, _pp_cfg.shadow_midtone_highlight.midtone_color);
					shader_set_uniform_f_array(__PPF_SU.shadow_midtone_highlight.highlight_color, _pp_cfg.shadow_midtone_highlight.highlight_color);
					shader_set_uniform_f(__PPF_SU.shadow_midtone_highlight.shadow_range, _pp_cfg.shadow_midtone_highlight.shadow_range);
					shader_set_uniform_f(__PPF_SU.shadow_midtone_highlight.highlight_range, _pp_cfg.shadow_midtone_highlight.highlight_range);
				}
				// > effect: exposure
				if (_pp_cfg.exposure.enabledd) {
					shader_set_uniform_f(__PPF_SU.exposure.value, _pp_cfg.exposure.value);
				}
				// > effect: brightness
				if (_pp_cfg.brightness.enabledd) {
					shader_set_uniform_f(__PPF_SU.brightness.value, _pp_cfg.brightness.value);
				}
				// > effect: saturation
				if (_pp_cfg.saturation.enabledd) {
					shader_set_uniform_f(__PPF_SU.saturation.value, _pp_cfg.saturation.value);
				}
				// > effect: contrast
				if (_pp_cfg.contrast.enabledd) {
					shader_set_uniform_f(__PPF_SU.contrast.value, _pp_cfg.contrast.value);
				}
				// > effect: tone_mapping
				if (_pp_cfg.tone_mapping.enabledd) {
					shader_set_uniform_i(__PPF_SU.tone_mapping.mode, _pp_cfg.tone_mapping.mode);
				}
				// > effect: lift_gamma_gain
				if (_pp_cfg.lift_gamma_gain.enabledd) {
					shader_set_uniform_f_array(__PPF_SU.lift_gamma_gain.lift, _pp_cfg.lift_gamma_gain.lift);
					shader_set_uniform_f_array(__PPF_SU.lift_gamma_gain.gamma, _pp_cfg.lift_gamma_gain.gamma);
					shader_set_uniform_f_array(__PPF_SU.lift_gamma_gain.gain, _pp_cfg.lift_gamma_gain.gain);
				}
				// > effect: hue_shift
				if (_pp_cfg.hue_shift.enabledd) {
					shader_set_uniform_f_array(__PPF_SU.hue_shift.colorr, _pp_cfg.hue_shift.colorr);
				}
				// > effect: colorize
				if (_pp_cfg.colorize.enabledd) {
					shader_set_uniform_f_array(__PPF_SU.colorize.colorr, _pp_cfg.colorize.colorr);
					shader_set_uniform_f(__PPF_SU.colorize.intensity, _pp_cfg.colorize.intensity);
					shader_set_uniform_f(__PPF_SU.colorize.darkness, _pp_cfg.colorize.darkness);
				}
				// > effect: posterization
				if (_pp_cfg.posterization.enabledd) {
					shader_set_uniform_f(__PPF_SU.posterization.color_factor, _pp_cfg.posterization.color_factor);
				}
				// > effect: invert_colors
				if (_pp_cfg.invert_colors.enabledd) {
					shader_set_uniform_f(__PPF_SU.invert_colors.intensity, _pp_cfg.invert_colors.intensity);
				}
				// > effect: texture_overlay
				if (_pp_cfg.texture_overlay.enabledd) {
					shader_set_uniform_f(__PPF_SU.texture_overlay.intensity, _pp_cfg.texture_overlay.intensity);
					shader_set_uniform_f(__PPF_SU.texture_overlay.zoom, _pp_cfg.texture_overlay.zoom);
					texture_set_stage(__PPF_SU.texture_overlay.texture, _pp_cfg.texture_overlay.texture);
				}
				// > [d] effect: border
				if (_pp_cfg.border.enabledd) {
					shader_set_uniform_f(__PPF_SU.border.curvature_c, _pp_cfg.border.curvature);
					shader_set_uniform_f(__PPF_SU.border.smooth_c, _pp_cfg.border.smooth);
					shader_set_uniform_f_array(__PPF_SU.border.colorr_c, _pp_cfg.border.colorr);
				}
				draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
				shader_reset();
				
				gpu_set_blendmode(bm_normal);
				surface_reset_target();
			}
			#endregion
			
			#region stack 8 - palette swap
			if (_pp_cfg.palette_swap.enabledd) {
				_pp_surf_index++;
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter_ext(__PPF_SU.palette_swap.texture, !_pp_cfg.palette_swap.limit_colors);
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_PALETTE_SWAP);
					shader_set_uniform_f(__PPF_SU.palette_swap.time_n_intensity, _pp_time, _pp_global_intensity);
					shader_set_uniform_f(__PPF_SU.palette_swap.row, _pp_cfg.palette_swap.row);
					shader_set_uniform_f(__PPF_SU.palette_swap.pal_height, _pp_cfg.palette_swap.pal_height);
					shader_set_uniform_f(__PPF_SU.palette_swap.threshold, _pp_cfg.palette_swap.threshold);
					shader_set_uniform_i(__PPF_SU.palette_swap.flip, _pp_cfg.palette_swap.flip);
					texture_set_stage(__PPF_SU.palette_swap.texture, _pp_cfg.palette_swap.texture);
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region stack 9 - kawase blur
			if (_pp_cfg.blur_kawase.enabledd) {
				// sets
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter(true);
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				var _ds = _pp_cfg.blur_kawase.downscale;
				var _amount = _pp_cfg.blur_kawase.amount;
				var _iterations = clamp(_pp_cfg.blur_kawase.iterations * _amount, 1, 8);
				var _ww = view_w, _hh = view_h;
				
				var _source = _pp_stack_surface[_pp_surf_index];
				var _current_destination = _source;
				var _current_source = _source;
				
				// downsampling
				var i = 0;
				repeat(_iterations) {
					_ww /= _ds;
					_hh /= _ds;
					_ww -= frac(_ww);
					_hh -= frac(_hh);
					if (min(_ww, _hh) < 2) break;
					if !surface_exists(_pp_kawase_blur_surface[i]) {
						_pp_kawase_blur_surface[i] = surface_create(_ww, _hh);
					}
					_current_destination = _pp_kawase_blur_surface[i];
					__ppf_surface_blit_alpha(_current_source, _current_destination, 1, {
						ww : _ww,
						hh : _hh,
						rb : false,
					});
					_current_source = _current_destination;
					++i;
				}
				
				// upsampling
				for (i -= 2; i >= 0; i--) {
					_current_destination = _pp_kawase_blur_surface[i];
					__ppf_surface_blit_alpha(_current_source, _current_destination, 3, {
						ww : surface_get_width(_current_destination),
						hh : surface_get_height(_current_destination),
						rb : false,
					});
					_current_source = _current_destination;
				}
				
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_KAWASE_BLUR);
					shader_set_uniform_f(__PPF_SU.blur_kawase.time_n_intensity, _pp_time, _pp_global_intensity);
					shader_set_uniform_f(__PPF_SU.blur_kawase.mask_power, _pp_cfg.blur_kawase.mask_power);
					shader_set_uniform_f(__PPF_SU.blur_kawase.mask_scale, _pp_cfg.blur_kawase.mask_scale);
					shader_set_uniform_f(__PPF_SU.blur_kawase.mask_smoothness, _pp_cfg.blur_kawase.mask_smoothness);
					texture_set_stage(__PPF_SU.blur_kawase.blur_tex, surface_get_texture(_current_destination));
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					surface_reset_target();
				}
				gpu_set_blendmode(bm_normal);
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region stack 10 - gaussian blur
			if (_pp_cfg.blur_gaussian.enabledd) {
				var _source = _pp_stack_surface[_pp_surf_index];
				var _ds = clamp(_pp_cfg.blur_gaussian.downscale, 0.1, 1);
				var _ww = view_w*_ds, _hh = view_h*_ds;
				
				if (_pp_gaussian_blur_downscale != _ds) {
					__ppf_surface_delete(_pp_gaussian_blur_ping_surface);
					__ppf_surface_delete(_pp_gaussian_blur_pong_surface);
					_pp_gaussian_blur_downscale = _ds;
				}
				if !surface_exists(_pp_gaussian_blur_ping_surface) {
					_pp_gaussian_blur_ping_surface = surface_create(_ww, _hh);
					_pp_gaussian_blur_pong_surface = surface_create(_ww/2, _hh/2);
				}
				
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter(true);
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				shader_set(__PPF_SH_GAUSSIAN_BLUR);
				shader_set_uniform_f(__PPF_SU.blur_gaussian.resolution, _ww, _hh);
				shader_set_uniform_f(__PPF_SU.blur_gaussian.time_n_intensity, _pp_time, _pp_global_intensity);
				shader_set_uniform_f(__PPF_SU.blur_gaussian.amount, _pp_cfg.blur_gaussian.amount);
				
				surface_set_target(_pp_gaussian_blur_ping_surface);
				draw_clear_alpha(c_black, 0);
				draw_surface_stretched(_source, 0, 0, _ww, _hh);
				surface_reset_target();
				
				surface_set_target(_pp_gaussian_blur_pong_surface);
				draw_clear_alpha(c_black, 0);
				draw_surface_stretched(_pp_gaussian_blur_ping_surface, 0, 0, _ww/2, _hh/2);
				surface_reset_target();
				shader_reset();
				
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_GNMSK);
					shader_set_uniform_f(__PPF_SU.gnmask_power, _pp_cfg.blur_gaussian.mask_power);
					shader_set_uniform_f(__PPF_SU.gnmask_scale, _pp_cfg.blur_gaussian.mask_scale);
					shader_set_uniform_f(__PPF_SU.gnmask_smoothness, _pp_cfg.blur_gaussian.mask_smoothness);
					texture_set_stage(__PPF_SU.gnmask_texture, surface_get_texture(_pp_gaussian_blur_pong_surface));
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					surface_reset_target();
				}
				gpu_set_blendmode(bm_normal);
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region stack 11 - chromatic aberration
			if (_pp_cfg.chromaber.enabledd) {
				_pp_surf_index++;
				if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
					_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
				}
				surface_set_target(_pp_stack_surface[_pp_surf_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_CHROMABER);
					shader_set_uniform_f(__PPF_SU.chromaber.pos_res, x, y, view_w, view_h);
					shader_set_uniform_f(__PPF_SU.chromaber.time_n_intensity, _pp_time, _pp_global_intensity);
					shader_set_uniform_f(__PPF_SU.chromaber.angle, _pp_cfg.chromaber.angle);
					shader_set_uniform_f(__PPF_SU.chromaber.intensity, _pp_cfg.chromaber.intensity);
					shader_set_uniform_f(__PPF_SU.chromaber.only_outer, _pp_cfg.chromaber.only_outer);
					shader_set_uniform_f(__PPF_SU.chromaber.center_radius, _pp_cfg.chromaber.center_radius);
					shader_set_uniform_f(__PPF_SU.chromaber.blur_enable, _pp_cfg.chromaber.blur_enable);
					texture_set_stage(__PPF_SU.chromaber.prisma_lut_tex, _pp_cfg.chromaber.prisma_lut_tex);
					draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region stack 12 - final
			_pp_surf_index++;
			if !surface_exists(_pp_stack_surface[_pp_surf_index]) {
				_pp_stack_surface[_pp_surf_index] = surface_create(view_w, view_h);
			}
			surface_set_target(_pp_stack_surface[_pp_surf_index]) {
				draw_clear_alpha(c_black, 0);
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				
				shader_set(__PPF_SH_FINAL);
				shader_set_uniform_f(__PPF_SU.base_final.pos_res, x, y, view_w, view_h);
				shader_set_uniform_f(__PPF_SU.base_final.time_n_intensity, _pp_time, _pp_global_intensity);
				shader_set_uniform_f_array(__PPF_SU.base_final.enabledd, [
					_pp_cfg.lens_distortion.enabledd,
					_pp_cfg.mist.enabledd,
					_pp_cfg.speedlines.enabledd,
					_pp_cfg.dithering.enabledd,
					_pp_cfg.noise_grain.enabledd,
					_pp_cfg.vignette.enabledd,
					_pp_cfg.nes_fade.enabledd,
					_pp_cfg.scanlines.enabledd,
					_pp_cfg.fade.enabledd,
					_pp_cfg.cinema_bars.enabledd,
					_pp_cfg.color_blindness.enabledd,
					_pp_cfg.channels.enabledd,
					_pp_cfg.border.enabledd,
				]);
				
				// > [d] effect: lens_distortion
				if (_pp_cfg.lens_distortion.enabledd) {
					shader_set_uniform_f(__PPF_SU.lens_distortion.amount_f, _pp_cfg.lens_distortion.amount);
				}
				// > effect: mist
				if (_pp_cfg.mist.enabledd) {
					shader_set_uniform_f(__PPF_SU.mist.intensity, _pp_cfg.mist.intensity);
					shader_set_uniform_f(__PPF_SU.mist.scale, _pp_cfg.mist.scale);
					shader_set_uniform_f(__PPF_SU.mist.tiling, _pp_cfg.mist.tiling);
					shader_set_uniform_f(__PPF_SU.mist.speedd, _pp_cfg.mist.speedd);
					shader_set_uniform_f(__PPF_SU.mist.angle, _pp_cfg.mist.angle);
					shader_set_uniform_f(__PPF_SU.mist.contrast, _pp_cfg.mist.contrast);
					shader_set_uniform_f(__PPF_SU.mist.powerr, _pp_cfg.mist.powerr);
					shader_set_uniform_f(__PPF_SU.mist.remap, _pp_cfg.mist.remap);
					shader_set_uniform_f_array(__PPF_SU.mist.colorr, _pp_cfg.mist.colorr);
					shader_set_uniform_f(__PPF_SU.mist.mix, _pp_cfg.mist.mix);
					shader_set_uniform_f(__PPF_SU.mist.mix_threshold, _pp_cfg.mist.mix_threshold);
					texture_set_stage(__PPF_SU.mist.noise_tex, _pp_cfg.mist.noise_tex);
					gpu_set_tex_repeat_ext(__PPF_SU.mist.noise_tex, true);
				}
				// > effect: speedlines
				if (_pp_cfg.speedlines.enabledd) {
					shader_set_uniform_f(__PPF_SU.speedlines.scale, _pp_cfg.speedlines.scale);
					shader_set_uniform_f(__PPF_SU.speedlines.tiling, _pp_cfg.speedlines.tiling);
					shader_set_uniform_f(__PPF_SU.speedlines.speedd, _pp_cfg.speedlines.speedd);
					shader_set_uniform_f(__PPF_SU.speedlines.rot_speed, _pp_cfg.speedlines.rot_speed);
					shader_set_uniform_f(__PPF_SU.speedlines.contrast, _pp_cfg.speedlines.contrast);
					shader_set_uniform_f(__PPF_SU.speedlines.powerr, _pp_cfg.speedlines.powerr);
					shader_set_uniform_f(__PPF_SU.speedlines.remap, _pp_cfg.speedlines.remap);
					shader_set_uniform_f(__PPF_SU.speedlines.mask_power, _pp_cfg.speedlines.mask_power);
					shader_set_uniform_f(__PPF_SU.speedlines.mask_scale, _pp_cfg.speedlines.mask_scale);
					shader_set_uniform_f(__PPF_SU.speedlines.mask_smoothness, _pp_cfg.speedlines.mask_smoothness);
					shader_set_uniform_f_array(__PPF_SU.speedlines.colorr, _pp_cfg.speedlines.colorr);
					texture_set_stage(__PPF_SU.speedlines.noise_tex, _pp_cfg.speedlines.noise_tex);
					gpu_set_tex_repeat_ext(__PPF_SU.speedlines.noise_tex, true);
				}
				// > effect: dithering
				if (_pp_cfg.dithering.enabledd) {
					texture_set_stage(__PPF_SU.dithering.bayer_texture, _pp_cfg.dithering.bayer_texture);
					shader_set_uniform_f(__PPF_SU.dithering.threshold, _pp_cfg.dithering.threshold);
					shader_set_uniform_f(__PPF_SU.dithering.strength, _pp_cfg.dithering.strength);
					shader_set_uniform_f(__PPF_SU.dithering.mode, _pp_cfg.dithering.mode);
					shader_set_uniform_i(__PPF_SU.dithering.coord_absolute, _pp_cfg.dithering.coord_absolute);
					shader_set_uniform_f(__PPF_SU.dithering.bayer_size, _pp_cfg.dithering.bayer_size);
					//gpu_set_tex_filter_ext(__PPF_SU.dithering.bayer_texture, false); // not working ??
				}
				// > effect: noise_grain
				if (_pp_cfg.noise_grain.enabledd) {
					shader_set_uniform_f(__PPF_SU.noise_grain.intensity, _pp_cfg.noise_grain.intensity);
					shader_set_uniform_f(__PPF_SU.noise_grain.scale, _pp_cfg.noise_grain.scale);
					shader_set_uniform_f(__PPF_SU.noise_grain.mix, _pp_cfg.noise_grain.mix);
					texture_set_stage(__PPF_SU.noise_grain.noise_tex, _pp_cfg.noise_grain.noise_tex);
					gpu_set_tex_repeat_ext(__PPF_SU.noise_grain.noise_tex, true);
				}
				// > effect: vignette
				if (_pp_cfg.vignette.enabledd) {
					shader_set_uniform_f(__PPF_SU.vignette.intensity, _pp_cfg.vignette.intensity);
					shader_set_uniform_f(__PPF_SU.vignette.curvature, _pp_cfg.vignette.curvature);
					shader_set_uniform_f(__PPF_SU.vignette.inner, _pp_cfg.vignette.inner);
					shader_set_uniform_f(__PPF_SU.vignette.outer, _pp_cfg.vignette.outer);
					shader_set_uniform_f_array(__PPF_SU.vignette.colorr, _pp_cfg.vignette.colorr);
					shader_set_uniform_f_array(__PPF_SU.vignette.center, _pp_cfg.vignette.center);
					shader_set_uniform_f(__PPF_SU.vignette.rounded, _pp_cfg.vignette.rounded);
					shader_set_uniform_f(__PPF_SU.vignette.linear, _pp_cfg.vignette.linear);
				}
				// > effect: nes_fade
				if (_pp_cfg.nes_fade.enabledd) {
					shader_set_uniform_f(__PPF_SU.nes_fade.amount, _pp_cfg.nes_fade.amount);
					shader_set_uniform_f(__PPF_SU.nes_fade.levels, _pp_cfg.nes_fade.levels);
				}
				// > effect: scanlines
				if (_pp_cfg.scanlines.enabledd) {
					shader_set_uniform_f(__PPF_SU.scanlines.intensity, _pp_cfg.scanlines.intensity);
					shader_set_uniform_f(__PPF_SU.scanlines.speedd, _pp_cfg.scanlines.speedd);
					shader_set_uniform_f(__PPF_SU.scanlines.amount, _pp_cfg.scanlines.amount);
					shader_set_uniform_f_array(__PPF_SU.scanlines.colorr, _pp_cfg.scanlines.colorr);
					shader_set_uniform_f(__PPF_SU.scanlines.mask_power, _pp_cfg.scanlines.mask_power);
					shader_set_uniform_f(__PPF_SU.scanlines.mask_scale, _pp_cfg.scanlines.mask_scale);
					shader_set_uniform_f(__PPF_SU.scanlines.mask_smoothness, _pp_cfg.scanlines.mask_smoothness);
				}
				// > effect: fade
				if (_pp_cfg.fade.enabledd) {
					shader_set_uniform_f(__PPF_SU.fade.amount, _pp_cfg.fade.amount);
					shader_set_uniform_f_array(__PPF_SU.fade.colorr, _pp_cfg.fade.colorr);
				}
				// > effect: cinema_bars
				if (_pp_cfg.cinema_bars.enabledd) {
					shader_set_uniform_f(__PPF_SU.cinema_bars.amount, _pp_cfg.cinema_bars.amount);
					shader_set_uniform_f_array(__PPF_SU.cinema_bars.colorr, _pp_cfg.cinema_bars.colorr);
					shader_set_uniform_f(__PPF_SU.cinema_bars.vertical_enable, _pp_cfg.cinema_bars.vertical_enable);
					shader_set_uniform_f(__PPF_SU.cinema_bars.horizontal_enable, _pp_cfg.cinema_bars.horizontal_enable);
					shader_set_uniform_f(__PPF_SU.cinema_bars.is_fixed, _pp_cfg.cinema_bars.is_fixed);
				}
				// > effect: color_blindness
				if (_pp_cfg.color_blindness.enabledd) {
					shader_set_uniform_f(__PPF_SU.color_blindness.mode, _pp_cfg.color_blindness.mode);
				}
				// > effect: channels
				if (_pp_cfg.channels.enabledd) {
					shader_set_uniform_f(__PPF_SU.channels.rgb, _pp_cfg.channels.red, _pp_cfg.channels.green, _pp_cfg.channels.blue);
				}
				// > [d] effect: border
				if (_pp_cfg.border.enabledd) {
					shader_set_uniform_f(__PPF_SU.border.curvature_f, _pp_cfg.border.curvature);
					shader_set_uniform_f(__PPF_SU.border.smooth_f, _pp_cfg.border.smooth);
					shader_set_uniform_f_array(__PPF_SU.border.colorr_f, _pp_cfg.border.colorr);
				}
				draw_surface_stretched(_pp_stack_surface[_pp_surf_index-1], 0, 0, view_w, view_h);
				shader_reset();
				
				gpu_set_blendmode(bm_normal);
				surface_reset_target();
			}
			#endregion
			
			// final render
			gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			if (_pp_draw_enabled) draw_surface_stretched(_pp_stack_surface[_pp_surf_index], x, y, w, h);
			//_pp_render_final_tex = surface_get_texture(_pp_stack_surface[_pp_surf_index]);
		} else {
			// final render
			gpu_set_blendenable(false);
			if (_pp_draw_enabled) draw_surface_stretched(surface, x, y, w, h);
			
		}
		gpu_set_blendenable(_sys_blendenable);
		gpu_set_blendmode(_sys_blendmode);
		surface_depth_disable(_sys_depth_disable);
	}
}
