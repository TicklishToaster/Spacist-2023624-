/// @description Randomly Generate Asteroid Field

function generate_asteroid_field() {
	var row_height = 196;
	for (var row = 1; row < 6; ++row) {
		// Attempt to 32 objects on each row.
		repeat (32) {
			// Randomise Object Type
			var object_type = irandom_range(0, 1000);
			var object_sprite_index	= noone;
			var object_sprite_frame	= 0;
			var object_mass			= 1;
			var object_scale		= 1.0;		
			var type_set = false;
			
			// Condition for Curio.
			if (!type_set && object_type < 1) {
				//object_type = "Curio";
				object_sprite_index	= spr_curio_01;
				object_sprite_frame = 0;
				object_mass			= 1;
				type_set = true;
			}			
			
			// Condition for Debris.
			if (!type_set && object_type < 250) {
				//object_type = "Debris";

				// Randomise object mass and sprite.
				var object_size = irandom_range(0, 100);
				if (!type_set && object_size < 35) {
					object_size = false;
					object_sprite_index	= spr_debris_small;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_small)-1);
					object_mass			= 1;
					object_scale		= random_range(0.8, 0.9);
					type_set			= true;
				}
				
				if (!type_set && object_size < 65) {
					object_size = false;
					object_sprite_index	= spr_debris_medium;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_medium)-1);
					object_mass			= 2;
					object_scale		= random_range(0.9, 1.0);
					type_set			= true;
				}
				
				if (!type_set && object_size < 95) {
					object_size = false;
					object_sprite_index	= spr_debris_large;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_large)-1);
					object_mass			= 3;
					object_scale		= random_range(0.9, 1.0);
					type_set			= true;
				}
				
				if (!type_set && object_size <= 100) {
					object_size = false;
					object_sprite_index	= spr_debris_large;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_large)-1);
					object_mass			= 3;
					object_scale		= random_range(0.9, 1.0);
					type_set			= true;
				}
				
				//if (!type_set && object_size <= 100) {
				//	object_size = false;
				//	object_sprite_index	= spr_debris_giant;
				//	object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_giant)-1);
				//	object_mass			= 4;
				//	object_scale		= 0.25;
				//	type_set			= true;
				//}
			}
			
			// Condition for Asteroid.
			if (!type_set && object_type <= 1000) {
				//object_type = "Asteroid";
				
				// Randomise object mass and sprite.
				var object_size = irandom_range(0, 100);
				if (!type_set && object_size < 35) {
					object_size = false;
					object_sprite_index	= spr_asteroid_small;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_small)-1);
					object_mass			= 1;
					object_scale		= random_range(0.8, 0.9);
					type_set			= true;
				}
				
				if (!type_set && object_size < 65) {
					object_size = false;
					object_sprite_index	= spr_asteroid_medium;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_medium)-1);
					object_mass			= 2;
					object_scale		= random_range(0.9, 1.0);
					type_set			= true;
				}
				
				if (!type_set && object_size < 95) {
					object_size = false;
					object_sprite_index	= spr_asteroid_large;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_large)-1);
					object_mass			= 3;
					object_scale		= random_range(0.9, 1.0);
					type_set			= true;
				}
				
				if (!type_set && object_size <= 100) {
					object_size = false;
					object_sprite_index	= spr_asteroid_giant;
					object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_giant)-1);
					object_mass			= 4;
					object_scale		= random_range(1.0, 1.2);
					type_set			= true;
				}
			}
			
			// Randomise Object Variables
			//var object_scale			= random_range(0.8, 1.0);
			//var object_rotation		= irandom_range(0, 12) * 30;
			var object_rotation			= 0;
			var object_rotation_speed	= random_range(-0.3, 0.3);
			//var object_velocity		= random_range(0.4, 0.6);
			var object_velocity			= 0.5;
			var object_y_offset			= random_range(-32, 32);
			var object_mirror			= choose(-1, 1);
			
			// The "Create" event (values set in the "with" statement) for the new instance is automatically run first.
		    //with (instance_create_layer(irandom(room_width), row*row_height + object_y_offset, "Instances", obj_asteroid, {
		    with (instance_create_layer(irandom(room_width), row*row_height + object_y_offset, "Asteroids_Layer", obj_asteroid)) {
				// Apply instance attributes.
				sprite_index	= object_sprite_index;
				sprite_frame	= object_sprite_frame;
				mass			= object_mass;
				image_xscale	= object_scale * image_scale;
				image_yscale	= object_scale * image_scale * object_mirror;
				image_angle		= object_rotation;
				rotation_speed	= object_rotation_speed;
				row_speed		= object_velocity;
				
				// Ensure the newly created object down not overlap an existing object.
				var exit_check = 0;
				
				//var sprite_border_x = (sprite_width /2 * object_scale * image_scale);
				//var sprite_border_y = (sprite_height/2 * object_scale * image_scale);
				var sprite_border_x = (sprite_width /2 * object_scale);
				var sprite_border_y = (sprite_height/2 * object_scale);
				//while (!place_empty(x, y, obj_asteroid)) {
				while (collision_rectangle(x - sprite_border_x, y - sprite_border_y, x + sprite_border_x, y + sprite_border_y, obj_asteroid, true, true)) {
		            x = irandom(room_width);
					y = row*row_height + object_y_offset;
					
					// In case of a inifinite loop error, exit function.
					exit_check += 1;
					if (exit_check > 640) {
						//show_debug_message("INDEFINITE NESTED LOOP - EXITING");
						//exit;
						
						show_debug_message("INDEFINITE NESTED LOOP - DESTROYING OBJECT");
						instance_destroy(self);
						break;
					}					
				}
			}
		}	
	}
}