//////////// *THIS IS FOR APPLYING EFFECTS TO THE WHOLE SCREEN* ////////////////////
//// Get exact position and size of original application_surface
//var _pos = application_get_position();
//var _view_width = surface_get_width(application_surface), _view_height = surface_get_height(application_surface);

//// Draw post-processing on screen
//ppfx_draw(application_surface, _pos[0], _pos[1], _pos[2]-_pos[0], _pos[3]-_pos[1], _view_width, _view_height, ppfx_id);

//show_debug_message(string(_pos));
//show_debug_message(string(window_get_y()));


//var _pos = application_get_position();
//var _xx = _pos[0];
//var _yy = _pos[1];
//var _ww = _pos[2]-_pos[0];
//var _wh = _pos[3]-_pos[1];
//var _vw = surface_get_width(application_surface);
//var _vh = surface_get_height(application_surface);

//// render main system from "Main"
//ppfx_draw(application_surface, _xx, _yy, _ww, _wh, _vw, _vh, ppfx_id);

//// render system from "Glass Blur", using main post-processing surface
//ppfx_draw(ppfx_get_render_surface(ppfx_id), _xx, _yy, _ww, _wh, _vw, _vh, lens_distort_id);
////ppfx_draw(application_surface, _xx, _yy, _ww, _wh, _vw, _vh, lens_distort_id);

