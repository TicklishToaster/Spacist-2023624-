// Global Variable Lever //////////////////////////////////////////////////////
m = 1;

// Movement Vars //////////////////////////////////////////////////////////////
x_speed = 0;
y_speed = 0;

max_x_speed	= 3.00 * m; // 5.5
max_y_speed	= 3.00 * m; // 9.0

grav_rise	= 0.10  * m;
grav_fall	= 0.00  * m;

// Acceleration & Friction Vars ///////////////////////////////////////////////
air_accel	= 0.75 * m;
air_fric	= 0.10 * m;

// States /////////////////////////////////////////////////////////////////////
thrown_state = true;
move_state = false;
fall_state = false;
camera_state = false;

thrown_physics	= [5.50, 9.00, 0.00, 0.00, 0.75, 0.00];
move_physics	= [3.00, 3.00, 0.10, 0.00, 0.75, 0.10];
fall_physics	= [5.50, 9.00 * 2, 0.10, 0.00, 0.75, 0.10];

// Misc ///////////////////////////////////////////////////////////////////////
object_attached = 0;

img_index = 0;
img_speed = 0;
img_rot = 0;
