var cl = camera_get_view_x(view_camera[0])
var ct = camera_get_view_y(view_camera[0])
       
var off_x = mouse_x - cl // x is the normal x position
var off_y = mouse_y - ct // y is the normal y position
       
// convert to gui
var off_x_percent = off_x / camera_get_view_width(view_camera[0])
var off_y_percent = off_y / camera_get_view_height(view_camera[0])
       
var gui_x = off_x_percent * display_get_gui_width()
var gui_y = off_y_percent * display_get_gui_height()

if (collision_point(gui_x, gui_y, self, true, false)) {	
	if (mouse_check_button_pressed(mb_left)) {
		for (var i = 0; i < instance_number(obj_building_button); ++i) {
			button_selected = false;
		}
		button_selected = true;

		
		obj_build_manager.target_building_key			= building_key;		// key
		obj_build_manager.target_building_obj			= building_id;		// object id
		obj_build_manager.target_building_sprite		= building_sprite;	// object sprite
		obj_build_manager.target_building_repeating		= building_9slice;	// 9slice sprite	
	}
}