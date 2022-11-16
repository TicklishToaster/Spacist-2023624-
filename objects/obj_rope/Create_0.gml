/// @description Init Rope

// Intialise attributes.
X_grav = 0;
Y_grav = 1200;
//rope_len = 800-600;
joint_num = 32- 16;
rope_len = joint_num * 32 / 2
draw_joint_connections = false;
rope_sprite_width = 32;

// More iterations means better precision and stronger connections
// - between knots but it's slower to compute.
constraints_iterations = 10; // default 3

// Create initial state of rope.
joint_dist = rope_len/joint_num;
for (var i = 0; i <= joint_num; i++) {
    // Position of joint.
    X_joint[i] = x+random_range(-1, 1);
    Y_joint[i] = y+(joint_dist*i*0.25);
    // Previous position.
    X_joint_prev[i] = X_joint[i];
    Y_joint_prev[i] = Y_joint[i];
}
