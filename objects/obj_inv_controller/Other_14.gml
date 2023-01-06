///@desc	open static inventories

/*
	Event used to open the static (player) inventories. This includes only inventory panels
	that are always open, like the toolbar and the mouse.
*/

//Open the mouse inventory
ex_ui_panel_open(global.inv_mouse, obj_inv_mouse, 0, 0, layer);
	
//Open the toolbar inventory on the panels layer
ex_ui_panel_open(global.inv_toolbar, obj_inv_panel_toolbar,
	obj_camera.display_width / 2 - sprite_get_width(spr_toolbar) / 2, 
	obj_camera.display_height - sprite_get_height(spr_toolbar), 
	layer);
//ex_ui_panel_open(global.inv_toolbar, obj_inv_panel_toolbar, 264, 558, layer);