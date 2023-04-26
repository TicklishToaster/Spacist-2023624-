



// Toggle build mode if the blueprint tool is currently selected.
var selected_item = ex_item_get_item(global.inv_toolbar, array_get_index(obj_inv_panel_toolbar.slots, obj_inv_panel_toolbar.selected_slot))
if (ds_exists(selected_item, ds_type_map)) {
	//if (selected_item[? "key"] == "tool_blueprint" && object_get_visible(obj_building_button) == false) {
	if (selected_item[? "key"] == "tool_blueprint" && build_menu_active == false) {
		instance_activate_object(obj_building_button);
		build_menu_active = true;
	}
	else if (selected_item[? "key"] != "tool_blueprint" && build_menu_active == true) {
		instance_deactivate_object(obj_building_button);
		build_menu_active = false;
	}
}
else if (build_menu_active == true) {
	instance_deactivate_object(obj_building_button);
	build_menu_active = false;
}
