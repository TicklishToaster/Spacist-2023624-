/// @description Randomly Generate Asteroid Field

function generate_asteroid_field() {
	var row_height = 196;
	for (var row = 1; row < 6; ++row) {
		// Create 16 objects on each row.
		repeat (20) {
			// Randomise Object Type
			var object_type = irandom_range(0, 100);
			if (object_type < 70) {
				object_type = "Asteroid";
				var sprite_id = choose(spr_asteroid_02, spr_asteroid_03, spr_asteroid_04);
				switch (sprite_id) {
					case spr_asteroid_02:
						var object_mass = 1;
						break;
					case spr_asteroid_03:
						var object_mass = 2;
						break;
					case spr_asteroid_04:
						var object_mass = 3;
						break;					
				}
			}
			else if (object_type > 70 && object_type < 99) {
				object_type = "Debris";
				var sprite_id = choose(spr_asteroid_01, spr_asteroid_01, spr_asteroid_01);
				switch (sprite_id) {
					case spr_asteroid_01:
						var object_mass = 3;
						break;
					//case spr_asteroid_01:
					//	var object_mass = 3;
					//	break;
					//case spr_asteroid_01:
					//	var object_mass = 3;
					//	break;					
				}				
			}
			else if (object_type > 99) {
				object_type = "Curio";
				var sprite_id = choose(spr_resource_raw, spr_resource_raw, spr_resource_raw);
				switch (sprite_id) {
					case spr_resource_raw:
						var object_mass = 3;
						break;
					//case spr_resource_raw:
					//	var object_mass = 3;
					//	break;
					//case spr_resource_raw:
					//	var object_mass = 3;
					//	break;					
				}
			}			
			
			// Randomise Object Variables
			var object_scale			= random_range(0.8, 1.0);
			var object_rotation			= irandom_range(0, 12) * 30;
			var object_rotation_speed	= random_range(-0.3, 0.3);
			var object_velocity			= random_range(0.4, 0.6);
			var object_y_offset			= random_range(-32, 32);
			object_velocity = 0.5;
			object_rotation = 0;
			
			// The "Create" event (values set in the "with" statement) for the new instance is automatically run first.
		    //with (instance_create_layer(irandom(room_width), row*row_height + object_y_offset, "Instances", obj_asteroid, {
		    with (instance_create_layer(irandom(room_width), row*row_height + object_y_offset, "Asteroids_Layer", obj_asteroid, {
					sprite_index	: sprite_id,
					mass			: object_mass,
					image_xscale	: object_scale,
					image_yscale	: object_scale,
					image_angle		: object_rotation, 
					rotation_speed	: object_rotation_speed, 
					row_speed		: object_velocity})) {	
				// Ensure the newly created object down not overlap an existing object.
				var exit_check = 0;
				while (!place_empty(x, y, obj_asteroid)) {
		            x = irandom(room_width);
					y = row*row_height + object_y_offset;
					
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
}