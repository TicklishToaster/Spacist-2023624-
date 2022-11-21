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
x_joint[joint_num] = obj_hook.x;
y_joint[joint_num] = obj_hook.y;
x_joint_prev[joint_num] = obj_hook.x;
y_joint_prev[joint_num] = obj_hook.y;