// Draw rope joints.
for (var i = 1; i <= joint_num; i++) {
	var scale = point_distance(X_joint[i], Y_joint[i], X_joint[i-1], Y_joint[i-1])/rope_sprite_width;  
	var rot = point_direction(X_joint[i], Y_joint[i], X_joint[i-1], Y_joint[i-1]);
	
	draw_sprite_ext(sprite_index, 0, X_joint[i], Y_joint[i], scale, 1, rot, -1, 1 );
}

// Draw joint connections.
//if (draw_joint_connections) {
//	for (var i = 1; i <= joint_num; i++) {
//		draw_sprite(spr_rope_origin, 1, X_joint[i], Y_joint[i]);
//	}
//}

// Draw root joint.
draw_sprite(spr_rope_origin, 0, X_joint[0], Y_joint[0]);

// Draw end joint. (Hook)
draw_sprite_ext(spr_grapple, 0, X_joint[joint_num], Y_joint[joint_num], 1, 1, rot+90, -1, 1);