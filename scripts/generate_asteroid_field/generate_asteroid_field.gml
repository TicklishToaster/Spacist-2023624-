/// @description generate_asteroid_field();

function generate_asteroid_field() {
	var row_height = 196;
	for (var row = 1; row < 6; ++row) {
		repeat (16) {
			var sprite_id = choose(spr_asteroid_02, spr_asteroid_03, spr_asteroid_04);
			var scale = random_range(0.8, 1.0);
			var rot = irandom_range(0, 12) * 30;
			var rot_speed = random_range(-0.5, 0.5);
			var velocity = random_range(0.4, 0.5);
			var y_offset = random_range(-32, 32);			
			//scale = 1.0;
			velocity = 0.5;
			rot = 0;
			// The "Create" event for the new instance is automatically run first. The variables set below come after.
		    with (instance_create_layer(irandom(room_width), row*row_height + y_offset, "Instances", obj_asteroid, 
				{sprite_index : sprite_id, size : scale, image_angle : rot, rot_speed : rot_speed, row_speed : velocity, row_direction : row})) {	
				var exit_check = 0;
				while (!place_empty(x, y, obj_asteroid)) {
		            x = irandom(room_width);
					y = row*row_height + y_offset;
					
					// In case of a inifinite loop error, exit function.
					exit_check += 1;
					if (exit_check > 64) {
						show_debug_message("INDEFINITE NESTED LOOP - EXITING");
						exit;
					}					
				}
			}
		}	
	}
	//for (var row = 1; row < 6; ++row) {
	//	repeat (16) {
	//		var sprite_id = choose(spr_asteroid_02, spr_asteroid_03, spr_asteroid_04);
	//		var scale = random_range(0.8, 1.2);
	//		var rot = irandom_range(0, 12) * 30;
	//		var rot_speed = random_range(-0.5, 0.5);
	//		var velocity = random_range(0.1, 0.5);
	//		var y_offset = random_range(-32, 32);			
	//		scale = 0.5;
	//		velocity = 0.5;
	//		rot = 0;
	//		// The "Create" event for the new instance is automatically run first. The variables set below come after.
	//	    with (instance_create_layer(irandom(room_width), row*row_height + y_offset, "Asteroids_Layer", obj_asteroid, 
	//			{sprite_index : sprite_id, size : scale, image_angle : rot, rot_speed : rot_speed, row_speed : velocity, row_direction : row})) {	
	//			var exit_check = 0;
	//			while (!place_empty(x, y, obj_asteroid)) {
	//	            x = irandom(room_width);
	//				y = row*row_height + y_offset;
					
	//				// In case of a inifinite loop error, exit function.
	//				exit_check += 1;
	//				if (exit_check > 64) {
	//					show_debug_message("EXIT 2");
	//					exit;
	//				}
	//			}
	//		}
	//	}	
	//}
}