/// @description Init Rope

// Intialise attributes.
x_grav = 0;
y_grav = 1200 - 600-600;
//rope_len = 800-600;
joint_num = 32- 16;
rope_len = joint_num * 32 / 2
draw_joint_connections = false;
rope_sprite_width = 32;

// More iterations means better precision and stronger connections
// - between knots but it's slower to compute.
constraints_iterations = 10; // default 3

// Words
//view_visible[0] = false;
//view_visible[1] = true;
//obj_camera.target = self;

// Create initial state of rope.
joint_dist = rope_len/joint_num;
for (var i = 0; i <= joint_num; i++) {
    // Position of joint.
    x_joint[i] = x+random_range(-1, 1);
    y_joint[i] = y+(joint_dist*i*0.25);
    // Previous position.
    x_joint_prev[i] = x_joint[i];
    y_joint_prev[i] = y_joint[i];
}

// Create Hook Object
instance_create_layer(x, y, "Instances", obj_hook, {creator : obj_rope})
obj_camera.target = obj_hook;
