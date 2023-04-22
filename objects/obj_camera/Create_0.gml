/// @description Camera Setup
view_enabled = true;
view_visible[0] = true;

// Camera Vars ////////////////////////////////////////////////////////////////
target = obj_player;
camera_x = room_width/2;
camera_y = room_height/2;

camera_width = 1920;
camera_height = 1080;

camera_set_view_size(view_camera[0], camera_width, camera_height);

// Display Vars ///////////////////////////////////////////////////////////////
display_scale = 1;
display_width = camera_width * display_scale;
display_height = camera_height * display_scale;

window_set_size(display_width, display_height);
surface_resize(application_surface, display_width, display_height);
window_set_fullscreen(false);
//window_set_fullscreen(true);

// GUI Vars ///////////////////////////////////////////////////////////////////
display_set_gui_size(camera_width, camera_height);
window_center();

// Parallax Background Vars ///////////////////////////////////////////////////
bg_shift_x = 0;
bg_shift_y = 1;
bg_window_shift_x = 0;
bg_asteroid_shift = 0;

nebula_shift_co = 0;
nebula_shift_x	= 0;
nebula_shift_y	= 0;

// Popup Window Surface Vars //////////////////////////////////////////////////
popup_window_surface = -1;

// Camera Panning Methods /////////////////////////////////////////////////////
state_panning		= false;
pann_speed			= 0.01;
pann_coefficient	= 0.00;
pann_origin_object	= noone;
pann_target_object	= noone;
pann_origin_x		= 10;
pann_origin_y		= 10;

pann_camera = function(origin_object, target_object, move_speed) {
	show_debug_message("PANN START");
	state_panning		= true;
	pann_speed			= move_speed;
	pann_coefficient	= 0.00;
	pann_origin_object	= origin_object;
	pann_target_object	= target_object;
	pann_origin_x		= pann_origin_object.hotspot_x;
	pann_origin_y		= pann_origin_object.hotspot_y;
	pann_target_x		= pann_target_object.hotspot_x;
	pann_target_y		= pann_target_object.hotspot_y;
}

popup_window_surface = -1;