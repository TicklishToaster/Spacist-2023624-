
/*
  Shift all existing items on conveyor belts to connecting conveyor belts if they exist.
  This script will loop through each conveyor belt in reverse order from when they were created.
*/

//if (conveyor_count > 0 && instance_exists(obj_conveyor_belt) && animation_frame <= 0) {
if (conveyor_count > 0 && instance_exists(obj_conveyor_belt)) {
	for (var i = 0; i < conveyor_count; i++) {
		var target_belt = ds_grid_get(conveyor_list, 0, i);
		if (target_belt.connector_building == noone) {
			
			if (target_belt.connector_exit != noone) {			
				//show_debug_message("GO 1")
				for (var i1 = 0; i1 < ds_list_size(target_belt.item_instance.item_list); ++i1) {
					
					//if (ds_list_find_value(target_belt.item_instance.item_list, i1) >= 32 - (32/4)*i1) {
					if (ds_list_find_value(target_belt.item_instance.item_list, 0) >= 32 - (32/4)*0) {
						//show_debug_message("GO 2")
						//ex_item_move(target_belt.inv_building, i1, target_belt.connector_exit.inv_building, -1);
						ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, 1);
						ds_list_delete(target_belt.item_instance.item_list, 0);
						//ex_inv_sort(target_belt.inv_building, EX_COLS.index, true);
						
						//if (ex_item_get_amount(target_belt.inv_building, 0) == 0) {
						//	ds_list_delete(target_belt.item_instance.item_list, 0);
						//}
						//ds_list_add(target_belt.connection_exit.item_instance.item_list, 0);
					}
				}
			}
		}
		else if (target_belt.connector_building != noone) {				
			for (var i1 = 0; i1 < ds_list_size(target_belt.item_instance.item_list); ++i1) {
				if (ds_list_find_value(target_belt.item_instance.item_list, i1) >= 32 - (32/4)*i1) {
					
					//if (ex_inv_find(target_belt.connector_building.inv_building, ex_item_get_key(target_belt.inv_building, i1), EX_FIND.first) == ex_item_get_key(target_belt.inv_building, i1)) {
					if (ex_item_get_key(target_belt.connector_building.inv_building, 0) == "") {
						ex_item_move(target_belt.inv_building, 0, target_belt.connector_building.inv_building, -1, 0);
						ds_list_delete(target_belt.item_instance.item_list, 0);
					}
					
					else if (ex_item_get_key(target_belt.connector_building.inv_building, 0) == ex_item_get_key(target_belt.inv_building, 0)) {
						if (ex_item_get_amount(target_belt.connector_building.inv_building, 0) < ex_item_get_stack_id(target_belt.connector_building.inv_building, 0)) {
							ex_item_move(target_belt.inv_building, 0, target_belt.connector_building.inv_building, -1, 0);						
							ds_list_delete(target_belt.item_instance.item_list, 0);
						}
					}
					//else if (ex_item_get_amount(target_belt.connector_building.inv_building, 0) > 0) {
					//	if (ex_item_get_amount(target_belt.connector_building.inv_building, 0) < ex_item_get_stack_id(target_belt.connector_building.inv_building, 0)) {
					//		ex_item_move(target_belt.inv_building, 0, target_belt.connector_building.inv_building, -1, 0);						
					//		ds_list_delete(target_belt.item_instance.item_list, 0);
					//	}
					//}
					
					//ex_item_move(target_belt.inv_building, i1, target_belt.connector_building.inv_building, -1, 0);						
					//ds_list_delete(target_belt.item_instance.item_list, 0);
					
					//ex_item_move(target_belt.inv_building, i1, target_belt.connector_building.inv_building, -1, 0);
					
					////ex_item_move(target_belt.inv_building, i1, target_belt.connector_exit.inv_building, -1);
						
					//ds_list_delete(target_belt.item_instance.item_list, 0);
				}
			}		
		}
	}
}

//if (conveyor_count > 0 && instance_exists(obj_conveyor_belt) && animation_frame <= 0) {
//	for (var i = 0; i < conveyor_count; i++) {
//		var target_belt = ds_grid_get(conveyor_list, 0, i);
//		if (target_belt.connector_building == noone) {
//			if (target_belt.connector_exit != noone && ex_item_get_amount(target_belt.inv_building, 0) > 0) {
//				ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, -1);
//			}
//		}
//		else if (target_belt.connector_building != noone) {
//			ex_item_move(target_belt.inv_building, 0, target_belt.connector_building.inv_building, -1, 0);
//		}
//	}
//}

//if (instance_exists(obj_conveyor_belt) && obj_conveyor_belt.animation_frame <= 0) {
//	for (var i = instance_number(obj_conveyor_belt)-1; i >= 0; i-=1) {
//		var target_belt = instance_find(obj_conveyor_belt, i);
//		if (target_belt.animation_frame <= 0) {
//			if (target_belt.connector_exit != noone && ex_item_get_amount(target_belt.inv_building, 0) > 0) {
//				ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, -1);
//			}
//		}
//	}
//}