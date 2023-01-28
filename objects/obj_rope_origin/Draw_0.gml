if (animation_visible) {
	// Draw rope joints.
	for (var i = 2; i <= joint_num; i++) {
		var scale = point_distance(x_joint[i], y_joint[i], x_joint[i-1], y_joint[i-1])/rope_sprite_width;  
		var rot = point_direction(x_joint[i], y_joint[i], x_joint[i-1], y_joint[i-1]);
	
		draw_sprite_ext(sprite_index, animation_index, x_joint[i], y_joint[i], scale, 1, rot, -1, 1);
	}
}

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