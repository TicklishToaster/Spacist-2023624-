/// @description Camera Setup
view_enabled = true;
view_visible[0] = true;


// Camera /////////////////////////////////////////////////////////////////////
target = obj_player;
camera_x = room_width/2;
camera_y = room_height/2;

camera_width = 1920;
camera_height = 1080;

camera_set_view_size(view_camera[0], camera_width, camera_height);


// Display ////////////////////////////////////////////////////////////////////
display_scale = 1;
display_width = camera_width * display_scale;
display_height = camera_height * display_scale;

window_set_size(display_width, display_height);
surface_resize(application_surface, display_width, display_height);
//window_set_fullscreen(true);


// GUI ////////////////////////////////////////////////////////////////////////
display_set_gui_size(camera_width, camera_height);
alarm[0] = 1;


// Parallax Background Vars ///////////////////////////////////////////////////
bg_shift_x = 0;
bg_shift_y = 1;
bg_window_shift_x = 0;

// Popup Window Surface Var ///////////////////////////////////////////////////
popup_window_surface = -1;
