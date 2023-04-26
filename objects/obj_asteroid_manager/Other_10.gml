/// @description Generate Asteroid Field
var row_height = 196;
for (var row = 1; row < 6; ++row) {
	// Attempt to 32 objects on each row.
	repeat (32) {
		var object_random = random_weighted(
			object_spawn_chance[0][1],
			object_spawn_chance[1][1],
			object_spawn_chance[2][1]
		);
		//var object_type = object_spawn_chance[object_random][0];
		var target_spawn_data	= object_spawn_data[object_random];
		var target_info_data	= object_info_data[object_random];
		
		var object_spawn_random = random_weighted(
			target_spawn_data[0][1],
			target_spawn_data[1][1],
			target_spawn_data[2][1]
		);		
		var object_info_random = random_weighted(
			target_info_data[0][0],
			target_info_data[1][0],
			target_info_data[2][0],
			target_info_data[3][0]
		);
		var target_spawn	= target_spawn_data[object_spawn_random];
		var target_info		= target_info_data[object_info_random];
		
		
		var object_name				= object_spawn_chance[object_random][0];
		var object_category			= target_spawn[0];
		var object_resource_01		= target_spawn[2];
		var object_resource_02		= target_spawn[3];
		var object_resource_03		= target_spawn[4];
		
		var object_sprite_index		= target_info[1];
		var object_sprite_frame		= irandom_range(target_info[2][0], target_info[2][1]);
		var object_mass				= target_info[3];
		var object_scale			= random_range(target_info[4][0], target_info[4][1]);
		var object_colour			= target_spawn[5];
		
		var object_velocity			= 0.5;
		var object_y_offset			= random_range(-32, 32);
		var object_rotation_speed	= random_range(-0.3, 0.3);
		var object_mirror			= choose(-1, 1);

		#region
		//// Randomise Object Type
		//var object_type = irandom_range(0, 1000);
		//var object_sprite_index	= noone;
		//var object_sprite_frame	= 0;
		//var object_mass			= 1;
		//var object_scale		= 1.0;		
		//var type_set = false;
			
		//// Condition for Curio.
		//if (!type_set && object_type < 1) {
		//	//object_type = "Curio";
		//	object_sprite_index	= spr_curio_01;
		//	object_sprite_frame = 0;
		//	object_mass			= 1;
		//	type_set = true;
		//}			
			
		//// Condition for Debris.
		//if (!type_set && object_type < 250) {
		//	//object_type = "Debris";

		//	// Randomise object mass and sprite.
		//	var object_size = irandom_range(0, 100);
		//	if (!type_set && object_size < 35) {
		//		object_size = false;
		//		object_sprite_index	= spr_debris_small;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_small)-1);
		//		object_mass			= 1;
		//		object_scale		= random_range(0.8, 0.9);
		//		type_set			= true;
		//	}
				
		//	if (!type_set && object_size < 65) {
		//		object_size = false;
		//		object_sprite_index	= spr_debris_medium;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_medium)-1);
		//		object_mass			= 2;
		//		object_scale		= random_range(0.9, 1.0);
		//		type_set			= true;
		//	}
				
		//	if (!type_set && object_size < 95) {
		//		object_size = false;
		//		object_sprite_index	= spr_debris_large;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_large)-1);
		//		object_mass			= 3;
		//		object_scale		= random_range(0.9, 1.0);
		//		type_set			= true;
		//	}
				
		//	if (!type_set && object_size <= 100) {
		//		object_size = false;
		//		object_sprite_index	= spr_debris_large;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_large)-1);
		//		object_mass			= 3;
		//		object_scale		= random_range(0.9, 1.0);
		//		type_set			= true;
		//	}
				
		//	//if (!type_set && object_size <= 100) {
		//	//	object_size = false;
		//	//	object_sprite_index	= spr_debris_giant;
		//	//	object_sprite_frame = irandom_range(0, sprite_get_number(spr_debris_giant)-1);
		//	//	object_mass			= 4;
		//	//	object_scale		= 0.25;
		//	//	type_set			= true;
		//	//}
		//}
			
		//// Condition for Asteroid.
		//if (!type_set && object_type <= 1000) {
		//	//object_type = "Asteroid";
				
		//	// Randomise object mass and sprite.
		//	var object_size = irandom_range(0, 100);
		//	if (!type_set && object_size < 35) {
		//		object_size = false;
		//		object_sprite_index	= spr_asteroid_small;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_small)-1);
		//		object_mass			= 1;
		//		object_scale		= random_range(0.8, 0.9);
		//		type_set			= true;
		//	}
				
		//	if (!type_set && object_size < 65) {
		//		object_size = false;
		//		object_sprite_index	= spr_asteroid_medium;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_medium)-1);
		//		object_mass			= 2;
		//		object_scale		= random_range(0.9, 1.0);
		//		type_set			= true;
		//	}
				
		//	if (!type_set && object_size < 95) {
		//		object_size = false;
		//		object_sprite_index	= spr_asteroid_large;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_large)-1);
		//		object_mass			= 3;
		//		object_scale		= random_range(0.9, 1.0);
		//		type_set			= true;
		//	}
				
		//	if (!type_set && object_size <= 100) {
		//		object_size = false;
		//		object_sprite_index	= spr_asteroid_giant;
		//		object_sprite_frame = irandom_range(0, sprite_get_number(spr_asteroid_giant)-1);
		//		object_mass			= 4;
		//		object_scale		= random_range(1.0, 1.2);
		//		type_set			= true;
		//	}
		//}
		
		#endregion
		#region
		//// Randomise Object Variables
		////var object_scale			= random_range(0.8, 1.0);
		////var object_rotation		= irandom_range(0, 12) * 30;
		//var object_rotation			= 0;
		//var object_rotation_speed	= random_range(-0.3, 0.3);
		////var object_velocity		= random_range(0.4, 0.6);
		//var object_velocity			= 0.5;
		//var object_y_offset			= random_range(-32, 32);
		//var object_mirror			= choose(-1, 1);
		#endregion
			
		// The "Create" event (values set in the "with" statement) for the new instance is automatically run first.
		//with (instance_create_layer(irandom(room_width), row*row_height + object_y_offset, "Instances", obj_asteroid, {
		with (instance_create_layer(irandom(room_width), row*row_height + object_y_offset, "Asteroids_Layer", obj_asteroid)) {
			// Apply instance attributes.
			item_name			= object_name;
			item_category		= object_category;
			item_resource_01	= object_resource_01;
			item_resource_02	= object_resource_02;
			item_resource_03	= object_resource_03;
			item_sprite_index	= object_sprite_index;
			item_sprite_frame	= object_sprite_frame;
			item_mass			= object_mass;
			item_scale			= object_scale;
			item_velocity		= object_velocity;
			item_y_offset		= object_y_offset;
			item_rotation_speed	= object_rotation_speed;
			item_mirror			= object_mirror;
			item_colour			= object_colour;
				
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