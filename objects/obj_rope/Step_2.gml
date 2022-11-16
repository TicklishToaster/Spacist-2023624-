/// @description Core of Movement

// Simulation speed (delta time)
dt = 0.0001+0.0000;

for (var i = 0; i <= joint_num; i++) {
    var temp_X = X_joint[i];
    var temp_Y = Y_joint[i];
    X_joint[i] += X_joint[i] - X_joint_prev[i] + X_grav*dt;
    Y_joint[i] += Y_joint[i] - Y_joint_prev[i] + Y_grav*dt;
    X_joint_prev[i] = temp_X;
    Y_joint_prev[i] = temp_Y;
}