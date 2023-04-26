
if (keyboard_check_pressed(ord("E")) && selection_active == false) {
	if (collision_point(mouse_x, mouse_y, id, true, false)) {
		
		instance_activate_object(obj_resource_button);
		
		for (var i = 0; i < instance_number(obj_resource_button); ++i) {
			var target_button = instance_find(obj_resource_button, i)
			with (target_button) {
				target_output = other.id;
			}
		}
		
		selection_active = true;
	}
}

if (keyboard_check_pressed(ord("E")) && selection_active == true) {
	if (!collision_point(mouse_x, mouse_y, id, true, false)) {
		instance_deactivate_object(obj_resource_button);
		selection_active = false;
	}
}

//show_debug_message(target_resource_key)

//show_debug_message(ex_inv_size(inv_building))
if (target_resource_key != noone && ex_inv_size(inv_building) == 0) {
	//show_debug_message(obj_conveyor_manager.animation_frame)
	if (obj_conveyor_manager.animation_frame == 0) {
	    // code here
		var find_item = ex_inv_find(obj_deconstructive_refinery.inv_building, target_resource_key, EX_FIND.first);
		//show_debug_message(find_item)
		if (find_item != -1) {
		    // code here
			ex_item_move(obj_deconstructive_refinery.inv_building, find_item, inv_building, 1, -1, true);
		}
	}
    // code here
}


if (target_resource_key != noone && ex_inv_size(inv_building) == 1) {
	if (obj_conveyor_manager.animation_frame == 0 ) {
		ex_item_move(inv_building, 0, connector_exit.inv_building, 1, -1, true);
	}
}

//// Get the conveyor belt that leads into this object.
//var conveyor_enter = collision_rectangle(
//	connection_point_1.bbox_left, 
//	connection_point_1.bbox_top, 
//	connection_point_1.bbox_right, 
//	connection_point_1.bbox_bottom,
//	obj_conveyor_belt, false, true
//);
//if (conveyor_enter != noone) {
//	if (connector_entrance != conveyor_enter) {
//		connector_entrance = conveyor_enter;
//	}
//} else if (conveyor_enter == noone && connector_entrance != noone) {
//	connector_entrance = noone;
//}


// Get the conveyor belt the this object leads into.
var conveyor_exit = collision_rectangle(
	connection_point_2.bbox_left, 
	connection_point_2.bbox_top, 
	connection_point_2.bbox_right, 
	connection_point_2.bbox_bottom,
	obj_conveyor_belt, false, true
);
if (conveyor_exit != noone) {
	if (connector_exit != conveyor_exit) {
		connector_exit = conveyor_exit;
	}
} else if (conveyor_exit == noone && connector_exit != noone) {
	connector_exit = noone;
}


//// Get the building and connection point this object connects to.
//var connected_building = collision_point(x, y-sprite_height/2, obj_building_connector, false, true);
//if (connected_building != noone) {
//	if (connector_building != connected_building.creator) {
		
//		connector_building		= connected_building.creator;
//		connector_building_type = connected_building.connection_type;
		
//		if (connector_building_type = "input") {
//			with (connected_building.creator) {
//				target_conveyor_input = other;
//			}
//		}
//		else if (connector_building_type = "output") {
//			with (connected_building.creator) {
//				target_conveyor_input = other;
//			}
//		}
//		//with (connected_building) {
//		//	target_conveyor = other;
//		//}
//	}
//} else if (connected_building == noone && connector_building != noone) {
//	connector_building = noone;
//}