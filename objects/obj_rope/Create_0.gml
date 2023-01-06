/// @description Init Rope

// Intialise attributes.
x_grav = 0;
y_grav = 1200;
joint_num = 32 - 8;
//rope_len = 320;
rope_len = obj_camera.camera_height + 320;
draw_joint_connections = false;
rope_sprite_width = 32;
end_rotation = 0;
recall_rope = false;

// More iterations means better precision and stronger connections
// - between knots but it's slower to compute.
constraints_iterations = 10; // default 3

// Create initial state of rope.
//joint_dist = rope_len/joint_num;
joint_dist = 8;
for (var i = 0; i <= joint_num; i++) {
    // Position of joint.
    x_joint[i] = x+random_range(-1, 1);
    y_joint[i] = y+(joint_dist*i*0.25);
    // Previous position.
    x_joint_prev[i] = x_joint[i];
    y_joint_prev[i] = y_joint[i];
}

// Set higher depth so object is drawn behind grapple launcher, but in front of asteroids.
depth = 100;
