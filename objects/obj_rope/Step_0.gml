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
		var x_root = creator.x + creator.sprite_width/2;
		var y_root = creator.y + creator.sprite_height/2;	
	    x_joint[0] = x_root;
	    y_joint[0] = y_root;
	}
	
	// Pin root joint to screen.
	else {
	    x_joint[0] = x;
	    y_joint[0] = y;
	}
	
    // Move last rope joint to hook position.
    x_joint[joint_num] = obj_hook.x;
    y_joint[joint_num] = obj_hook.y;
    x_joint_prev[joint_num] = obj_hook.x;
    y_joint_prev[joint_num] = obj_hook.y;


    //// Move last rope joint to mouse position.
    //if (mouse_check_button(mb_left)) {
    //    x_joint[joint_num] = mouse_x;
    //    y_joint[joint_num] = mouse_y;
    //    x_joint_prev[joint_num] = mouse_x;
    //    y_joint_prev[joint_num] = mouse_y;
    //}
    
    //// Move root joint to mouse.
    //if (mouse_check_button(mb_right)) {
    //    x = mouse_x;
    //    y = mouse_y;
    //}
    
    // If current joint position meets a collider object then move it back to previous position.
    for (var i = 0; i <= joint_num; i++) {        
        var velX = x_joint[i]-x_joint_prev[i];
        var velY = y_joint[i]-y_joint_prev[i];
        if (position_meeting(x_joint[i]+velX, y_joint[i], obj_parent_solid))
            x_joint[i] = x_joint_prev[i];
        if (position_meeting(x_joint[i], y_joint[i]+velY, obj_parent_solid))
            y_joint[i] = y_joint_prev[i];
    }
}