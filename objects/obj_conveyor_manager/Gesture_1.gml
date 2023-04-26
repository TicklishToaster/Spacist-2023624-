///// @description OLD
//// You can write your code in this editor

///*
//  Shift all existing items on conveyor belts to connecting conveyor belts if they exist.
//  This script will loop through each conveyor belt in reverse order from when they were created.
//*/

////if (conveyor_count > 0 && instance_exists(obj_conveyor_belt) && animation_frame <= 0) {
//if (conveyor_count > 0 && instance_exists(obj_conveyor_belt)) {
//	for (var i = 0; i < conveyor_count; i++) {
//		var target_belt = ds_grid_get(conveyor_list, 0, i);
//		if (target_belt.connector_building == noone) {
//			if (target_belt.connector_exit != noone) {
//				if (ex_inv_size(target_belt.connector_exit.inv_building) < 1) {
//					for (var i1 = 0; i1 < ds_list_size(target_belt.item_instance.item_list); ++i1) {
//						//ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, 1, -1, true);
//						//ds_list_delete(target_belt.item_instance.item_list, 0);						
						
//						if (ds_list_find_value(target_belt.item_instance.item_list, 0) >= 32) {
//							ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, 1, -1, true);
//							//ds_list_set(target_belt.item_instance.item_list, 0, 0);
//							ds_list_delete(target_belt.item_instance.item_list, 0);
//							//ds_list_sort(target_belt.item_instance.item_list, false);
							
							
							
//							//ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, 1, -1, true);
//							//target_belt.item_instance.item01[1] -= 8;
//							//target_belt.item_instance.item02[1] -= 8;
//							//target_belt.item_instance.item03[1] -= 8;
//							//target_belt.item_instance.item04[1] -= 8;
							
//							//with (target_belt) {
//							//	var sort_list = false
//							//	for (var i = 0; i < ex_inv_size(inv_building); ++i) {
//							//		if (ex_item_get_amount(inv_building, i) <= 0) {
//							//			sort_list = true;
//							//			var target_index = i;
//							//			break;
//							//		}
//							//	}
//							//	if (sort_list) { 
//							//		ex_inv_sort(inv_building, EX_COLS.index, true);
//							//		ds_list_delete(item_instance.item_list, target_index);
//							//	}							
//							//}
							
//							//ds_list_set(target_belt.item_instance.item_list, 0, 0);
//							//ds_list_delete(target_belt.connector_exit.item_instance.item_list, 3);
//							//ds_list_delete(target_belt.item_instance.item_list, 0);
//							//ds_list_set(target_belt.connector_exit.item_instance.item_list, 0, 0);
//							//ds_list_sort(target_belt.item_instance.item_list, false);
//							break;
//						}
//						//if (ds_list_find_value(target_belt.item_instance.item_list, 0) >= 32) {
//						//	if (ds_list_size(target_belt.connector_exit.item_instance.item_list) >= 4) {
//						//		if (ds_list_find_value(target_belt.connector_exit.item_instance.item_list, 3) >= 8) {
//						//			ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, 1, -1, true);
//						//			//ds_list_set(target_belt.item_instance.item_list, 0, 0);
//						//			ds_list_delete(target_belt.item_instance.item_list, 0);
//						//			//ds_list_sort(target_belt.item_instance.item_list, false);
//						//			break;
//						//		}
//						//	}
//						//	else {
//						//		ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, 1, -1, true);
//						//		//ds_list_set(target_belt.item_instance.item_list, 0, 0);
//						//		ds_list_delete(target_belt.item_instance.item_list, 0);
//						//		//ds_list_sort(target_belt.item_instance.item_list, false);
//						//		break;							
//						//	}
//						//}
//					}
//				}
//			}
//		}
//		else if (target_belt.connector_building != noone) {				
//			for (var i1 = 0; i1 < ds_list_size(target_belt.item_instance.item_list); ++i1) {
//				if (ds_list_find_value(target_belt.item_instance.item_list, i1) >= 32 - (32/4)*i1) {
//					if (ex_item_get_key(target_belt.connector_building.inv_building, 0) == "") {
//						ex_item_move(target_belt.inv_building, 0, target_belt.connector_building.inv_building, -1, -1, true);
//						ds_list_delete(target_belt.item_instance.item_list, 0);
//					}
					
//					else if (ex_item_get_key(target_belt.connector_building.inv_building, 0) == ex_item_get_key(target_belt.inv_building, 0)) {
//						if (ex_item_get_amount(target_belt.connector_building.inv_building, 0) < ex_item_get_stack_id(target_belt.connector_building.inv_building, 0)) {
//							ex_item_move(target_belt.inv_building, 0, target_belt.connector_building.inv_building, -1, -1, true);						
//							ds_list_delete(target_belt.item_instance.item_list, 0);
//						}
//					}
//				}
//			}		
//		}
//	}
//}

////if (conveyor_count > 0 && instance_exists(obj_conveyor_belt) && animation_frame <= 0) {
////	for (var i = 0; i < conveyor_count; i++) {
////		var target_belt = ds_grid_get(conveyor_list, 0, i);
////		if (target_belt.connector_building == noone) {
////			if (target_belt.connector_exit != noone && ex_item_get_amount(target_belt.inv_building, 0) > 0) {
////				ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, -1);
////			}
////		}
////		else if (target_belt.connector_building != noone) {
////			ex_item_move(target_belt.inv_building, 0, target_belt.connector_building.inv_building, -1, 0);
////		}
////	}
////}

////if (instance_exists(obj_conveyor_belt) && obj_conveyor_belt.animation_frame <= 0) {
////	for (var i = instance_number(obj_conveyor_belt)-1; i >= 0; i-=1) {
////		var target_belt = instance_find(obj_conveyor_belt, i);
////		if (target_belt.animation_frame <= 0) {
////			if (target_belt.connector_exit != noone && ex_item_get_amount(target_belt.inv_building, 0) > 0) {
////				ex_item_move(target_belt.inv_building, 0, target_belt.connector_exit.inv_building, -1);
////			}
////		}
////	}
////}