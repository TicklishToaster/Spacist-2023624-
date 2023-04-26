

draw_self();

draw_sprite_ext(building_icon[0], building_icon[1], x + 16, y + 16, 1, 1, 0, -1, 1);


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
	draw_sprite_ext(spr_slot_selected, -1, x+8, y+8, 1, 1, 0, -1, 1);
	
	draw_set_font(fnt_ex);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);	
			
	var _label_text = building_name;
	var _label_w = (string_width(_label_text) + 8);
	var _label_h = (string_height(_label_text) + 4);

	draw_set_color(c_dkgray);
	draw_rectangle(gui_x - _label_w, gui_y - _label_h, gui_x + _label_w*0, gui_y, false);
	draw_set_color(c_white); 
	draw_text(gui_x - _label_w div 2, gui_y - _label_h div 2, _label_text);
	
	//if (mouse_check_button_pressed(mb_left)) {
	//	for (var i = 0; i < instance_number(obj_building_button); ++i) {
	//		button_selected = false;
	//	}
	//	button_selected = true;
	//	obj_build_manager.target_building = building_key;
	//}
}
else if (button_selected) {
	draw_sprite_ext(spr_slot_selected, -1, x+8, y+8, 1, 1, 0, -1, 1);
}

