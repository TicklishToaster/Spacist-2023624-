// Draw rope joints.
var rot = 0;
for (var i = 2; i <= joint_num; i++) {
	var scale = point_distance(x_joint[i], y_joint[i], x_joint[i-1], y_joint[i-1])/rope_sprite_width;  
	var rot = point_direction(x_joint[i], y_joint[i], x_joint[i-1], y_joint[i-1]);
	
	draw_sprite_ext(sprite_index, -1, x_joint[i], y_joint[i], scale, 1, rot, -1, 1);
}

// Used in the Hook Object
end_rotation = rot; 

with (creator) {
	// Right Arm
	if (state_aiming && animation_index >= 4.9) || (state_grappling || state_retrieving) {
		draw_sprite_ext(animation_id_r, animation_index_r,
			grapple_origin_x, grapple_origin_y,
			image_xscale, image_yscale,
			aim_angle, image_blend, image_alpha);
	} else {
		draw_sprite_ext(animation_id_r, animation_index_r,
			x, y,
			image_xscale, image_yscale,
			image_angle, image_blend, image_alpha);
	}
}


// Draw joint connections.
//if (draw_joint_connections) {
//	for (var i = 1; i <= joint_num; i++) {
//		draw_sprite(spr_rope_origin, 1, x_joint[i], y_joint[i]);
//	}
//}

//// Draw root joint.
//draw_sprite(spr_rope_origin, -1, x_joint[0], y_joint[0]);

//// Draw end joint. (Hook)
//draw_sprite_ext(spr_grapple, 0, x_joint[joint_num], y_joint[joint_num], 1, 1, rot+90, -1, 1);