
// Get the conveyor belt that leads into this object.
var conveyor_enter = collision_rectangle(
	connection_point_1.bbox_left, 
	connection_point_1.bbox_top, 
	connection_point_1.bbox_right, 
	connection_point_1.bbox_bottom,
	obj_conveyor_belt, false, true
);
if (conveyor_enter != noone) {
	if (connector_entrance != conveyor_enter) {
		connector_entrance = conveyor_enter;
	}
} else if (conveyor_enter == noone && connector_entrance != noone) {
	connector_entrance = noone;
}


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


// Get the building and connection point this object connects to.
var connected_building = collision_point(x, y-sprite_height/2, obj_building_connector, false, true);
if (connected_building != noone) {
	if (connector_building != connected_building.creator) {
		
		connector_building		= connected_building.creator;
		connector_building_type = connected_building.connection_type;
		
		if (connector_building_type = "input") {
			with (connected_building.creator) {
				target_conveyor_input = other;
			}
		}
		else if (connector_building_type = "output") {
			with (connected_building.creator) {
				target_conveyor_input = other;
			}
		}
		//with (connected_building) {
		//	target_conveyor = other;
		//}
	}
} else if (connected_building == noone && connector_building != noone) {
	connector_building = noone;
}