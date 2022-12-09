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
	
	// Position rope origin offscreen, extending towards the player.
	var point_dist = point_distance(x_joint[joint_num], y_joint[joint_num], creator.hotspot_x, creator.hotspot_y);
	var point_dir = point_direction(x_joint[joint_num], y_joint[joint_num], creator.hotspot_x, creator.hotspot_y);	
		
	var dir_x = lengthdir_x(min(point_dist, rope_len), point_dir);
	var dir_y = lengthdir_y(min(point_dist, rope_len), point_dir);
    x_joint[0] = x_joint[joint_num] + dir_x;
    y_joint[0] = y_joint[joint_num] + dir_y;	
	
    // Move last rope joint to hook position.
    x_joint[joint_num] = obj_hook.x;
    y_joint[joint_num] = obj_hook.y;
    //x_joint_prev[joint_num] = obj_hook.x;
    //y_joint_prev[joint_num] = obj_hook.y;
    
    //// If current joint position meets a collider object then move it back to previous position.
    //for (var i = 0; i <= joint_num; i++) {        
    //    var velX = x_joint[i]-x_joint_prev[i];
    //    var velY = y_joint[i]-y_joint_prev[i];
    //    if (position_meeting(x_joint[i]+velX, y_joint[i], obj_parent_solid))
    //        x_joint[i] = x_joint_prev[i];
    //    if (position_meeting(x_joint[i], y_joint[i]+velY, obj_parent_solid))
    //        y_joint[i] = y_joint_prev[i];
    //}
}

if (!creator.grapple_mode && recall_rope && joint_num > 1) {
	hook_distance = point_distance(obj_hook.x, obj_hook.y, x_joint[joint_num-1], y_joint[joint_num-1]);
	hook_direction = point_direction(obj_hook.x, obj_hook.y, x_joint[joint_num-1], y_joint[joint_num-1]);
	
	var dir_x = lengthdir_x(hook_distance, hook_direction);
	var dir_y = lengthdir_y(hook_distance, hook_direction);

	//obj_hook.x = lerp(obj_hook.x, obj_hook.x+dir_x, 0.25);
	//obj_hook.y = lerp(obj_hook.y, obj_hook.y+dir_y, 0.25);
	
	//new_dir_x = lengthdir_x(hook_distance, hook_direction);
	//new_dir_y = lengthdir_y(hook_distance, hook_direction);	
	
	obj_hook.x = clamp(lerp(obj_hook.x, obj_hook.x+dir_x, 0.25), obj_hook.x, x_joint[joint_num-1]);
	obj_hook.y = clamp(lerp(obj_hook.y, obj_hook.y+dir_y, 0.25), obj_hook.y, y_joint[joint_num-1]);

}

if (keyboard_check_pressed(ord("V"))) {
	with (obj_hook) {event_user(1);}
	with (creator) {event_user(1);}
	 
	if (instance_exists(obj_asteroid)) {
		obj_asteroid.hook_attached = false;
		obj_asteroid.grounded = true;
	}
	obj_hook.grav_fall = 2.2;
	obj_hook.y_speed = 3;
	recall_rope = true;
	alarm[0] = room_speed * 1;
}