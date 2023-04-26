// Row Speed
if (!hook_attached && !state_grounded && !state_returning) {
	x -= item_velocity;
	image_angle += item_rotation_speed;
}

//// Row Speed
//if (!hook_attached && !state_grounded && !state_returning) {
//	if variable_struct_exists(self, "row_speed") {
//		x -= row_speed;
//	}

//	if variable_struct_exists(self, "rotation_speed") {
//		image_angle += rotation_speed;
//		//show_debug_message(image_angle)
//	}
//}

// Pann Camera When Landed
if (state_grounded && !state_landed) {
	//show_debug_message("ASTEROID LANDED");
	state_landed = true;
	with (obj_camera) {
		target = obj_player;
		obj_camera_point_01.x = camera_x;
		obj_camera_point_01.y = camera_y;
		obj_camera_point_01.hotspot_x = obj_camera_point_01.x + (camera_width /2);
		obj_camera_point_01.hotspot_y = obj_camera_point_01.y + (camera_height/2);
		pann_camera(obj_camera_point_01, target, 0.01);
	}
	obj_player.state_suspended = false;
	
	show_debug_message("Asteroid Name				"	+ string(item_name			));
	show_debug_message("Asteroid Category			"	+ string(item_category		));
	show_debug_message("Asteroid Resource_01		"	+ string(item_resource_01	));
	show_debug_message("Asteroid Resource_02		"	+ string(item_resource_02	));
	show_debug_message("Asteroid Resource_03		"	+ string(item_resource_03	));
	show_debug_message("Asteroid Sprite_index		"	+ string(item_sprite_index	));
	show_debug_message("Asteroid Sprite_frame		"	+ string(item_sprite_frame	));
	show_debug_message("Asteroid Mass				"	+ string(item_mass			));
}


// Collect asteroid into inventory.
if (state_grounded && state_landed) {	
	if (collision_point(mouse_x, mouse_y, obj_asteroid, true, false)) {
		if (keyboard_check_pressed(ord("E"))) {
			show_debug_message(item_resource_01)
		    // code here
			ex_item_add(obj_deconstructive_refinery.inv_building, item_resource_01[0], irandom_range(item_resource_01[1], item_resource_01[2]))
			ex_item_add(obj_deconstructive_refinery.inv_building, item_resource_02[0], irandom_range(item_resource_02[1], item_resource_02[2]))
			ex_item_add(obj_deconstructive_refinery.inv_building, item_resource_03[0], irandom_range(item_resource_03[1], item_resource_03[2]))
			instance_destroy();
		}
	}
}


// Room Wrap
move_wrap(true, false, 0);