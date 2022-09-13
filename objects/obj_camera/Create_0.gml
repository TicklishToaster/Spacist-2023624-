/// @description Camera Setup
view_enabled = true;
view_visible[0] = true;

// Camera
target = obj_player;
camera_x = room_width/2;
camera_y = room_height/2;

camera_width = 1280;
camera_height = 720;
camera_shake = 0;

camera_set_view_size(view_camera[0], camera_width, camera_height);

// Display
display_scale = 1;
display_width = camera_width * display_scale;
display_height = camera_height * display_scale;

window_set_size(display_width, display_height);
surface_resize(application_surface, display_width, display_height);

// GUI
display_set_gui_size(camera_width, camera_height);
alarm[0] = 1;