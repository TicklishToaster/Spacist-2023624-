// Forces and Speeds
// Acceleration and jumping forces
x_force = 1000;
y_force = 1000;

// How fast player can move (pixels/second)
max_x_speed = 4;
// Jumping is limited by y_force and gravity room setting

// Input buffering
// Adding a buffer in frames to make jumping more forgiving
jump_buffer = 10;
// Count placeholder (should be 0 here)
jump_buffer_count = 0;

// Controls
control_left = ord("A");
control_right = ord("D");
control_jump = vk_space;

// Prevent player from falling over.
phy_fixed_rotation = true;
