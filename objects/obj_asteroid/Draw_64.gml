
if (state_grounded && state_landed) {	
	if (collision_point(mouse_x, mouse_y, obj_asteroid, true, false)) {
		draw_set_font(fnt_poco);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
        var cl = camera_get_view_x(view_camera[0])
        var ct = camera_get_view_y(view_camera[0])
       
        var off_x = mouse_x - cl // x is the normal x position
        var off_y = mouse_y - ct // y is the normal y position
       
        // convert to gui
        var off_x_percent = off_x / camera_get_view_width(view_camera[0])
        var off_y_percent = off_y / camera_get_view_height(view_camera[0])
       
        var gui_x = off_x_percent * display_get_gui_width()
        var gui_y = off_y_percent * display_get_gui_height()
		
		draw_text(gui_x, gui_y, "E: TAKE TO REFINERY");
		//draw_text(mouse_x + display_get_gui_width(), mouse_y + display_get_gui_height(), "E: TAKE TO REFINERY");
	}
}