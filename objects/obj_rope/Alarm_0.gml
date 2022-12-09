/// @description Recall Rope
joint_num -= 1;

if (joint_num > 1) {
	//old_pos_x = obj_hook.x;
	//old_pos_y = obj_hook.y;
	//hook_distance = point_distance(obj_hook.x, obj_hook.y, x_joint[joint_num-1], y_joint[joint_num-1]);
	//hook_direction = point_direction(obj_hook.x, obj_hook.y, x_joint[joint_num-1], y_joint[joint_num-1]);
	
	//var dir_x = lengthdir_x(hook_distance, hook_direction);
	//var dir_y = lengthdir_y(hook_distance, hook_direction);

	//obj_hook.x += dir_x;
	//obj_hook.y += dir_y;
	alarm[0] = 5;
}

if (joint_num == 1) {
	instance_destroy(obj_hook);
	instance_destroy(self);
}


