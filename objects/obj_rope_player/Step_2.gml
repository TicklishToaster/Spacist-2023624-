/// @description Core of Movement

// Simulation speed (delta time)
dt = 0.0001+0.0000;

for (var i = 0; i <= joint_num; i++) {
    var temp_X = x_joint[i];
    var temp_Y = y_joint[i];
    x_joint[i] += x_joint[i] - x_joint_prev[i] + x_grav*dt;
    y_joint[i] += y_joint[i] - y_joint_prev[i] + y_grav*dt;
    x_joint_prev[i] = temp_X;
    y_joint_prev[i] = temp_Y;
}

// Move last rope joint to hook position. (This must be run in addtion to the copy in Step).
var point_dist = point_distance(x_joint[0], y_joint[0], obj_hook.x, obj_hook.y);
var point_dir = point_direction(x_joint[0], y_joint[0], obj_hook.x, obj_hook.y);
var dir_x = lengthdir_x(min(point_dist, rope_len), point_dir);
var dir_y = lengthdir_y(min(point_dist, rope_len), point_dir);
x_joint[joint_num] = x_joint[0] + dir_x;
y_joint[joint_num] = y_joint[0] + dir_y;