/// @description Satisfy Constraints

repeat constraints_iterations {
    // "Spring loads" the connections between 2 joints.
    for (var i = 0; i < joint_num; i++) {
        var diff_dist = point_distance(X_joint[i], Y_joint[i], X_joint[i+1], Y_joint[i+1]);
        var diff_dir  = point_direction(X_joint[i], Y_joint[i], X_joint[i+1], Y_joint[i+1]);
        
        diff_dist *= joint_dist*joint_dist / (diff_dist*diff_dist+joint_dist*joint_dist)-0.5;
        X_joint[i]		-= lengthdir_x(diff_dist, diff_dir);
        X_joint[i+1]	+= lengthdir_x(diff_dist, diff_dir); 
        Y_joint[i]		-= lengthdir_y(diff_dist, diff_dir);
        Y_joint[i+1]	+= lengthdir_y(diff_dist, diff_dir);   
    }    

    // Pin root joint to screen.
    X_joint[0] = x;
    Y_joint[0] = y;
     
    // Move last rope joint to mouse position.
    if (mouse_check_button(mb_left)) {
        X_joint[joint_num] = mouse_x;
        Y_joint[joint_num] = mouse_y;
        X_joint_prev[joint_num] = mouse_x;
        Y_joint_prev[joint_num] = mouse_y;
    }
    
    // Move root joint to mouse.
    if (mouse_check_button(mb_right)) {
        x = mouse_x;
        y = mouse_y;
    }
    
    // If current joint position meets a collider object then move it back to previous position.
    for (var i = 0; i <= joint_num; i++) {        
        var velX = X_joint[i]-X_joint_prev[i];
        var velY = Y_joint[i]-Y_joint_prev[i];
        if (position_meeting(X_joint[i]+velX, Y_joint[i], obj_parent_solid))
            X_joint[i] = X_joint_prev[i];
        if (position_meeting(X_joint[i], Y_joint[i]+velY, obj_parent_solid))
            Y_joint[i] = Y_joint_prev[i];
    }
}