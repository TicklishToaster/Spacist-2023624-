if (animation_visible) {
	// Draw rope joints.
	for (var i = 2; i <= joint_num; i++) {
		var scale = point_distance(x_joint[i], y_joint[i], x_joint[i-1], y_joint[i-1])/rope_sprite_width;  
		var rot = point_direction(x_joint[i], y_joint[i], x_joint[i-1], y_joint[i-1]);
	
		draw_sprite_ext(sprite_index, animation_index, x_joint[i], y_joint[i], scale, 1, rot, -1, 1 );
	}
}

// Draw joint connections.
//if (draw_joint_connections) {
//	for (var i = 1; i <= joint_num; i++) {
//		draw_sprite(spr_rope_origin, 1, x_joint[i], y_joint[i]);
//	}
//}