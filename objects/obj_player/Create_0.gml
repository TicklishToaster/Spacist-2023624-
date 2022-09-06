//// Forces and Speeds
//// Acceleration and jumping forces
//x_force = 1000;
//y_force = 1000;

//// How fast player can move (pixels/second)
//max_x_speed = 4;
//// Jumping is limited by y_force and gravity room setting

//// Input buffering
//// Adding a buffer in frames to make jumping more forgiving
//jump_buffer = 10;
//// Count placeholder (should be 0 here)
//jump_buffer_count = 0;

//// Controls
//control_left = ord("A");
//control_right = ord("D");
//control_jump = vk_space;

//// Prevent player from falling over.
//phy_fixed_rotation = true;


// =================================================


//// Room speed
//room_speed = 60;

// Settings
walkSpd = 4; // speed when walking
airControl = 0.2+0.8; // maneuverability when not on planet
maxSpd = 20 - 16; // maximum moving speed
jumpForce = 9 - 4; // jump height
grav = 6000; // gravity force
landForce = 0.2; // force applied to a planet when landing on it
distLimit = 800; // how far away the player can be to the nearest planet (when outside this radius, the player will accelerate towards it)
offset = sprite_height/2-1; // player sprite should be centered, so it needs an offset to not sink into the ground
turnSpd = 0.2; // how fast the player sprite turns (between 0-1)

// Movement
xSpd = 0;
ySpd = 0;
onPlanet = false;
planet = 0;
near = -1;

