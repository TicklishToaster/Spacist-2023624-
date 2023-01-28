/// @description Satisfy Constraints
repeat constraints_iterations {
    // "Spring loads" the connections between 2 joints.
    for (var i = 0; i < joint_num; i++) {
        var diff_dist = point_distance(x_joint[i], y_joint[i], x_joint[i+1], y_joint[i+1]);
        var diff_dir  = point_direction(x_joint[i], y_joint[i], x_joint[i+1], y_joint[i+1]);
        
        diff_dist *= joint_dist*joint_dist / (diff_dist*diff_dist+joint_dist*joint_dist)-0.5;
        x_joint[i]		-= lengthdir_x(diff_dist, diff_dir);
        x_joint[i+1]	+= lengthdir_x(diff_dist, diff_dir); 
        y_joint[i]		-= lengthdir_y(diff_dist, diff_dir);
        y_joint[i+1]	+= lengthdir_y(diff_dist, diff_dir);   
    }    

    // Pin root joint to the creator object (if possible).
	if (variable_instance_exists(id, "creator")) {
		var x_root = creator.grapple_hotspot_x;
		var y_root = creator.grapple_hotspot_y;
		var x_root = creator.grapple_origin_x;
		var y_root = creator.grapple_origin_y;		
	    x_joint[0] = x_root;
	    y_joint[0] = y_root;
	}
	
	// Move last rope joint to hook position, or closest to hook position if maximum length.
	var point_dist = point_distance(x_joint[0], y_joint[0], obj_hook.x, obj_hook.y);
	var point_dir = point_direction(x_joint[0], y_joint[0], obj_hook.x, obj_hook.y);
	var dir_x = lengthdir_x(min(point_dist, rope_len), point_dir);
	var dir_y = lengthdir_y(min(point_dist, rope_len), point_dir);
    x_joint[joint_num] = x_joint[0] + dir_x;
    y_joint[joint_num] = y_joint[0] + dir_y;
}

// Rope Animation /////////////////////////////////////////////////////////////
if (obj_hook.y_speed > 0.2) {
	//animation_index = clamp(animation_index + 0.4, 0, 7.9);
	animation_index = clamp(animation_index + obj_hook.y_speed/10, 0, 7.9);
	if (animation_index >= 7.9) {
		animation_index = 0;
	}
}
	
if (obj_hook.y_speed < -0.2) {
	//animation_index = clamp(animation_index - 0.4, 0, 7.9);
	animation_index = clamp(animation_index + obj_hook.y_speed/10, 0, 7.9);
	if (animation_index <= 0.0) {
		animation_index = 7.9;
	}
}	
