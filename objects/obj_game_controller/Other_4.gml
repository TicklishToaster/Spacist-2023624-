///@desc create the inventories

if(room == rm_main) {
	with(obj_inv_controller) {
		event_user(INV_CONTROLLER_EVENTS.create_inventories);
	}

}