// Movement speed
x_speed = 0;
y_speed = 0;

// Collision below
grounded = false;

// Movement Vars //////////////////////////////////////////////////////////////

// Adjust THIS to adjust overall player speed
m = 1;

// Acceleration + friction
ground_accel = 1.0  * m;
ground_fric  = 2.0  * m;
air_accel    = 0.75 * m;
air_fric     = 0.10 * m;

// Max movement speeds
max_x_speed	= 5.5  * m;
max_y_speed	= 9.0  * m;

jump_height  = 10.0  * m;
grav_rise    = 0.2  * m * 0.5;
grav_fall    = 0.2  * m * 0.5;
//grav_slide   = 0.25 * m;

// Misc ///////////////////////////////////////////////////////////////////////
jump_release_timer = 0;


///////////////////////////////////////////////////////////////////////////////