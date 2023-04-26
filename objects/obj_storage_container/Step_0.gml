

if (instance_exists(target_conveyor_output)) {
	if (ex_inv_size(target_conveyor_output.inv_building) != 1) {
		ex_item_move(inv_building, 0, target_conveyor_output.inv_building, 1, -1, false);
	}
}

if (ex_inv_size(inv_building) > 0) {
    // code here
	if (ex_item_get_amount(inv_building, 0) <= 0) {
	    // code here
		ex_inv_sort(inv_building, "key", true);
	}
}